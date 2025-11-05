#!/bin/bash
# check_file_params.sh
# Checks if exactly 4 parameters are provided and if the file exists

# Source the common configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../config.sh"

echo -e "${GREEN}=== File Parameter Check Script ===${NC}\n"

# Check: Anzahl Parameter ≠ 4?
if [ $# -ne 4 ]; then
    echo -e "${RED}Fehlermeldung: Genau 4 Parameter erforderlich!${NC}" >&2
    echo "Verwendung: $0 <param1> <param2> <param3> <param4>" >&2
    echo "Sie haben $# Parameter angegeben." >&2
    exit 1
fi

echo -e "${GREEN}✓ Anzahl Parameter korrekt: $#${NC}"
echo ""

# Parameter anzeigen
echo -e "${YELLOW}Übergebene Parameter:${NC}"
echo "  Parameter 1: $1"
echo "  Parameter 2: $2"
echo "  Parameter 3: $3"
echo "  Parameter 4: $4"
echo ""

# Check: Datei schon vorhanden?
DATEI="$1"
if [ -e "$DATEI" ]; then
    echo -e "${RED}Fehlermeldung: Datei '$DATEI' existiert bereits!${NC}" >&2
    exit 2
fi

echo -e "${GREEN}✓ Datei '$DATEI' existiert nicht (kann erstellt werden)${NC}"
echo ""

# Anweisung ...
echo -e "${YELLOW}Anweisung 1: Führe Aktion aus...${NC}"
echo "  → Verarbeite Parameter..."
echo ""

# Anweisung ....
echo -e "${YELLOW}Anweisung 2: Weitere Aktionen...${NC}"
echo "  → Erstelle Datei '$DATEI' mit Inhalt..."

# Create the file with the parameters as content
cat > "$DATEI" <<EOF
# Datei erstellt von $0
# Datum: $(date)
# ====================================================================

Parameter 1: $1
Parameter 2: $2
Parameter 3: $3
Parameter 4: $4

Diese Datei wurde erfolgreich erstellt.
EOF

echo -e "${GREEN}  ✓ Datei '$DATEI' wurde erstellt${NC}"
echo ""

# exit 0
echo -e "${GREEN}=== Script erfolgreich beendet ===${NC}"
exit 0
