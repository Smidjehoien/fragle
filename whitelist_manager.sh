#!/bin/bash

# 🎯 Whitelist Manager
# Easy tool to manage who's allowed in your repository

WHITELIST_FILE="/home/pinky/fragle/.whitelist"

show_help() {
    echo "🎯 Fragle Whitelist Manager"
    echo "=========================="
    echo ""
    echo "Usage: $0 [command] [username]"
    echo ""
    echo "Commands:"
    echo "  add <username>      Add user to whitelist"
    echo "  remove <username>   Remove user from whitelist"
    echo "  list                Show all whitelisted users"
    echo "  check <username>    Check if user is whitelisted"
    echo "  help                Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 add alice              # Add alice to whitelist"
    echo "  $0 remove bob             # Remove bob from whitelist"
    echo "  $0 list                   # Show all allowed users"
    echo "  $0 check charlie          # Check if charlie is allowed"
}

list_whitelist() {
    echo "📋 Current Whitelist:"
    echo "==================="
    if [ -f "$WHITELIST_FILE" ]; then
        # Show only non-comment, non-blank lines
        local users=$(grep -v '^#' "$WHITELIST_FILE" | grep -v '^$' | sort)
        if [ -z "$users" ]; then
            echo "  (empty - only owner can access)"
        else
            echo "$users" | nl -w2 -s'. '
        fi
    else
        echo "  ⚠️  Whitelist file not found!"
    fi
    echo ""
}

add_user() {
    local username="$1"
    if [ -z "$username" ]; then
        echo "❌ Error: Please specify a username"
        echo "Usage: $0 add <username>"
        exit 1
    fi
    
    # Check if already whitelisted
    if grep -q "^${username}$" "$WHITELIST_FILE" 2>/dev/null; then
        echo "ℹ️  User '$username' is already whitelisted!"
        exit 0
    fi
    
    # Add to whitelist
    echo "$username" >> "$WHITELIST_FILE"
    echo "✅ Added '$username' to whitelist!"
    echo "🍪 They can now access the repository without triggering traps."
}

remove_user() {
    local username="$1"
    if [ -z "$username" ]; then
        echo "❌ Error: Please specify a username"
        echo "Usage: $0 remove <username>"
        exit 1
    fi
    
    # Check if whitelisted
    if ! grep -q "^${username}$" "$WHITELIST_FILE" 2>/dev/null; then
        echo "ℹ️  User '$username' is not in the whitelist!"
        exit 0
    fi
    
    # Remove from whitelist
    grep -v "^${username}$" "$WHITELIST_FILE" > "$WHITELIST_FILE.tmp"
    mv "$WHITELIST_FILE.tmp" "$WHITELIST_FILE"
    echo "✅ Removed '$username' from whitelist!"
    echo "🚨 They will now trigger anti-snoop measures."
}

check_user() {
    local username="$1"
    if [ -z "$username" ]; then
        echo "❌ Error: Please specify a username"
        echo "Usage: $0 check <username>"
        exit 1
    fi
    
    if grep -q "^${username}$" "$WHITELIST_FILE" 2>/dev/null; then
        echo "✅ User '$username' is whitelisted!"
        echo "🍪 They can access without triggering traps."
    else
        echo "❌ User '$username' is NOT whitelisted!"
        echo "🚨 They will trigger anti-snoop measures."
    fi
}

# Main logic
case "$1" in
    add)
        add_user "$2"
        ;;
    remove)
        remove_user "$2"
        ;;
    list)
        list_whitelist
        ;;
    check)
        check_user "$2"
        ;;
    help|--help|-h)
        show_help
        ;;
    "")
        show_help
        ;;
    *)
        echo "❌ Unknown command: $1"
        echo ""
        show_help
        exit 1
        ;;
esac
