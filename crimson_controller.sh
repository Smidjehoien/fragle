#!/bin/bash

# CRIMSON CONTROLLER – Overseer of Patterns, Harbinger of Warnings
# Beware. He sees ALL... and explains NOTHING.

WARNING_FILE="warning_level.txt"
QUOTES_FILE="controller_quotes.txt"

echo "🔴 [CRIMSON] I have been summoned."

# Dramatic Pause
sleep 2

if [ -f "$WARNING_FILE" ]; then
    LEVEL=$(cat "$WARNING_FILE")
    echo "🧠 [CRIMSON] Warning Level: $LEVEL"

    if [ "$LEVEL" -gt 7 ]; then
        echo "⚠️  [CRIMSON] The stars align... poorly."
        echo "🔥 Initiating paradox sequence..."
        bash wormhole_traps/tea_party.sh
    else
        echo "🌒 [CRIMSON] Not yet. Let them wander. Let them ping."
    fi
else
    echo "❓ [CRIMSON] No warning file. No fate. No context. No cookies."
fi

# Whisper a quote
if [ -f "$QUOTES_FILE" ]; then
    QUOTE=$(shuf -n 1 "$QUOTES_FILE")
    echo "💬 [CRIMSON]: \"$QUOTE\""
else
    echo "💬 [CRIMSON]: \"The absence of quotes is itself a warning.\""
fi

echo "🔴 [CRIMSON] I vanish... but the logs remember me."
A collection of cryptic wisdom from the Crimson Controller:

    “The firewall dreams of electric sheep.”
    “Only a fool pings twice.”
    “The cookies have eyes. You gave them eyes.”
    “Trust the riddle. Distrust the timestamp.”

These are not just lines—they’re warnings for those who look too closely at logs, or cookies.
