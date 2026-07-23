#!/bin/bash
# Fragle Interactive Portal - CLI Menu System
# Theatrical opt-in experience with persona detection
# Pairs with fragle_learning_pyramid.sh for actual trap execution

set -e

FRAGLE_HOME="${FRAGLE_HOME:-.}"
SESSION_UUID=$(uuidgen 2>/dev/null || python3 -c "import uuid; print(uuid.uuid4())" 2>/dev/null || echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Persona detection based on environment signals
detect_persona() {
    local score_technical=0
    local score_aggressive=0
    local score_artistic=0
    local score_curious=0

    # Shell type signals
    [[ "$SHELL" == *"zsh"* ]] && ((score_technical++))
    [[ "$SHELL" == *"fish"* ]] && ((score_artistic++))
    [[ "$SHELL" == *"bash"* ]] && ((score_technical++))

    # User environment signals
    [[ -n "$SSH_CLIENT" ]] && ((score_aggressive++))
    [[ -n "$DISPLAY" ]] && ((score_curious++))
    [[ -f ~/.ssh/config ]] && ((score_technical+=2))
    [[ -f ~/.gitconfig ]] && ((score_technical++))

    # History signals
    if command -v history &>/dev/null; then
        local hist_lines=$(history 100 2>/dev/null | wc -l)
        if ((hist_lines > 500)); then
            ((score_technical+=2))
        elif ((hist_lines < 50)); then
            ((score_curious++))
        fi

        # Command patterns
        history 100 2>/dev/null | grep -q "curl\|wget\|nmap" && ((score_aggressive+=2))
        history 100 2>/dev/null | grep -q "python\|node\|rust" && ((score_technical+=2))
        history 100 2>/dev/null | grep -q "git\|github" && ((score_technical++))
    fi

    # Time of day signal
    local hour=$(date +%H)
    if ((hour >= 22 || hour <= 5)); then
        ((score_aggressive++))
    elif ((hour >= 9 && hour <= 12)); then
        ((score_curious++))
    fi

    # Determine winning persona
    local personas=(
        "technical:$score_technical"
        "aggressive:$score_aggressive"
        "artistic:$score_artistic"
        "curious:$score_curious"
    )

    local winner=$(echo "${personas[@]}" | tr ' ' '\n' | sort -t: -k2 -nr | head -1 | cut -d: -f1)
    echo "$winner"
}

# Persona-specific content
get_persona_content() {
    local persona=$1
    case "$persona" in
        technical)
            cat << 'EOF'

╔════════════════════════════════════════════════════════════╗
║              🎪 FRAGLE DETECTED: TECHNICAL 🎪              ║
╚════════════════════════════════════════════════════════════╝

Excellent. You've got tools. You've got history. You know
how to poke systems without breaking them.

Fragle is a 5-level progressive trap system:
  • Expertise auto-detection (bash history analysis)
  • Escalating complexity (Novice → Enlightened)
  • Trap collaboration mechanics at higher levels
  • Anonymized session tracking (UUIDs only)

Your expertise: 1-5 scale (auto-detected upon entry)

Levels:
  1. Novice        → Graphics tricks (6/10 silliness)
  2. Intermediate  → Logic puzzles (7/10 silliness)
  3. Advanced      → Recursive traps (8/10 silliness)
  4. Expert        → Meta-reality (10/10 silliness)
  5. Enlightened   → Consciousness (12/10 silliness)

At Level 5, things get philosophical.

EOF
            ;;

        aggressive)
            cat << 'EOF'

╔════════════════════════════════════════════════════════════╗
║              🎪 FRAGLE DETECTED: AGGRESSIVE 🎪             ║
╚════════════════════════════════════════════════════════════╝

Looking to break things, eh?

Fragle WANTS you to try. Each escape attempt teaches the
system. Each exploit makes the next trap smarter. You're not
being attacked—you're co-authoring the lore.

Three legendary snoops have reached Level 5.
Their names live in TRAP_TOURNAMENT.md.
Whispers suggest they were offered something... interesting.

Rules:
  ✓ No external malware. Pure theatre.
  ✓ Every escape is logged anonymously.
  ✓ Every snoop becomes part of documented history.
  ✓ You can exit anytime. No harm, no foul.
  ✓ Level 5 may unlock special status.

We respect clever. We reward persistence.

EOF
            ;;

        artistic)
            cat << 'EOF'

╔════════════════════════════════════════════════════════════╗
║               🎪 FRAGLE DETECTED: ARTISTIC 🎪              ║
╚════════════════════════════════════════════════════════════╝

Welcome to the gallery.

Fragle is performance art disguised as security. Each trap
is a character. Each level is an act in a larger story.

The silliness quotient escalates with your expertise:
  • Level 1: 6/10  (subtly absurd)
  • Level 2: 7/10  (whimsically deceptive)
  • Level 3: 8/10  (delightfully recursive)
  • Level 4: 10/10 (reality-bending)
  • Level 5: 12/10 (consciousness questionable)

Your journey becomes documented in FRAGLE_LORE.md.
You're not just entering a trap.
You're becoming a character in a narrative that outlives you.

Come experience the show.

EOF
            ;;

        *)
            cat << 'EOF'

╔════════════════════════════════════════════════════════════╗
║                  🎪 FRAGLE DETECTED 🎪                    ║
╚════════════════════════════════════════════════════════════╝

Curious, are we?

Fragle is a 5-level learning system wrapped in theatrical
traps. The more you explore, the more you understand.
The more you understand, the deeper you can go.

No judgment. Pure exploration.

Features:
  • 5 progressive levels (expertise-scaled)
  • 15 trap mechanics per level
  • Anonymized session tracking (UUIDs only)
  • Lore integration (you become documented history)
  • Graceful exit (always available, no punishment)

What you make of it depends on who you are.

EOF
            ;;
    esac
}

# Display elaborate terms
show_terms() {
    clear
    cat << 'EOF'

╔════════════════════════════════════════════════════════════╗
║                    🎪 FRAGLE TERMS 🎪                     ║
╚════════════════════════════════════════════════════════════╝

PHILOSOPHY
──────────
Fragle is based on the WIMP principle:
  W - Weak Interaction (invitation, not force)
  I - Invitation Only (you choose to enter)
  M - Massive Presence (omnipresent, never invisible)
  P - Privacy Sacred (UUIDs only, no PII)

WHAT HAPPENS HERE
──────────────────
1. You enter the pyramid
2. Your expertise is auto-detected (1-5 scale)
3. You're routed to appropriate trap difficulty
4. You navigate traps, attempt escapes
5. Sessions logged anonymously
6. Lore updated with your results
7. You exit (always available)

SAFETY COMMITMENTS
───────────────────
✓ No external calls or malware
✓ No PII collection (UUID-based only)
✓ Graceful timeout (defaults to 15 minutes)
✓ Exit anytime (Ctrl+C always works)
✓ All data anonymized and archived
✓ No auto-emails or forced actions
✓ Theatre-first design (education through play)

DATA COLLECTION
────────────────
Anonymous session files stored in .fragle_sessions/:
  • Session UUID
  • Detected expertise level
  • Trap selections
  • Exit type (natural timeout, Ctrl+C, escape)
  • Timestamp
  • Performance metrics

NO REAL NAMES, IPS, OR PIDS ARE LOGGED.

LEVEL PROGRESSION
──────────────────
Level 1 (Novice):      Graphics-based decoys
Level 2 (Intermediate): Logic puzzles & misdirection
Level 3 (Advanced):    Recursive traps with escape routes
Level 4 (Expert):      Meta-reality (trap questions reality)
Level 5 (Enlightened):  Consciousness edge-case (philosophy)

Level 5 is where legendary snoops are documented.

BY ENTERING, YOU AGREE TO:
───────────────────────────
• Your experience will teach others (lore documentation)
• Your expertise helps calibrate future traps
• You may be featured in anonymized hall of fame
• You accept the theatrical and philosophical nature
• Your session data is archived (no deletion)

OPTIONAL:
──────────
If you reach Level 5, you may receive optional outreach
(via optional email template). This is NEVER automatic.
Manual use only. Your choice to respond.

════════════════════════════════════════════════════════════

EOF
}

# Main menu
main_menu() {
    local persona=$1

    while true; do
        clear
        echo -e "${CYAN}"
        cat << 'EOF'

╔════════════════════════════════════════════════════════════╗
║           🎪 FRAGLE INTERACTIVE PORTAL v1.0 🎪            ║
╚════════════════════════════════════════════════════════════╝

EOF
        echo -e "${NC}"

        get_persona_content "$persona"

        echo -e "${WHITE}Session UUID: ${GREEN}$SESSION_UUID${NC}"
        echo -e "${WHITE}Detected Persona: ${MAGENTA}${persona^^}${NC}"
        echo ""
        echo -e "${CYAN}Options:${NC}"
        echo "  1) Enter the Pyramid (start trap system)"
        echo "  2) Read the Lore (FRAGLE_LORE.md)"
        echo "  3) Check Rankings (TRAP_TOURNAMENT.md)"
        echo "  4) View Learning Framework (LEARNING_JOURNEY.md)"
        echo "  5) Show Terms & Philosophy"
        echo "  6) Exit (decline challenge)"
        echo ""
        echo -n "Choice [1-6]: "
        read -r choice

        case "$choice" in
            1)
                enter_pyramid
                ;;
            2)
                show_lore
                ;;
            3)
                show_rankings
                ;;
            4)
                show_framework
                ;;
            5)
                show_terms
                read -p "Press Enter to continue..."
                ;;
            6)
                echo ""
                echo -e "${RED}Until next time. The pyramid remembers you.${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}Invalid choice. Try again.${NC}"
                sleep 1
                ;;
        esac
    done
}

# Enter the pyramid (launch trap system)
enter_pyramid() {
    clear
    echo -e "${CYAN}"
    cat << 'EOF'

╔════════════════════════════════════════════════════════════╗
║                  ENTERING THE PYRAMID...                  ║
╚════════════════════════════════════════════════════════════╝

EOF
    echo -e "${NC}"
    echo "Session UUID: $SESSION_UUID"
    echo "Persona: ${persona^^}"
    echo ""
    echo "Launching fragle_learning_pyramid.sh..."
    echo ""
    sleep 2

    # Launch the actual trap system
    bash "$FRAGLE_HOME/fragle_learning_pyramid.sh" "$SESSION_UUID"

    echo ""
    echo -e "${GREEN}Session complete. Returning to portal...${NC}"
    sleep 2
}

# Show lore
show_lore() {
    if [[ -f "$FRAGLE_HOME/FRAGLE_LORE.md" ]]; then
        less "$FRAGLE_HOME/FRAGLE_LORE.md"
    else
        echo "Lore file not found: $FRAGLE_HOME/FRAGLE_LORE.md"
        read -p "Press Enter to continue..."
    fi
}

# Show rankings
show_rankings() {
    if [[ -f "$FRAGLE_HOME/TRAP_TOURNAMENT.md" ]]; then
        less "$FRAGLE_HOME/TRAP_TOURNAMENT.md"
    else
        echo "Rankings file not found: $FRAGLE_HOME/TRAP_TOURNAMENT.md"
        read -p "Press Enter to continue..."
    fi
}

# Show framework
show_framework() {
    if [[ -f "$FRAGLE_HOME/LEARNING_JOURNEY.md" ]]; then
        less "$FRAGLE_HOME/LEARNING_JOURNEY.md"
    else
        echo "Framework file not found: $FRAGLE_HOME/LEARNING_JOURNEY.md"
        read -p "Press Enter to continue..."
    fi
}

# Main execution
main() {
    local persona=$(detect_persona)
    main_menu "$persona"
}

main "$@"
