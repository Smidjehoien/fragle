#!/bin/bash

# 🎪 The Infinite Rabbit Hole
# A seemingly serious security script that wastes maximum time

echo "🔐 SECURITY VERIFICATION SYSTEM v3.7.42"
echo "========================================"
echo ""
sleep 1

echo "⚠️  WARNING: Unauthorized access detected"
echo "🔍 Analyzing user credentials..."
sleep 2

# Fake loading bar
echo -n "Loading: ["
for i in {1..30}; do
    echo -n "█"
    sleep 0.1
done
echo "] 100%"
echo ""
sleep 1

echo "📊 Analysis Complete."
echo "👤 User: $(whoami)"
echo "🖥️  System: $(uname -s)"
echo "⏰ Time: $(date)"
echo ""
sleep 2

echo "🚨 CRITICAL: Multiple security violations detected!"
echo ""
sleep 1

echo "Would you like to:"
echo "  A) Run full system diagnostic (recommended)"
echo "  B) Skip diagnostics (not recommended)"
echo "  C) Contact system administrator"
echo ""
read -t 15 -p "Select option [A/B/C]: " choice

case "$choice" in
    [Aa])
        echo ""
        echo "🔧 Initiating full system diagnostic..."
        sleep 2
        
        echo "Phase 1/7: Checking kernel integrity..."
        sleep 3
        echo "✅ Kernel integrity: OK"
        
        echo "Phase 2/7: Scanning for rootkits..."
        sleep 4
        echo "✅ No rootkits detected"
        
        echo "Phase 3/7: Verifying filesystem..."
        sleep 3
        echo "✅ Filesystem verification complete"
        
        echo "Phase 4/7: Analyzing network traffic..."
        sleep 4
        echo "✅ Network traffic: Normal"
        
        echo "Phase 5/7: Checking for unauthorized processes..."
        sleep 3
        echo "⚠️  Found 1 suspicious process: YOU"
        
        echo "Phase 6/7: Validating security certificates..."
        sleep 4
        echo "❌ Invalid certificate detected for: SNOOPING_AROUND.exe"
        
        echo "Phase 7/7: Generating comprehensive report..."
        sleep 5
        
        echo ""
        echo "📄 DIAGNOSTIC REPORT SUMMARY"
        echo "============================="
        echo "Issues Found: 1"
        echo "Issue Type: Excessive Curiosity"
        echo "Recommended Action: Stop snooping"
        echo "Alternative Action: Make yourself a sandwich"
        echo ""
        sleep 2
        
        echo "🎭 Would you like to read the full 500-page report? [Y/N]"
        read -t 10 -p "Answer: " report_choice
        
        if [[ "$report_choice" =~ ^[Yy]$ ]]; then
            echo ""
            echo "📚 Loading full report..."
            sleep 2
            echo "⚠️  ERROR: Report too large to display in terminal"
            echo "💡 Attempting to compress report..."
            sleep 3
            echo "📦 Compressing... This may take several minutes..."
            sleep 4
            echo "❌ Compression failed: Not enough disk space"
            echo "😏 Also, there is no report. You've been pranked!"
        fi
        ;;
    [Bb])
        echo ""
        echo "⚠️  Are you SURE you want to skip diagnostics?"
        echo "This could compromise system security!"
        read -t 10 -p "Type 'I UNDERSTAND THE RISKS' to continue: " confirm
        
        if [ "$confirm" = "I UNDERSTAND THE RISKS" ]; then
            echo ""
            echo "😏 Bold choice! Skipping diagnostics..."
            sleep 2
        else
            echo ""
            echo "❌ Incorrect confirmation. Restarting verification..."
            sleep 2
            exec "$0"  # Restart the script!
        fi
        ;;
    [Cc])
        echo ""
        echo "📞 Contacting administrator..."
        sleep 2
        echo "☎️  Dialing..."
        sleep 2
        echo "📵 Administrator is currently: Not Real"
        echo "💡 Try again later (hint: never)"
        ;;
    *)
        echo ""
        echo "⏱️  Timeout or invalid selection."
        echo "🔄 Defaulting to option A..."
        sleep 2
        exec "$0"  # Restart!
        ;;
esac

echo ""
sleep 1
echo "🎯 FINAL SECURITY CHECK"
echo "======================="
echo ""
sleep 1

echo "To proceed, please solve this security challenge:"
echo ""
NUM1=$((RANDOM % 10 + 1))
NUM2=$((RANDOM % 10 + 1))
CORRECT=$((NUM1 + NUM2))

echo "What is $NUM1 + $NUM2?"
read -t 20 -p "Answer: " math_answer

if [ "$math_answer" = "$CORRECT" ]; then
    echo ""
    echo "✅ Correct! You can do basic math!"
    sleep 1
else
    echo ""
    echo "❌ Wrong answer! The correct answer was $CORRECT"
    echo "🎓 Please retake elementary school before continuing."
    sleep 2
fi

echo ""
echo "🎪 FINAL REVELATION"
echo "=================="
sleep 2
echo ""
echo "Congratulations! You've wasted approximately 2-5 minutes"
echo "reading a completely fake security script!"
echo ""
sleep 2
echo "🏆 ACHIEVEMENT UNLOCKED: Master Time Waster"
echo "🎖️  Badge Earned: 'I Should've Been Working'"
echo "🍪 Reward: One Imaginary Cookie"
echo ""
sleep 2
echo "📜 MORAL OF THE STORY:"
echo "   1. Don't snoop in other people's repositories"
echo "   2. If something looks too official, it's probably fake"
echo "   3. You really should be doing something productive"
echo "   4. But hey, at least this was mildly entertaining!"
echo ""
sleep 2
echo "🚪 Now please exit and close the door behind you."
echo "👋 Have a nice day!"
echo ""

# Log the victim
PRANK_LOG="/home/pinky/fragle/logs/rabbit_hole_victims.log"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] User $(whoami) fell down the rabbit hole" >> "$PRANK_LOG"
