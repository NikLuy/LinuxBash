#!/bin/bash
# init.sh
# Initialize the repository: Make all scripts executable

echo "╔════════════════════════════════════════════════╗"
echo "║   Linux Course - Repository Initialization    ║"
echo "╚════════════════════════════════════════════════╝"
echo ""

# Count total scripts
SCRIPT_COUNT=$(find scripts -name "*.sh" -type f 2>/dev/null | wc -l)

echo "Found $SCRIPT_COUNT script(s) in the scripts/ directory"
echo ""

# Make all .sh files in scripts/ executable
echo "Setting executable permissions..."
find scripts -name "*.sh" -type f -exec chmod +x {} \;

# Also make config.sh executable if it exists
if [ -f "config.sh" ]; then
    chmod +x config.sh
    echo "✓ config.sh"
fi

# List all scripts with their new permissions
echo ""
echo "Scripts with executable permissions:"
echo "────────────────────────────────────────────────"
find scripts -name "*.sh" -type f -exec ls -lh {} \; | awk '{print "✓ " $9 " (" $1 ")"}'

echo ""
echo "╔════════════════════════════════════════════════╗"
echo "║   Initialization complete!                     ║"
echo "║   All scripts are now executable.              ║"
echo "╚════════════════════════════════════════════════╝"
echo ""
echo "You can now run any script with: ./scripts/script_name.sh"
