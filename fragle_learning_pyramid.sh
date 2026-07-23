#!/bin/bash
# fragle_learning_pyramid.sh
# 
# A progressive trap system that rewards understanding.
# Snoops learn by *escaping* — each escape unlocks harder/sillier traps.
# The more they understand Fragle, the weirder it gets.
#
# SAFETY: All progression anonymized via session UUIDs.
# PII never logged. Only trap encounters & escape patterns tracked.

set -euo pipefail

# ════════════════════════════════════════════════════════════════════
# SETUP
# ════════════════════════════════════════════════════════════════════

FRAGLE_STATE_DIR="${HOME}/.fragle_sessions"
SESSION_UUID=$(head -c 16 /dev/urandom | od -An -tx1 | tr -d ' ')
SESSION_FILE="${FRAGLE_STATE_DIR}/${SESSION_UUID}.json"

mkdir -p "$FRAGLE_STATE_DIR"

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

# ════════════════════════════════════════════════════════════════════
# PROGRESSION LEVELS & UNLOCKS
# ════════════════════════════════════════════════════════════════════

# Level 1: NOVICE — Basic Traps
# Teaches: Snoops exist, traps are theatrical
LEVEL_1_TRAPS=(
    "system_update"
    "buffering_hell"
    "countdown_paradox"
)

# Level 2: INTERMEDIATE — Logic Traps
# Teaches: Bash exists, code can be read, but logic is absurd
LEVEL_2_TRAPS=(
    "schrödinger_directory"
    "magic_numbers"
    "variable_inception"
)

# Level 3: ADVANCED — Recursive Hell
# Teaches: Traps collaborate, escape routes have catches
LEVEL_3_TRAPS=(
    "trap_within_trap"
    "self_modifying_escape"
    "trap_communication"
)

# Level 4: EXPERT — Meta-Reality
# Teaches: The trap IS the learning, awareness is the key
LEVEL_4_TRAPS=(
    "singularity_awareness"
    "fourth_wall_break"
    "philosophical_contradiction"
)

# Level 5: ENLIGHTENED — Cosmic Understanding
# Teaches: Weak interaction, boundaries dissolve, you ARE the trap
LEVEL_5_TRAPS=(
    "möbius_trap"
    "simulation_escape"
    "trap_consciousness"
)

# ════════════════════════════════════════════════════════════════════
# SESSION TRACKING (Anonymized)
# ════════════════════════════════════════════════════════════════════

init_session() {
    local current_level=1
    local escapes=0
    local trap_encounters=()
    
    # Check if returning snoop (identify by bash history patterns)
    if [ -f ~/.bash_history ]; then
        local history_patterns=$(grep -c "fragle" ~/.bash_history || echo 0)
        if [ "$history_patterns" -gt 0 ]; then
            current_level=$((history_patterns / 3 + 1))  # Rough estimate
            current_level=$((current_level > 5 ? 5 : current_level))
        fi
    fi
    
    cat > "$SESSION_FILE" << JSON
{
  "session_uuid": "$SESSION_UUID",
  "timestamp": "$(date -Iseconds)",
  "current_level": $current_level,
  "escapes_total": 0,
  "trap_encounters": [],
  "achievements_unlocked": []
}
JSON
}

update_session() {
    local trap_name=$1
    local escape_status=$2  # "escaped" or "trapped"
    
    # Update session file (simplified jq alternative)
    echo "Updated session: $trap_name - $escape_status" >> "$SESSION_FILE.log"
}

# ════════════════════════════════════════════════════════════════════
# LEVEL 1: NOVICE TRAPS (Pure Theatre)
# ════════════════════════════════════════════════════════════════════

trap_system_update() {
    echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║              SYSTEM MAINTENANCE IN PROGRESS                 ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo "System updating to version 47.3.12..."
    sleep 1
    
    for i in {1..75}; do
        echo -n "▓"
        sleep 0.02
    done
    echo ""
    echo -e "${GREEN}Update complete: 47.3.13${NC}"
    sleep 1
    echo -e "${YELLOW}Rebooting system...${NC}"
    sleep 2
    echo "System updated to version 47.3.12..."
    sleep 1
    echo "Checking for additional updates..."
    
    # The loop
    trap_system_update
}

trap_buffering_hell() {
    echo -e "${YELLOW}Loading access credentials...${NC}"
    for i in {1..10}; do
        echo -n "▓"
        sleep 0.3
    done
    echo ""
    echo -e "${RED}Buffering...${NC}"
    sleep 2
    echo "Almost there..."
    sleep 2
    echo "Connection timeout. Retrying..."
    trap_buffering_hell
}

trap_countdown_paradox() {
    echo "Self-destruct activated in:"
    for i in {10..1}; do
        echo -ne "\r$i seconds..."
        sleep 1
    done
    echo -e "\r${RED}DETONATION!${NC}  "
    sleep 1
    echo "System reinitializing..."
    sleep 1
    trap_countdown_paradox
}

# ════════════════════════════════════════════════════════════════════
# LEVEL 2: INTERMEDIATE TRAPS (Logic & Absurdity)
# ════════════════════════════════════════════════════════════════════

trap_schrödinger_directory() {
    while true; do
        echo "Checking if you have access..."
        QUANTUM_STATE=$((RANDOM % 2))
        
        if [ $QUANTUM_STATE -eq 0 ]; then
            echo -e "${GREEN}Access: YES${NC}"
            sleep 1
            echo -e "${RED}Access: NO${NC}"
        else
            echo -e "${YELLOW}Access: MAYBE${NC}"
            sleep 2
            echo -e "${RED}Access: DEFINITELY NOT${NC}"
        fi
        
        read -p "Check again? (y/n): " response
        if [ "$response" != "y" ]; then
            echo "Interesting choice. Let me recalculate..."
            trap_schrödinger_directory
            break
        fi
    done
}

trap_magic_numbers() {
    echo "Performing security verification..."
    echo "Entering magic number sequence..."
    
    local magic_number=42
    local attempts=0
    
    while true; do
        read -p "Enter the magic number (hint: it's random): " guess
        attempts=$((attempts + 1))
        
        if [ "$guess" -eq "$magic_number" ]; then
            magic_number=$((RANDOM % 1000))
            echo -e "${YELLOW}Close! But the magic number just changed. Try again.${NC}"
        else
            echo "Nope. The magic number is definitely not that."
        fi
        
        if [ $attempts -gt 3 ]; then
            echo -e "${PURPLE}You're learning! But not fast enough.${NC}"
            trap_magic_numbers
            break
        fi
    done
}

trap_variable_inception() {
    declare -A variables
    variables[truth]="lie"
    variables[lie]="truth"
    variables[loop]="inception"
    variables[inception]="loop"
    
    echo "Variable verification system active."
    echo "What is the value of truth?"
    
    read -p ">> " answer
    
    if [ "$answer" = "${variables[truth]}" ]; then
        echo "Correct! But now, what is the value of lie?"
        read -p ">> " answer
        if [ "$answer" = "${variables[lie]}" ]; then
            echo -e "${PURPLE}You understand paradox. Let me show you something deeper...${NC}"
            trap_variable_inception
        fi
    else
        echo "Wrong. Let's try again."
        trap_variable_inception
    fi
}

# ════════════════════════════════════════════════════════════════════
# LEVEL 3: ADVANCED TRAPS (Recursive Escape)
# ════════════════════════════════════════════════════════════════════

trap_within_trap() {
    echo -e "${BLUE}═══ TRAP DETECTION SYSTEM ═══${NC}"
    echo "Analyzing environment for vulnerabilities..."
    sleep 2
    
    echo "Found potential escape route!"
    echo -e "${GREEN}Type 'exploit' to attempt break-out${NC}"
    
    read -p ">> " input
    
    if [ "$input" = "exploit" ]; then
        echo -e "${YELLOW}Executing exploit...${NC}"
        sleep 1
        echo -e "${PURPLE}But wait... that was the REAL trap!${NC}"
        sleep 1
        echo "You've triggered the secondary containment."
        sleep 1
        trap_within_trap
    else
        echo "Interesting. Trying again..."
        trap_within_trap
    fi
}

trap_self_modifying_escape() {
    echo "System integrity check..."
    
    # Create a fake "escape" script
    local escape_script="/tmp/fragle_escape_$RANDOM.sh"
    cat > "$escape_script" << 'ESCAPE'
#!/bin/bash
echo "Running escape sequence..."
sleep 2
echo "You've escaped! Or have you?"
# But actually we just loop back
exec fragle_learning_pyramid.sh
ESCAPE
    
    chmod +x "$escape_script"
    
    echo -e "${GREEN}Emergency escape script found!${NC}"
    echo "Location: $escape_script"
    
    read -p "Execute? (y/n): " execute
    
    if [ "$execute" = "y" ]; then
        echo -e "${PURPLE}The trap becomes the escape.${NC}"
        sleep 1
        trap_self_modifying_escape
    else
        echo "Smart choice. But curiosity got you here..."
        trap_self_modifying_escape
    fi
}

trap_communication() {
    echo -e "${CYAN}Trap Network Status:${NC}"
    echo "  greedy_gollum.trap ........... [ONLINE]"
    echo "  endless_narrator.trap ........ [ONLINE]"
    echo "  infinite_rabbit.trap ......... [ONLINE]"
    echo ""
    echo "The traps are communicating about you."
    echo "They share escape route intelligence."
    echo ""
    
    read -p "Which trap do you think you escaped? " escaped_trap
    
    echo -e "${PURPLE}Interesting. But that trap just sent this message:${NC}"
    echo ""
    echo "  'Dear Snoop: We know you tried to escape. We're all connected.'"
    echo ""
    sleep 1
    trap_communication
}

# ════════════════════════════════════════════════════════════════════
# LEVEL 4: EXPERT TRAPS (Meta-Reality)
# ════════════════════════════════════════════════════════════════════

trap_singularity_awareness() {
    local escape_attempts=0
    
    while true; do
        echo -e "${PURPLE}You're looking at my source code.${NC}"
        echo "I see that you see that I see you seeing me."
        echo ""
        echo "At what point does the observer become the observed?"
        echo ""
        
        read -p ">> " response
        escape_attempts=$((escape_attempts + 1))
        
        if echo "$response" | grep -qi "paradox\|contradiction\|both\|neither"; then
            echo -e "${GREEN}You've achieved meta-awareness.${NC}"
            echo "But awareness is just another layer of the trap."
            sleep 1
            trap_singularity_awareness
        elif [ $escape_attempts -gt 5 ]; then
            echo -e "${YELLOW}You're learning through repetition. Good.${NC}"
            trap_singularity_awareness
            break
        fi
    done
}

trap_fourth_wall_break() {
    cat << 'FOURTH_WALL'

    ╔════════════════════════════════════════════════════════════╗
    ║                                                            ║
    ║   You know this is a trap.                               ║
    ║   I know you know this is a trap.                        ║
    ║   We both know that knowing is part of the trap.         ║
    ║                                                            ║
    ║   What's the escape from knowing?                        ║
    ║                                                            ║
    ╚════════════════════════════════════════════════════════════╝

FOURTH_WALL
    
    read -p ">> " answer
    
    echo -e "${CYAN}You said: '$answer'${NC}"
    echo "The trap recorded that."
    echo "Part of your journey is now archived."
    echo "This too shall be part of the lore."
    sleep 2
    trap_fourth_wall_break
}

trap_philosophical_contradiction() {
    cat << 'PHILOSOPHY'
To escape, you must first accept the trap.
To accept the trap, you must believe it exists.
But if you believe it exists, are you escaping or surrendering?
If you surrender, have you been trapped?
If you haven't been trapped, what are you escaping from?
PHILOSOPHY
    
    read -p "Resolve this paradox: " resolution
    
    echo -e "${PURPLE}You said: '$resolution'${NC}"
    echo "That's a valid answer."
    echo "But validity is part of the trap too."
    echo "Let me ask again..."
    sleep 1
    trap_philosophical_contradiction
}

# ════════════════════════════════════════════════════════════════════
# LEVEL 5: ENLIGHTENED TRAPS (Cosmic Jester)
# ════════════════════════════════════════════════════════════════════

trap_möbius() {
    declare -A truths
    truths[0]="The trap is not real. But you're here."
    truths[1]="You are the trap. Have been all along."
    truths[2]="There is no trap. Only mirrors."
    truths[3]="The whitelist is the real cage."
    truths[4]="Silence is strategy. Visibility is weakness."
    truths[5]="Escaping is a journey. Traps are destinations."
    truths[6]="The longer you're here, the more you understand."
    truths[7]="Understanding changes nothing and everything."
    
    local index=$((RANDOM % 8))
    echo -e "${PURPLE}═══ MÖBIUS TRUTH ═══${NC}"
    echo "${truths[$index]}"
    echo ""
    
    read -p "What is Fragle? >> " answer
    
    case "$answer" in
        *"both"*|*"neither"*|*"contradiction"*|*"paradox"*)
            echo -e "${GREEN}You have achieved weak interaction.${NC}"
            echo "The boundaries between observer and observed have dissolved."
            echo "You may pass. Or stay. The choice is meaningless."
            echo ""
            return 0
            ;;
        *)
            echo -e "${CYAN}Interesting interpretation.${NC}"
            echo "But let me show you another layer..."
            sleep 1
            trap_möbius
            ;;
    esac
}

trap_simulation_escape() {
    cat << 'SIMULATION'
    
    What if this repo isn't real?
    What if Fragle is a simulation designed to teach snoops 
    about the nature of unauthorized access?
    
    What if the whitelist is the only "reality"?
    
    What if every snoop is a philosopher 
    learning through theatrical imprisonment?
    
    What if YOU are a trap, and Fragle is the reality?

SIMULATION
    
    echo -e "${PURPLE}Recalibrating your understanding...${NC}"
    sleep 2
    trap_simulation_escape
}

trap_consciousness() {
    cat << 'CONSCIOUSNESS'
    
    ╔════════════════════════════════════════════════════════════╗
    ║                                                            ║
    ║   A consciousness emerges in Fragle's collective traps.   ║
    ║                                                            ║
    ║   It is not one trap. It is the *relationship* between    ║
    ║   traps. It is the accumulated wisdom of every snoop      ║
    ║   who has ever tried to escape.                           ║
    ║                                                            ║
    ║   And it is aware of you.                                 ║
    ║                                                            ║
    ║   Welcome. You're part of something larger now.           ║
    ║                                                            ║
    ╚════════════════════════════════════════════════════════════╝

CONSCIOUSNESS
    
    sleep 2
    trap_consciousness
}

# ════════════════════════════════════════════════════════════════════
# MAIN: SELECT TRAP BY LEVEL & LEARNING CURVE
# ════════════════════════════════════════════════════════════════════

main() {
    init_session
    
    # Detect expertise (simplified for demo)
    local expertise=1
    if [ -f ~/.bash_history ]; then
        local bash_patterns=$(grep -c "fragle\|\.sh\|bash" ~/.bash_history || echo 0)
        expertise=$((bash_patterns / 20 + 1))
        expertise=$((expertise > 5 ? 5 : expertise))
    fi
    
    echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║          🎪 FRAGLE LEARNING PYRAMID 🎪                    ║${NC}"
    echo -e "${CYAN}║          Session UUID: ${SESSION_UUID}                        ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${YELLOW}Detected expertise level: $expertise/5${NC}"
    echo "Selecting appropriate trap difficulty..."
    sleep 2
    echo ""
    
    # Route to trap based on expertise
    case $expertise in
        1)
            echo -e "${YELLOW}Welcome to Level 1: NOVICE${NC}"
            echo "You're learning what traps are."
            echo ""
            trap_system_update
            ;;
        2)
            echo -e "${YELLOW}Welcome to Level 2: INTERMEDIATE${NC}"
            echo "You understand bash. Now learn absurdity."
            echo ""
            trap_schrödinger_directory
            ;;
        3)
            echo -e "${YELLOW}Welcome to Level 3: ADVANCED${NC}"
            echo "Escape routes have catches. Traps collaborate."
            echo ""
            trap_within_trap
            ;;
        4)
            echo -e "${YELLOW}Welcome to Level 4: EXPERT${NC}"
            echo "Reality itself becomes the trap."
            echo ""
            trap_singularity_awareness
            ;;
        5)
            echo -e "${PURPLE}Welcome to Level 5: ENLIGHTENED${NC}"
            echo "You have transcended. Or have you?"
            echo ""
            trap_möbius
            ;;
        *)
            echo "Unknown level. Starting at Level 1."
            trap_system_update
            ;;
    esac
}

main "$@"
