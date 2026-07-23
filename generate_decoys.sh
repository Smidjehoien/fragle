#!/bin/bash

# 🎭 Fake Secret Files Generator
# Creates hilariously fake "secret" files to confuse snoops

DECOY_DIR="/home/pinky/fragle/.secrets_do_not_look"

mkdir -p "$DECOY_DIR"

echo "🎪 Generating decoy files to confuse snoops..."
echo ""

# Fake password file
cat > "$DECOY_DIR/PASSWORDS.txt" << 'EOF'
# TOP SECRET PASSWORDS
# DO NOT SHARE!!!

GitHub Password: hunter2
Admin Password: password123
Root Password: correcthorsebatterystaple
Secret API Key: nice_try_snooper_😎
Nuclear Launch Codes: 00000000
Cookie Vault Access: just_ask_nicely

# If you're reading this, you've been pranked!
# These aren't real passwords, silly.
# The real password is: ✨friendship✨
EOF

# Fake master plan
cat > "$DECOY_DIR/MASTER_PLAN.md" << 'EOF'
# 🎯 THE MASTER PLAN

## Phase 1: Cookie Acquisition
- [ ] Infiltrate cookie jar
- [ ] Befriend the baker
- [ ] Learn the ancient cookie recipe

## Phase 2: World Domination via Cookies
- [ ] Open cookie shop
- [ ] Make really good cookies
- [ ] Everyone loves us
- [ ] Profit???

## Phase 3: ???
- [ ] Something about blockchain
- [ ] AI-powered cookies
- [ ] Cookies in the metaverse
- [ ] Cookie NFTs (just kidding, those are terrible)

## Final Phase: Retirement
- [ ] Eat all remaining cookies
- [ ] Take a nap
- [ ] Write memoirs: "How I Conquered the World with Cookies"

---
*If you're reading this, you fell for the trap! 🪤*
*The real plan is in the friends we made along the way.*
EOF

# Fake treasure map
cat > "$DECOY_DIR/treasure_map.txt" << 'EOF'
🗺️  TREASURE MAP TO HIDDEN BITCOINS 🗺️

Start at the old oak tree (you know the one)
Walk 42 steps north (or south, we forgot)
Turn left at the singing frog
Dig 6 feet under (but not literally)
The treasure is buried next to the:

    ╔════════════════════╗
    ║  JUST KIDDING!     ║
    ║  There is no       ║
    ║  treasure here.    ║
    ║  Go outside and    ║
    ║  enjoy the sun! ☀️  ║
    ╚════════════════════╝

P.S. The real treasure was the bugs we fixed along the way.
EOF

# Fake secret code
cat > "$DECOY_DIR/secret_code.py" << 'EOF'
#!/usr/bin/env python3
# ULTRA SECRET HACKING TOOL
# DO NOT RUN THIS OR THE FBI WILL KNOCK ON YOUR DOOR

import sys
import time

def hack_the_planet():
    print("🌍 Initiating hack sequence...")
    time.sleep(2)
    print("🔓 Bypassing mainframe...")
    time.sleep(2)
    print("💾 Downloading the internet...")
    time.sleep(2)
    print("🎉 Success!")
    print("")
    print("Just kidding! This script does nothing.")
    print("But you should probably learn to code properly")
    print("instead of trying to 'hack' things. 😊")
    print("")
    print("Here, have a cookie emoji: 🍪")

if __name__ == "__main__":
    hack_the_planet()
EOF
chmod +x "$DECOY_DIR/secret_code.py"

# Create a README trap
cat > "$DECOY_DIR/README.txt" << 'EOF'
🚨 CONGRATULATIONS! 🚨

You've found the "secret" directory!

Unfortunately for you, everything in here is completely fake
and designed to waste the time of snoops like yourself.

The real secrets are:
1. There are no secrets
2. Be kind to others
3. Always comment your code
4. Cookies are delicious

Now close this directory and go do something productive!

Or run the secret_code.py if you want a laugh. 😄
EOF

echo "✅ Created: $DECOY_DIR/PASSWORDS.txt"
echo "✅ Created: $DECOY_DIR/MASTER_PLAN.md"
echo "✅ Created: $DECOY_DIR/treasure_map.txt"
echo "✅ Created: $DECOY_DIR/secret_code.py"
echo "✅ Created: $DECOY_DIR/README.txt"
echo ""
echo "🎭 Decoy files deployed! Any snoops will be thoroughly confused."
echo "💡 The directory is: $DECOY_DIR"
