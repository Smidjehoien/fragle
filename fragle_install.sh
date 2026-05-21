#!/bin/bash
# fragle_install.sh
#
# ONE-STEP FRAGLE SETUP
# Installs all scripts, docs, and creates demo environment
#
# Usage:
#   bash fragle_install.sh          (interactive install)
#   bash fragle_install.sh --demo   (run demo immediately)
#   bash fragle_install.sh --verify (check installation)

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

FRAGLE_DIR="$(pwd)"
DEMO_MODE="${1:-}"

# ════════════════════════════════════════════════════════════════════
# INSTALLATION
# ════════════════════════════════════════════════════════════════════

install_fragle() {
    echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║          🎪 FRAGLE INSTALLATION 🎪                         ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    # Check if already installed
    if [ -d "$FRAGLE_DIR" ] && [ -f "$FRAGLE_DIR/fragle_learning_pyramid.sh" ]; then
        echo -e "${YELLOW}⚠️  Fragle already installed at: $FRAGLE_DIR${NC}"
        read -p "Reinstall? (y/n): " reinstall
        if [ "$reinstall" != "y" ]; then
            echo "Keeping existing installation."
            return 0
        fi
    fi
    
    # Create directories
    echo -e "${BLUE}Creating directories...${NC}"
    mkdir -p "$FRAGLE_DIR"/.fragle_sessions
    
    # Make scripts executable
    echo -e "${BLUE}Setting up scripts...${NC}"
    chmod +x "$FRAGLE_DIR"/fragle_learning_pyramid.sh 2>/dev/null || true
    
    echo -e "${GREEN}✅ Installation complete!${NC}"
    echo ""
    echo "Fragle installed at: $FRAGLE_DIR"
    echo ""
    echo -e "${YELLOW}Next steps:${NC}"
    echo "  1. Run tutorial:    bash fragle_install.sh --demo"
    echo "  2. Start trap:      cd $FRAGLE_DIR && bash fragle_learning_pyramid.sh"
    echo "  3. Check status:    bash fragle_install.sh --verify"
    echo "  4. View docs:       cat $FRAGLE_DIR/LEARNING_JOURNEY.md"
}

# ════════════════════════════════════════════════════════════════════
# DEMO MODE (Safe, non-trapping)
# ════════════════════════════════════════════════════════════════════

run_demo() {
    clear
    echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║          🎪 FRAGLE DEMO — Level 1 Preview 🎪              ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${YELLOW}This is a SAFE PREVIEW of Level 1 trap mechanics.${NC}"
    echo "You can exit anytime with Ctrl+C."
    echo ""
    sleep 2
    
    # Demo Level 1: System Update Trap (shortened)
    echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║              SYSTEM MAINTENANCE IN PROGRESS                 ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo "System updating to version 47.3.12..."
    sleep 1
    
    # Progress bar (shorter for demo)
    for i in {1..40}; do
        echo -n "▓"
        sleep 0.03
    done
    echo ""
    echo -e "${GREEN}Update complete: 47.3.13${NC}"
    sleep 1
    
    echo -e "${YELLOW}System rebooting...${NC}"
    sleep 1
    
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${YELLOW}Notice:${NC} In the real trap, this would loop forever."
    echo -e "${YELLOW}Level 1${NC} teaches: Authority through graphics."
    echo ""
    
    sleep 1
    
    # Show expertise detection
    echo -e "${BLUE}Your Profile:${NC}"
    if [ -f ~/.bash_history ]; then
        local bash_patterns=$(grep -c "fragle\|\.sh\|bash" ~/.bash_history || echo 0)
        local expertise=$((bash_patterns / 20 + 1))
        expertise=$((expertise > 5 ? 5 : expertise))
        echo "  Detected Expertise: $expertise/5"
        
        case $expertise in
            1) echo "  → You'd encounter Level 1 (Novice) traps" ;;
            2) echo "  → You'd encounter Level 2 (Intermediate) traps" ;;
            3) echo "  → You'd encounter Level 3 (Advanced) traps" ;;
            4) echo "  → You'd encounter Level 4 (Expert) traps" ;;
            5) echo "  → You'd encounter Level 5 (Enlightened) traps" ;;
        esac
    else
        echo "  Detected Expertise: Unknown (no history)"
        echo "  → You'd encounter Level 1 (Novice) traps"
    fi
    
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
    echo ""
    echo -e "${GREEN}📚 Documentation Available:${NC}"
    echo "  • LEARNING_JOURNEY.md — Full progression system"
    echo "  • TRAP_TOURNAMENT.md — Legendary encounters"
    echo "  • SILLINESS_SCALE.md — Trap difficulty tiers"
    echo "  • FRAGLE_LORE.md — Universe & characters"
    echo ""
    
    read -p "Ready to enter the real trap? (y/n): " enter_real
    
    if [ "$enter_real" = "y" ]; then
        echo ""
        echo -e "${YELLOW}Starting full trap system...${NC}"
        sleep 1
        cd "$FRAGLE_DIR" && bash fragle_learning_pyramid.sh
    else
        echo -e "${CYAN}You may return to the trap anytime.${NC}"
        echo ""
        exit 0
    fi
}

# ════════════════════════════════════════════════════════════════════
# VERIFY INSTALLATION
# ════════════════════════════════════════════════════════════════════

verify_installation() {
    echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║          🎪 FRAGLE VERIFICATION 🎪                         ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    local all_good=true
    
    # Check main script
    if [ -f "$FRAGLE_DIR/fragle_learning_pyramid.sh" ]; then
        echo -e "${GREEN}✅${NC} fragle_learning_pyramid.sh"
    else
        echo -e "${RED}❌${NC} fragle_learning_pyramid.sh (missing)"
        all_good=false
    fi
    
    # Check documentation
    local docs=(
        "LEARNING_JOURNEY.md"
        "TRAP_TOURNAMENT.md"
        "SILLINESS_SCALE.md"
        "FRAGLE_LORE.md"
        "INTEGRATION_GUIDE.md"
    )
    
    for doc in "${docs[@]}"; do
        if [ -f "$FRAGLE_DIR/$doc" ]; then
            echo -e "${GREEN}✅${NC} $doc"
        else
            echo -e "${YELLOW}⚠️ ${NC} $doc (optional, nice to have)"
        fi
    done
    
    # Check session directory
    if [ -d "$FRAGLE_DIR/.fragle_sessions" ]; then
        echo -e "${GREEN}✅${NC} .fragle_sessions/ (session tracking)"
    else
        echo -e "${YELLOW}⚠️ ${NC} .fragle_sessions/ (will be created on first run)"
    fi
    
    echo ""
    
    if [ "$all_good" = true ]; then
        echo -e "${GREEN}🎉 All systems operational!${NC}"
        echo ""
        echo "Ready to run:"
        echo "  cd $FRAGLE_DIR && bash fragle_learning_pyramid.sh"
    else
        echo -e "${RED}⚠️  Some files missing. Run installer again.${NC}"
        return 1
    fi
    
    echo ""
}

# ════════════════════════════════════════════════════════════════════
# MAIN
# ════════════════════════════════════════════════════════════════════

case "${DEMO_MODE}" in
    --demo)
        run_demo
        ;;
    --verify)
        verify_installation
        ;;
    --help|-h)
        cat << 'HELP'
FRAGLE INSTALLER

Usage:
  bash fragle_install.sh              Install Fragle
  bash fragle_install.sh --demo       Run interactive demo
  bash fragle_install.sh --verify     Check installation
  bash fragle_install.sh --help       Show this help

Examples:
  bash fragle_install.sh
  cd fragle && bash fragle_learning_pyramid.sh

  bash fragle_install.sh --demo
  (Safe preview, then enter real trap if you want)

  bash fragle_install.sh --verify
  (Check that all files are in place)

About:
  Fragle is a theatrical honeypot with 5 difficulty levels
  and a learning system that evolves with each snoop.
  
  By entering, you join the lore. Your journey becomes
  part of Fragle's documented history.
  
  Welcome. 🎪
HELP
        ;;
    *)
        install_fragle
        ;;
esac
