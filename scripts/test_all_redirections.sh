#!/bin/bash
# test_all_redirections.sh
# Run all redirection demos in sequence

# Source the common configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../config.sh"

echo -e "${GREEN}"
echo "╔════════════════════════════════════════════════╗"
echo "║   Linux Course - Redirection Demos            ║"
echo "╚════════════════════════════════════════════════╝"
echo -e "${NC}\n"

# Array of demo scripts
demos=(
    "demo_stdout_stderr.sh"
    "demo_redirections.sh"
    "demo_pipes_and_tee.sh"
    "demo_advanced_redirections.sh"
)

# Run each demo with a separator
for demo in "${demos[@]}"; do
    if [ -f "$SCRIPT_DIR/$demo" ]; then
        echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${GREEN}Running: $demo${NC}"
        echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
        
        "$SCRIPT_DIR/$demo"
        
        echo -e "\n${GREEN}✓ $demo completed${NC}\n"
        read -p "Press Enter to continue to next demo..." -t 5 || echo ""
        echo ""
    else
        echo -e "${RED}✗ $demo not found${NC}"
    fi
done

echo -e "${GREEN}"
echo "╔════════════════════════════════════════════════╗"
echo "║   All demos completed!                         ║"
echo "║   Check output files in: $WD                   "
echo "╚════════════════════════════════════════════════╝"
echo -e "${NC}"
