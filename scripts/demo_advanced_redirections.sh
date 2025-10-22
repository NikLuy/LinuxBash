#!/bin/bash
# demo_advanced_redirections.sh
# Advanced redirection techniques

# Source the common configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../config.sh"

# Ensure working directory exists
ensure_working_dir

echo -e "${GREEN}=== Advanced Redirection Techniques ===${NC}\n"

echo -e "${YELLOW}1. Swap stdout and stderr (3>&1 1>&2 2>&3)${NC}"
# Save file descriptor 1 to 3, redirect 1 to 2, redirect 2 to saved 3
(echo "This is stdout" ; echo "This is stderr" >&2) 3>&1 1>&2 2>&3 | \
    tee "$WD/swapped_output.txt"
echo -e "   Output swapped and saved\n"

echo -e "${YELLOW}2. Redirect stderr to stdout for piping (2>&1 |)${NC}"
(echo "Success message"; ls /nonexistent 2>&1) 2>&1 | grep -i "message"
echo ""

echo -e "${YELLOW}3. Separate stdout and stderr to different files${NC}"
(echo "Success: Operation completed"; echo "Warning: Low memory" >&2; echo "Done") \
    > "$WD/success.log" 2> "$WD/errors.log"
echo "   stdout saved to: $WD/success.log"
echo "   stderr saved to: $WD/errors.log"
echo -e "\n   Success log:"
cat "$WD/success.log"
echo -e "\n   Error log:"
cat "$WD/errors.log"
echo ""

echo -e "${YELLOW}4. Here document (<<EOF)${NC}"
cat > "$WD/heredoc_example.txt" <<EOF
This is a here document.
It allows multi-line input.
Variables work: WD=$WD
Current date: $(date)
EOF
echo "   Created: $WD/heredoc_example.txt"
cat "$WD/heredoc_example.txt"
echo ""

echo -e "${YELLOW}5. Here string (<<<)${NC}"
grep "test" <<< "This is a test string"
echo ""

echo -e "${YELLOW}6. Process substitution <(command)${NC}"
echo "Compare two command outputs:"
diff <(echo "Line 1") <(echo "Line 2") || echo "   Files differ"
echo ""

echo -e "${YELLOW}7. Noclobber protection (set -C and >|)${NC}"
echo "First content" > "$WD/protected.txt"
echo "With noclobber enabled, this would fail: > protected.txt"
echo "But this works with >|:"
echo "Overwritten content" >| "$WD/protected.txt"
cat "$WD/protected.txt"
echo ""

echo -e "${GREEN}=== Demo completed ===${NC}"
echo "All files in: $WD"
ls -lh "$WD" | tail -n +2
