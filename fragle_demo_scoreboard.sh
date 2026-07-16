#!/bin/bash
# fragle_demo_scoreboard.sh
# Seed the scoreboard with realistic test data for preview

set -e

FRAGLE_HOME="${FRAGLE_HOME:-.}"
SCOREBOARD_SCRIPT="$FRAGLE_HOME/fragle_scoreboard.sh"

if [[ ! -f "$SCOREBOARD_SCRIPT" ]]; then
    echo "❌ fragle_scoreboard.sh not found"
    exit 1
fi

echo "🎭 Seeding Fragle Theatre with demo data..."
echo ""

# Test UUIDs (deterministic for reproducibility)
UUIDS=(
    "550e8400-e29b-41d4-a716-446655440000"
    "550e8400-e29b-41d4-a716-446655440001"
    "550e8400-e29b-41d4-a716-446655440002"
    "550e8400-e29b-41d4-a716-446655440003"
    "550e8400-e29b-41d4-a716-446655440004"
    "550e8400-e29b-41d4-a716-446655440005"
    "550e8400-e29b-41d4-a716-446655440006"
    "550e8400-e29b-41d4-a716-446655440007"
    "550e8400-e29b-41d4-a716-446655440008"
    "550e8400-e29b-41d4-a716-446655440009"
)

PERSONAS=("chaotic" "technical" "aggressive" "artistic" "curious" "unknown")
LEVELS=(1 2 3 4 5)

# Generate 100 realistic log entries
echo "Generating 100 demo activities..."
for i in {1..100}; do
    uuid=${UUIDS[$((RANDOM % ${#UUIDS[@]}))]}
    persona=${PERSONAS[$((RANDOM % ${#PERSONAS[@]}))]}
    level=${LEVELS[$((RANDOM % ${#LEVELS[@]}))]}
    silliness=$((6 + RANDOM % 7))
    duration=$((RANDOM % 3600))
    
    "$SCOREBOARD_SCRIPT" log "$uuid" "$persona" "trap_level_$level" "$level" "$silliness" "$duration"
    
    # Visual feedback every 10
    if (( i % 10 == 0 )); then
        printf "  %-3d activities logged ✓\n" "$i"
    fi
done

echo ""
echo "✓ Demo data seeded! Now you can:"
echo ""
echo "  View leaderboard:"
echo "    $SCOREBOARD_SCRIPT show"
echo ""
echo "  Get stats:"
echo "    $SCOREBOARD_SCRIPT stats | jq ."
echo ""
echo "  View activity feed:"
echo "    $SCOREBOARD_SCRIPT feed 20"
echo ""
echo "  Export for API:"
echo "    $SCOREBOARD_SCRIPT export ./demo_stats.json"
echo ""
echo "  Get heatmap:"
echo "    $SCOREBOARD_SCRIPT heatmap | jq ."
echo ""
