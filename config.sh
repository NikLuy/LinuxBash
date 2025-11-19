#!/bin/bash
# config.sh
# Common configuration variables for all scripts
# Source this file in your scripts with: source "$(dirname "$0")/../config.sh"

# Working directory - where all outputs should go
WD="working_dir"

# Base directory for course structure
KURS_DIR="$WD/Kurs"

# Default script author
DEFAULT_AUTHOR="Nik Lussy"

# Default script version
DEFAULT_VERSION="1.0"

# Colors for output (optional)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Helper function to create working directory if it doesn't exist
ensure_working_dir() {
    if [ ! -d "$WD" ]; then
        mkdir -p "$WD"
        echo -e "${GREEN}Created working directory: $WD${NC}"
    fi
}
