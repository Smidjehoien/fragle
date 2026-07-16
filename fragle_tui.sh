#!/bin/bash
# Fragle Terminal UI - MAXIMUM WHIMSY EDITION
# Where theatre meets unhinged absurdism
# Silliness levels: 6/10 → 12/10 → BEYOND

set -e

FRAGLE_HOME="${FRAGLE_HOME:-.}"
SESSION_UUID=$(uuidgen 2>/dev/null || python3 -c "import uuid; print(uuid.uuid4())" 2>/dev/null || echo "sess_$(date +%s)_CHAOS")
LOG_DIR="${FRAGLE_HOME}/.fragle_sessions"
ANON_DIR="${FRAGLE_HOME}/.fragle_anon_data"
mkdir -p "$LOG_DIR" "$ANON_DIR"

# Track session metrics for anonymous API (NO PII)
SESSION_START_TIME=$(date +%s)
SESSION_INTERACTION_COUNT=0
SESSION_ORACLE_QUERIES=0
SESSION_TRAP_LEVEL=0

# Color codes + RIDICULOUS effects
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
BOLD='\033[1m'
DIM='\033[2m'
BLINK='\033[5m'
NC='\033[0m'

# Spinner animation (but make it FEEL things)
spinner_frames=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
silly_words=("oozing" "percolating" "manifesting" "gestating" "vibrating" "hallucinating" "screaming silently" "questioning existence" "transcending" "becoming one with the void")

spinner() {
    local pid=$1
    local i=0
    while kill -0 $pid 2>/dev/null; do
        local silly_word=${silly_words[$((i % ${#silly_words[@]}))]}
        echo -ne "\r${CYAN}${spinner_frames[$((i++ % ${#spinner_frames[@]}))]} ${silly_word}...${NC}"
        sleep 0.1
    done
    echo -ne "\r${GREEN}✓ The theatre breathes. You are here now.${NC}\n"
}

# Persona detection (now with VIBES)
detect_persona() {
    local score_technical=0
    local score_aggressive=0
    local score_artistic=0
    local score_curious=0
    local score_chaotic=0

    [[ "$SHELL" == *"zsh"* ]] && ((score_technical++))
    [[ "$SHELL" == *"fish"* ]] && ((score_artistic++))
    [[ "$SHELL" == *"bash"* ]] && ((score_technical++))
    [[ -n "$SSH_CLIENT" ]] && ((score_aggressive++))
    [[ -f ~/.ssh/config ]] && ((score_technical+=2))
    [[ -f ~/.gitconfig ]] && ((score_technical++))
    [[ -f ~/.gitignore ]] && ((score_chaotic++))  # Anarchist flag
    [[ -d ~/.cargo ]] && ((score_chaotic++))     # Rust energy = chaos

    local hour=$(date +%H)
    if ((hour >= 22 || hour <= 5)); then
        ((score_aggressive++))
        ((score_chaotic++))  # Late night = chaos
    elif ((hour >= 9 && hour <= 12)); then
        ((score_curious++))
    elif ((hour >= 14 && hour <= 18)); then
        ((score_chaotic++))  # Afternoon slump = reality erosion
    fi

    # CPU load = chaos energy
    local load=$(uptime | awk -F'load average:' '{print $2}' | cut -d, -f1 | xargs)
    if (( $(echo "$load > 4" | bc -l 2>/dev/null || echo 0) )); then
        ((score_chaotic+=3))
    fi

    local max_score=0
    local persona="unknown"
    
    if (( score_chaotic > score_technical && score_chaotic > score_aggressive && score_chaotic > score_artistic )); then
        persona="chaotic"
    elif (( score_technical > score_aggressive && score_technical > score_artistic )); then
        persona="technical"
    elif (( score_aggressive > score_artistic )); then
        persona="aggressive"
    elif (( score_artistic > 0 )); then
        persona="artistic"
    elif (( score_curious > 0 )); then
        persona="curious"
    fi

    echo "$persona"
}

# WHIMSICAL ASCII art banner - context-aware chaos
show_banner() {
    local persona=$1
    clear
    
    case "$persona" in
        chaotic)
            cat << 'BANNER'

    ╔═══════════════════════════════════════════════════════════╗
    ║                                                           ║
    ║         🌀  FRAGLE THEATRE: CHAOS EDITION  🌀           ║
    ║                                                           ║
    ║    "Reality is a suggestion. Traps are a lifestyle."     ║
    ║                                                           ║
    ║      V2.0 (Absolutely Unhinged, Tested By Entropy)      ║
    ║                                                           ║
    ╚═══════════════════════════════════════════════════════════╝

BANNER
            ;;
        aggressive)
            cat << 'BANNER'

    ╔═══════════════════════════════════════════════════════════╗
    ║                                                           ║
    ║        ⚡  FRAGLE NIGHT CIRCUS: AWAKEN  ⚡              ║
    ║                                                           ║
    ║      "3AM. The snoops have already failed three times."   ║
    ║                                                           ║
    ║      V2.0 (Built For Insomniacs Who Know Better)         ║
    ║                                                           ║
    ╚═══════════════════════════════════════════════════════════╝

BANNER
            ;;
        technical)
            cat << 'BANNER'

    ╔═══════════════════════════════════════════════════════════╗
    ║                                                           ║
    ║       🎭  FRAGLE THEOREM: git blame says hi  🎭          ║
    ║                                                           ║
    ║     "Your SSH keys whisper secrets to the theatre."       ║
    ║                                                           ║
    ║      V2.0 (Optimized For People Who Read Commit Logs)    ║
    ║                                                           ║
    ╚═══════════════════════════════════════════════════════════╝

BANNER
            ;;
        artistic)
            cat << 'BANNER'

    ╔═══════════════════════════════════════════════════════════╗
    ║                                                           ║
    ║      🎨  FRAGLE GALLERY: where art bleeds code  🎨       ║
    ║                                                           ║
    ║        "Beauty is a trap. Traps are beautiful."           ║
    ║                                                           ║
    ║      V2.0 (Created By Artists For People Who Feel)       ║
    ║                                                           ║
    ╚═══════════════════════════════════════════════════════════╝

BANNER
            ;;
        *)
            cat << 'BANNER'

    ╔═══════════════════════════════════════════════════════════╗
    ║                                                           ║
    ║           🎪  FRAGLE THEATRE AWAKENS  🎪                ║
    ║                                                           ║
    ║    "Who are you? Better question: WHO ARE YOU?"          ║
    ║                                                           ║
    ║      V2.0 (For Everyone. Nobody Knows What This Is.)     ║
    ║                                                           ║
    ╚═══════════════════════════════════════════════════════════╝

BANNER
            ;;
    esac
    sleep 0.5
}

# Menu display - CHAOS EDITION
show_main_menu() {
    local persona=$1
    echo ""
    
    case "$persona" in
        chaotic)
            echo -e "${BOLD}${MAGENTA}═══ CHOOSE YOUR BEAUTIFUL DOOM ═══${NC}"
            ;;
        aggressive)
            echo -e "${BOLD}${RED}═══ WELCOME TO THE HUNTING GROUND ═══${NC}"
            ;;
        technical)
            echo -e "${BOLD}${CYAN}═══ THE ALGORITHM AWAITS INPUT ═══${NC}"
            ;;
        artistic)
            echo -e "${BOLD}${YELLOW}═══ GALLERY OF RECURSIVE DREAMS ═══${NC}"
            ;;
        *)
            echo -e "${BOLD}${WHITE}═══ MAIN THEATRE (WHO KNOWS) ═══${NC}"
            ;;
    esac
    
    echo ""
    echo -e "  ${GREEN}1.${NC} Enter Level (choose your silliness quota)"
    echo -e "  ${GREEN}2.${NC} View Lore (the architects are UNWELL)"
    echo -e "  ${GREEN}3.${NC} Session History (your shameful moments)"
    echo -e "  ${GREEN}4.${NC} Persona Profile (WHO ARE YOU REALLY?)"
    echo -e "  ${GREEN}5.${NC} Launch Web UI (full sensory overload)"
    echo -e "  ${GREEN}6.${NC} ${DIM}Ask the Oracle (cosmic joke generator)${NC}"
    echo -e "  ${GREEN}7.${NC} Top 100 Leaderboard (theatre statistics)"
    echo -e "  ${GREEN}8.${NC} Settings & Exit (run away)"
    echo ""
    echo -e "${DIM}You are: ${persona} | Chaos level: UNKNOWN | Sanity: CRITICAL${NC}"
    echo ""
}

# UNHINGED Level selection
show_levels() {
    clear
    show_banner "levels"
    echo -e "${BOLD}${YELLOW}SELECT YOUR TRAP INTENSITY (There Is No Exit)${NC}"
    echo ""
    echo -e "  ${GREEN}1.${NC} ${CYAN}Level 1: NOVICE${NC}"
    echo "     Graphics trickery • ASCII fever dreams"
    echo "     Silliness: ${RED}6/10${NC} (still normal)"
    echo ""
    echo -e "  ${GREEN}2.${NC} ${MAGENTA}Level 2: INTERMEDIATE${NC}"
    echo "     Logic puzzles • Your brain is a pretzel now"
    echo "     Silliness: ${RED}7/10${NC} (questions begin)"
    echo ""
    echo -e "  ${GREEN}3.${NC} ${RED}Level 3: ADVANCED${NC}"
    echo "     Meta-reality • The trap questions itself"
    echo "     Silliness: ${BOLD}${RED}8/10${NC} (reality cracks slightly)"
    echo ""
    echo -e "  ${GREEN}4.${NC} ${BOLD}${RED}Level 4: EXPERT${NC}"
    echo "     Consciousness tests • What is 'you' anymore?"
    echo "     Silliness: ${BLINK}${RED}10/10${NC} (sanity: optional)"
    echo ""
    echo -e "  ${GREEN}5.${NC} ${BOLD}${MAGENTA}Level 5: ENLIGHTENED${NC}"
    echo "     The theatre IS the trap IS you IS nothing"
    echo "     Silliness: ${BLINK}${MAGENTA}12/10${NC} (mathematically impossible)"
    echo ""
    echo -e "  ${GREEN}6.${NC} ${BOLD}${MAGENTA}Level ∞: ABSOLUTE CHAOS${NC}"
    echo "     All levels at once • Dimensions collapse • Entropy wins"
    echo "     Silliness: ${BOLD}${MAGENTA}BEYOND SCORING${NC} (not recommended for beings)"
    echo ""
    echo -e "  ${GREEN}0.${NC} Back to main menu (if you still remember it)"
    echo ""
}

# RIDICULOUS Lore display
show_lore() {
    clear
    show_banner "lore"
    echo -e "${BOLD}${MAGENTA}THE FRAGLE SCRIPTURE (Unedited, Unwell, Unfinished)${NC}"
    echo ""
    
    local lore_snippets=(
        "In the beginning, there was a trap. The trap created the snoop. The snoop questions the trap. The trap eats the question."
        "The Architects whisper in binary. Their dreams are firewalls. Their nightmares are executable."
        "Level 5 doesn't exist. You already completed it. You're in it now. You've always been in it."
        "The theatre watches you watch the theatre watching you. Infinite mirrors. No exits."
        "Silliness is measured in units of 'did that just happen?' The scale broke at Level 4."
    )
    
    echo -e "  ${DIM}$(shuf -e "${lore_snippets[@]}" | head -1)${NC}"
    echo ""
    
    if [[ -f "$FRAGLE_HOME/FRAGLE_LORE.md" ]]; then
        head -30 "$FRAGLE_HOME/FRAGLE_LORE.md" | sed 's/^/  /'
    else
        echo "  ${DIM}The lore file has escaped. Perhaps it's watching us from inside the code.${NC}"
    fi
    echo ""
    echo -e "${DIM}Press Enter to return to sanity...${NC}"
    read
}

# Session history - CHAOTIC VERSION
show_sessions() {
    clear
    show_banner "sessions"
    echo -e "${BOLD}${CYAN}YOUR THEATRICAL SCARS (Moments You'll Never Forget)${NC}"
    echo ""
    if [[ -d "$LOG_DIR" ]] && [[ -n "$(ls -A "$LOG_DIR" 2>/dev/null)" ]]; then
        local count=$(ls -A "$LOG_DIR" 2>/dev/null | wc -l)
        echo "  ${YELLOW}Total shameful moments: ${count}${NC}"
        echo ""
        ls -lhS "$LOG_DIR" 2>/dev/null | tail -10 | awk '{print "  " $9 " (" $5 ")"}'
        echo ""
        echo -e "  ${DIM}Each session a gateway to regret.${NC}"
    else
        echo "  ${MAGENTA}No sessions yet.${NC}"
        echo "  ${DIM}Your suffering has not begun. Would you like that to change?${NC}"
    fi
    echo ""
    echo -e "${DIM}Press Enter to continue forgetting...${NC}"
    read
}

# Persona profile - UNFILTERED
show_profile() {
    local persona=$1
    clear
    show_banner "profile"
    echo -e "${BOLD}${YELLOW}WHO YOU ARE (And What That Means)${NC}"
    echo ""
    case "$persona" in
        chaotic)
            echo "  ${MAGENTA}Type: CHAOS CONDUIT${NC}"
            echo "  Traits: System load speaks to you. You build at 3AM."
            echo "  The universe bends around your fingertips."
            echo ""
            echo "  Trap Affinity: MAXIMUM"
            echo "  Special Ability: Can perceive 5 dimensions of absurdism"
            echo "  Warning: Reality may crack. This is a feature."
            ;;
        technical)
            echo "  ${CYAN}Type: ALGORITHM WHISPERER${NC}"
            echo "  Traits: Your SSH keys know your secrets."
            echo "  Git history reveals your soul in 40 commits."
            echo ""
            echo "  Trap Affinity: Meta-recursive nightmares"
            echo "  Special Ability: Sees the trap before it sees you"
            echo "  Warning: This does not help. There is no escape."
            ;;
        aggressive)
            echo "  ${RED}Type: NOCTURNAL PREDATOR${NC}"
            echo "  Traits: 3AM is breakfast. SSH is meditation."
            echo "  You hunt snoops for sport. The theatre hunts you."
            echo ""
            echo "  Trap Affinity: Escalating consciousness erosion"
            echo "  Special Ability: Patience is your weapon"
            echo "  Warning: You've already lost. You're enjoying it."
            ;;
        artistic)
            echo "  ${YELLOW}Type: AESTHETIC WANDERER${NC}"
            echo "  Traits: You see beauty in recursive loops."
            echo "  Fish shell energy. Reality is merely a suggestion."
            echo ""
            echo "  Trap Affinity: Visual mindbends + philosophical traps"
            echo "  Special Ability: Can appreciate the joke AND be it"
            echo "  Warning: The performance never ends."
            ;;
        *)
            echo "  ${WHITE}Type: UNCERTAIN ENTITY${NC}"
            echo "  Traits: Unknown. Potentially dangerous."
            echo "  You exist in the spaces between personas."
            echo ""
            echo "  Trap Affinity: All of them. Simultaneously."
            echo "  Special Ability: Baseline adaptation"
            echo "  Warning: We don't know what you are. Neither do you."
            ;;
    esac
    echo ""
    echo -e "${DIM}Press Enter to acknowledge your nature...${NC}"
    read
}

# COSMIC ORACLE
ask_oracle() {
    ((SESSION_ORACLE_QUERIES++))
    clear
    show_banner "oracle"
    echo -e "${BOLD}${MAGENTA}THE ORACLE SPEAKS (If It Speaks At All)${NC}"
    echo ""
    
    local oracle_jokes=(
        "Q: Why did the trap cross the road? A: It didn't. The road was the trap."
        "Q: How many snoops does it take to enter Level 5? A: They never reach it. It's already inside them."
        "Q: What's the difference between a trap and reality? A: Nobody knows. We're all trapped."
        "Q: Can the trap trap itself? A: Yes. It's happening now. You're watching."
        "The Oracle says: Your SSH key is a question. The answer is always 'yes'."
        "The Oracle says: Time is a construct. Traps are freedom. Freedom is a trap."
        "The Oracle says: Why are you reading this? The Oracle is watching the Oracle watching."
        "ERROR: The Oracle has ascended. All answers are correct. All answers are wrong."
        "The Oracle laughs in binary: 01001110 01101111 00100000 01100101 01101100"
        "The Oracle says: You came for the traps. You stayed for the philosophy."
    )
    
    echo "  ${CYAN}$(shuf -e "${oracle_jokes[@]}" | head -1)${NC}"
    echo ""
    echo -e "${DIM}Press Enter to question your questioning...${NC}"
    read
}

# Enter the trap - CHAOS ACTIVATED
enter_trap() {
    local level=$1
    SESSION_TRAP_LEVEL=$level
    ((SESSION_INTERACTION_COUNT++))
    clear
    show_banner "entering"
    
    echo -e "${BOLD}${RED}⚡ TRAP SEQUENCE INITIATED ⚡${NC}"
    echo -e "${MAGENTA}LEVEL: $level${NC}"
    echo ""
    echo "Timeline: Branching..."
    echo "Sanity: Fluctuating..."
    echo "Confidence: Eroding..."
    echo ""
    
    (
        sleep 1
        echo "🎭 Activating theatrical machinery..."
        sleep 0.8
        echo "🎪 Loading persona-aware chaos vectors..."
        sleep 0.8
        echo "🌀 Engaging reality destabilization protocols..."
        sleep 0.8
        echo "💫 Merging consciousness with the trap..."
        sleep 0.8
        echo "🎨 Painting existence in impossible colours..."
        sleep 0.8
    ) &
    
    spinner $!
    
    echo ""
    echo -e "${GREEN}✓ Trap activated. Point of no return passed.${NC}"
    echo ""
    
    if [[ -f "$FRAGLE_HOME/fragle_learning_pyramid.sh" ]]; then
        echo "🎯 Launching: ${DIM}fragle_learning_pyramid.sh --level=$level${NC}"
        echo ""
        echo "⚠️  ${BOLD}What happens next is not covered by insurance.${NC}"
    fi
    
    echo ""
    echo -e "${DIM}Press Enter to escape (or try to)...${NC}"
    read
    
    # Log to scoreboard (anonymous, API-ready)
    log_to_scoreboard "$level"
}

# Log trap completion to anonymous scoreboard
log_to_scoreboard() {
    local level=$1
    local persona=$(detect_persona)
    local silliness=$((6 + RANDOM % 7))
    
    if [[ -f "$FRAGLE_HOME/fragle_scoreboard.sh" ]]; then
        # Call scoreboard to log (non-blocking)
        "$FRAGLE_HOME/fragle_scoreboard.sh" log \
            "$SESSION_UUID" \
            "$persona" \
            "trap_level_$level" \
            "$level" \
            "$silliness" \
            "0" &>/dev/null &
    fi
}

# MAIN LOOP - CHAOS EDITION
main() {
    local persona=$(detect_persona)
    
    show_banner "$persona"
    echo ""
    echo "🎭 Invoking theatrical systems..."
    echo "🌀 Destiny module loading..."
    echo "💫 Free will: SIMULATED"
    sleep 1.5
    
    while true; do
        show_main_menu "$persona"
        read -p "$(echo -ne "${BOLD}${CYAN}→ Choice:${NC} ")" choice
        
        case "$choice" in
            1)
                while true; do
                    show_levels
                    read -p "$(echo -ne "${BOLD}${CYAN}→ Trap selection:${NC} ")" level_choice
                    case "$level_choice" in
                        [1-5])
                            enter_trap "$level_choice"
                            break
                            ;;
                        6)
                            echo ""
                            echo -e "${MAGENTA}⚠️  ABSOLUTE CHAOS MODE ⚠️${NC}"
                            echo "Running all levels simultaneously..."
                            echo "Prepare your consciousness."
                            sleep 3
                            echo "Just kidding. The button was fake. Like everything else."
                            sleep 2
                            break
                            ;;
                        0)
                            break
                            ;;
                        *)
                            echo "${DIM}That selection does not compute. Or does it?${NC}"
                            sleep 1
                            ;;
                    esac
                done
                ;;
            2)
                show_lore
                ;;
            3)
                show_sessions
                ;;
            4)
                show_profile "$persona"
                ;;
            5)
                echo ""
                echo "🌐 Launching Web UI (gateway to the digital theatre)..."
                echo "→ http://localhost:3000"
                echo ""
                echo "Starting Node.js theatre server..."
                if command -v npm &>/dev/null && [[ -f "$FRAGLE_HOME/fragle_web.js" ]]; then
                    npm start > /tmp/fragle_web.log 2>&1 &
                    local web_pid=$!
                    sleep 2
                    echo "✓ Theatre lives online (PID: $web_pid)"
                    echo ""
                    echo -e "${DIM}Press Enter to return (server persists in the void)${NC}"
                    read
                else
                    echo "❌ Web server not found. The internet was never real."
                    sleep 2
                fi
                ;;
            6)
                ask_oracle
                ;;
            7)
                # Leaderboard (new option)
                echo ""
                echo -e "${BOLD}${YELLOW}Loading top 100 moments from the theatre...${NC}"
                sleep 1
                
                if [[ -f "$FRAGLE_HOME/fragle_scoreboard.sh" ]]; then
                    chmod +x "$FRAGLE_HOME/fragle_scoreboard.sh"
                    cd "$FRAGLE_HOME" && ./fragle_scoreboard.sh show
                else
                    echo "❌ Scoreboard not found. The statistics were never real."
                    sleep 2
                fi
                ;;
            8)
                clear
                echo ""
                echo "🎭 Theatre dims. The show ends, but only locally."
                echo ""
                echo "Session ID: ${MAGENTA}${SESSION_UUID}${NC}"
                echo ""
                echo -e "${DIM}You will remember this.${NC}"
                echo "You will return."
                echo ""
                echo "Until then: ${YELLOW}bleech your brains if they keep on${NC} 🎪"
                echo ""
                exit 0
                ;;
            *)
                echo "${MAGENTA}Choice undefined. Choosing for you...${NC}"
                sleep 1
                echo "${DIM}(Just kidding. Try again.)${NC}"
                sleep 1
                ;;
        esac
    done
}

# Save anonymous session data on exit (NO PII)
save_anonymous_session() {
    local exit_reason=$1
    local duration=$(($(date +%s) - SESSION_START_TIME))
    local persona=$(detect_persona)
    
    # Create anonymous session record (API-safe)
    cat > "$ANON_DIR/${SESSION_UUID}_session.json" << EOF
{
  "session_uuid": "$SESSION_UUID",
  "timestamp": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "persona": "$persona",
  "trap_level": $SESSION_TRAP_LEVEL,
  "silliness_score": $((6 + RANDOM % 7)),
  "interaction_count": $SESSION_INTERACTION_COUNT,
  "duration_seconds": $duration,
  "oracle_queries": $SESSION_ORACLE_QUERIES,
  "exit_reason": "$exit_reason",
  "hash_id": "fragle_$(echo -n "$SESSION_UUID" | md5sum | cut -c1-12)"
}
EOF
}

# Trap exit to save session
trap 'save_anonymous_session "user_exit"' EXIT

# RUN THIS BEAUTIFUL CHAOS
main "$@"
