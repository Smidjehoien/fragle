#!/bin/bash

# 🎯 Enhanced Git Activity Logger
# Automatically logs git operations

LOG_DIR="/home/pinky/fragle/logs"
LOG_FILE="$LOG_DIR/git_activity_$(date +%Y%m%d).log"

mkdir -p "$LOG_DIR"

log_git() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local action="$1"
    local details="$2"
    echo "[$timestamp] ⚡ $action | $details" >> "$LOG_FILE"
}

# Main logging
REPO=$(basename "$(pwd)")
BRANCH=$(git branch --show-current 2>/dev/null || echo "not-a-git-repo")

case "$1" in
    commit)
        MESSAGE="$2"
        log_git "COMMIT" "Branch: $BRANCH | Message: $MESSAGE"
        echo "📝 Logged commit to $LOG_FILE"
        ;;
    push)
        log_git "PUSH" "Branch: $BRANCH | Repo: $REPO"
        echo "🚀 Logged push to $LOG_FILE"
        ;;
    pull)
        log_git "PULL" "Branch: $BRANCH | Repo: $REPO"
        echo "⬇️  Logged pull to $LOG_FILE"
        ;;
    checkout)
        NEW_BRANCH="$2"
        log_git "CHECKOUT" "From: $BRANCH → To: $NEW_BRANCH"
        echo "🌿 Logged branch switch to $LOG_FILE"
        ;;
    merge)
        SOURCE="$2"
        log_git "MERGE" "Merging $SOURCE into $BRANCH"
        echo "🔀 Logged merge to $LOG_FILE"
        ;;
    *)
        log_git "OTHER" "Action: $1 | Branch: $BRANCH"
        echo "📋 Logged git activity to $LOG_FILE"
        ;;
esac

# Show last few entries
echo ""
echo "📜 Recent git activities:"
tail -n 5 "$LOG_FILE"
