#!/bin/bash

# 🎯 Fragle Activity Logger
# Logs all the silly things happening in your local repository

LOG_DIR="/home/pinky/fragle/logs"
LOG_FILE="$LOG_DIR/fragle_activity_$(date +%Y%m%d).log"

# Create logs directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Function to write log entries
log_entry() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local message="$1"
    echo "[$timestamp] $message" >> "$LOG_FILE"
    echo "✅ Logged: $message"
}

# Welcome message
echo "📝 Fragle Activity Logger Initialized!"
echo "📂 Log location: $LOG_FILE"
echo ""

# Log the start
log_entry "🎪 Fragle Logger started"

# Log repository info
REPO_NAME=$(basename "$(pwd)")
log_entry "📍 Repository: $REPO_NAME"

# Log git status if in a git repo
if [ -d .git ]; then
    BRANCH=$(git branch --show-current 2>/dev/null)
    log_entry "🌿 Current branch: $BRANCH"
    
    # Count uncommitted changes
    CHANGES=$(git status --short | wc -l)
    log_entry "📊 Uncommitted changes: $CHANGES files"
fi

# Log system info
log_entry "💻 User: $USER"
log_entry "🖥️  Hostname: $(hostname)"

# Log some fun stuff
COOKIE_COUNT=$((RANDOM % 100))
log_entry "🍪 Cookie count today: $COOKIE_COUNT"

# Log crew member on duty
CREW=("Captain Rattlecode" "Gumball the Whisperer" "Bobby Blip" "YELLER" "Dennis")
ON_DUTY=${CREW[$RANDOM % ${#CREW[@]}]}
log_entry "👤 Crew member on duty: $ON_DUTY"

# Show recent logs
echo ""
echo "📜 Recent log entries:"
echo "===================="
tail -n 10 "$LOG_FILE"

echo ""
echo "🎉 Logging complete! Your activities are now recorded for posterity (and giggles)."
echo ""
echo "💡 To view full log: cat $LOG_FILE"
echo "💡 To watch log live: tail -f $LOG_FILE"
