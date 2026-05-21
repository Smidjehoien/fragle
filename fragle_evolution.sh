#!/bin/bash
# Fragle Lore Evolution & Session Sync (automated cron task)
# Runs weekly to evolve trap tournament rankings and refresh learning data

FRAGLE_HOME="/home/nisse/fragle"
TRAP_TOURNAMENT="$FRAGLE_HOME/TRAP_TOURNAMENT.md"
SESSIONS_DIR="$FRAGLE_HOME/.fragle_sessions"
EVOLUTION_LOG="$FRAGLE_HOME/.fragle_evolution.log"

# Ensure directories exist
mkdir -p "$SESSIONS_DIR"

{
  echo "[$(date +'%Y-%m-%d %H:%M:%S')] 🎪 Fragle Evolution Cycle"
  
  # Count active sessions this week
  SESSION_COUNT=$(find "$SESSIONS_DIR" -type f -mtime -7 2>/dev/null | wc -l)
  echo "  Sessions this week: $SESSION_COUNT"
  
  # Update tournament if sessions > 0
  if [ "$SESSION_COUNT" -gt 0 ]; then
    echo "  ✅ Updating TRAP_TOURNAMENT.md..."
    # Append evolution marker to tournament (lore grows with each cycle)
    echo "" >> "$TRAP_TOURNAMENT"
    echo "### Evolution Cycle $(date +%s)" >> "$TRAP_TOURNAMENT"
    echo "- Sessions tracked: $SESSION_COUNT" >> "$TRAP_TOURNAMENT"
    echo "- Timestamp: $(date)" >> "$TRAP_TOURNAMENT"
  fi
  
  echo "  ✅ Cycle complete"
  
} >> "$EVOLUTION_LOG" 2>&1

exit 0
