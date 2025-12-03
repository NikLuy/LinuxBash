#!/bin/bash
# mkscript.sh
# Creates a new bash script with a standard header template

# Source the common configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../config.sh"

# Check for interactive mode flag
INTERACTIVE=false
if [ "$1" = "-i" ]; then
    INTERACTIVE=true
    shift  # Remove -i from parameters
fi

# Interactive mode
if [ "$INTERACTIVE" = true ]; then
    echo -e "${GREEN}=== Interaktiver Modus ===${NC}"
    echo ""
    
    # Prompt for script name
    read -p "Skriptname: " SCRIPTNAME
    if [ -z "$SCRIPTNAME" ]; then
        echo -e "${RED}Fehler: Skriptname darf nicht leer sein!${NC}"
        exit 1
    fi
    
    # Prompt for description
    read -p "Beschreibung: " DESCRIPTION
    if [ -z "$DESCRIPTION" ]; then
        echo -e "${RED}Fehler: Beschreibung darf nicht leer sein!${NC}"
        exit 1
    fi
    
    # Prompt for author (with default)
    read -p "Autor [$(whoami)]: " AUTHOR
    AUTHOR="${AUTHOR:-$(whoami)}"
    
    # Prompt for version (with default)
    read -p "Version [1.0]: " VERSION
    VERSION="${VERSION:-1.0}"
    
    DATE=$(date +%Y-%m-%d)
else
    # Check if at least 2 parameters are provided
    if [ $# -lt 2 ]; then
        echo -e "${RED}Error: Not enough parameters!${NC}"
        echo "Usage: $0 [-i] <scriptname> <description> [author] [version]"
        echo ""
        echo "Options:"
        echo "  -i    Interactive mode (prompts for all information)"
        echo ""
        echo "Example:"
        echo "  $0 script1 \"Erstes Skript\" \"Heinz Strunk\" 1.0"
        echo "  $0 -i"
        exit 1
    fi
    
    # Get parameters
    SCRIPTNAME="$1"
    DESCRIPTION="$2"
    AUTHOR="${3:-$(whoami)}"  # Default to current user if not provided
    VERSION="${4:-1.0}"        # Default to 1.0 if not provided
    DATE=$(date +%Y-%m-%d)
fi

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
cat "$SCRIPTNAME"
