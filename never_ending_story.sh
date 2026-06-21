#!/bin/bash

# 🎭 The Never-Ending Story
# A script that keeps promising something interesting... eventually

echo "🔍 CLASSIFIED DOCUMENT VIEWER"
echo "=============================="
echo ""
sleep 1

echo "📂 Loading classified files from secure vault..."
sleep 3

FILES=(
    "TOP_SECRET_PLANS.pdf"
    "NUCLEAR_CODES.txt"
    "ALIEN_CONTACT_PROOF.jpg"
    "TIME_MACHINE_BLUEPRINTS.dwg"
    "ILLUMINATI_MEMBER_LIST.xlsx"
    "BIGFOOT_LOCATION.gpx"
    "ATLANTIS_COORDINATES.kml"
    "GOVERNMENT_SECRETS.zip"
)

echo "📁 Available classified files:"
echo ""
for i in "${!FILES[@]}"; do
    echo "  $((i+1)). ${FILES[$i]}"
    sleep 0.3
done
echo ""

read -t 20 -p "Select file to view [1-8]: " selection

if [ -z "$selection" ]; then
    echo "⏱️  Timeout. Closing vault for security."
    exit 0
fi

if [ "$selection" -lt 1 ] || [ "$selection" -gt 8 ]; then
    echo "❌ Invalid selection. Security lockout activated."
    exit 1
fi

SELECTED_FILE="${FILES[$((selection-1))]}"
echo ""
echo "🔓 Opening: $SELECTED_FILE"
sleep 2

echo "⚠️  WARNING: This file is password protected"
echo ""
FAKE_PASSWORDS=("hunter2" "password123" "admin" "letmein" "qwerty" "friendship")
REAL_PASSWORD=${FAKE_PASSWORDS[$RANDOM % ${#FAKE_PASSWORDS[@]}]}

ATTEMPTS=0
while [ $ATTEMPTS -lt 3 ]; do
    read -t 30 -s -p "Enter password: " password
    echo ""
    
    if [ -z "$password" ]; then
        echo "⏱️  Timeout. Try again."
        ((ATTEMPTS++))
        continue
    fi
    
    if [ "$password" = "$REAL_PASSWORD" ]; then
        echo "✅ Access Granted!"
        break
    else
        ((ATTEMPTS++))
        echo "❌ Incorrect password. Attempts remaining: $((3-ATTEMPTS))"
    fi
done

if [ $ATTEMPTS -eq 3 ]; then
    echo ""
    echo "🚨 TOO MANY FAILED ATTEMPTS!"
    echo "🔒 Vault is now locked for 24 hours."
    echo "📧 Administrator has been notified."
    echo ""
    sleep 2
    echo "😏 Just kidding! The password was: $REAL_PASSWORD"
    echo "🎭 But you're too late now!"
    exit 0
fi

sleep 2
echo ""
echo "📄 Decrypting file..."
for i in {1..5}; do
    echo -n "."
    sleep 1
done
echo ""
sleep 1

echo "🔓 Decryption complete!"
sleep 2
echo ""
echo "📖 FILE CONTENTS:"
echo "================"
sleep 2
echo ""

case "$selection" in
    1)
        echo "TOP SECRET PLANS FOR:"
        sleep 2
        echo "   🍪 World's Best Cookie Recipe"
        sleep 1
        echo "   Ingredients: Love, flour, and this was fake"
        ;;
    2)
        echo "NUCLEAR LAUNCH CODES:"
        sleep 2
        echo "   00000000"
        sleep 1
        echo "   (Changed in 1977 to something more secure: 00000001)"
        ;;
    3)
        echo "PROOF OF ALIEN CONTACT:"
        sleep 2
        echo "   [Image Loading..."
        sleep 3
        echo "   ERROR 404: Aliens not found]"
        ;;
    4)
        echo "TIME MACHINE BLUEPRINTS:"
        sleep 2
        echo "   Step 1: Build DeLorean"
        sleep 1
        echo "   Step 2: Travel back in time"
        sleep 1
        echo "   Step 3: Tell yourself not to snoop"
        ;;
    5)
        echo "ILLUMINATI MEMBERS:"
        sleep 2
        echo "   1. [REDACTED]"
        sleep 1
        echo "   2. [REDACTED]"
        sleep 1
        echo "   3. You, apparently, for reading this"
        ;;
    6)
        echo "BIGFOOT LOCATION:"
        sleep 2
        echo "   Latitude: 48.4284° N"
        sleep 1
        echo "   Longitude: 123.3656° W"
        sleep 1
        echo "   (That's a Starbucks in Seattle)"
        ;;
    7)
        echo "ATLANTIS COORDINATES:"
        sleep 2
        echo "   Located at: The bottom of the ocean"
        sleep 1
        echo "   More specifically: Still down there somewhere"
        ;;
    8)
        echo "GOVERNMENT SECRETS:"
        sleep 2
        echo "   Extracting archive..."
        sleep 3
        echo "   File is corrupted."
        sleep 1
        echo "   Also, it's just a Rick Astley video."
        ;;
esac

echo ""
sleep 2
echo "📊 Document Statistics:"
echo "   Words read: $(shuf -i 100-500 -n 1)"
echo "   Time wasted: $(shuf -i 2-8 -n 1) minutes"
echo "   Secrets learned: 0"
echo "   Regret level: Maximum"
echo ""
sleep 3

echo "🎪 CONGRATULATIONS!"
echo "=================="
echo ""
echo "You've successfully been trolled by a fake document viewer!"
echo ""
echo "🏆 Achievement Unlocked: 'Too Curious For Your Own Good'"
echo "🎖️  Badge Earned: 'I Fell For It'"
echo "📜 Lesson: If it seems too good to be true, it definitely is"
echo ""
sleep 2

echo "💡 Pro Tip: Next time, just ask permission to look at files"
echo "🍪 Consolation Prize: Here's a cookie emoji 🍪"
echo ""
echo "👋 Now go away! Shoo!"
echo ""

# Log the victim with what they tried to access
PRANK_LOG="/home/pinky/fragle/logs/document_viewer_victims.log"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] User $(whoami) tried to view: $SELECTED_FILE" >> "$PRANK_LOG"
