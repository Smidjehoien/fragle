#!/bin/bash

# 🎯 Smart Snooper Detector with Whitelist
# Only trolls unauthorized users, welcomes friends!

WHITELIST_FILE="/home/pinky/fragle/.whitelist"
TRAP_LOG="/home/pinky/fragle/logs/snooper_trap_$(date +%Y%m%d).log"
CURRENT_USER=$(whoami)

log_snoop() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] 👀 $1" >> "$TRAP_LOG"
}

# Check if user is whitelisted
is_whitelisted() {
    local user="$1"
    if [ -f "$WHITELIST_FILE" ]; then
        # Check if user exists in whitelist (ignore comments and blank lines)
        if grep -q "^${user}$" "$WHITELIST_FILE" 2>/dev/null; then
            return 0  # User is whitelisted
        fi
    fi
    return 1  # User is NOT whitelisted
}

# Main logic
if is_whitelisted "$CURRENT_USER"; then
    echo "✅ Welcome, $CURRENT_USER! You're on the guest list."
    echo "🍪 Help yourself to the cookies!"
    log_snoop "Whitelisted user '$CURRENT_USER' accessed repository - WELCOME!"
    exit 0
fi

# If not whitelisted, activate the trap!
log_snoop "ALERT: Non-whitelisted user '$CURRENT_USER' detected!"

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

# Helpful message
echo "💡 TIP: If you're a friend, ask pinky to add you to .whitelist"
echo "📝 Your username for whitelist: $CURRENT_USER"
echo ""
sleep 1

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

log_snoop "Snooper '$CURRENT_USER' was gently discouraged (not whitelisted)"
exit 1
