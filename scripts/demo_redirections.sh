#!/bin/bash
# demo_redirections.sh
# Demonstrates various redirection techniques

# Source the common configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../config.sh"

# Ensure working directory exists
ensure_working_dir

echo -e "${GREEN}=== Demonstrating I/O Redirections ===${NC}\n"

# File paths for output
STDOUT_FILE="$WD/stdout.txt"
STDERR_FILE="$WD/stderr.txt"
COMBINED_FILE="$WD/combined.txt"

echo -e "${YELLOW}1. Redirect stdout to file (>)${NC}"
echo "This goes to stdout file" > "$STDOUT_FILE"
echo -e "   Created: $STDOUT_FILE\n"

echo -e "${YELLOW}2. Append to file (>>)${NC}"
echo "First line" > "$STDOUT_FILE"
echo "Second line" >> "$STDOUT_FILE"
echo "Third line" >> "$STDOUT_FILE"
echo -e "   Appended to: $STDOUT_FILE"
cat "$STDOUT_FILE"
echo ""

echo -e "${YELLOW}3. Redirect stderr to file (2>)${NC}"
echo "Trying to access non-existent file..." 
ls /nonexistent/file 2> "$STDERR_FILE"
echo -e "   Error saved to: $STDERR_FILE"
echo -e "   Content:"
cat "$STDERR_FILE"
echo ""

echo -e "${YELLOW}4. Redirect both stdout and stderr to same file (2>&1)${NC}"
echo "Running command with both output types..."
(echo "This is stdout"; echo "This is stderr" >&2) > "$COMBINED_FILE" 2>&1
echo -e "   Both saved to: $COMBINED_FILE"
echo -e "   Content:"
cat "$COMBINED_FILE"
echo ""

echo -e "${YELLOW}5. Redirect both using &> (shorthand)${NC}"
(echo "Stdout message"; ls /nonexistent 2>&1) &> "$COMBINED_FILE"
echo -e "   Saved to: $COMBINED_FILE\n"

echo -e "${YELLOW}6. Discard output to /dev/null${NC}"
echo "This will not be seen" > /dev/null
echo "Error messages discarded" 2> /dev/null
echo -e "   (Output discarded)\n"

echo -e "${GREEN}=== All output files are in: $WD ===${NC}"
ls -lh "$WD"/*.txt 2>/dev/null || echo "No files created yet"
