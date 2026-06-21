#!/bin/bash

# 🎓 The Silly Learning Adventure - Where Education Meets Chaos
# Brought to you by Captain Rattlecode's School of Accidental Knowledge

echo "🎪 Welcome to the FRAGLE ACADEMY OF ABSURD LEARNING!"
echo "=================================================="
echo ""
sleep 1

# Lesson 1: Variables
echo "📚 LESSON 1: Variables (or 'Magic Boxes That Remember Stuff')"
echo "-----------------------------------------------------------"
FAVORITE_COOKIE="Chocolate Chip"
STUDENT_NAME="Brave Code Warrior"
MAGIC_NUMBER=$((RANDOM % 100))

echo "👋 Hello, $STUDENT_NAME!"
echo "🍪 Your favorite cookie is: $FAVORITE_COOKIE"
echo "🎲 Your lucky number today is: $MAGIC_NUMBER"
echo ""
sleep 2

# Lesson 2: Loops
echo "📚 LESSON 2: Loops (or 'Doing Boring Stuff Without Getting Bored')"
echo "----------------------------------------------------------------"
echo "Let's count cookies!"
for i in {1..5}; do
    echo "🍪 Cookie #$i - Yum!"
    sleep 0.5
done
echo "😋 We counted $i cookies. Now we're hungry."
echo ""
sleep 2

# Lesson 3: Conditionals
echo "📚 LESSON 3: If/Then/Else (or 'Making Decisions Like a Robot')"
echo "------------------------------------------------------------"
CURRENT_HOUR=$(date +%H)
echo "⏰ Current hour: $CURRENT_HOUR"

if [ "$CURRENT_HOUR" -lt 12 ]; then
    echo "🌅 Good morning! Time for debugging with coffee!"
elif [ "$CURRENT_HOUR" -lt 18 ]; then
    echo "☀️ Good afternoon! Time for more debugging with snacks!"
else
    echo "🌙 Good evening! Time for late-night coding and pizza!"
fi
echo ""
sleep 2

# Lesson 4: Arrays
echo "📚 LESSON 4: Arrays (or 'A List of Things That Sound Fancy')"
echo "----------------------------------------------------------"
CREW=("Captain Rattlecode" "Gumball the Whisperer" "Bobby Blip" "YELLER" "Dennis")
echo "🎭 Meet the Fragle Crew:"
for member in "${CREW[@]}"; do
    echo "   ✨ $member"
    sleep 0.3
done
echo ""
sleep 2

# Lesson 5: Functions
echo "📚 LESSON 5: Functions (or 'Reusable Magic Spells')"
echo "-------------------------------------------------"

function tell_joke() {
    local jokes=(
        "Why do programmers prefer dark mode? Because light attracts bugs! 🐛"
        "How many programmers does it take to change a lightbulb? None, that's a hardware problem! 💡"
        "Why do Java developers wear glasses? Because they can't C#! 👓"
        "What's a pirate's favorite programming language? RRRRuby! 🏴‍☠️"
    )
    local random_joke=${jokes[$RANDOM % ${#jokes[@]}]}
    echo "😂 $random_joke"
}

echo "🎤 Here's a programming joke:"
tell_joke
echo ""
sleep 2

# Final Quiz
echo "🎯 FINAL QUIZ: Are You Ready?"
echo "============================"
echo ""
QUIZ_SCORE=0

echo "Question 1: What do cookies taste like in bash?"
echo "A) Chocolate   B) Binary   C) Variables"
read -t 10 -p "Your answer (A/B/C): " answer1
if [[ "$answer1" =~ ^[Cc]$ ]]; then
    echo "✅ Correct! Cookies are variables in our world!"
    ((QUIZ_SCORE++))
else
    echo "❌ Nope! But nice try. Cookies are variables here!"
fi
echo ""
sleep 1

echo "Question 2: What does 'YELLER' probably do?"
echo "A) Whispers   B) Types quietly   C) YELLS!"
read -t 10 -p "Your answer (A/B/C): " answer2
if [[ "$answer2" =~ ^[Cc]$ ]]; then
    echo "✅ CORRECT! YELLER DEFINITELY YELLS! 📢"
    ((QUIZ_SCORE++))
else
    echo "❌ Wrong! YELLER ALWAYS YELLS! 🔊"
fi
echo ""
sleep 1

# Results
echo "🏆 GRADUATION RESULTS"
echo "===================="
echo "📊 Your score: $QUIZ_SCORE/2"
echo ""

if [ "$QUIZ_SCORE" -eq 2 ]; then
    echo "🎓 PERFECT SCORE! You're now a Certified Fragle Scholar!"
    echo "🏅 You earned: The Golden Cookie of Wisdom"
elif [ "$QUIZ_SCORE" -eq 1 ]; then
    echo "👍 Not bad! You're a Fragle Apprentice!"
    echo "🥈 You earned: The Silver Ping of Promise"
else
    echo "😅 Keep learning! You're a Fragle Newbie (but that's okay!)"
    echo "🥉 You earned: The Bronze Bug of Bravery"
fi

echo ""
echo "✨ Remember: Every bug is just a feature in disguise!"
echo "🚀 Now go forth and code with confidence (and cookies)!"
echo ""
echo "🎪 Thank you for attending the Fragle Academy!"
echo "=================================================="
