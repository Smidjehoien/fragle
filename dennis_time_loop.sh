from datetime import datetime

# Create a surprise file for the Fragle Firewall
surprise_file_path = "/mnt/data/FIREWALL_extracted/FIREWALL/paradox_pantry/dennis_time_loop.sh"

# Dennis's Time Loop Surprise Bash Script
dennis_script = f"""#!/bin/bash

# 🌀 Dennis's Temporal Slip Trap
# WARNING: May cause recursive deja vu and mild giggling

echo "⏳ Welcome to Dennis's Time Loop. It's {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}... or is it?"

# Choose a random paradox
PARADOXES=(
  "What if the ping pings back?"
  "Did the cookie eat you first?"
  "This script doesn't exist yet, but it's running."
  "Starla said the past is written in bash history."
  "The Crimson Controller has already denied this loop."
)
RAND_INDEX=$((RANDOM % ${#PARADOXES[@]}))
echo "💭 Paradox: ${PARADOXES[$RAND_INDEX]}"

# Offer an illusion cookie
COOKIE_FORTUNES=(
  "You will forget this moment, but remember the feeling."
  "Trust the 404 you encountered along the way."
  "Clear your DNS and your conscience."
  "The packet you dropped was never yours."
)
FORTUNE_INDEX=$((RANDOM % ${#COOKIE_FORTUNES[@]}))
echo "🍪 Cookie Fortune: ${COOKIE_FORTUNES[$FORTUNE_INDEX]}"

# Loop detection ritual
echo "🔁 Initiating loop check..."
for i in {{1..3}}; do
  echo "⏲️  Loop pass $i..."
  sleep 1
done

echo "🎩 Dennis has vanished again. But he left this timestamp: {datetime.now().isoformat()}"
"""

# Write the file
with open(surprise_file_path, "w") as f:
    f.write(dennis_script)

# Make it executable
os.chmod(surprise_file_path, 0o755)

surprise_file_path
