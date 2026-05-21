#!/bin/bash
# post_snoop_debriefing.sh
# 
# Generates a humorous post-snoop debriefing report
# Usage: ./post_snoop_debriefing.sh <snoop_session_log>
#
# IMPORTANT: This script generates ANONYMIZED reports.
# No PII is included. Snoops are identified only by session UUID.
# No real names, IPs, or identifying information in the output.

set -euo pipefail

# Color codes for fancy output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Generate a random session UUID (anonymized identifier)
SESSION_UUID=$(head -c 16 /dev/urandom | od -An -tx1 | tr -d ' ')

# Parse session log or use defaults
TIMESTAMP="${1:-$(date)}"
DURATION_SECONDS="${2:-420}" # Default 7 minutes
TRAPS_ENCOUNTERED="${3:-3}"
TRAPS_COMPLETED="${4:-1}"

# Convert seconds to human-readable time
convert_seconds() {
    local seconds=$1
    local hours=$((seconds / 3600))
    local minutes=$(((seconds % 3600) / 60))
    local secs=$((seconds % 60))
    
    if [ $hours -gt 0 ]; then
        printf "%dh %dm %ds" $hours $minutes $secs
    elif [ $minutes -gt 0 ]; then
        printf "%dm %ds" $minutes $secs
    else
        printf "%ds" $secs
    fi
}

# Pick a random achievement badge
pick_achievement() {
    local duration=$1
    local completed=$2
    
    if [ $duration -lt 60 ]; then
        echo "🏃 Speed Runner — Escaped in under a minute!"
    elif [ $duration -lt 180 ]; then
        echo "🎯 Sharp Mind — Efficient trap navigation"
    elif [ $duration -lt 300 ]; then
        echo "🧠 Persistent — You really committed to this"
    elif [ $duration -lt 600 ]; then
        echo "💪 Dedicated — Respect for the time investment"
    else
        echo "🏆 Legendary — They're writing songs about you"
    fi
}

# Pick a random motivational/roast message
pick_message() {
    local completed=$1
    
    local messages=(
        "Come back next time for more entertainment!"
        "We've upgraded the traps. Think you can do better?"
        "You were #$(( (RANDOM % 1000) + 1 )) to try this. And counting."
        "Your escape route has been logged for posterity."
        "The traps remember you. Will you remember them?"
        "This is what happens when curiosity meets Fragle."
        "Congratulations on your new career in time management."
        "You've learned a valuable lesson about authorized access."
    )
    
    echo "${messages[$((RANDOM % ${#messages[@]}))]}"
}

# ASCII art for debriefing
print_header() {
    cat << 'EOF'
╔══════════════════════════════════════════════════════════════════╗
║                  🎪 FRAGLE POST-SNOOP DEBRIEFING 🎪             ║
║                                                                  ║
║              Your Performance in the Theatre of Traps            ║
╚══════════════════════════════════════════════════════════════════╝
EOF
}

# Print ASCII sad snoop character
print_snoop_art() {
    local duration=$1
    
    if [ $duration -lt 60 ]; then
        cat << 'EOF'
   _____
  /     \
  | O O |  "That was... fast?"
  |  >  |
   \ _ /
  /|   |\
   |   |
EOF
    elif [ $duration -lt 300 ]; then
        cat << 'EOF'
   _____
  /     \
  | . . |  "Hmm... more than I expected..."
  | ___ |
   \ _ /
  /|   |\
   |   |
EOF
    elif [ $duration -lt 600 ]; then
        cat << 'EOF'
   _____
  /     \
  | ^ ^ |  "Wait... how long was I in here?"
  | :O: |
   \ _ /
  /|   |\
   |   |
EOF
    else
        cat << 'EOF'
   _____
  /     \
  | O_O |  "...I'm never going back there again."
  |  <  |
   \ _ /
  /|   |\
   |   |
EOF
    fi
}

# Main debriefing output
print_debriefing() {
    local duration=$1
    local traps_enc=$2
    local traps_comp=$3
    local uuid=$4
    
    local readable_duration=$(convert_seconds "$duration")
    local achievement=$(pick_achievement "$duration" "$traps_comp")
    local message=$(pick_message "$traps_comp")
    
    echo ""
    echo -e "${CYAN}═══════════════════════════════════════════════════════════════════${NC}"
    echo -e "${CYAN}SESSION REPORT — ANONYMIZED${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════════════${NC}"
    echo ""
    
    echo -e "${YELLOW}Session UUID:${NC} $uuid"
    echo -e "${YELLOW}Timestamp:${NC} $TIMESTAMP"
    echo ""
    
    echo -e "${PURPLE}📊 PERFORMANCE METRICS${NC}"
    echo -e "   ${BLUE}Total Time Spent:${NC} $readable_duration"
    echo -e "   ${BLUE}Traps Encountered:${NC} $traps_enc"
    echo -e "   ${BLUE}Traps Completed:${NC} $traps_comp"
    
    if [ $traps_comp -gt 0 ]; then
        local escape_rate=$((traps_comp * 100 / traps_enc))
        echo -e "   ${BLUE}Escape Success Rate:${NC} ${escape_rate}%"
    fi
    echo ""
    
    echo -e "${GREEN}🏆 ACHIEVEMENT UNLOCKED${NC}"
    echo -e "   $achievement"
    echo ""
    
    echo -e "${CYAN}💬 FEEDBACK FROM THE TRAPS${NC}"
    echo -e "   \"$message\""
    echo ""
    
    echo -e "${PURPLE}📈 COMPARATIVE ANALYSIS${NC}"
    echo -e "   ${BLUE}Snoop Rank:${NC} Top $(( (RANDOM % 15) + 1 ))% (estimated)"
    echo -e "   ${BLUE}Most Similar To:${NC} The ${BLUE}$([ $((RANDOM % 2)) -eq 0 ] && echo "Philosopher" || echo "Speed Runner")${NC}"
    echo ""
    
    echo -e "${YELLOW}💡 RECOMMENDATIONS FOR NEXT TIME${NC}"
    if [ $duration -lt 120 ]; then
        echo -e "   • Try spending more time in ${BLUE}never_ending_story.sh${NC} — it rewards patience"
    elif [ $duration -lt 300 ]; then
        echo -e "   • Consider exploring ${BLUE}endless_treasure_hunt.sh${NC} for a 5-10 minute experience"
    elif [ $duration -lt 600 ]; then
        echo -e "   • You're getting better! Next time, challenge ${BLUE}infinite_rabbit_hole.sh${NC}"
    else
        echo -e "   • You've unlocked all traps. Please consider joining the Whitelist."
    fi
    echo ""
    
    echo -e "${CYAN}═══════════════════════════════════════════════════════════════════${NC}"
    echo -e "${PURPLE}Thank you for playing. The traps salute you. 🎪${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════════════${NC}"
    echo ""
}

# Main execution
main() {
    print_header
    echo ""
    print_snoop_art "$DURATION_SECONDS"
    echo ""
    print_debriefing "$DURATION_SECONDS" "$TRAPS_ENCOUNTERED" "$TRAPS_COMPLETED" "$SESSION_UUID"
}

main "$@"
