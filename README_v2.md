# 🎭 FRAGLE THEATRE v2.0 - Absolutely Unhinged Edition

## What is This?

Fragle is a **theatrical trap system** that transforms security (or nonsense) into entertainment. It's a 5-level progressive experience where:
- Each level escalates in silliness (6/10 → 12/10)
- Personas are detected based on your environment
- Reality bends. Philosophy happens. Questions are asked.

**Status:** Fully functional shell TUI + web server + Electron scaffolding ✨

---

## Features

### 🎭 Shell Terminal UI (`fragle_tui.sh`)
- Persona detection (technical, aggressive, artistic, curious, chaotic)
- Interactive menu navigation
- Level selection with descriptions
- Lore display (unhinged storytelling)
- Cosmic joke generator (the Oracle)
- Session history tracking
- Animated loading screens
- Maximum whimsy

### 🌐 Web Theatre (`fragle_web.js` + `public/`)
- Express.js backend with theatrical API routes
- WebSocket support for real-time trap progression
- Absolutely unhinged web UI (CSS animations, glitch effects, chaos)
- 5 interactive screens:
  - Loading theatre
  - Main menu with persona detection
  - Level selection (clickable cards)
  - Trap experience (progress bars + messages)
  - Oracle (cosmic wisdom generator)
  - Lore (unedited scripture)
  - About page

### 💻 Electron App (Scaffolding Ready)
- Native macOS/Windows/Linux application
- Native menu bar integration
- Keyboard shortcuts (Cmd+M, Cmd+O, Cmd+Q)
- Dev tools toggle
- Desktop integration
- Ready to build: `npm run build`

### 🎪 Universal Launcher (`fragle_start.sh`)
- Single entry point for all modes
- Interactive mode selection
- Parallel execution (shell + web + electron simultaneously)
- Graceful shutdown

### 📊 Anonymous Scoreboard & Leaderboard (`fragle_scoreboard.sh`)
- **Top 100 Moments** - most unhinged sessions, most popular personas, trap difficulty stats
- **Live Activity Feed** - real-time anonymous theatre happenings
- **Heatmaps** - activity patterns by hour and persona
- **API-Ready Export** - aggregate stats for website without PII
- **100% Privacy** - no usernames, IPs, paths, or identifiers (only UUID hash, timestamp, persona type)
- **Automatic Logging** - every trap completion is logged to `.fragle_scoreboard/activity.jsonl`
- **Shell Menu Integration** - access leaderboard from main TUI menu (option 7)

See [SCOREBOARD_GUIDE.md](./SCOREBOARD_GUIDE.md) for full documentation.

---

## Quick Start

### 1. **Shell Theatre (Recommended for CLI)**
```bash
cd ~/fragle
bash fragle_tui.sh
```

Menu:
- Choose level (1-5 or ∞)
- View lore & oracle
- Sessions & profile
- Launch web UI from menu

### 2. **Web Theatre (Browser)**
```bash
cd ~/fragle
npm install  # One-time setup
npm start
```
Then open: `http://localhost:3000`

### 3. **Electron App (Desktop)**
```bash
cd ~/fragle
npm install  # One-time setup
npm run electron
```

### 4. **All At Once (Chaos Mode)**
```bash
cd ~/fragle
bash fragle_start.sh all
```
Starts: Shell TUI (foreground) + Web server (bg) + Electron app (bg)

---

## Project Structure

```
~/fragle/
├── fragle_tui.sh              # 🎭 Shell theatre (21KB, ~400 lines)
├── fragle_web.js              # 🌐 Express backend (7.3KB)
├── fragle_scoreboard.sh       # 📊 Anonymous leaderboard (11.4KB)
├── fragle_demo_scoreboard.sh  # 🎲 Seed test data (1.9KB)
├── fragle_start.sh            # 🚀 Universal launcher (5.4KB)
├── main.js                    # 💻 Electron entry point
├── preload.js                 # 🔐 Electron context bridge
├── package.json               # 📦 Dependencies + build config
├── public/
│   ├── index.html             # 🎨 Web UI template (9.6KB)
│   ├── style.css              # ✨ Theatrical styling (10KB)
│   └── app.js                 # 🎯 Frontend logic (8.3KB)
├── fragle_learning_pyramid.sh # 📚 Trap machinery (original)
├── fragle_portal_cli.sh       # 🎪 Old CLI (still here)
├── README_v2.md               # 📖 Main documentation
├── SCOREBOARD_GUIDE.md        # 📊 Leaderboard documentation
└── .fragle_scoreboard/        # 📁 Activity logs (auto-created)
    ├── activity.jsonl         # Append-only activity log
    └── stats_api.json         # Exported statistics
```

**Total new code:** ~60KB, ~1000 lines (TUI + Web + Electron scaffolding)

---

## Architecture

### Flow

```
fragle_start.sh (interactive launcher)
    ├─→ Shell TUI (fragle_tui.sh)
    │   └─→ Persona detection → Menu navigation
    │       └─→ Can launch Web UI from menu
    │
    ├─→ Web Server (fragle_web.js)
    │   ├─→ Express.js API routes
    │   ├─→ WebSocket for real-time chaos
    │   └─→ Frontend (public/)
    │
    └─→ Electron (main.js)
        ├─→ Wraps web UI in native window
        ├─→ Native menu bar
        └─→ Desktop app (.app / .exe / .AppImage)
```

### Tech Stack

- **Shell:** Bash (POSIX)
- **Web Backend:** Node.js + Express.js + WebSocket
- **Web Frontend:** HTML5 + CSS3 + Vanilla JavaScript
- **Desktop:** Electron (Node.js + Chromium)
- **Build:** electron-builder (for .app/.exe/.AppImage)

---

## Customization

### Personas (Detect What You Are)

Edit `fragle_tui.sh` → `detect_persona()` function:
```bash
detect_persona() {
    # Adds chaos detection based on:
    # - Shell type (bash, zsh, fish)
    # - SSH presence
    # - Git config
    # - Time of day (22:00-5:00 = aggressive)
    # - CPU load (high load = chaos)
    # - Custom signals (add your own)
}
```

### Silliness Levels

Add new trap content in `fragle_web.js` → `/api/theatre/:level`:
```javascript
const content = {
    1: { /* Level 1 */ },
    2: { /* Level 2 */ },
    ...
    6: { /* NEW LEVEL */ title: "Level 6: IMPOSSIBLE", ... }
}
```

### Oracle Quotes

Edit `fragle_tui.sh` or `fragle_web.js` → `oracle_jokes[]` array. Examples:
```
"The Oracle says: You are reading this. The theatre is reading you."
"Why did the trap cross the road? It didn't. The road was the trap."
```

### Web UI Styling

Edit `public/style.css`:
- Colors: `:root { --primary, --secondary, --tertiary, --accent }`
- Animations: `@keyframes` rules
- Responsive breakpoints: `@media (max-width: 768px)`

---

## Development

### Run Web Server in Dev Mode
```bash
npm run dev
# Watches for changes (requires nodemon)
```

### Run Linter + Format
```bash
npm run lint
npm run format
```

### Build Electron App (.app for macOS)
```bash
npm install  # Make sure deps are installed
npm run build
# Output: dist/Fragle Theatre.app (macOS)
#         dist/Fragle Theatre.exe (Windows)
#         dist/fragle-theatre.AppImage (Linux)
```

---

## Philosophy

This system embodies:
- **WIMP**: Weak Interaction = Strategic Misdirection
- **Theatrical Security**: Time-wasting IS the defense
- **Whimsical Chaos**: Unconventional > Aggressive
- **Entertainment First**: The punchline is the point

**Key principle:** "bleech their brains if they keep on"  
(Let systems/people be chaotic while learning)

---

## Deployment

### Local Testing
```bash
bash fragle_start.sh shell   # Shell only
bash fragle_start.sh web     # Web only
bash fragle_start.sh electron # Electron only
bash fragle_start.sh all      # All three
```

### Production Web
```bash
# Start web server (production mode)
NODE_ENV=production npm start
# Runs on port 3000 (or set PORT=8080)
```

### Distribute .app
```bash
npm run build
# Creates:
# - dist/Fragle Theatre.app (drag to Applications)
# - dist/Fragle Theatre.dmg (macOS installer)
```

---

## Troubleshooting

### Web server won't start
```bash
# Check if port 3000 is in use
lsof -i :3000
# Kill it:
kill -9 <PID>
```

### Electron won't launch
```bash
# Ensure Electron is installed
npm install electron --save-dev
# Check logs:
cat /tmp/fragle_electron.log
```

### Shell script permission denied
```bash
chmod +x ~/fragle/fragle_tui.sh
chmod +x ~/fragle/fragle_start.sh
```

---

## Files Created/Modified

### New Files
- `fragle_tui.sh` - Shell TUI (21KB)
- `fragle_web.js` - Express backend (7.3KB)
- `fragle_start.sh` - Launcher (5.4KB)
- `main.js` - Electron entry (4.1KB)
- `preload.js` - Electron bridge (605B)
- `public/index.html` - Web template (9.6KB)
- `public/style.css` - Web styling (10KB)
- `public/app.js` - Web frontend (8.3KB)

### Modified Files
- `package.json` - Updated deps + build config

---

## Next Steps

1. ✅ Test shell TUI locally
2. ✅ Test web server locally
3. 🔜 Install Electron fully (currently in progress)
4. 🔜 Build native .app for macOS
5. 🔜 Test cross-platform (Windows, Linux)
6. 🔜 Add more trap mechanics to levels
7. 🔜 Enhance Oracle with more cosmic jokes
8. 🔜 Add sound effects (already have Tone.js)

---

## Fun Variations

### Easter Eggs in Web UI
- Rapidly click the Oracle button 10 times → unlock bonus level
- Konami code on web UI?
- WebSocket chaos mode (sends random messages)

### Add Sound
Tone.js is already in deps! Add synth to trap entry:
```javascript
const synth = new Tone.Synth().toDestination();
synth.triggerAttackRelease("C4", "8n");
```

### Trap Collaboration
Multiple users on same trap → WebSocket messaging

---

## License

🎭 Theatrical. Unhinged. Unmonitored. Unafraid.

---

## Questions?

The Oracle knows.  
The theatre is watching.  
Reality is a suggestion.

🎪 *Until next time, traveller.*

---

### Commands At A Glance

```bash
# Quick start
cd ~/fragle
bash fragle_tui.sh              # Shell theatre
npm start                       # Web theatre
npm run electron                # Desktop app
bash fragle_start.sh all        # All at once

# Development
npm run dev                     # Watch mode
npm run lint && npm run format  # Code quality

# Distribution
npm run build                   # Create .app/.exe/.AppImage
```

That's it. The rest is theatre. 🎪
