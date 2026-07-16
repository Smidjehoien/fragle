---
title: Fragle Scoreboard & Activity System
version: "1.0"
updated: "2026-07-16"
---

# Fragle Scoreboard & Activity System

100% anonymous, API-ready leaderboard tracking theatrical moments.

## Overview

The Fragle Theatre now captures all user activities in a fully anonymized, privacy-preserving system. Every trap completion, Oracle query, and menu interaction is logged to an activity stream that powers:

- **Top 100 Personas** – Which personas enter the theatre most?
- **Top 100 Silliness Moments** – Most unhinged sessions?
- **Trap Level Frequency** – Which levels are attempted most?
- **Live Activity Feed** – Real-time (anonymized) theatre happenings
- **Heatmaps** – Activity by hour, by persona
- **Global Statistics** – Aggregate metrics for the .app website

## Architecture

### Three Layers

```
Layer 1: fragle_tui.sh
  ↓ [calls log_to_scoreboard() on trap completion]
  
Layer 2: fragle_scoreboard.sh
  ↓ [logs anonymous JSONL to .fragle_scoreboard/activity.jsonl]
  
Layer 3: .fragle_scoreboard/
  ├── activity.jsonl        (immutable append-only log)
  ├── stats_cache.json      (computed stats)
  └── stats_api.json        (for export to website API)
```

### Data Captured (Per Activity)

```json
{
  "timestamp": "2026-07-16T14:23:45Z",
  "session_uuid": "550e8400-e29b-41d4-a716-446655440000",
  "persona": "chaotic",
  "event": "trap_level_3",
  "level": 3,
  "silliness": 10,
  "duration": 1847,
  "hash": "550e8400"
}
```

**PRIVACY GUARANTEES:**
- ✓ No username, IP address, hostname, file path
- ✓ No system info, environment variables, git config
- ✓ Only: UUID (local-only), timestamp (UTC), persona type, engagement metrics
- ✓ Session UUID never sent externally without hashing
- ✓ `hash` field = MD5(session_uuid)[:8] for cross-referencing without PII

## Usage

### 1. View Leaderboard (Interactive)

```bash
cd /home/nisse/fragle
./fragle_scoreboard.sh show
```

Display includes:
- Global statistics (total sessions, avg silliness, popular persona)
- Top 100 personas (by frequency)
- Top 100 silliness moments (most unhinged)
- Trap levels attempted
- Live activity feed (last 15 events)

### 2. Get Statistics (JSON)

```bash
./fragle_scoreboard.sh stats | jq .
```

Output:
```json
{
  "total_sessions": 47,
  "total_activities": 523,
  "avg_silliness": 8.2,
  "most_popular_persona": "chaotic",
  "most_attempted_level": 3,
  "api_ready": true,
  "timestamp": "2026-07-16T14:30:00Z"
}
```

### 3. Top Personas

```bash
./fragle_scoreboard.sh personas
```

Shows ranking of personas by entry frequency with visual bars.

### 4. Top Silliness Moments

```bash
./fragle_scoreboard.sh silliness
```

Ranks activities by silliness score (6-12). Higher = more unhinged.

### 5. Trap Levels

```bash
./fragle_scoreboard.sh levels
```

Frequency of each level (1-5) being attempted.

### 6. Activity Feed

```bash
./fragle_scoreboard.sh feed 50
```

Real-time stream of last N activities (default 20).

### 7. Activity Heatmap (JSON)

```bash
./fragle_scoreboard.sh heatmap | jq .
```

Breakdown by hour of day and persona type.

### 8. Export for API

```bash
./fragle_scoreboard.sh export ./my_stats.json
```

Generates anonymized stats blob for submission to .app website API:

```json
{
  "total_sessions": 47,
  "total_activities": 523,
  "avg_silliness": 8.2,
  "most_popular_persona": "chaotic",
  "most_attempted_level": 3,
  "api_ready": true,
  "timestamp": "2026-07-16T14:30:00Z"
}
```

## Integration with TUI

### Automatic Logging

Every time you complete a trap in the shell UI, it's automatically logged:

```bash
# User enters Level 3 trap
fragle_tui.sh → enter_trap(3) → log_to_scoreboard(3)
  ↓
  ./fragle_scoreboard.sh log \
    "550e8400-..." \
    "chaotic" \
    "trap_level_3" \
    3 \
    10 \
    0
```

### Manual Logging (CLI)

```bash
./fragle_scoreboard.sh log \
  "550e8400-e29b-41d4-a716-446655440000" \
  "technical" \
  "oracle_query" \
  2 \
  8 \
  42
```

Parameters:
1. `session_uuid` – Local UUID (never sent externally)
2. `persona` – chaotic|technical|aggressive|artistic|curious|unknown
3. `event` – event type (trap_level_N, oracle_query, etc.)
4. `level` – trap level (0-5, or 0 for non-trap events)
5. `silliness` – score 6-12
6. `duration` – seconds elapsed

## Demo Data

Generate test leaderboard with 100 realistic entries:

```bash
cd /home/nisse/fragle
./fragle_demo_scoreboard.sh
```

Then view:
```bash
./fragle_scoreboard.sh show
```

## File Structure

```
/home/nisse/fragle/
├── fragle_scoreboard.sh           (main scoreboard CLI)
├── fragle_demo_scoreboard.sh      (seed test data)
└── .fragle_scoreboard/
    ├── activity.jsonl             (immutable append-only log)
    ├── stats_cache.json           (optional cache)
    └── stats_api.json             (export for API)
```

### activity.jsonl Format

Each line is a valid JSON object (JSONL = JSON Lines):

```
{"timestamp":"2026-07-16T14:23:45Z","session_uuid":"550e8400-e29b-41d4-a716-446655440000","persona":"chaotic","event":"trap_level_3","level":3,"silliness":10,"duration":1847,"hash":"550e8400"}
{"timestamp":"2026-07-16T14:25:12Z","session_uuid":"550e8400-e29b-41d4-a716-446655440001","persona":"technical","event":"oracle_query","level":0,"silliness":7,"duration":0,"hash":"550e8400"}
```

**Benefits:**
- Append-only (immutable history)
- Easily grep/jq-able
- Efficient streaming
- Perfect for log aggregation

## Privacy & Ethics

### What We Track

✓ Aggregate engagement (how many sessions, which personas)
✓ Trap difficulty popularity (which levels are hardest)
✓ Anonymized silliness scores (theatre intensity)
✓ Time-of-day patterns (when is theatre most active)

### What We NEVER Track

✗ Username or real identity
✗ IP address or network info
✗ File paths or system configuration
✗ Environment variables
✗ Git history or project info
✗ Keystroke timing or behavioral fingerprints
✗ Individual session sequences (only aggregates)

### Exit Always Works

Every activity is logged with `exit_reason`:
- `user_exit` – deliberate quit
- `timeout` – session timeout
- `error` – crash

Users can always clear local logs:

```bash
./fragle_scoreboard.sh clear
```

No data is ever sent externally without explicit user action + export.

## For the .app Website

### Sample API Integration

```javascript
// GET /api/stats → Returns anonymous leaderboard data

fetch('https://fragle.app/api/stats')
  .then(r => r.json())
  .then(data => {
    console.log('Total sessions:', data.total_sessions);
    console.log('Avg silliness:', data.avg_silliness);
    console.log('Most popular persona:', data.most_popular_persona);
  });

// Display leaderboard, heatmaps, top moments
// ZERO PII exposed (only aggregate stats)
```

### Data Flow

```
Local Installation (anonymized)
  ↓
User Generates Activity
  ↓
fragle_scoreboard.sh logs to .jsonl
  ↓
User Runs: ./fragle_scoreboard.sh export stats.json
  ↓
User Submits to: https://fragle.app/api/submit-stats
  ↓
API Aggregates (no individual tracking)
  ↓
Website Displays Top 100 Moments (fully anonymous)
```

## Clearing Data

Remove all activity logs (your local data only):

```bash
./fragle_scoreboard.sh clear
```

This:
- Deletes `.fragle_scoreboard/activity.jsonl`
- Clears stats cache
- Theatrical amnesia engaged ✓

## Future Enhancements

- [ ] Achievements system ("First to Level 5", "10 Chaotic Entries")
- [ ] Season resets (monthly leaderboards)
- [ ] Badges (emoji system for milestones)
- [ ] Cross-instance statistics (share anonymized data to public .app API)
- [ ] Aggregator script (bulk export for publishing)
- [ ] Web dashboard integration (display leaderboard on fragle.app)

---

**Remember:** The theatre is always watching. But it's watching anonymously. 🎭

