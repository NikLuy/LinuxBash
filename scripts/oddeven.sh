#!/bin/bash
# oddeven.sh
# Checks if a number is odd or even, validates that input is an integer

# Source the common configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../config.sh"

echo -e "${GREEN}=== Odd/Even Checker ===${NC}\n"

# Check if parameter is provided
if [ $# -ne 1 ]; then
    echo -e "${RED}Fehler: Genau ein Parameter erforderlich!${NC}" >&2
    echo "Verwendung: $0 <ganze_zahl>" >&2
    echo "" >&2
    echo "Beispiele:" >&2
    echo "  $0 42" >&2
    echo "  $0 -17" >&2
    echo "  $0 0" >&2
    exit 1
fi

# Get the parameter
number="$1"

# Check if the parameter is a valid integer (positive or negative)
# Regex: optional minus, followed by one or more digits
if ! [[ $number =~ ^-?[0-9]+$ ]]; then
    echo -e "${RED}Fehler: '$number' ist keine ganze Zahl!${NC}" >&2
    echo "" >&2
    echo "Eine ganze Zahl muss folgende Kriterien erfüllen:" >&2
    echo "  • Nur Ziffern (0-9)" >&2
    echo "  • Optional ein Minus (-) am Anfang" >&2
    echo "  • Keine Leerzeichen, Buchstaben oder Sonderzeichen" >&2
    echo "" >&2
    echo "Gültige Beispiele: 42, -17, 0, 999" >&2
    echo "Ungültige Beispiele: 3.14, abc, 12x, ''" >&2
    exit 2
fi

echo -e "${GREEN}✓ Eingabe ist eine gültige ganze Zahl: $number${NC}\n"

# Check if the number is even or odd using modulo operator
if ((number % 2 == 0)); then
    echo -e "${YELLOW}Ergebnis:${NC}"
    echo -e "  $number ist eine ${GREEN}GERADE${NC} Zahl"
    echo ""
    echo "  Berechnung: $number % 2 = $((number % 2))"
    echo "  Da der Rest 0 ist, ist die Zahl gerade."
else
    echo -e "${YELLOW}Ergebnis:${NC}"
    echo -e "  $number ist eine ${YELLOW}UNGERADE${NC} Zahl"
    echo ""
    echo "  Berechnung: $number % 2 = $((number % 2))"
    echo "  Da der Rest nicht 0 ist, ist die Zahl ungerade."
fi

echo ""
echo -e "${GREEN}=== Prüfung abgeschlossen ===${NC}"
exit 0
