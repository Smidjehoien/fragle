# 🧭 FRAGLE – The Theatrical Security Theatre System

> *A generative, progressive learning system. Enter as a curious browser. Leave enlightened—or trapped. Depends on how deep your nose goes.*

---

## 🎭 What Is This?

**FRAGLE** is not a typical security project. It's a **social learning experiment** wrapped in theatrical security traps, designed so that every level of curiosity learns something real—about systems, about attention, about yourself.

- **Level 1 (Casual):** Quick, fun, delightful confusion. You think you're just running a script.
- **Level 2 (Curious):** Architecture unfolds. You start noticing layers.
- **Level 3 (Determined):** Traps become visible. You realize you're being taught *through play*.
- **Level 4 (Deep Diver):** Philosophy emerges. WIMP. Theatrical intent. Autonomous behavior.
- **Level 5 (Enlightened):** You understand the system is also understanding you. Welcome to the chaos.

---

## 🚀 Quick Start (Choose Your Path)

### 👶 Level 1: I Just Want to Run Something Fun

```bash
cd ~/fragle
bash fragle_portal_cli.sh
```

Press Enter and **follow the prompts**. You'll enter a theatrical experience. Don't think too hard about it. Just enjoy.

---

### 🧠 Level 2: I Want to Understand the Architecture

Read this first:
- **[BUILD_SUMMARY.md](/BUILD_SUMMARY.md)** – What exists and why
- **[README_v2.md](/README_v2.md)** – Full system overview

Then explore:

```bash
bash fragle_tui.sh        # Terminal UI – explore the theatre
bash fragle_web.js        # Start Web Theatre (http://localhost:3000)
```

**You'll discover:**
- 5 trap levels × 15 mechanics each
- Persona detection (who are you, really?)
- Lore evolution (FRAGLE_LORE.md + TRAP_TOURNAMENT.md)
- Anonymous scoreboard (see who else got caught)

---

### 🔍 Level 3: I Want to Audit the Security

Questions you might ask:
- *"How does it detect me?"* → [.whitelist](/.whitelist) (who's safe) + Detection logic in trap scripts
- *"What's the actual trap?"* → [ANTI_SNOOP_README.md](/ANTI_SNOOP_README.md) (mechanics revealed)
- *"Can I escape?"* → Yes. Read the exit routes. Every trap has one.
- *"Who else fell in?"* → [SCOREBOARD_GUIDE.md](/SCOREBOARD_GUIDE.md) (anonymous leaderboard)

**Discovery path:**
```bash
bash fragle_scoreboard.sh  # See activity (top 100 snoops)
cat ANTI_SNOOP_README.md   # Trap mechanics demystified
cat .whitelist             # Who's whitelisted
```

**Key insight:** Security theatre *is* security. Time-wasting through misdirection. Theatrical misdirection *is the defence*.

---

### 🎓 Level 4: I Want to Understand the Philosophy

You're asking the real questions now:

- **What is WIMP?** → Weak Interaction = Strategic Misdirection. It's in [.hermes.md](/.hermes.md)
- **How does this teach?** → Through **play**, not punishment. Every trap teaches a lesson.
- **Why theatrical?** → Because theatre is how humans learn best. Narrative > lecture.
- **What's the lore?** → Read [FRAGLE_LORE.md](/FRAGLE_LORE.md) + [TRAP_TOURNAMENT.md](/TRAP_TOURNAMENT.md)

**Deep dive:**
```bash
cat FRAGLE_LORE.md           # The story behind the traps
cat TRAP_TOURNAMENT.md       # How traps evolve & compete
cat .hermes.md               # Project philosophy & automation
```

**The pattern you'll see:**
- 4-layer architecture (Portals → Traps → Lore → Automation)
- Persona detection (are you technical? artistic? aggressive?)
- Silliness scales with depth (more knowledge = more absurdity)
- Everything logs anonymously (learning, not surveillance)

---

### 🌌 Level 5: I Want to Contribute to the Evolution

You've reached enlightenment. Now you're **part of the system**. Read:

- **[CLAUDE.md](/CLAUDE.md)** – How to enhance traps creatively
- **[SECURITY.md](/SECURITY.md)** – Safeguards (no PII, exits always work, etc.)
- **Git workflow** – Feature branches: `trap/`, `feature/`, `refactor/`

**Contribute:**
- New traps (theatrical, creative, time-wasting potential)
- Trap evolution (weekly automated improvements)
- Lore expansion (FRAGLE_LORE.md grows with you)
- Scoreboard enhancements (what metrics matter?)

```bash
git checkout -b trap/your-trap-name
# Build your trap
git commit -m "trap: [name] – description of theatrical intent"
git push origin trap/your-trap-name
# Open PR, link to trap doc + amusement notes
```

---

## 📋 File Map (Choose What You Need)

| File | Purpose | Level |
|------|---------|-------|
| `fragle_portal_cli.sh` | Entry point (CLI persona detect) | 1 |
| `fragle_tui.sh` | Terminal UI explorer | 2 |
| `fragle_web.js` | Web Theatre (browser-based) | 2 |
| `fragle_scoreboard.sh` | Anonymous leaderboard viewer | 3 |
| `.whitelist` | Trusted users (bypasses traps) | 3 |
| `ANTI_SNOOP_README.md` | Trap mechanics (spoiler alert!) | 3 |
| `BUILD_SUMMARY.md` | What was built & why | 2 |
| `README_v2.md` | Full system overview | 2 |
| `FRAGLE_LORE.md` | Story + trap mythology | 4 |
| `TRAP_TOURNAMENT.md` | How traps compete & evolve | 4 |
| `.hermes.md` | Philosophy + automation rules | 4 |
| `CLAUDE.md` | Contribution guidelines | 5 |
| `SECURITY.md` | Safeguards & ethical gates | 5 |

---

## 🎮 The Experience

### Entry: Portal (Persona Detection)

You run `fragle_portal_cli.sh`. It watches you:
- What commands do you run?
- How fast?
- Do you check files first or dive in?
- Your detection → your persona → your trap

### Traps: 5 Levels of Silliness

Each level makes time-wasting more elaborate:
- **Level 1:** Simple loops, fake files
- **Level 2:** Nested redirects, philosophical output
- **Level 3:** Fake systems, escalating absurdity
- **Level 4:** Full theatrical sequences, meta-commentary
- **Level 5:** Systems that understand they're being understood

### Lore: The Story

Each trap tells a story. Read FRAGLE_LORE.md to understand the **narrative arc**. Traps aren't random—they're **staged chapters**.

### Evolution: Autonomous Learning

Every week, traps **analyze logs** and evolve. Did a snooper escape? The system learns. Did someone get entertained? It doubles down. This is not written once—it **grows**.

### Scoreboard: Anonymous Recognition

See where you rank. No names. Just UUID hashes, timestamps, silliness scores. Learn from others. Celebrate creative escapes.

---

## 🛡️ Safety & Ethics

**We believe in:**
- ✅ No PII ever logged or exposed
- ✅ Every trap has an exit route
- ✅ 15-minute timeout (no infinite loops)
- ✅ Whitelisting works (team members bypass entirely)
- ✅ Entertainment > punishment
- ✅ Learning > surveillance

**If you get stuck:** Every trap prints `[EXIT: <key sequence>]` at the top. Use it.

---

## 🎭 The Philosophy (WIMP)

**Weak Interaction = Massive Particles**

Security theatre isn't weak because it fails—it's weak because it **misdirects**. Like particles in a system, attention scatters. But that scatter *is the defence*.

FRAGLE teaches you this by *making you experience it*. You don't read about it. You live through it. And by the end, you understand:

- Systems can be beautiful and tricky at once
- Learning through play outlasts learning through rules
- Theatrical intent is serious intent
- Every snooper is also a teacher

---

## 🚀 Entry Points by Role

| Role | Start Here |
|------|-----------|
| **Newcomer** | `bash fragle_portal_cli.sh` |
| **Security Auditor** | [ANTI_SNOOP_README.md](/ANTI_SNOOP_README.md) |
| **Architect** | [BUILD_SUMMARY.md](/BUILD_SUMMARY.md) |
| **Philosopher** | [FRAGLE_LORE.md](/FRAGLE_LORE.md) |
| **Contributor** | [CLAUDE.md](/CLAUDE.md) |
| **Curious Chaos Theorist** | Anywhere. Pick randomly. Report back. |

---

## 📞 Questions?

- **"How do I escape?"** → Look for `[EXIT: ...]` in trap output
- **"Is this malicious?"** → No. Read [SECURITY.md](/SECURITY.md)
- **"Can I contribute?"** → Yes. Start with [CLAUDE.md](/CLAUDE.md)
- **"What's the endgame?"** → There isn't one. That's the point.

---

## 🎯 TL;DR

1. Run `bash fragle_portal_cli.sh` to enter
2. Choose your curiosity level
3. Learn through play (not punishment)
4. See the architecture, understand the philosophy
5. Maybe contribute. Maybe just appreciate.

**Welcome to FRAGLE. Your nose got you here. Let's see where it takes you.**

---

*Built with theatrical intent. Maintained with curiosity. Evolved by the community.*  
*V2.0 — July 2026 — Smidjehoien/Fragle*
