// fragle_web.js - Web UI Theatre (Absolutely Unhinged Edition)
// Express server + WebSocket + theatrical experience

const express = require('express');
const path = require('path');
const { exec } = require('child_process');
const http = require('http');
const WebSocket = require('ws');

const app = express();
const PORT = process.env.PORT || 3000;
const FRAGLE_HOME = process.env.FRAGLE_HOME || __dirname;

// Middleware
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

// Store active sessions
const sessions = new Map();

// ============================================================================
// ROUTES
// ============================================================================

// Main page
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// API: Get persona for user
app.post('/api/persona', (req, res) => {
  const personas = ['technical', 'aggressive', 'artistic', 'curious', 'chaotic'];
  const persona = personas[Math.floor(Math.random() * personas.length)];
  
  res.json({
    persona,
    message: `You are: ${persona}. The theatre knows.`,
    timestamp: new Date().toISOString()
  });
});

// API: Start a trap
app.post('/api/trap/start', (req, res) => {
  const { level } = req.body;
  const trapId = `trap_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`;
  
  sessions.set(trapId, {
    level,
    startTime: Date.now(),
    status: 'active'
  });
  
  res.json({
    trapId,
    level,
    message: '⚡ Trap activated. Point of no return passed. ⚡',
    status: 'active'
  });
});

// API: Get silly quotes (oracle)
app.get('/api/oracle', (req, res) => {
  const quotes = [
    "Why did the trap cross the road? It didn't. The road was the trap.",
    "How many snoops does it take to enter Level 5? They never reach it.",
    "What's the difference between a trap and reality? Nobody knows.",
    "Can the trap trap itself? Yes. It's happening now.",
    "Your SSH key is a question. The answer is always 'yes'.",
    "Time is a construct. Traps are freedom. Freedom is a trap.",
    "Why are you reading this? The Oracle is watching.",
    "You came for the traps. You stayed for the philosophy.",
    "The theatre watches you watch the theatre.",
    "Reality is a suggestion. Traps are a lifestyle.",
    "All levels exist simultaneously in superposition.",
    "The exit was always inside you. Or was it?",
    "Silliness measured in units of 'did that just happen?'",
    "You are reading this. The theatre is reading you.",
    "Level ∞ is happening. It's always happening."
  ];
  
  const quote = quotes[Math.floor(Math.random() * quotes.length)];
  res.json({ quote });
});

// API: Get theatrical experience content
app.get('/api/theatre/:level', (req, res) => {
  const { level } = req.params;
  
  const content = {
    1: {
      title: "Level 1: NOVICE",
      description: "Graphics trickery. ASCII fever dreams.",
      silliness: "6/10 (still normal)",
      duration: "5-10 minutes",
      experience: "Your brain begins to itch."
    },
    2: {
      title: "Level 2: INTERMEDIATE",
      description: "Logic puzzles. Your brain is a pretzel now.",
      silliness: "7/10 (questions begin)",
      duration: "10-20 minutes",
      experience: "Reality wobbles slightly."
    },
    3: {
      title: "Level 3: ADVANCED",
      description: "Meta-reality. The trap questions itself.",
      silliness: "8/10 (reality cracks)",
      duration: "20-45 minutes",
      experience: "You are no longer sure who's watching whom."
    },
    4: {
      title: "Level 4: EXPERT",
      description: "Consciousness tests. What is 'you' anymore?",
      silliness: "10/10 (sanity optional)",
      duration: "45-90 minutes",
      experience: "Your very existence is a punchline."
    },
    5: {
      title: "Level 5: ENLIGHTENED",
      description: "The theatre IS the trap IS you.",
      silliness: "12/10 (mathematically impossible)",
      duration: "∞ minutes",
      experience: "You have transcended. Or been consumed. Both. Neither."
    }
  };
  
  res.json(content[level] || { error: 'Level not found' });
});

// ============================================================================
// WEBSOCKET (for real-time chaos)
// ============================================================================

const server = http.createServer(app);
const wss = new WebSocket.Server({ server });

wss.on('connection', (ws) => {
  console.log('🎭 Client connected to theatre');
  
  ws.on('message', (message) => {
    try {
      const data = JSON.parse(message);
      
      switch(data.type) {
        case 'enter_trap':
          ws.send(JSON.stringify({
            type: 'trap_status',
            message: '⚡ Trap sequence initiated ⚡',
            level: data.level,
            chaos_level: Math.random() * 100
          }));
          
          // Simulated trap progression
          let progress = 0;
          const trapInterval = setInterval(() => {
            progress += Math.random() * 30;
            
            if (progress >= 100) {
              ws.send(JSON.stringify({
                type: 'trap_complete',
                message: '✓ Trap experience complete. You survived.',
                final_chaos: Math.random() * 100
              }));
              clearInterval(trapInterval);
            } else {
              ws.send(JSON.stringify({
                type: 'trap_progress',
                progress: Math.min(progress, 100),
                status: ['Initializing', 'Engaging', 'Escalating', 'Destabilizing'][Math.floor(progress / 25)]
              }));
            }
          }, 1000);
          break;
          
        case 'ask_oracle':
          ws.send(JSON.stringify({
            type: 'oracle_speaks',
            wisdom: "The Oracle says: You are asking questions. The theatre appreciates this."
          }));
          break;
          
        default:
          ws.send(JSON.stringify({
            type: 'echo',
            message: `Received: ${data.type}`
          }));
      }
    } catch(e) {
      console.error('WebSocket error:', e);
    }
  });
  
  ws.on('close', () => {
    console.log('🎭 Client left the theatre');
  });
});

// ============================================================================
// START SERVER
// ============================================================================

server.listen(PORT, () => {
  console.log(`
╔════════════════════════════════════════════════════════════╗
║                                                            ║
║         🎭  FRAGLE WEB THEATRE ONLINE  🎭                ║
║                                                            ║
║  http://localhost:${PORT}                                   ║
║                                                            ║
║  Reality is a suggestion. Welcome to the show.             ║
║                                                            ║
╚════════════════════════════════════════════════════════════╝
  `);
});

module.exports = app;
