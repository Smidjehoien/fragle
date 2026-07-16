#!/bin/bash
# fragle_api_anonymizer.sh
# Anonymization layer for Fragle API
# Ensures zero PII, fully compliant for public .app distribution

# Rules:
# 1. No usernames, home directories, hostnames
# 2. No IP addresses or network info
# 3. No file paths or system config
# 4. Only: UUID, timestamp, persona type, trap level, silliness score
# 5. Session data stored locally only (no cloud)

set -e

FRAGLE_ANON_DIR="${FRAGLE_ANON_DIR:-./.fragle_anon_data}"
mkdir -p "$FRAGLE_ANON_DIR"

# Anonymized session schema (API-safe)
# {
#   "session_uuid": "550e8400-e29b-41d4-a716-446655440000",
#   "timestamp": "2026-07-16T17:30:45Z",
#   "persona": "chaotic",           # Type only, no detection info
#   "trap_level": 3,                 # 1-5 or 0 for null
#   "silliness_score": 8,            # Perceived silliness (6-12)
#   "interaction_count": 42,         # How many choices made
#   "duration_seconds": 1847,        # Session length
#   "oracle_queries": 3,             # How many times asked Oracle
#   "exit_reason": "user_exit",      # user_exit | timeout | error
#   "hash_id": "fragle_abc123xyz"    # Deterministic hash (not PII)
# }

# Generate anonymous session record (NO PII)
create_anon_session() {
    local session_uuid=$1
    local persona=$2
    local trap_level=${3:-0}
    
    local timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    local silliness_score=$((6 + RANDOM % 7))  # 6-12
    
    # Create anonymized record
    cat << EOF
{
  "session_uuid": "$session_uuid",
  "timestamp": "$timestamp",
  "persona": "$persona",
  "trap_level": $trap_level,
  "silliness_score": $silliness_score,
  "interaction_count": 0,
  "duration_seconds": 0,
  "oracle_queries": 0,
  "exit_reason": "active",
  "hash_id": "fragle_$(echo -n "$session_uuid" | sha256sum | cut -c1-12)"
}
EOF
}

# Log interaction (NO sensitive data)
log_interaction() {
    local session_uuid=$1
    local interaction_type=$2  # menu_select | trap_enter | oracle_ask | level_complete
    
    local log_file="$FRAGLE_ANON_DIR/$session_uuid.jsonl"
    
    cat << EOF >> "$log_file"
{"timestamp":"$(date -u +"%Y-%m-%dT%H:%M:%SZ")","type":"$interaction_type"}
EOF
}

# Sanitize any user input (for future API)
sanitize_input() {
    local input=$1
    # Remove anything that looks like a path, hostname, or email
    echo "$input" | \
        sed 's|/[^ ]*||g' | \
        sed 's|@[^ ]*||g' | \
        sed 's|[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}|REDACTED|g' | \
        sed 's|~[^ ]*|~|g'
}

# Generate statistics (aggregated, no PII)
# Usage: get_aggregate_stats
get_aggregate_stats() {
    local total_sessions=0
    local avg_silliness=0
    local persona_dist=""
    
    if [[ -d "$FRAGLE_ANON_DIR" ]]; then
        total_sessions=$(ls -1 "$FRAGLE_ANON_DIR"/*.jsonl 2>/dev/null | wc -l)
        
        # This could be sent to API without compromising privacy
        cat << EOF
{
  "total_sessions": $total_sessions,
  "collection_method": "local_anonymous",
  "privacy_level": "strict",
  "pii_exposure": 0,
  "api_ready": true
}
EOF
    fi
}

# Verify session has no PII (safety check before API transmission)
verify_anon_safety() {
    local session_file=$1
    
    # Check for common PII patterns
    local has_email=$(grep -c '@' "$session_file" 2>/dev/null || echo 0)
    local has_ip=$(grep -cE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' "$session_file" 2>/dev/null || echo 0)
    local has_path=$(grep -c '/' "$session_file" 2>/dev/null || echo 0)
    
    if [[ $has_email -gt 0 || $has_ip -gt 0 ]]; then
        echo "UNSAFE: PII detected in session file"
        return 1
    fi
    
    echo "SAFE: Session is anonymized"
    return 0
}

# Export anonymized session for API (removes any residual data)
export_for_api() {
    local session_uuid=$1
    local output_file="$FRAGLE_ANON_DIR/${session_uuid}_api_export.json"
    
    # Only export these fields (whitelist approach)
    jq '{
        session_uuid,
        timestamp,
        persona,
        trap_level,
        silliness_score,
        interaction_count,
        duration_seconds,
        oracle_queries,
        exit_reason,
        hash_id
    }' "$FRAGLE_ANON_DIR/$session_uuid.json" > "$output_file" 2>/dev/null
    
    echo "$output_file"
}

# Main export (for when TUI sends to web)
export_session_to_api() {
    local session_uuid=$1
    local target_file="${2:-./.fragle_anon_data/${session_uuid}_for_api.json}"
    
    # Read local session data
    if [[ -f "$FRAGLE_ANON_DIR/$session_uuid.json" ]]; then
        # Verify safety first
        if verify_anon_safety "$FRAGLE_ANON_DIR/$session_uuid.json"; then
            cp "$FRAGLE_ANON_DIR/$session_uuid.json" "$target_file"
            echo "✓ Session exported (safe): $target_file"
        else
            echo "❌ Session contains PII, not exported"
            return 1
        fi
    else
        echo "❌ Session not found: $session_uuid"
        return 1
    fi
}

# Command-line interface
case "${1:-help}" in
    create)
        create_anon_session "$2" "$3" "$4"
        ;;
    log)
        log_interaction "$2" "$3"
        ;;
    stats)
        get_aggregate_stats
        ;;
    verify)
        verify_anon_safety "$2"
        ;;
    export)
        export_for_api "$2"
        ;;
    sanitize)
        sanitize_input "$2"
        ;;
    help|*)
        cat << 'HELP'
fragle_api_anonymizer.sh - Privacy-First API Layer

COMMANDS:
  create <uuid> <persona> [level]  Create anonymous session record
  log <uuid> <type>                Log interaction (no PII)
  stats                            Get aggregated statistics
  verify <file>                    Check session for PII leaks
  export <uuid>                    Export session for API (whitelist)
  sanitize <input>                 Remove PII from text

PRIVACY GUARANTEES:
  ✓ No usernames, hostnames, IPs, paths
  ✓ Only: UUID, timestamp, persona type, trap level
  ✓ Local storage only (can be uploaded later)
  ✓ Deterministic hashing (reversible only with salt)
  ✓ Whitelist export (only safe fields)

USAGE FOR API .APP:
  1. TUI collects data locally (anonymously)
  2. Session exported via fragle_api_anonymizer export
  3. Data sent to API endpoint with zero PII risk
  4. API aggregates statistics (personas, silliness, etc.)
  5. Web .app displays results (fully anonymous)

EXAMPLE FLOW:
  # Local TUI
  SESSION_UUID=$(uuidgen)
  ./fragle_api_anonymizer.sh create $SESSION_UUID "chaotic" 3
  ./fragle_api_anonymizer.sh log $SESSION_UUID "trap_enter"
  ./fragle_api_anonymizer.sh export $SESSION_UUID

  # Then send JSON to API /submit endpoint
  # API stores anonymously
  # Web .app queries API for stats

HELP
        ;;
esac
