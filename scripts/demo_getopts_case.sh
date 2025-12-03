#!/bin/bash

# demo_getopts_case.sh - Demonstrates getopts and case for command-line option parsing
# Example usage:
#   ./demo_getopts_case.sh -v -f input.txt -o output.txt -n 42 arg1 arg2
#   ./demo_getopts_case.sh -h

# Initialize variables with defaults
VERBOSE=false
INPUT_FILE=""
OUTPUT_FILE=""
NUMBER=0
HELP=false

# Function to display help
show_help() {
    cat << EOF
Verwendung: $0 [OPTIONEN] [ARGUMENTE]

Optionen:
  -h          Zeigt diese Hilfe an
  -v          Verbose-Modus (ausführliche Ausgabe)
  -f <file>   Input-Datei angeben
  -o <file>   Output-Datei angeben
  -n <number> Eine Zahl angeben
  -c <choice> Auswahl: red, green, blue

Beispiele:
  $0 -v -f input.txt -o output.txt
  $0 -n 42 -c red argument1 argument2
  $0 -h
EOF
}

# Parse options with getopts
# The colon after a letter means that option requires an argument
while getopts ":hvf:o:n:c:" opt; do
    case $opt in
        h)
            HELP=true
            ;;
        v)
            VERBOSE=true
            echo "Verbose-Modus aktiviert"
            ;;
        f)
            INPUT_FILE="$OPTARG"
            [ "$VERBOSE" = true ] && echo "Input-Datei: $INPUT_FILE"
            ;;
        o)
            OUTPUT_FILE="$OPTARG"
            [ "$VERBOSE" = true ] && echo "Output-Datei: $OUTPUT_FILE"
            ;;
        n)
            NUMBER="$OPTARG"
            # Validate that it's a number
            if ! [[ "$NUMBER" =~ ^[0-9]+$ ]]; then
                echo "Fehler: -n erwartet eine Zahl" >&2
                exit 1
            fi
            [ "$VERBOSE" = true ] && echo "Zahl: $NUMBER"
            ;;
        c)
            CHOICE="$OPTARG"
            # Use case to validate the choice
            case $CHOICE in
                red|green|blue)
                    [ "$VERBOSE" = true ] && echo "Farbe gewählt: $CHOICE"
                    ;;
                *)
                    echo "Fehler: Ungültige Farbe '$CHOICE'. Wähle: red, green, blue" >&2
                    exit 1
                    ;;
            esac
            ;;
        :)
            echo "Fehler: Option -$OPTARG benötigt ein Argument" >&2
            exit 1
            ;;
        \?)
            echo "Fehler: Ungültige Option -$OPTARG" >&2
            echo "Verwende -h für Hilfe"
            exit 1
            ;;
    esac
done

# Show help if requested
if [ "$HELP" = true ]; then
    show_help
    exit 0
fi

# Shift away the processed options
shift $((OPTIND-1))

# Remaining arguments are now in $@
echo ""
echo "=== Zusammenfassung ==="
echo "Verbose-Modus: $VERBOSE"
echo "Input-Datei: ${INPUT_FILE:-nicht angegeben}"
echo "Output-Datei: ${OUTPUT_FILE:-nicht angegeben}"
echo "Zahl: $NUMBER"
echo "Farbe: ${CHOICE:-nicht angegeben}"
echo ""
echo "Verbleibende Argumente: $#"
if [ $# -gt 0 ]; then
    echo "Argumente:"
    counter=1
    for arg in "$@"; do
        echo "  $counter: $arg"
        ((counter++))
    done
fi

# Demonstration of case with different patterns
echo ""
echo "=== Case-Demonstrationen ==="

# Example 1: Simple string matching
read -p "Gib einen Wochentag ein (Mo-So): " day
case $day in
    Mo|Montag)
        echo "Wochenanfang! ☕"
        ;;
    Di|Dienstag|Mi|Mittwoch|Do|Donnerstag)
        echo "Mitte der Woche 💼"
        ;;
    Fr|Freitag)
        echo "Fast Wochenende! 🎉"
        ;;
    Sa|Samstag|So|Sonntag)
        echo "Wochenende! 🏖️"
        ;;
    *)
        echo "Kein gültiger Wochentag"
        ;;
esac

# Example 2: Pattern matching with wildcards
echo ""
read -p "Gib einen Dateinamen ein: " filename
case $filename in
    *.sh)
        echo "Das ist ein Shell-Script"
        ;;
    *.txt)
        echo "Das ist eine Text-Datei"
        ;;
    *.jpg|*.png|*.gif)
        echo "Das ist eine Bild-Datei"
        ;;
    [0-9]*.*)
        echo "Dateiname beginnt mit einer Zahl"
        ;;
    *)
        echo "Unbekannter Dateityp"
        ;;
esac

# Example 3: Case with yes/no confirmation
echo ""
read -p "Möchtest du fortfahren? (j/n): " answer
case $answer in
    [jJ]|[jJ][aA]|[yY]|[yY][eE][sS])
        echo "OK, fahre fort..."
        ;;
    [nN]|[nN][eE][iI][nN]|[nN][oO])
        echo "Abbruch."
        exit 0
        ;;
    *)
        echo "Ungültige Eingabe. Verwende j oder n"
        ;;
esac

echo ""
echo "=== Script beendet ==="
