#!/bin/bash
# mkscript.sh
# Creates a new bash script with a standard header template

# Source the common configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../config.sh"

# Check if at least 2 parameters are provided
if [ $# -lt 2 ]; then
    echo -e "${RED}Error: Not enough parameters!${NC}"
    echo "Usage: $0 <scriptname> <description> [author] [version]"
    echo ""
    echo "Example:"
    echo "  $0 script1 \"Erstes Skript\" \"Heinz Strunk\" 1.0"
    exit 1
fi

# Get parameters
SCRIPTNAME="$1"
DESCRIPTION="$2"
AUTHOR="${3:-$(whoami)}"  # Default to current user if not provided
VERSION="${4:-1.0}"        # Default to 1.0 if not provided
DATE=$(date +%Y-%m-%d)

# Add .sh extension if not present
if [[ ! "$SCRIPTNAME" =~ \.sh$ ]]; then
    SCRIPTNAME="${SCRIPTNAME}.sh"
fi

# Check if file already exists
if [ -f "$SCRIPTNAME" ]; then
    echo -e "${RED}Error: File '$SCRIPTNAME' already exists!${NC}"
    exit 1
fi

# Create the script file with header
cat > "$SCRIPTNAME" <<EOF
#!/bin/bash
# Beschreibung: $DESCRIPTION
# Autor       : $AUTHOR
# Version     : $VERSION
# Datum       : $DATE
# ====================================================================

# Your code here

EOF

# Make the script executable
chmod +x "$SCRIPTNAME"

echo -e "${GREEN}Script '$SCRIPTNAME' created successfully!${NC}"
echo -e "${YELLOW}Opening in editor...${NC}"

# Open in editor (try various editors)
# Position cursor at the end of the file
if command -v nano &> /dev/null; then
    # +999 positions cursor at line 999 (effectively end of file for small scripts)
    nano +999 "$SCRIPTNAME"
elif command -v vim &> /dev/null; then
    # + positions cursor at last line
    vim + "$SCRIPTNAME"
elif command -v vi &> /dev/null; then
    # + positions cursor at last line
    vi + "$SCRIPTNAME"
else
    echo -e "${YELLOW}No editor found. You can edit the file manually.${NC}"
    echo "File location: $(pwd)/$SCRIPTNAME"
fi
