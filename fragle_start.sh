#!/bin/bash
# fragle_start.sh - Universal entry point for all Fragle experiences
# Shell UI | Web Server | Electron App

set -e

FRAGLE_HOME="${FRAGLE_HOME:-.}"
MODE="${1:-shell}"  # shell | web | electron | all

# Colors
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

show_banner() {
    clear
    cat << 'BANNER'

    ╔═══════════════════════════════════════════════════════════╗
    ║                                                           ║
    ║        🎭  FRAGLE THEATRE - UNIVERSAL LAUNCHER  🎭       ║
    ║                                                           ║
    ║              Choose Your Journey Into Chaos              ║
    ║                                                           ║
    ╚═══════════════════════════════════════════════════════════╝

BANNER
}

show_menu() {
    echo ""
    echo -e "${CYAN}═══ MODE SELECTION ═══${NC}"
    echo ""
    echo -e "  ${GREEN}1.${NC} Shell TUI (Terminal Theatre)"
    echo "     Pure bash interface with whimsy"
    echo ""
    echo -e "  ${GREEN}2.${NC} Web Server (Browser Experience)"
    echo "     Express.js + WebSocket + theatrical web UI"
    echo ""
    echo -e "  ${GREEN}3.${NC} Electron App (Native .app)"
    echo "     Full desktop experience (macOS/Windows/Linux)"
    echo ""
    echo -e "  ${GREEN}4.${NC} All (Shell + Web + Electron)"
    echo "     Full sensory overload across all platforms"
    echo ""
    echo -e "  ${GREEN}0.${NC} Exit (if you dare)"
    echo ""
}

start_shell_ui() {
    echo ""
    echo -e "${GREEN}🎭 Launching Shell Theatre...${NC}"
    echo ""
    sleep 1
    
    if [[ -f "$FRAGLE_HOME/fragle_tui.sh" ]]; then
        bash "$FRAGLE_HOME/fragle_tui.sh"
    else
        echo "❌ fragle_tui.sh not found at $FRAGLE_HOME"
        exit 1
    fi
}

start_web_server() {
    echo ""
    echo -e "${GREEN}🌐 Starting Web Server Theatre...${NC}"
    echo ""
    
    if ! command -v npm &>/dev/null; then
        echo "❌ npm not installed. Cannot start web server."
        exit 1
    fi
    
    if [[ ! -f "$FRAGLE_HOME/fragle_web.js" ]]; then
        echo "❌ fragle_web.js not found"
        exit 1
    fi
    
    cd "$FRAGLE_HOME"
    
    echo "Installing dependencies (if needed)..."
    npm install > /tmp/fragle_npm.log 2>&1 || true
    
    echo ""
    echo -e "${GREEN}✓ Theatre online!${NC}"
    echo ""
    echo -e "  🌐 ${CYAN}http://localhost:3000${NC}"
    echo ""
    echo "Press Ctrl+C to stop the server"
    echo ""
    
    npm start
}

start_electron_app() {
    echo ""
    echo -e "${GREEN}💻 Starting Electron Desktop App...${NC}"
    echo ""
    
    if ! command -v npm &>/dev/null; then
        echo "❌ npm not installed. Cannot start Electron app."
        exit 1
    fi
    
    cd "$FRAGLE_HOME"
    
    echo "Installing Electron dependencies..."
    npm install > /tmp/fragle_electron.log 2>&1 || true
    
    echo ""
    echo -e "${GREEN}✓ Launching native app...${NC}"
    echo ""
    
    npm run electron
}

start_all() {
    echo ""
    echo -e "${YELLOW}⚠️  MULTI-THEATRE MODE ⚠️${NC}"
    echo ""
    echo "Starting all experiences simultaneously..."
    echo ""
    
    cd "$FRAGLE_HOME"
    
    # Start web server in background
    echo "1. Starting Web Server (localhost:3000)..."
    npm install > /tmp/fragle_npm.log 2>&1 || true
    npm start > /tmp/fragle_web.log 2>&1 &
    WEB_PID=$!
    echo "   PID: $WEB_PID"
    sleep 2
    
    # Start Electron in background
    echo "2. Starting Electron App..."
    npm run electron > /tmp/fragle_electron.log 2>&1 &
    ELECTRON_PID=$!
    echo "   PID: $ELECTRON_PID"
    sleep 2
    
    # Launch shell UI in foreground
    echo "3. Launching Shell Theatre (foreground)..."
    echo ""
    sleep 1
    
    if [[ -f "$FRAGLE_HOME/fragle_tui.sh" ]]; then
        bash "$FRAGLE_HOME/fragle_tui.sh"
    fi
    
    # Clean up
    echo ""
    echo "Shutting down other theatre instances..."
    kill $WEB_PID 2>/dev/null || true
    kill $ELECTRON_PID 2>/dev/null || true
    echo "✓ Theatre closed."
}

main() {
    show_banner
    
    if [[ "$MODE" == "shell" ]] || [[ "$MODE" == "1" ]]; then
        start_shell_ui
    elif [[ "$MODE" == "web" ]] || [[ "$MODE" == "2" ]]; then
        start_web_server
    elif [[ "$MODE" == "electron" ]] || [[ "$MODE" == "3" ]]; then
        start_electron_app
    elif [[ "$MODE" == "all" ]] || [[ "$MODE" == "4" ]]; then
        start_all
    else
        # Interactive menu
        show_menu
        read -p "$(echo -ne "${CYAN}→ Choice:${NC} ")" choice
        
        case "$choice" in
            1)
                start_shell_ui
                ;;
            2)
                start_web_server
                ;;
            3)
                start_electron_app
                ;;
            4)
                start_all
                ;;
            0)
                echo ""
                echo "🎭 The theatre remains, waiting..."
                exit 0
                ;;
            *)
                echo "Invalid choice"
                exit 1
                ;;
        esac
    fi
}

main "$@"
