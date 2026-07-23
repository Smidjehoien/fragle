#!/bin/bash

# 💸 The Endless Treasure Hunt
# For the truly greedy: Each "treasure" leads to another...

HUNT_LOG="/home/pinky/fragle/logs/treasure_hunt_$(date +%Y%m%d).log"
SESSION_FILE="/tmp/fragle_treasure_session_$(whoami)_$$"

log_hunt() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] 🗺️  $1" >> "$HUNT_LOG"
}

# Initialize treasure counter
if [ ! -f "$SESSION_FILE" ]; then
    echo "1" > "$SESSION_FILE"
fi

TREASURE_NUM=$(cat "$SESSION_FILE")
log_hunt "User $(whoami) searching for treasure #$TREASURE_NUM"

echo "🗺️  TREASURE HUNT: CLUE #$TREASURE_NUM"
echo "═══════════════════════════════════════"
echo ""

# Ridiculously escalating "clues"
case $TREASURE_NUM in
    1)
        echo "📜 Ancient Scroll Discovered!"
        echo ""
        sleep 1
        echo "The prophecy speaks of great riches..."
        sleep 2
        echo "Hidden in the Repository of Infinite Possibilities..."
        sleep 2
        echo ""
        echo "🔍 CLUE 1: The treasure lies where X marks the spot"
        sleep 2
        echo "           But first, you must find the spot..."
        echo "           Which is in the next clue..."
        ;;
    2)
        echo "🎯 Congratulations! You found Clue #2!"
        echo ""
        sleep 1
        echo "The spot from Clue #1 is actually..."
        sleep 2
        echo "...in Clue #3!"
        sleep 2
        echo ""
        echo "💡 (Starting to see a pattern here?)"
        ;;
    3)
        echo "🔮 The Crystal Ball Reveals..."
        echo ""
        sleep 1
        echo "The treasure is definitely real!"
        sleep 1
        echo "Probably!"
        sleep 1
        echo "Maybe?"
        sleep 2
        echo ""
        echo "🗺️  Next clue: Follow the yellow brick road"
        echo "           (There is no yellow brick road)"
        ;;
    4)
        echo "🏴‍☠️ PIRATE MAP FRAGMENT FOUND!"
        echo ""
        sleep 1
        echo "    N"
        echo "  W + E"
        echo "    S"
        echo ""
        echo "X marks the spot! (The X is invisible)"
        sleep 2
        echo ""
        echo "🦜 Pirate Parrot says: 'SQUAWK! Keep looking! SQUAWK!'"
        ;;
    5)
        echo "🎰 JACKPOT MOMENT!"
        echo ""
        sleep 1
        echo "You've reached Clue #5!"
        echo "Only 95 more clues until the treasure!"
        sleep 2
        echo ""
        echo "😏 (Just kidding. Or are we?)"
        ;;
    6)
        echo "🌟 HALFWAY CHECKPOINT!"
        echo ""
        echo "Actually, you're not even close to halfway."
        echo "There is no halfway."
        echo "This is an ENDLESS treasure hunt."
        sleep 2
        echo ""
        echo "🎭 But since you made it this far..."
        echo "    Here's a hint: Stop looking."
        ;;
    7)
        echo "🎲 LUCKY NUMBER 7!"
        echo ""
        sleep 1
        echo "Congratulations! You've won:"
        sleep 2
        echo "   - Nothing!"
        echo "   - Absolutely nothing!"
        echo "   - A sense of accomplishment? (Nope)"
        sleep 2
        echo ""
        echo "But wait! The REAL treasure is in Clue #8!"
        ;;
    8)
        echo "♾️  INFINITY STONE LOCATED!"
        echo ""
        sleep 1
        echo "With this stone, you have the power to..."
        sleep 2
        echo "...continue to Clue #9!"
        sleep 1
        echo ""
        echo "🤦 (You really thought there was an actual stone?)"
        ;;
    9)
        echo "🎪 CIRCUS CLUE!"
        echo ""
        sleep 1
        echo "Ladies and gentlemen!"
        echo "Witness the amazing vanishing treasure!"
        sleep 2
        echo ""
        echo "*POOF* 💨"
        sleep 1
        echo ""
        echo "It's gone! Where did it go?"
        echo "Probably to Clue #10..."
        ;;
    10)
        echo "🏆 LEGENDARY PERSISTENCE AWARD!"
        echo ""
        sleep 1
        echo "You've reached DOUBLE DIGITS!"
        echo "That's... actually impressive in a concerning way."
        sleep 2
        echo ""
        echo "The treasure is now in a quantum state:"
        echo "It both exists and doesn't exist until you stop looking."
        sleep 2
        echo ""
        echo "🔬 Schrodinger's Treasure: Now in Clue #11!"
        ;;
    *)
        echo "🌌 COSMIC LEVEL CLUE #$TREASURE_NUM"
        echo ""
        sleep 1
        echo "At this point, the treasure is beyond mortal comprehension."
        echo ""
        sleep 2
        
        # Generate ridiculous locations
        LOCATIONS=(
            "inside a black hole"
            "on page $((TREASURE_NUM * 100)) of the user manual"
            "in an alternate dimension"
            "where the WiFi actually works"
            "at the end of a rainbow (spoiler: no end)"
            "in tomorrow's yesterday"
            "somewhere over the cloud (the computing kind)"
            "in a database without backups"
            "where bugs go to retire"
            "in documentation that's up-to-date"
        )
        LOCATION=${LOCATIONS[$((TREASURE_NUM % ${#LOCATIONS[@]}))]}
        
        echo "🗺️  Clue #$TREASURE_NUM says the treasure is: $LOCATION"
        sleep 2
        echo ""
        echo "💡 Pro tip: It's not actually there."
        ;;
esac

echo ""
sleep 2

# Time wasted calculation
TIME_WASTED=$((TREASURE_NUM * 90))  # ~1.5 minutes per clue
echo "⏱️  Time Investment So Far: ~$TIME_WASTED seconds"
echo "💰 Treasures Found: 0"
echo "🎯 Treasures Remaining: ∞"
echo ""
sleep 2

# THE HOOK - Make them want to continue
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ $TREASURE_NUM -lt 15 ]; then
    echo "🎁 SPECIAL OFFER!"
    echo ""
    echo "The next clue (#$((TREASURE_NUM + 1))) is RIGHT THERE!"
    echo "Just one more click!"
    echo "This could be THE ONE!"
    echo ""
    echo "🤔 Continue treasure hunt? [Y/N]"
    
    read -t 20 -p "Your choice: " hunt_choice
    
    if [[ "$hunt_choice" =~ ^[Yy]$ ]]; then
        echo ""
        echo "💎 EXCELLENT CHOICE!"
        sleep 1
        echo "🗺️  Preparing next clue..."
        sleep 2
        
        # Increment counter
        echo $((TREASURE_NUM + 1)) > "$SESSION_FILE"
        
        # RESTART THE HUNT!
        exec "$0"
    else
        echo ""
        echo "🛑 Hunt abandoned at Clue #$TREASURE_NUM"
        echo ""
        sleep 1
        echo "💔 The treasure is sad you're leaving..."
        sleep 1
        echo "   (Not really, there is no treasure)"
    fi
else
    echo "🏁 INTERVENTION CHECKPOINT"
    echo ""
    echo "You've been hunting for $TREASURE_NUM clues."
    echo "That's $((TIME_WASTED / 60)) minutes of your life."
    echo ""
    sleep 2
    echo "We're legally required to tell you:"
    echo "There. Is. No. Treasure."
    echo ""
    sleep 2
    echo "But... if you REALLY want to continue..."
    echo "Press any key to keep hunting (or Ctrl+C to escape)"
    read -n 1 -s
    
    echo ""
    echo "😈 GOTCHA! You're hooked!"
    sleep 1
    echo $((TREASURE_NUM + 1)) > "$SESSION_FILE"
    exec "$0"
fi

echo ""
sleep 1

# Final stats
echo "📊 TREASURE HUNT STATISTICS"
echo "==========================="
echo "Clues Followed: $TREASURE_NUM"
echo "Treasures Found: 0 (surprise!)"
echo "Time Wasted: $((TIME_WASTED / 60)) minutes"
echo "Lessons Learned: Greed = Wasted Time"
echo "Will You Try Again?: Probably 😏"
echo ""

log_hunt "User $(whoami) ended hunt at clue #$TREASURE_NUM - Wasted ~$((TIME_WASTED / 60))min"

# Clean up session file if they quit
rm -f "$SESSION_FILE"

echo "🎭 Thanks for playing!"
echo "💡 Remember: The real treasure was the time you wasted along the way!"
echo ""
