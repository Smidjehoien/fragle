#!/bin/bash

# 🎭 The Greed Amplifier
# For those who just can't stop clicking "next"...
# Gets progressively more ridiculous with each choice

GREED_LOG="/home/pinky/fragle/logs/greed_trap_$(date +%Y%m%d).log"
STRIKE_FILE="/tmp/fragle_greed_strikes_$(whoami)"

log_greed() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] 💰 $1" >> "$GREED_LOG"
}

# Track how many times they've fallen for this
if [ -f "$STRIKE_FILE" ]; then
    STRIKES=$(cat "$STRIKE_FILE")
else
    STRIKES=0
fi

((STRIKES++))
echo "$STRIKES" > "$STRIKE_FILE"

log_greed "User $(whoami) triggered greed trap - Strike #$STRIKES"

echo "💎 PREMIUM SECRETS VAULT"
echo "========================"
echo ""
sleep 1

# Progressive messages based on strikes
if [ $STRIKES -eq 1 ]; then
    echo "🎁 Welcome! You've discovered the premium vault!"
    echo "📦 This contains our MOST valuable secrets..."
elif [ $STRIKES -eq 2 ]; then
    echo "🤔 Back again? The good stuff is just ahead!"
    echo "💡 (You really want those secrets, don't you?)"
elif [ $STRIKES -eq 3 ]; then
    echo "😏 Third time's the charm, they say..."
    echo "🎰 (Or is it? Let's find out!)"
elif [ $STRIKES -ge 4 ]; then
    echo "🤦 SERIOUSLY?! You're back AGAIN?"
    echo "🎪 You know this is a trap by now, right?"
    echo "💸 But since you're HERE..."
fi

echo ""
sleep 2

# Offer progressively more ridiculous "rewards"
TIER_REWARDS=(
    "🥉 BRONZE TIER: Password to the snack cupboard"
    "🥈 SILVER TIER: Location of the office WiFi password"
    "🥇 GOLD TIER: Secret recipe for instant ramen upgrades"
    "💎 PLATINUM TIER: The truth about why meetings exist"
    "👑 DIAMOND TIER: How to look busy while browsing memes"
    "🌟 LEGENDARY TIER: The answer to life, universe, everything"
    "🚀 ULTIMATE TIER: Complete Netflix password collection"
    "🔮 MYTHICAL TIER: Time travel instructions (May not work)"
)

CURRENT_TIER=$((STRIKES - 1))
if [ $CURRENT_TIER -ge ${#TIER_REWARDS[@]} ]; then
    CURRENT_TIER=$((${#TIER_REWARDS[@]} - 1))
fi

echo "🎯 Your Current Tier: Level $STRIKES"
echo "🎁 Today's Reward: ${TIER_REWARDS[$CURRENT_TIER]}"
echo ""
sleep 2

echo "📊 Loading reward package..."
sleep 2
echo "🔓 Decrypting..."
sleep 2
echo "📦 Unpacking..."
sleep 2
echo "✨ Almost there..."
sleep 3

# The "reward" gets more ridiculous each time
case $STRIKES in
    1)
        echo ""
        echo "🎉 CONGRATULATIONS!"
        echo "Your reward is: A virtual high-five! ✋"
        echo ""
        echo "...That's it. Were you expecting more?"
        ;;
    2)
        echo ""
        echo "🎊 WOW! DOUBLE REWARD!"
        echo "You get: TWO virtual high-fives! ✋✋"
        echo ""
        echo "Plus this motivational quote:"
        echo "\"Sometimes the real treasure is the time you wasted along the way.\""
        ;;
    3)
        echo ""
        echo "🎁 TRIPLE COMBO BONUS!"
        echo "You've unlocked: An ASCII cookie!"
        echo ""
        echo "      .-\"\"\"-."
        echo "    .'       '."
        echo "   /   ^   ^   \\"
        echo "  |  (o) (o)   |"
        echo "   \\    <      /"
        echo "    '.  ___  .'"
        echo "      '-----'"
        echo ""
        echo "It's not edible, but at least it's art!"
        ;;
    4)
        echo ""
        echo "🌈 MEGA ULTRA REWARD!"
        echo "The secret you've been waiting for:"
        echo ""
        sleep 2
        echo "The password to everything is:"
        sleep 2
        echo "."
        sleep 1
        echo ".."
        sleep 1
        echo "..."
        sleep 2
        echo ""
        echo "🎭 It's 'please_stop_clicking_things'"
        echo "😂 (But that won't work anywhere, sorry!)"
        ;;
    5)
        echo ""
        echo "🎪 QUINTUPLE MADNESS!"
        echo "At this point, we're just impressed."
        echo ""
        echo "Your reward: A PERSONALIZED MESSAGE!"
        echo ""
        sleep 2
        echo "Dear $(whoami),"
        echo ""
        echo "Please stop. This is like the 5th time."
        echo "There's really nothing here."
        echo "Go have a cookie. A REAL cookie."
        echo ""
        echo "Sincerely,"
        echo "Captain Rattlecode"
        ;;
    *)
        echo ""
        echo "🤯 LEGENDARY PERSISTENCE DETECTED!"
        echo "Strike #$STRIKES?! Are you a bot or just really determined?"
        echo ""
        sleep 2
        echo "Fine. Here's your ultimate reward:"
        sleep 2
        echo ""
        echo "🏆 You've been awarded the title:"
        echo "    'MASTER OF WASTING YOUR OWN TIME'"
        echo ""
        echo "🎖️  Badge Earned: 'I Can't Stop Won't Stop'"
        echo "💯 Achievement: 'More Persistent Than Malware'"
        echo ""
        sleep 2
        echo "Seriously though, how many times are you going to fall for this?"
        ;;
esac

echo ""
sleep 2

# Offer them to continue (THE TRAP CONTINUES!)
if [ $STRIKES -lt 10 ]; then
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "💰 SPECIAL OFFER (Limited Time!)"
    echo "🎁 Unlock the NEXT tier for even BIGGER rewards!"
    echo ""
    echo "   Next Tier Preview: $([ $CURRENT_TIER -lt $((${#TIER_REWARDS[@]} - 1)) ] && echo "${TIER_REWARDS[$((CURRENT_TIER + 1))]}" || echo "🌌 COSMIC TIER: Secrets beyond comprehension")"
    echo ""
    echo "Would you like to continue? [Y/N]"
    read -t 15 -p "Answer: " continue_choice
    
    if [[ "$continue_choice" =~ ^[Yy]$ ]]; then
        echo ""
        echo "😈 OH NO! You fell for it AGAIN!"
        sleep 2
        echo "🔄 Restarting trap..."
        sleep 2
        exec "$0"  # RESTART THE WHOLE THING!
    else
        echo ""
        echo "✅ Smart choice! You're learning!"
    fi
else
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "🛑 INTERVENTION TIME"
    echo ""
    echo "You've triggered this trap $STRIKES times."
    echo "That's... that's too many times."
    echo ""
    echo "We're cutting you off for your own good."
    echo "Go touch grass. Pet a dog. Eat a sandwich."
    echo ""
    echo "Your strike counter has been reset to 0."
    echo "(Not really, we're lying. It's still $STRIKES.)"
fi

echo ""
sleep 2

# Final stats
echo "📊 YOUR GREED STATISTICS"
echo "========================"
echo "Total Times Fooled: $STRIKES"
echo "Time Wasted Today: ~$((STRIKES * 2)) minutes"
echo "Lessons Learned: Probably 0"
echo "Regret Level: $([ $STRIKES -gt 5 ] && echo "Maximum" || echo "Growing")"
echo ""

log_greed "User $(whoami) completed trap at Strike #$STRIKES - Time wasted: ~$((STRIKES * 2))min"

echo "🎭 Thank you for playing!"
echo "👋 See you again in... oh who are we kidding, you'll be back."
echo ""
