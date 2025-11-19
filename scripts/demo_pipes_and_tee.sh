#!/bin/bash
# demo_pipes_and_tee.sh
# Demonstrates pipes and tee command

# Source the common configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../config.sh"

# Ensure working directory exists
ensure_working_dir

echo -e "${GREEN}=== Demonstrating Pipes and Tee ===${NC}\n"

# File for tee output
OUTPUT_FILE="$WD/pipe_output.txt"
TEE_FILE="$WD/tee_output.txt"

echo -e "${YELLOW}1. Simple pipe (|)${NC}"
echo "Pipes connect stdout of one command to stdin of another"
echo "apple banana cherry date elderberry" | tr ' ' '\n' | sort
echo ""

echo -e "${YELLOW}2. Chain multiple pipes${NC}"
echo "Count lines, words, and characters in this text:"
echo -e "Line 1\nLine 2\nLine 3" | tee "$OUTPUT_FILE" | wc
echo -e "   (Also saved to: $OUTPUT_FILE)\n"

echo -e "${YELLOW}3. Using tee to split output${NC}"
echo "Tee sends output to BOTH file AND stdout"
echo "This message goes to screen AND file" | tee "$TEE_FILE"
echo -e "   Saved to: $TEE_FILE\n"

echo -e "${YELLOW}4. Tee with append mode (-a)${NC}"
echo "First message" | tee "$TEE_FILE"
echo "Second message" | tee -a "$TEE_FILE"
echo "Third message" | tee -a "$TEE_FILE"
echo -e "\n   Final content of $TEE_FILE:"
cat "$TEE_FILE"
echo ""

echo -e "${YELLOW}5. Pipe stderr through tee (2>&1 |)${NC}"
(echo "Normal output"; echo "Error output" >&2) 2>&1 | tee "$WD/all_output.txt"
echo -e "   Both streams captured\n"

echo -e "${YELLOW}6. Complex pipeline example${NC}"
echo "Find all .sh files and count them:"
find "$SCRIPT_DIR" -name "*.sh" -type f 2>/dev/null | tee "$WD/scripts_list.txt" | wc -l
echo "   Script list saved to: $WD/scripts_list.txt"
echo ""

echo -e "${GREEN}=== Demo completed ===${NC}"
echo -e "Check output files in: $WD"
