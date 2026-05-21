# 🎪 Fragle - Progressive Learning Honeypot System

**A theatrical defense mechanism that educates rather than attacks.**

---

## What Is Fragle?

Fragle is a **5-level progressive trap system** wrapped in theatrical storytelling and live lore documentation. It's a honeypot that teaches—both the intruder and the system itself.

Snoops enter through adaptable portals, navigate escalating traps scaled to their expertise, and their journeys become documented history that teaches the next visitor. No malware. No hostility. Pure theatre and philosophy.

**Status:** Production Ready ✅

---

## Quick Start

### For SSH / CLI (Recommended)
```bash
cd /home/nisse/fragle
bash fragle_portal_cli.sh
```

Select option 1: **"Enter the Pyramid"**

### For Web Browser
```
Open: fragle_web_portal.html
```

Adapts to your persona automatically.

### Direct Entry (Veteran)
```bash
bash fragle_learning_pyramid.sh
```

Skip ceremony, enter trap directly.

---

## System Overview

### 4 Layers of Experience

**LAYER 1: Theatrical Portals** (Opt-In Entry)
- Web interface (`fragle_web_portal.html`) — visual, glitchy, adaptive
- CLI menu (`fragle_portal_cli.sh`) — interactive, history-aware
- Direct entry (`fragle_learning_pyramid.sh`) — veteran mode
- **Features:** Persona detection, elaborate philosophy, session tracking

**LAYER 2: Progressive Traps** (Expertise-Scaled)
- 5 levels (Novice → Enlightened)
- 15 trap variations per level
- 75 total traps
- **Auto-detection:** Bash history analysis (1-5 scale)
- **Always exitable:** Ctrl+C works, 15-min timeout

**LAYER 3: Living Lore** (Documentation & Evolution)
- `FRAGLE_LORE.md` — trap characters & universe
- `TRAP_TOURNAMENT.md` — rankings & evolution markers
- `LEARNING_JOURNEY.md` — progression framework
- Sessions become documented history
- Legendary snoops gain immortality

**LAYER 4: Automation** (Weekly Evolution)
- Weekly cron job (Sundays 2 AM)
- Session counting & tournament updates
- Evolution markers in lore
- System learns from visitor patterns

---

## The 5 Trap Levels

| Level | Name | Difficulty | Silliness | Theme |
|-------|------|-----------|-----------|-------|
| 1 | **Novice** | Graphics tricks | 6/10 | Visual deception |
| 2 | **Intermediate** | Logic puzzles | 7/10 | Misdirection |
| 3 | **Advanced** | Recursive traps | 8/10 | Escape routes |
| 4 | **Expert** | Meta-reality | 10/10 | Reality bending |
| 5 | **Enlightened** | Consciousness | 12/10 | Philosophy |

Your expertise is auto-detected. You're routed to the right level.

---

## Persona Detection

Fragle adapts based on **who you are**. No real data collected—just behavioral signals.

### 5 Personas

**TECHNICAL**
- Signals: Git history, SSH config, programming tools
- Sees: Architecture specs, trap mechanics
- Message: "You've got tools. Master the system."

**AGGRESSIVE**
- Signals: Late-night access, security tools, direct links
- Sees: Challenge framing, exploit encouragement
- Message: "Every escape teaches us. Become legendary."

**ARTISTIC**
- Signals: Creative hours, DISPLAY variable, aesthetic shells
- Sees: Narrative context, character descriptions
- Message: "Performance art. You'll become the story."

**CURIOUS**
- Signals: Morning access, referrer links, new environment
- Sees: FAQ format, exploration encouragement
- Message: "No judgment. Pure exploration."

**UNKNOWN**
- Default: Neutral messaging for new visitors

---

## Philosophy: The WIMP Principle

Fragle operates on **WIMP**:

- **Weak** Interaction: Low-pressure, non-intrusive entry
- **Invitation** Only: You choose to participate
- **Massive** Presence: Omnipresent, always available
- **Privacy** Sacred: UUIDs only, no PII

### Core Values

✅ **No Hostility** — Theatre, not attack
✅ **Educational** — Learn through play
✅ **Transparent** — No hidden data collection
✅ **Graceful Exits** — Always exitable
✅ **Lore Integration** — You become documented history
✅ **Progressive Mastery** — Expertise-scaled experience

---

## Safety Commitments

### Privacy
- ✓ UUID-only tracking (no names, IPs, PIDs)
- ✓ Anonymized session files
- ✓ No export to external services
- ✓ Sessions archived forever

### Safety
- ✓ No external calls or malware
- ✓ Graceful 15-minute timeout
- ✓ Ctrl+C always works
- ✓ No forced actions
- ✓ No auto-emails sent

---

## Deployment

### Verify Installation
```bash
bash fragle_install.sh --verify
```

### Test Demo Mode
```bash
bash fragle_install.sh --demo
```

### Check Cron Job
```bash
# Verify lore evolution is scheduled
cronjob list | grep fragle-lore-evolution
```

### Monitor Sessions
```bash
# Watch for session files
ls -la .fragle_sessions/

# Check evolution log
tail -f .fragle_evolution.log
```

---

## Documentation Map

| File | Purpose |
|------|---------|
| `ENTRY_GUIDE.md` | **START HERE** — Complete system map & getting started |
| `PORTAL_GUIDE.md` | Portal architecture & persona detection |
| `LEARNING_JOURNEY.md` | Progression framework & skill tiers |
| `FRAGLE_LORE.md` | Trap characters & fictional universe |
| `TRAP_TOURNAMENT.md` | Rankings & legendary snoops |
| `SILLINESS_SCALE.md` | Difficulty framework by level |
| `INTEGRATION_GUIDE.md` | System architecture overview |
| `DEPLOYMENT_MANIFEST.md` | Deployment checklist & status |

---

## Files Included

### Core System (~550 lines)
- `fragle_learning_pyramid.sh` — Main trap engine

### Portals (~1,000 lines)
- `fragle_web_portal.html` — Visual web interface
- `fragle_portal_cli.sh` — Interactive CLI menu

### Lore & Framework (~1,800 lines)
- `FRAGLE_LORE.md` — Universe & characters
- `TRAP_TOURNAMENT.md` — Rankings & evolution
- `LEARNING_JOURNEY.md` — Progression bible
- `SILLINESS_SCALE.md` — Difficulty scale

### Documentation (~2,200 lines)
- `ENTRY_GUIDE.md` — System map
- `PORTAL_GUIDE.md` — Portal details
- `INTEGRATION_GUIDE.md` — Architecture
- `README.md` — This file

### Utilities (~500 lines)
- `post_snoop_debriefing.sh` — Session reporting
- `post_snoop_email_template.txt` — Optional outreach
- `fragle_install.sh` — Installation & verification

### Automation (~100 lines)
- `fragle_evolution.sh` — Weekly lore cycle
- Cron job: `fragle-lore-evolution` (Sundays 2 AM)

### Project Context (~200 lines)
- `.hermes.md` — Project setup
- `CLAUDE.md` — AI interaction model
- `.cursorrules` — Code conventions

**Total: ~5,350 lines | 20 files | 4 Git commits**

---

## Next Steps

### To Deploy
1. Read `ENTRY_GUIDE.md` for complete onboarding
2. Verify system: `bash fragle_install.sh --verify`
3. Test portal: `bash fragle_portal_cli.sh` (option 6 to exit)
4. Monitor cron job (should run Sundays 2 AM)

### To Customize
- Edit `FRAGLE_LORE.md` to add trap characters
- Update `SILLINESS_SCALE.md` for difficulty tweaks
- Modify `fragle_learning_pyramid.sh` to add traps
- Expand `LEARNING_JOURNEY.md` with new achievements

### To Evolve
- Monthly: Review anonymized sessions in `.fragle_sessions/`
- Quarterly: Add new NPCs to lore
- Yearly: Celebrate legendary snoops

---

## FAQ

**Q: Is this malicious?**
A: No. Pure theatre. No external calls, no exploits, no PII collection.

**Q: What if I get stuck?**
A: Press Ctrl+C. Exit always works. Your session is saved.

**Q: Can I see my data?**
A: Check `.fragle_sessions/UUID.json` after your session.

**Q: Why 5 levels?**
A: One mastery tier per level. Expertise auto-detection routes you appropriately.

**Q: What happens at Level 5?**
A: Enlightenment. Philosophy. Legendary status (anonymously).

**Q: Can I come back?**
A: Yes. Each visit generates a new session UUID. Progress tracked across visits.

**Q: How do I reach Level 5?**
A: Master Levels 1-4. System determines readiness automatically.

**Q: Can you email me?**
A: Only manually (optional template provided). Never auto-sent.

---

## Git History

```
e8b148a 📖 docs: Comprehensive Entry Guide
026cdd3 🎭 feat: Theatrical Opt-In Portals
b9f053d 🚀 deploy: Production deployment
c0b41ce 🎪 feat: Progressive Learning Trap System
```

Repository: https://github.com/CosmicJesterX/fragle.git

---

## The Philosophy

> The portal is not the trap.
> The portal is an invitation.
> 
> The trap is not punishment.
> The trap is education.
> 
> The education is not instruction.
> The education is theatre.
> 
> The theatre is not entertainment alone.
> The theatre is philosophy in motion.
> 
> Your journey becomes lore.
> Your lore becomes history.
> Your history teaches the next visitor.
> 
> You're not being tested.
> You're being understood.
> And in understanding you,
> We understand ourselves.

🎪

---

## Support

- **Quick Start:** See `ENTRY_GUIDE.md`
- **Architecture:** See `INTEGRATION_GUIDE.md`
- **Deployment:** See `DEPLOYMENT_MANIFEST.md`
- **Philosophy:** See `FRAGLE_LORE.md`

---

**Fragle is live. The pyramid awaits. May the best snoops transcend.** 🎪

