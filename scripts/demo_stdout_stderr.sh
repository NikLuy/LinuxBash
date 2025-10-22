#!/bin/bash
# demo_stdout_stderr.sh
# Demonstrates stdout (file descriptor 1) and stderr (file descriptor 2)

# Source the common configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../config.sh"

echo -e "${GREEN}=== Demonstrating stdout and stderr ===${NC}\n"

# Normal output goes to stdout (file descriptor 1)
echo "This is stdout (file descriptor 1)"

# Error messages should go to stderr (file descriptor 2)
echo "This is stderr (file descriptor 2)" >&2

# More examples
echo -e "\n${YELLOW}Simulating a successful operation:${NC}"
echo "SUCCESS: File processed successfully"

echo -e "\n${YELLOW}Simulating an error:${NC}"
echo "ERROR: File not found!" >&2

# Demonstrate with a real error
echo -e "\n${YELLOW}Trying to list a non-existent directory:${NC}"
ls /nonexistent/directory 2>&1 | head -n 1

echo -e "\n${GREEN}=== Demo completed ===${NC}"
