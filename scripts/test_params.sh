#!/bin/bash
#test_params.sh
# Tests the show_params.sh script with different parameters

# Get the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Test 1: Numbers 0-9 ==="
"$SCRIPT_DIR/show_params.sh" 0 1 2 3 4 5 6 7 8 9

echo ""
echo "=== Test 2: German words ==="
"$SCRIPT_DIR/show_params.sh" 'Mein' 'Name' 'ist' 'Hase'
