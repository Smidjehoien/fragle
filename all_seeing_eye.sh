#!/bin/bash

# 👁️ The All-Seeing Eye
# Watches for suspicious activity and logs EVERYTHING

LOG_FILE="/home/pinky/fragle/logs/all_seeing_eye_$(date +%Y%m%d).log"

echo "👁️  The All-Seeing Eye is now watching..."
echo "📂 Log: $LOG_FILE"
echo ""

log_activity() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# Log activation
log_activity "👁️  All-Seeing Eye activated"

# Monitor who's here
CURRENT_USER=$(whoami)
log_activity "👤 Current user: $CURRENT_USER"
log_activity "📍 Location: $(pwd)"
log_activity "🖥️  Terminal: $TERM"
log_activity "🔌 SSH Connection: ${SSH_CONNECTION:-'No (local)'}"

# Check git activity
if [ -d .git ]; then
    LAST_COMMIT=$(git log -1 --pretty=format:"%h - %s (%cr)" 2>/dev/null)
    log_activity "📝 Last commit: $LAST_COMMIT"
    
    UNCOMMITTED=$(git status --short | wc -l)
    log_activity "📊 Uncommitted files: $UNCOMMITTED"
fi

# Check recent file access
echo "🔍 Checking recently accessed files..."
RECENT_FILES=$(find . -type f -not -path "./.git/*" -mmin -10 2>/dev/null | head -10)
if [ -n "$RECENT_FILES" ]; then
    log_activity "📁 Recently modified files in last 10 minutes:"
    echo "$RECENT_FILES" | while read -r file; do
        log_activity "   📄 $file"
    done
fi

# Log session commands if history is accessible
if [ -f ~/.bash_history ]; then
    RECENT_COMMANDS=$(tail -5 ~/.bash_history 2>/dev/null)
    log_activity "⌨️  Recent commands from history:"
    echo "$RECENT_COMMANDS" | while read -r cmd; do
        log_activity "   > $cmd"
    done
fi

# Philosophical observation
OBSERVATIONS=(
    "🤔 The code is watching you, as you watch the code."
    "🌀 Every keystroke echoes through eternity... or at least the logs."
    "🎭 You are being watched. But don't worry, we're all friends here."
    "🍪 Remember: cookies track you, but these ones taste better."
    "👀 Big Brother called. He wants his surveillance back."
)
RANDOM_OBS=${OBSERVATIONS[$RANDOM % ${#OBSERVATIONS[@]}]}
log_activity "$RANDOM_OBS"

echo ""
echo "✅ Activity logged successfully!"
echo "👁️  The Eye sees all, knows all, logs all."
echo ""
echo "💡 View the log: cat $LOG_FILE"
