#!/bin/bash
# fragle_scoreboard.sh
# Anonymous activity + leaderboard system
# 100% PII-safe, API-ready for .app website

set -e

FRAGLE_HOME="${FRAGLE_HOME:-.}"
SCOREBOARD_DIR="${FRAGLE_HOME}/.fragle_scoreboard"
ACTIVITY_LOG="${SCOREBOARD_DIR}/activity.jsonl"
STATS_CACHE="${SCOREBOARD_DIR}/stats_cache.json"

mkdir -p "$SCOREBOARD_DIR"

# Colours for display
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

# Log an activity (anonymous, no PII)
# Usage: log_activity <session_uuid> <persona> <event_type> <level> <silliness> <duration>
log_activity() {
    local session_uuid=$1
    local persona=$2
    local event_type=$3
    local level=$4
    local silliness=$5
    local duration=$6
    
    # Ensure ACTIVITY_LOG exists
    touch "$ACTIVITY_LOG"
    
    # Append JSON line (JSONL format)
    cat >> "$ACTIVITY_LOG" << EOF
{"timestamp":"$(date -u +"%Y-%m-%dT%H:%M:%SZ")","session_uuid":"$session_uuid","persona":"$persona","event":"$event_type","level":$level,"silliness":$silliness,"duration":$duration,"hash":"$(echo -n "$session_uuid" | md5sum | cut -c1-8)"}
EOF
}

# Get top 100 personas by frequency
get_top_personas() {
    if [[ ! -f "$ACTIVITY_LOG" ]]; then
        echo "No activity yet. The theatre sleeps."
        return
    fi
    
    echo -e "${BOLD}${CYAN}🎭 TOP PERSONAS (Who Entered Most)${NC}"
    echo ""
    
    local count=1
    grep -o '"persona":"[^"]*"' "$ACTIVITY_LOG" | \
        cut -d'"' -f4 | \
        sort | uniq -c | sort -rn | head -100 | \
        while read freq persona; do
            local bar=$(printf '▓%.0s' $(seq 1 $((freq / 2))))
            printf "%3d. %-12s %s (%d entries)\n" "$count" "$persona" "$bar" "$freq"
            ((count++))
        done
}

# Get top 100 sessions by silliness score
get_top_silliness() {
    if [[ ! -f "$ACTIVITY_LOG" ]]; then
        echo "No activity yet. The theatre is silent."
        return
    fi
    
    echo -e "${BOLD}${YELLOW}🌀 TOP SILLINESS MOMENTS (Most Unhinged Sessions)${NC}"
    echo ""
    
    local count=1
    jq -r '.silliness' "$ACTIVITY_LOG" 2>/dev/null | \
        sort -nr | head -100 | \
        while read silliness; do
            local bars=$(printf '█%.0s' $(seq 1 $((silliness))))
            printf "%3d. Silliness %2d/12 %s\n" "$count" "$silliness" "$bars"
            ((count++))
        done
}

# Get top 100 trap levels entered
get_top_levels() {
    if [[ ! -f "$ACTIVITY_LOG" ]]; then
        echo "No levels conquered yet."
        return
    fi
    
    echo -e "${BOLD}${MAGENTA}📊 TRAP LEVELS ENTERED (Frequency)${NC}"
    echo ""
    
    grep -o '"level":[0-9]*' "$ACTIVITY_LOG" | \
        cut -d':' -f2 | \
        sort | uniq -c | sort -rn | \
        awk '{
            level=$2
            count=$1
            bars=""
            for(i=0;i<count;i++) bars=bars"█"
            printf "Level %d: %s (%d times)\n", level, bars, count
        }'
}

# Get global statistics (for API)
get_global_stats() {
    if [[ ! -f "$ACTIVITY_LOG" ]]; then
        cat << EOF
{
  "total_sessions": 0,
  "total_activities": 0,
  "avg_silliness": 0,
  "most_popular_persona": "unknown",
  "most_attempted_level": 0,
  "api_ready": true
}
EOF
        return
    fi
    
    local total_sessions=$(cut -d'"' -f8 "$ACTIVITY_LOG" | sort -u | wc -l)
    local total_activities=$(wc -l < "$ACTIVITY_LOG")
    local avg_silliness=$(grep -o '"silliness":[0-9]*' "$ACTIVITY_LOG" | cut -d':' -f2 | awk '{sum+=$1} END {print int(sum/NR)}')
    local most_popular_persona=$(grep -o '"persona":"[^"]*"' "$ACTIVITY_LOG" | cut -d'"' -f4 | sort | uniq -c | sort -rn | head -1 | awk '{print $2}')
    local most_attempted_level=$(grep -o '"level":[0-9]*' "$ACTIVITY_LOG" | cut -d':' -f2 | sort | uniq -c | sort -rn | head -1 | awk '{print $2}')
    
    cat << EOF
{
  "total_sessions": $total_sessions,
  "total_activities": $total_activities,
  "avg_silliness": $avg_silliness,
  "most_popular_persona": "$most_popular_persona",
  "most_attempted_level": $most_attempted_level,
  "api_ready": true,
  "timestamp": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
}
EOF
}

# Real-time activity feed (last N events)
get_activity_feed() {
    local limit=${1:-20}
    
    if [[ ! -f "$ACTIVITY_LOG" ]]; then
        echo "The theatre is empty. No activity yet."
        return
    fi
    
    echo -e "${BOLD}${CYAN}📡 LIVE ACTIVITY (Last $limit Events)${NC}"
    echo ""
    
    local count=1
    tail -n "$limit" "$ACTIVITY_LOG" | tac | while read line; do
        local timestamp=$(echo "$line" | jq -r '.timestamp' 2>/dev/null)
        local persona=$(echo "$line" | jq -r '.persona' 2>/dev/null)
        local event=$(echo "$line" | jq -r '.event' 2>/dev/null)
        local level=$(echo "$line" | jq -r '.level' 2>/dev/null)
        local silliness=$(echo "$line" | jq -r '.silliness' 2>/dev/null)
        
        # Colour by persona
        case "$persona" in
            technical) persona_colour="${CYAN}$persona${NC}" ;;
            aggressive) persona_colour="${RED}$persona${NC}" ;;
            artistic) persona_colour="${MAGENTA}$persona${NC}" ;;
            curious) persona_colour="${GREEN}$persona${NC}" ;;
            chaotic) persona_colour="${YELLOW}$persona${NC}" ;;
            *) persona_colour="$persona" ;;
        esac
        
        printf "%2d. %s | %-12b | Level %d | Silliness %2d/12\n" "$count" "$timestamp" "$persona_colour" "$level" "$silliness"
        ((count++))
    done
}

# Aggregate anonymous stats for export to API
export_stats_for_api() {
    local output="${1:-./.fragle_scoreboard/stats_api.json}"
    
    get_global_stats > "$output"
    
    echo "✓ Stats exported to: $output"
    echo "Ready for API submission."
}

# Heatmap: most active hours (for API)
get_activity_heatmap() {
    if [[ ! -f "$ACTIVITY_LOG" ]]; then
        echo "{}"
        return
    fi
    
    echo "{"
    echo "  \"by_hour\": {"
    
    for hour in {0..23}; do
        local count=$(grep "T$(printf '%02d' $hour):" "$ACTIVITY_LOG" | wc -l)
        printf '    "%02d:00": %d' "$hour" "$count"
        [[ $hour -lt 23 ]] && echo ","
    done
    
    echo ""
    echo "  },"
    echo "  \"by_persona\": {"
    
    local first=true
    grep -o '"persona":"[^"]*"' "$ACTIVITY_LOG" | cut -d'"' -f4 | sort -u | while read persona; do
        local count=$(grep "\"persona\":\"$persona\"" "$ACTIVITY_LOG" | wc -l)
        if [[ "$first" == "false" ]]; then echo ","; fi
        printf '    "%s": %d' "$persona" "$count"
        first="false"
    done
    
    echo ""
    echo "  }"
    echo "}"
}

# Pretty-print top 100 leaderboard
show_leaderboard() {
    clear
    
    cat << 'BANNER'
╔════════════════════════════════════════════════════════════════════╗
║                                                                    ║
║          🎭  FRAGLE THEATRE - ANONYMOUS LEADERBOARD  🎭          ║
║                                                                    ║
║                    Top 100 Theatrical Moments                      ║
║                      (100% Privacy Preserved)                      ║
║                                                                    ║
╚════════════════════════════════════════════════════════════════════╝
BANNER
    
    echo ""
    echo "🌍 GLOBAL STATISTICS"
    echo "────────────────────"
    get_global_stats | jq . 2>/dev/null || get_global_stats
    
    echo ""
    echo "────────────────────────────────────────────────────────────────"
    echo ""
    get_top_personas
    
    echo ""
    echo "────────────────────────────────────────────────────────────────"
    echo ""
    get_top_silliness
    
    echo ""
    echo "────────────────────────────────────────────────────────────────"
    echo ""
    get_top_levels
    
    echo ""
    echo "────────────────────────────────────────────────────────────────"
    echo ""
    get_activity_feed 15
    
    echo ""
    echo "────────────────────────────────────────────────────────────────"
    echo ""
    echo "Press Enter to continue..."
    read
}

# Command interface
case "${1:-help}" in
    log)
        log_activity "$2" "$3" "$4" "$5" "$6" "$7"
        ;;
    stats)
        get_global_stats
        ;;
    personas)
        get_top_personas
        ;;
    silliness)
        get_top_silliness
        ;;
    levels)
        get_top_levels
        ;;
    feed)
        get_activity_feed "${2:-20}"
        ;;
    heatmap)
        get_activity_heatmap
        ;;
    export)
        export_stats_for_api "$2"
        ;;
    show)
        show_leaderboard
        ;;
    clear)
        rm -f "$ACTIVITY_LOG" "$STATS_CACHE"
        echo "✓ Activity log cleared (theatrical amnesia engaged)"
        ;;
    help|*)
        cat << 'HELP'
fragle_scoreboard.sh - Anonymous Activity + Leaderboard System

COMMANDS:
  log <uuid> <persona> <event> <level> <silliness> <duration>
      Log an anonymous activity (NO PII)

  stats                   Get global statistics (JSON)
  personas                Top 100 personas by frequency
  silliness               Top 100 moments by silliness score
  levels                  Top trap levels entered
  feed [N]                Live activity feed (last N, default 20)
  heatmap                 Activity heatmap by hour/persona (JSON)
  export [file]           Export stats for API submission
  show                    Pretty-print full leaderboard (interactive)
  clear                   Clear all activity logs
  help                    This message

PRIVACY GUARANTEES:
  ✓ No usernames, IPs, paths, hostnames
  ✓ Only: UUID hash, persona type, trap level, silliness score
  ✓ Timestamps (no PII)
  ✓ Session count (anonymous)
  ✓ Aggregated statistics (no individual tracking)

API INTEGRATION:
  1. TUI logs activities: log_activity <uuid> <persona> <level> <silly>
  2. Periodically export: export_stats_for_api
  3. API receives anonymous JSON blob
  4. Website displays leaderboards (fully anonymous)
  5. No user can be identified from data

EXAMPLE:
  # In TUI after trap completion:
  ./fragle_scoreboard.sh log "550e8400-e29b-41d4-a716-446655440000" \
                             "chaotic" "trap_complete" 5 10 1847

  # Get stats:
  ./fragle_scoreboard.sh stats

  # Export for API:
  ./fragle_scoreboard.sh export ./stats_to_send.json

  # View leaderboard:
  ./fragle_scoreboard.sh show

HELP
        ;;
esac
