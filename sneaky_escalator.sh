#!/bin/bash

# 🕵️ The Sneaky Escalator
# Gradually gets more suspicious as they keep snooping
# They won't even notice until it's too late...

SNEAK_LOG="/home/pinky/fragle/logs/sneaky_escalation_$(date +%Y%m%d).log"
SNOOP_COUNT_FILE="/tmp/fragle_snoop_count_$(whoami)"
LAST_SNOOP_FILE="/tmp/fragle_last_snoop_$(whoami)"

# Track snooping activity
if [ -f "$SNOOP_COUNT_FILE" ]; then
    SNOOP_COUNT=$(cat "$SNOOP_COUNT_FILE")
else
    SNOOP_COUNT=0
fi

# Check time since last snoop
CURRENT_TIME=$(date +%s)
if [ -f "$LAST_SNOOP_FILE" ]; then
    LAST_TIME=$(cat "$LAST_SNOOP_FILE")
    TIME_DIFF=$((CURRENT_TIME - LAST_TIME))
else
    TIME_DIFF=9999
fi

# Increment counter
((SNOOP_COUNT++))
echo "$SNOOP_COUNT" > "$SNOOP_COUNT_FILE"
echo "$CURRENT_TIME" > "$LAST_SNOOP_FILE"

# Log it
echo "[$(date '+%Y-%m-%d %H:%M:%S')] 👁️  Snoop #$SNOOP_COUNT by $(whoami) - Time since last: ${TIME_DIFF}s" >> "$SNEAK_LOG"

# Escalation levels - gets progressively more obvious
case $SNOOP_COUNT in
    1)
        # Completely normal
        echo "📂 Repository contents loaded successfully."
        echo "✅ All systems normal."
        ;;
    2)
        # Subtle hint
        echo "📂 Repository contents loaded."
        echo "✅ All systems normal."
        echo "ℹ️  Tip: Use 'ls -la' to see hidden files."
        ;;
    3)
        # Getting suspicious
        echo "📂 Repository contents loaded."
        echo "⚠️  Note: Some activity has been logged."
        echo "ℹ️  Everything is fine. Probably."
        ;;
    4)
        # More obvious
        echo "📂 Repository contents loaded."
        echo "⚠️  User activity is being monitored."
        echo "🔍 (This is your 4th visit today...)"
        ;;
    5)
        # Can't ignore this
        echo "📂 Repository access granted."
        echo "⚠️  NOTICE: Multiple access attempts detected."
        echo "👀 Someone's curious today!"
        echo "📊 Access count: $SNOOP_COUNT"
        ;;
    6)
        # Getting personal
        echo "📂 Repository access: GRANTED (again)"
        echo "🤔 Hey $(whoami), what are you looking for?"
        echo "💡 Maybe I can help?"
        echo "📊 This is visit #$SNOOP_COUNT"
        ;;
    7)
        # Friendly warning
        echo "📂 Access granted (we're keeping track now)"
        echo "👋 Hello again, $(whoami)!"
        echo "🍪 Want a cookie? You've been here $SNOOP_COUNT times."
        echo "⏱️  Time since last visit: ${TIME_DIFF} seconds"
        echo "💭 (Starting to wonder what you're after...)"
        ;;
    8)
        # More direct
        echo "📂 Repository Access Log Entry #$SNOOP_COUNT"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "👤 User: $(whoami)"
        echo "📊 Visit Count: $SNOOP_COUNT"
        echo "⏱️  Last visit: ${TIME_DIFF}s ago"
        echo "🎯 Pattern: Looking suspicious"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "⚠️  Okay, seriously, what are you looking for?"
        ;;
    9)
        # Intervention approaching
        echo "🚨 REPOSITORY ACTIVITY ALERT 🚨"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "👤 Frequent Visitor: $(whoami)"
        echo "📊 Total Visits: $SNOOP_COUNT"
        echo "⏱️  Obsession Level: High"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        echo "💡 Friendly advice: If you're looking for something"
        echo "   specific, just ask! No need to snoop $SNOOP_COUNT times!"
        ;;
    10)
        # Full intervention
        echo "🛑 ═══════════════════════════════════════ 🛑"
        echo "     REPOSITORY OBSESSION INTERVENTION"
        echo "🛑 ═══════════════════════════════════════ 🛑"
        echo ""
        echo "Dear $(whoami),"
        echo ""
        echo "You've accessed this repository $SNOOP_COUNT times."
        echo "That's... that's a lot."
        echo ""
        echo "Maybe you should:"
        echo "  ☕ Take a coffee break?"
        echo "  🚶 Go for a walk?"
        echo "  📞 Call a friend?"
        echo "  🍪 Have a snack?"
        echo ""
        echo "The repository will still be here when you get back."
        echo "Promise."
        echo ""
        ;;
    *)
        # Beyond help
        echo "🤦 ═══════════════════════════════════════ 🤦"
        echo "     VISIT #$SNOOP_COUNT"
        echo "     YOU HAVE A PROBLEM"
        echo "🤦 ═══════════════════════════════════════ 🤦"
        echo ""
        echo "$(whoami), at this point we're just concerned."
        echo ""
        echo "📈 Snoop Statistics:"
        echo "   • Total visits: $SNOOP_COUNT"
        echo "   • Time since last: ${TIME_DIFF}s"
        echo "   • Addiction level: MAXIMUM"
        echo ""
        if [ $SNOOP_COUNT -eq 15 ]; then
            echo "🎊 SPECIAL MILESTONE: 15 SNOOPS!"
            echo "🏆 You win: ABSOLUTELY NOTHING!"
            echo ""
        fi
        if [ $SNOOP_COUNT -eq 20 ]; then
            echo "🎉 WOW! 20 SNOOPS!"
            echo "🥇 Achievement Unlocked: 'Cannot Stop Snooping'"
            echo "💡 Secret revealed: There are no secrets here!"
            echo ""
        fi
        if [ $SNOOP_COUNT -gt 25 ]; then
            echo "😱 $SNOOP_COUNT TIMES?!"
            echo "🆘 This is an intervention."
            echo "📞 We're calling your family."
            echo "🏥 Snoop-aholics Anonymous meets Thursdays."
            echo ""
        fi
        echo "Please. Just... stop."
        echo ""
        ;;
esac

# Add subtle increasing delays as punishment
if [ $SNOOP_COUNT -gt 5 ]; then
    DELAY=$((SNOOP_COUNT - 5))
    if [ $DELAY -gt 10 ]; then
        DELAY=10
    fi
    echo ""
    echo "⏳ Loading... (this is taking longer because reasons)"
    sleep $DELAY
    echo "✅ Done. (That was a waste of $DELAY seconds, wasn't it?)"
fi

echo ""

# Offer fake "cure" for serial snoopers
if [ $SNOOP_COUNT -ge 8 ] && [ $SNOOP_COUNT -le 12 ]; then
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "💊 SNOOP ADDICTION TREATMENT"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "Press 'C' to reset your snoop counter"
    echo "Press 'Q' to quit snooping forever"
    echo ""
    read -t 10 -n 1 -p "Your choice: " cure_choice
    echo ""
    
    case "$cure_choice" in
        [Cc])
            echo ""
            echo "🔄 Resetting counter..."
            sleep 2
            echo "..."
            sleep 1
            echo "...just kidding! We're keeping count. 😏"
            echo "Current count: STILL $SNOOP_COUNT"
            ;;
        [Qq])
            echo ""
            echo "✅ Excellent choice!"
            sleep 1
            echo "🚪 Exiting..."
            sleep 1
            echo "..."
            sleep 1
            echo "Wait, you're still here? 😏"
            ;;
        *)
            echo ""
            echo "⏱️  Timeout. The cure is: Just stop snooping!"
            ;;
    esac
fi

# Random chance of surprise message for repeat snoopers
if [ $SNOOP_COUNT -gt 6 ]; then
    RANDOM_NUM=$((RANDOM % 5))
    if [ $RANDOM_NUM -eq 0 ]; then
        echo ""
        echo "🎰 SURPRISE MESSAGE:"
        SURPRISES=(
            "💭 Did you think I wouldn't notice?"
            "🎭 Captain Rattlecode is watching your career with great interest."
            "🍪 Fun fact: You've been here $SNOOP_COUNT times. That's $((SNOOP_COUNT * 2)) cookies worth of time."
            "👀 YELLER wants to know: WHY ARE YOU STILL HERE?"
            "🐝 The Bee Hive has voted: You're too curious for your own good."
        )
        SURPRISE=${SURPRISES[$((RANDOM % ${#SURPRISES[@]}))]}
        echo "$SURPRISE"
    fi
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "👋 Thank you for visiting (again)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
