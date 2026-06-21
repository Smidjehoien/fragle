# Fragle Opt-In Portal & Elaborate Interface

## Overview

The Fragle opt-in portal is a **persona-adaptive theatrical entry system** that shapes itself based on who you are. It exists in three forms:

1. **Web Portal** (`fragle_web_portal.html`) — Visual, glitchy, persona-detecting
2. **CLI Portal** (`fragle_portal_cli.sh`) — Terminal-based menu with lore browser
3. **Direct Entry** (`fragle_learning_pyramid.sh`) — For those who skip ceremony

The philosophy: **Let the visitor choose their experience.**

---

## Persona Detection & Adaptive Theatre

### How It Works

Both portals **profile** visitors without storing personal data. They look for behavioral signals:

**Technical Persona** (detected by):
- Git history, SSH config, command line expertise
- Firefox usage on small displays
- Late-night exploration (11 PM - 5 AM)
- Previous SSH connections
- Python/node/rust in command history

**Aggressive Persona** (detected by):
- Direct access (no referrer)
- Bot-like user agents
- Network tools in history (curl, wget, nmap)
- Late-night access
- SSH client presence

**Artistic Persona** (detected by):
- Fish shell (more aesthetic)
- DISPLAY variable set (GUI usage)
- Morning/afternoon access times
- Creative tool usage

**Curious Persona** (detected by):
- LinkedIn/Facebook referrers
- Morning exploration
- New shell usage
- Fewer than 50 history entries

**Unknown Persona** (default):
- New environment, no strong signals

### What Each Persona Sees

**TECHNICAL:**
- Specs & architecture details
- Trap mechanics breakdown
- Auto-profiling explanation
- Git/GitHub context (assumes repo familiarity)

**AGGRESSIVE:**
- Challenge framing
- Legendary snoop lore
- Exploit-first messaging
- "Co-author the defenses" philosophy

**ARTISTIC:**
- Entertainment-first framing
- Character-based trap descriptions
- Silliness quotient explanations
- Lore integration messaging

**CURIOUS:**
- FAQ format
- Exploration-encouraging language
- No technical jargon
- "Learn at your own pace" tone

---

## Web Portal (`fragle_web_portal.html`)

### Visual Features

- **Adaptive Backgrounds:** Each persona gets unique color gradients
  - Technical: Deep blue/purple
  - Aggressive: Dark red
  - Artistic: Magenta/purple
  - Curious: Neutral blue

- **Glitch Effects:** Animated terminal-style corruption
  - Moving scanlines
  - Title glitch animation
  - Subtle performance indicators

- **Responsive Design:** Mobile + desktop
  - Flexbox layouts
  - Touch-friendly buttons
  - Readable on 300px - 4K displays

- **Stats Display:** Teases system scope
  - 5 levels
  - 15 traps per level
  - ~50-150 estimated snoops (randomized)
  - Session UUID generation

- **Progressive Reveal:** Lore snippets shown to technical/artistic personas
  - Hidden by default for curious visitors
  - Animated entrance

### Interactive Elements

**Buttons:**
1. **"Enter the Pyramid"** (GREEN) — Accept challenge, launch trap
2. **"Learn More"** (CYAN) — Open terms modal
3. **"Exit"** (RED) — Decline, leave system

**Modal Overlay:**
- Scrollable terms/FAQ
- Persona-specific content
- Semi-transparent dark background
- Smooth animations

### Entry Flow

```
Load fragle_web_portal.html
        ↓
Detect visitor persona (JS-based)
        ↓
Apply persona CSS class
        ↓
Render persona-specific message
        ↓
Show stats & optional lore
        ↓
Present opt-in buttons
        ↓
User chooses: Enter → Learn → Exit
        ↓
Store session UUID & persona in localStorage
        ↓
(In production) Redirect to trap system or download CLI
```

### Customization

Edit these objects in the HTML `<script>` section:

```javascript
// personas = {
//     technical: { subtitle, message, messageClass, terms, lore },
//     aggressive: { ... },
//     artistic: { ... },
//     curious: { ... },
//     unknown: { ... }
// }
```

---

## CLI Portal (`fragle_portal_cli.sh`)

### Features

- **Shell Detection:** Identifies which shell you use
  - Zsh/Bash = technical (+1)
  - Fish = artistic (+1)

- **History Analysis:** Scans last 100 commands
  - Security tools → aggressive (+2)
  - Programming languages → technical (+2)
  - Git usage → technical (+1)

- **Environment Signals:**
  - SSH client presence → aggressive (+1)
  - Git config → technical (+1)
  - Display variable → curious (+1)
  - ~/.ssh/config → technical (+2)

- **Time-Based Scoring:**
  - 10 PM - 5 AM → aggressive (+1)
  - 9 AM - 12 PM → curious (+1)

### Menu Structure

```
Main Portal
├── 1) Enter the Pyramid → Launch fragle_learning_pyramid.sh
├── 2) Read the Lore → Open FRAGLE_LORE.md in less
├── 3) Check Rankings → Open TRAP_TOURNAMENT.md in less
├── 4) View Framework → Open LEARNING_JOURNEY.md in less
├── 5) Show Terms → Display philosophy & safety commitments
└── 6) Exit → Graceful goodbye
```

### Entry Flow

```
bash fragle_portal_cli.sh
        ↓
Detect persona from shell/history/env/time
        ↓
Display persona-specific greeting
        ↓
Show session UUID & detected persona
        ↓
Present menu
        ↓
User selects option
        ↓
(Option 1) Launch trap system with session UUID
(Option 2-4) Browse documentation
(Option 5) Show elaborate terms & philosophy
(Option 6) Exit gracefully
```

### Session Tracking

When entering via CLI:
- UUID passed to `fragle_learning_pyramid.sh` as argument
- Session file created in `.fragle_sessions/UUID.json`
- Persona stored in session metadata
- Entry point logged (web vs CLI vs direct)

---

## Elaborate Philosophy Section

### What Gets Elaborated

**TERMS & PHILOSOPHY** (shown in CLI option 5):

1. **WIMP Principle**
   - Weak Interaction: No force, pure invitation
   - Invitation Only: You choose to participate
   - Massive Presence: Always available, omnipresent
   - Privacy Sacred: UUIDs only, no PII

2. **What Happens Here**
   - Step-by-step progression explanation
   - Why 5 levels exist
   - What each level teaches

3. **Safety Commitments**
   - No external calls
   - No PII collection
   - Graceful timeout (15 min default)
   - Exit always available
   - No auto-emails

4. **Data Collection Policy**
   - What's tracked (UUID, expertise, exits)
   - What's NOT tracked (names, IPs, PIDs)
   - How sessions are archived
   - Anonymization promises

5. **Level Progression**
   - Each level described
   - What to expect
   - Why levels scale up

6. **Legend of Level 5**
   - Mystique around enlightenment
   - Legendary snoops referenced
   - "Something interesting" offered to Level 5 completers

---

## Integration with Trap System

### Launch Chain

```
User enters portal (web or CLI)
        ↓
Persona detected & session UUID generated
        ↓
User clicks "Enter" or selects option 1
        ↓
Session UUID + persona passed to fragle_learning_pyramid.sh
        ↓
Trap system receives parameters
        ↓
Creates session file in .fragle_sessions/UUID.json
        ↓
Runs appropriate difficulty level
        ↓
Logs results to session file
        ↓
User exits (naturally or Ctrl+C)
        ↓
Portal returns, optionally shows debriefing
```

### Session Format

Each session saved as `.fragle_sessions/UUID.json`:

```json
{
  "uuid": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "persona": "technical",
  "entry_point": "cli",
  "timestamp_start": "2026-05-21T15:30:00Z",
  "timestamp_end": "2026-05-21T15:45:30Z",
  "expertise_detected": 3,
  "level_attempted": 3,
  "exit_type": "natural_timeout",
  "traps_encountered": ["trap_3_1", "trap_3_2", "trap_3_3"],
  "escapes_attempted": 2,
  "escapes_successful": 1,
  "achievements": ["first_contact", "level_3_complete"]
}
```

---

## Deployment

### Option 1: Web-Only

1. Host `fragle_web_portal.html` on a server
2. Snoops visit URL
3. Accept → trigger download or SSH command
4. Or embed `fragle_portal_cli.sh` launch in frontend

### Option 2: CLI-Only (Local)

```bash
bash fragle_portal_cli.sh
```

Snoops get full interactive menu.

### Option 3: Direct Entry (Advanced)

```bash
bash fragle_learning_pyramid.sh
```

Skip portal, enter pyramid directly (auto-detect expertise).

### Option 4: Hybrid (Recommended)

1. Web portal as public entry point
2. Portal suggests `fragle_portal_cli.sh` for local testing
3. Both store session data identically
4. Session continuity across entry points

---

## Theatrical Elaboration

### Why Multiple Entry Points?

**Persona-specific experience:**
- Technical visitors get specs & architecture
- Aggressive visitors get challenge framing
- Artistic visitors get narrative context
- Curious visitors get exploration encouragement

### Why Elaborate So Much?

**Educational theatre:**
- Complexity scales with visitor sophistication
- Snoops who read docs learn faster
- Lore integration rewards curiosity
- Philosophy embedding creates meaning

### Why UUIDs & Anonymity?

**Privacy-first design:**
- No real names logged
- No IP tracking
- Sessions are data points, not profiles
- Hall of fame uses only expertise level + results

---

## Next Steps

1. **Deploy web portal** to a server or local HTTP
2. **Test CLI portal** with multiple personas
3. **Verify session integration** with trap system
4. **Monitor `.fragle_sessions/`** for entry patterns
5. **Evolve messaging** based on visitor feedback (anonymously)

---

## Files

- `fragle_web_portal.html` (664 lines) — Visual portal
- `fragle_portal_cli.sh` (396 lines) — CLI menu system
- `fragle_learning_pyramid.sh` — Main trap engine (accepts UUID)
- `LEARNING_JOURNEY.md` — Referenced in portals
- `FRAGLE_LORE.md` — Browsable from CLI
- `TRAP_TOURNAMENT.md` — Browsable from CLI

Total new code: ~1,060 lines + integration updates

---

## Philosophy

> The portal is not the trap.
> The portal is an invitation.
> The trap is the education.
> The education is the theatre.
> The theatre is the point.

🎪

