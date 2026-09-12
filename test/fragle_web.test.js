const assert = require('node:assert/strict');
const { spawn } = require('node:child_process');
const { once } = require('node:events');
const net = require('node:net');
const path = require('node:path');
const { after, before, describe, test } = require('node:test');
const WebSocket = require('ws');

const projectRoot = path.resolve(__dirname, '..');

const theatreLevels = {
  1: {
    title: 'Level 1: NOVICE',
    description: 'Graphics trickery. ASCII fever dreams.',
    silliness: '6/10 (still normal)',
    duration: '5-10 minutes',
    experience: 'Your brain begins to itch.',
  },
  2: {
    title: 'Level 2: INTERMEDIATE',
    description: 'Logic puzzles. Your brain is a pretzel now.',
    silliness: '7/10 (questions begin)',
    duration: '10-20 minutes',
    experience: 'Reality wobbles slightly.',
  },
  3: {
    title: 'Level 3: ADVANCED',
    description: 'Meta-reality. The trap questions itself.',
    silliness: '8/10 (reality cracks)',
    duration: '20-45 minutes',
    experience: "You are no longer sure who's watching whom.",
  },
  4: {
    title: 'Level 4: EXPERT',
    description: "Consciousness tests. What is 'you' anymore?",
    silliness: '10/10 (sanity optional)',
    duration: '45-90 minutes',
    experience: 'Your very existence is a punchline.',
  },
  5: {
    title: 'Level 5: ENLIGHTENED',
    description: 'The theatre IS the trap IS you.',
    silliness: '12/10 (mathematically impossible)',
    duration: '∞ minutes',
    experience: 'You have transcended. Or been consumed. Both. Neither.',
  },
};

const oracleQuotes = new Set([
  "Why did the trap cross the road? It didn't. The road was the trap.",
  'How many snoops does it take to enter Level 5? They never reach it.',
  "What's the difference between a trap and reality? Nobody knows.",
  "Can the trap trap itself? Yes. It's happening now.",
  "Your SSH key is a question. The answer is always 'yes'.",
  'Time is a construct. Traps are freedom. Freedom is a trap.',
  'Why are you reading this? The Oracle is watching.',
  'You came for the traps. You stayed for the philosophy.',
  'The theatre watches you watch the theatre.',
  'Reality is a suggestion. Traps are a lifestyle.',
  'All levels exist simultaneously in superposition.',
  'The exit was always inside you. Or was it?',
  "Silliness measured in units of 'did that just happen?'",
  'You are reading this. The theatre is reading you.',
  "Level ∞ is happening. It's always happening.",
]);

function getAvailablePort() {
  return new Promise((resolve, reject) => {
    const probe = net.createServer();
    probe.once('error', reject);
    probe.listen(0, '127.0.0.1', () => {
      const { port } = probe.address();
      probe.close((error) => (error ? reject(error) : resolve(port)));
    });
  });
}

function delay(milliseconds) {
  return new Promise((resolve) => setTimeout(resolve, milliseconds));
}

function messageQueue(socket) {
  const messages = [];
  const waiters = [];

  socket.on('message', (raw) => {
    const message = JSON.parse(raw.toString());
    const waiter = waiters.shift();
    if (waiter) waiter.resolve(message);
    else messages.push(message);
  });

  socket.on('error', (error) => {
    while (waiters.length) waiters.shift().reject(error);
  });

  return {
    next(timeout = 1_000) {
      if (messages.length) return Promise.resolve(messages.shift());

      return new Promise((resolve, reject) => {
        const waiter = { resolve, reject };
        waiters.push(waiter);
        const timer = setTimeout(() => {
          const index = waiters.indexOf(waiter);
          if (index !== -1) waiters.splice(index, 1);
          reject(new Error(`Timed out after ${timeout}ms waiting for a WebSocket message`));
        }, timeout);

        waiter.resolve = (value) => {
          clearTimeout(timer);
          resolve(value);
        };
        waiter.reject = (error) => {
          clearTimeout(timer);
          reject(error);
        };
      });
    },
  };
}

describe('Fragle web theatre', { concurrency: false }, () => {
  let baseUrl;
  let child;
  let childStderr = '';

  before(async () => {
    const port = await getAvailablePort();
    baseUrl = `http://127.0.0.1:${port}`;

    // Deterministic randomness makes the protocol assertions stable. Shortening
    // only the server's intervals keeps trap-progression coverage fast.
    const bootstrap = [
      'Math.random = () => 0.999;',
      'const originalSetInterval = global.setInterval;',
      'global.setInterval = (fn, delay, ...args) =>',
      '  originalSetInterval(fn, Math.min(delay, 20), ...args);',
      `require(${JSON.stringify(path.join(projectRoot, 'fragle_web.js'))});`,
    ].join('\n');

    child = spawn(process.execPath, ['-e', bootstrap], {
      cwd: projectRoot,
      env: { ...process.env, PORT: String(port) },
      stdio: ['ignore', 'ignore', 'pipe'],
    });
    child.stderr.setEncoding('utf8');
    child.stderr.on('data', (chunk) => {
      childStderr += chunk;
    });

    for (let attempt = 0; attempt < 100; attempt += 1) {
      if (child.exitCode !== null) {
        throw new Error(`Fragle server exited before readiness:\n${childStderr}`);
      }

      try {
        const response = await fetch(`${baseUrl}/api/oracle`);
        if (response.ok) return;
      } catch {
        // The server has not bound the port yet.
      }
      await delay(25);
    }

    throw new Error(`Fragle server did not become ready:\n${childStderr}`);
  });

  after(async () => {
    if (!child || child.exitCode !== null) return;
    const exited = once(child, 'exit');
    child.kill('SIGTERM');
    await exited;
  });

  test('serves the theatre page and static assets', async () => {
    const page = await fetch(`${baseUrl}/`);
    assert.equal(page.status, 200);
    assert.match(page.headers.get('content-type'), /^text\/html/);
    assert.match(await page.text(), /FRAGLE THEATRE AWAKENS/);

    const stylesheet = await fetch(`${baseUrl}/style.css`);
    assert.equal(stylesheet.status, 200);
    assert.match(stylesheet.headers.get('content-type'), /^text\/css/);
  });

  test('returns a self-consistent persona response', async () => {
    const response = await fetch(`${baseUrl}/api/persona`, { method: 'POST' });
    assert.equal(response.status, 200);

    const body = await response.json();
    assert.ok(
      ['technical', 'aggressive', 'artistic', 'curious', 'chaotic'].includes(
        body.persona,
      ),
    );
    assert.equal(body.message, `You are: ${body.persona}. The theatre knows.`);
    assert.equal(new Date(body.timestamp).toISOString(), body.timestamp);
  });

  test('starts a trap and echoes the requested level', async () => {
    const response = await fetch(`${baseUrl}/api/trap/start`, {
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: JSON.stringify({ level: 3 }),
    });
    assert.equal(response.status, 200);

    const body = await response.json();
    assert.match(body.trapId, /^trap_\d+_[a-z0-9]{9}$/);
    assert.deepEqual(
      { level: body.level, message: body.message, status: body.status },
      {
        level: 3,
        message: '⚡ Trap activated. Point of no return passed. ⚡',
        status: 'active',
      },
    );
  });

  test('rejects malformed JSON instead of activating a trap', async () => {
    const response = await fetch(`${baseUrl}/api/trap/start`, {
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: '{"level":',
    });

    assert.equal(response.status, 400);
  });

  test('returns only one of the documented oracle quotes', async () => {
    const response = await fetch(`${baseUrl}/api/oracle`);
    assert.equal(response.status, 200);
    assert.deepEqual(Object.keys(await response.clone().json()), ['quote']);
    assert.ok(oracleQuotes.has((await response.json()).quote));
  });

  for (const [level, expected] of Object.entries(theatreLevels)) {
    test(`returns the complete theatre metadata for level ${level}`, async () => {
      const response = await fetch(`${baseUrl}/api/theatre/${level}`);
      assert.equal(response.status, 200);
      assert.deepEqual(await response.json(), expected);
    });
  }

  test('returns the not-found payload at both sides of the level range', async () => {
    for (const level of ['0', '6', 'advanced']) {
      const response = await fetch(`${baseUrl}/api/theatre/${level}`);
      assert.equal(response.status, 200);
      assert.deepEqual(await response.json(), { error: 'Level not found' });
    }
  });

  test('returns a conventional 404 for an unknown route', async () => {
    const response = await fetch(`${baseUrl}/api/does-not-exist`);
    assert.equal(response.status, 404);
  });

  test('answers oracle requests and echoes unknown WebSocket messages', async () => {
    const socket = new WebSocket(baseUrl.replace('http', 'ws'));
    await once(socket, 'open');
    const messages = messageQueue(socket);

    socket.send(JSON.stringify({ type: 'ask_oracle' }));
    assert.deepEqual(await messages.next(), {
      type: 'oracle_speaks',
      wisdom:
        'The Oracle says: You are asking questions. The theatre appreciates this.',
    });

    socket.send(JSON.stringify({ type: 'dance' }));
    assert.deepEqual(await messages.next(), {
      type: 'echo',
      message: 'Received: dance',
    });

    socket.close();
    await once(socket, 'close');
  });

  test('ignores malformed WebSocket input while keeping the connection usable', async () => {
    const socket = new WebSocket(baseUrl.replace('http', 'ws'));
    await once(socket, 'open');
    const messages = messageQueue(socket);

    socket.send('{not-json');
    socket.send(JSON.stringify({ type: 'ask_oracle' }));

    assert.equal((await messages.next()).type, 'oracle_speaks');
    assert.equal(socket.readyState, WebSocket.OPEN);

    socket.close();
    await once(socket, 'close');
  });

  test('reports monotonic trap progress and a final completion event', async () => {
    const socket = new WebSocket(baseUrl.replace('http', 'ws'));
    await once(socket, 'open');
    const messages = messageQueue(socket);

    socket.send(JSON.stringify({ type: 'enter_trap', level: 5 }));
    const started = await messages.next();
    assert.equal(started.type, 'trap_status');
    assert.equal(started.level, 5);
    assert.ok(started.chaos_level >= 0 && started.chaos_level < 100);

    const progressEvents = [];
    let completed;
    while (!completed) {
      const message = await messages.next();
      if (message.type === 'trap_progress') progressEvents.push(message);
      if (message.type === 'trap_complete') completed = message;
    }

    assert.ok(progressEvents.length > 0);
    for (let index = 0; index < progressEvents.length; index += 1) {
      const event = progressEvents[index];
      assert.ok(event.progress > 0 && event.progress < 100);
      assert.ok(
        ['Initializing', 'Engaging', 'Escalating', 'Destabilizing'].includes(
          event.status,
        ),
      );
      if (index > 0) {
        assert.ok(event.progress > progressEvents[index - 1].progress);
      }
    }

    assert.equal(completed.message, '✓ Trap experience complete. You survived.');
    assert.ok(completed.final_chaos >= 0 && completed.final_chaos < 100);

    socket.close();
    await once(socket, 'close');
  });
});
