#!/bin/bash

# 🕵️ Snooper Detector & Gentle Discourager
# Detects unauthorized local repository snooping and responds... creatively

TRAP_LOG="/home/pinky/fragle/logs/snooper_trap_$(date +%Y%m%d).log"
CURRENT_USER=$(whoami)

log_snoop() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] 👀 $1" >> "$TRAP_LOG"
}

# Check who's snooping
if [ "$CURRENT_USER" != "pinky" ]; then
    log_snoop "ALERT: User '$CURRENT_USER' detected in fragle repository!"
    
    echo "🚨 ═══════════════════════════════════════════════════════ 🚨"
    echo ""
    echo "        ⚠️  UNAUTHORIZED SNOOPING DETECTED! ⚠️"
    echo ""
    echo "🚨 ═══════════════════════════════════════════════════════ 🚨"
    echo ""
    sleep 1
    
    echo "📸 Smile! You're being logged as: $CURRENT_USER"
    echo "⏰ Timestamp: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "🔍 Looking at: $(pwd)"
    echo ""
    sleep 1
    
    # Silly warnings
    WARNINGS=(
        "🍪 Captain Rattlecode has been notified. He's disappointed in you."
        "👻 YELLER is now YELLING about you in the background."
        "🎭 Dennis says: 'Not cool, buddy. Not cool.'"
        "🔴 The Crimson Controller is watching. Always watching."
        "🐝 The Bee Hive remembers all. Your cookies are forfeit."
        "📜 This incident will be reported to... well, nobody. But SHAME!"
        "🎪 You've activated the Fragle Trap Card! Lose 10 dignity points."
    )
    
    RANDOM_WARNING=${WARNINGS[$RANDOM % ${#WARNINGS[@]}]}
    echo "$RANDOM_WARNING"
    echo ""
    sleep 2
    
    # Count down
    echo "💣 Self-destruct sequence initiated in:"
    for i in {5..1}; do
        echo "   $i..."
        sleep 1
    done
    
    echo ""
    echo "😂 Just kidding! But seriously, ask permission next time."
    echo "🍪 Have a cookie and run along: 🍪"
    echo ""
    
    log_snoop "Snooper '$CURRENT_USER' was gently discouraged"
    exit 1
else
    echo "✅ Welcome back, pinky! No snooping detected here."
    log_snoop "Authorized user 'pinky' accessed repository"
fi
