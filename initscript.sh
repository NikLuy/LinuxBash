#!/bin/bash
# initscript.sh
# Interactive script creator with prompts and default values

# Source the common configuration
source "$(dirname "${BASH_SOURCE[0]}")/config.sh"

echo -e "${GREEN}"
echo "╔════════════════════════════════════════════════╗"
echo "║   Interactive Script Creator                   ║"
echo "╚════════════════════════════════════════════════╝"
echo -e "${NC}\n"

# Prompt for script name
read -p "Script name (without .sh): " SCRIPTNAME
if [ -z "$SCRIPTNAME" ]; then
    echo -e "${RED}Error: Script name is required!${NC}"
    exit 1
fi

# Add .sh extension if not present
if [[ ! "$SCRIPTNAME" =~ \.sh$ ]]; then
    SCRIPTNAME="${SCRIPTNAME}.sh"
fi

# Full path for the script
SCRIPT_PATH="scripts/$SCRIPTNAME"

# Check if file already exists
if [ -f "$SCRIPT_PATH" ]; then
    echo -e "${RED}Error: File '$SCRIPT_PATH' already exists!${NC}"
    exit 1
fi

# Prompt for description
read -p "Description: " DESCRIPTION
if [ -z "$DESCRIPTION" ]; then
    echo -e "${RED}Error: Description is required!${NC}"
    exit 1
fi

# Prompt for author (with default)
read -p "Author [${DEFAULT_AUTHOR}]: " AUTHOR
AUTHOR="${AUTHOR:-$DEFAULT_AUTHOR}"

# Prompt for version (with default)
read -p "Version [${DEFAULT_VERSION}]: " VERSION
VERSION="${VERSION:-$DEFAULT_VERSION}"

# Get current date
DATE=$(date +%Y-%m-%d)

echo -e "\n${YELLOW}Creating script with:${NC}"
echo "  Name       : $SCRIPTNAME"
echo "  Description: $DESCRIPTION"
echo "  Author     : $AUTHOR"
echo "  Version    : $VERSION"
echo "  Date       : $DATE"
echo "  Location   : $SCRIPT_PATH"
echo ""

# Confirm creation
read -p "Create this script? [Y/n]: " CONFIRM
CONFIRM="${CONFIRM:-Y}"

if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}Script creation cancelled.${NC}"
    exit 0
fi

# Create the script file with header
cat > "$SCRIPT_PATH" <<EOF
#!/bin/bash
# Beschreibung: $DESCRIPTION
# Autor       : $AUTHOR
# Version     : $VERSION
# Datum       : $DATE
# ====================================================================

# Source the common configuration
SCRIPT_DIR="\$(cd "\$(dirname "\${BASH_SOURCE[0]}")" && pwd)"
source "\$SCRIPT_DIR/../config.sh"

# Your code here

EOF

# Make the script executable
chmod +x "$SCRIPT_PATH"

echo -e "${GREEN}✓ Script '$SCRIPT_PATH' created successfully!${NC}"
echo -e "${YELLOW}Opening in editor...${NC}\n"

# Open in editor (try various editors)
# Position cursor at the end of the file
if command -v nano &> /dev/null; then
    nano +999 "$SCRIPT_PATH"
elif command -v vim &> /dev/null; then
    vim + "$SCRIPT_PATH"
elif command -v vi &> /dev/null; then
    vi + "$SCRIPT_PATH"
else
    echo -e "${YELLOW}No editor found. You can edit the file manually.${NC}"
    echo "File location: $(pwd)/$SCRIPT_PATH"
fi
