#!/bin/bash

# 🎪 The Patience Tester
# Adds increasingly ridiculous delays for persistent snoopers

PATIENCE_FILE="/tmp/fragle_patience_$(whoami)"
PATIENCE_LOG="/home/pinky/fragle/logs/patience_test_$(date +%Y%m%d).log"

# Track patience level
if [ -f "$PATIENCE_FILE" ]; then
    PATIENCE_LEVEL=$(cat "$PATIENCE_FILE")
else
    PATIENCE_LEVEL=1
fi

echo "[$(date '+%Y-%m-%d %H:%M:%S')] User $(whoami) - Patience Level $PATIENCE_LEVEL" >> "$PATIENCE_LOG"

echo "⏳ REPOSITORY LOADING SEQUENCE"
echo "=============================="
echo ""

case $PATIENCE_LEVEL in
    1)
        echo "🚀 Fast loading enabled!"
        sleep 1
        echo "✅ Ready!"
        ;;
    2)
        echo "⚙️  Standard loading..."
        sleep 2
        echo "📦 Unpacking files..."
        sleep 1
        echo "✅ Ready!"
        ;;
    3)
        echo "🐌 Slightly slower today..."
        sleep 2
        echo "📂 Reading files..."
        sleep 2
        echo "🔍 Verifying..."
        sleep 1
        echo "✅ Ready!"
        ;;
    4)
        echo "🕐 Loading might take a moment..."
        sleep 3
        echo "📊 Processing..."
        sleep 2
        echo "🔧 Optimizing..."
        sleep 2
        echo "✅ Ready! (Finally)"
        ;;
    5)
        echo "⏰ This is taking longer than usual..."
        echo ""
        sleep 2
        echo "Phase 1: Initialization..."
        sleep 3
        echo "Phase 2: Allocation..."
        sleep 3
        echo "Phase 3: Configuration..."
        sleep 2
        echo ""
        echo "✅ Done! (Hope you had coffee)"
        ;;
    6-7)
        echo "🐢 ULTRA SLOW MODE ACTIVATED"
        echo "(Because you keep coming back)"
        echo ""
        sleep 3
        echo "⏳ Loading: [          ] 10%"
        sleep 2
        echo "⏳ Loading: [███       ] 30%"
        sleep 3
        echo "⏳ Loading: [██████    ] 60%"
        sleep 3
        echo "⏳ Loading: [█████████ ] 90%"
        sleep 4
        echo "⏳ Loading: [██████████] 100%"
        echo ""
        echo "✅ Complete! (That was painful, wasn't it?)"
        ;;
    8-10)
        echo "🎪 RIDICULOUS DELAY MODE"
        echo ""
        sleep 2
        echo "You've triggered this $PATIENCE_LEVEL times."
        echo "Now you must suffer the consequences..."
        echo ""
        sleep 3
        echo "⏳ Calculating quantum fluctuations..."
        sleep 4
        echo "🌌 Consulting the cosmic database..."
        sleep 4
        echo "🔮 Reading ancient scrolls..."
        sleep 3
        echo "☕ Making coffee for the server..."
        sleep 4
        echo "🎲 Rolling for initiative..."
        sleep 3
        echo "💤 Waking up the hamster in the server room..."
        sleep 4
        echo ""
        echo "✅ Finally ready! ($((PATIENCE_LEVEL * 3)) seconds wasted)"
        ;;
    *)
        echo "🤦 MAXIMUM ANNOYANCE MODE"
        echo ""
        echo "Patience Level: $PATIENCE_LEVEL"
        echo "This will take a while..."
        echo ""
        
        # Ridiculously long delay
        for i in {1..5}; do
            sleep 3
            echo "⏳ Still loading... ($((i * 3))s elapsed)"
        done
        
        echo ""
        echo "💡 Fun fact: This is intentionally slow"
        echo "   because you keep coming back!"
        echo ""
        
        sleep 3
        echo "🎯 Current wait time: $((PATIENCE_LEVEL * 2)) seconds"
        echo "🎯 Expected wait time: Forever"
        echo ""
        
        sleep 2
        echo "✅ Done! Hope it was worth the wait! (It wasn't)"
        ;;
esac

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Patience Statistics:"
echo "   Times visited: $PATIENCE_LEVEL"
echo "   Time wasted: ~$((PATIENCE_LEVEL * 5)) seconds"
echo "   Regret level: $([ $PATIENCE_LEVEL -gt 7 ] && echo "Maximum" || echo "Building")"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━"

# Increment for next time
((PATIENCE_LEVEL++))
echo "$PATIENCE_LEVEL" > "$PATIENCE_FILE"

echo ""
echo "💡 Tip: The more you visit, the slower it gets!"
echo "🎭 (This is a feature, not a bug)"
