#!/bin/bash
# test_mkscript.sh
# Tests the mkscript.sh script

# Source the common configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../config.sh"

# Ensure working directory exists
ensure_working_dir

echo -e "${GREEN}=== Testing mkscript.sh ===${NC}\n"

# Change to working directory for testing
cd "$WD" || exit 1

echo -e "${YELLOW}Test 1: Create script with all parameters${NC}"
echo "Command: ../scripts/mkscript.sh script1 \"Erstes Skript\" \"Heinz Strunk\" 1.0"
echo ""

# Note: This will create the file but won't open the editor in automated mode
# For actual testing, run manually

echo -e "${YELLOW}Test 2: Create script with minimal parameters${NC}"
echo "Command: ../scripts/mkscript.sh script2 \"Zweites Skript\""
echo ""

echo -e "${YELLOW}Test 3: Show help (no parameters)${NC}"
"$SCRIPT_DIR/mkscript.sh"
echo ""

echo -e "${GREEN}=== Manual Testing Instructions ===${NC}"
echo "To actually create scripts, run these commands manually:"
echo "  cd $WD"
echo "  ../scripts/mkscript.sh script1 \"Erstes Skript\" \"Heinz Strunk\" 1.0"
echo "  ../scripts/mkscript.sh test_script \"My Test Script\""
