#!/bin/bash
# example_with_config.sh
# Example script showing how to use the common configuration

# Source the common configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../config.sh"

# Ensure working directory exists
ensure_working_dir

# Now you can use the variables
echo -e "${GREEN}Working directory is set to: $WD${NC}"
echo -e "${YELLOW}Course directory will be: $KURS_DIR${NC}"

# Example: Create a test file in the working directory
TEST_FILE="$WD/test_output.txt"
echo "This is a test output" > "$TEST_FILE"
echo -e "${GREEN}Created test file: $TEST_FILE${NC}"

# List contents of working directory
echo -e "\n${YELLOW}Contents of $WD:${NC}"
ls -la "$WD"
