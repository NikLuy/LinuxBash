#!/bin/bash
# vergleiche.sh
# Compares two integers and outputs their relationship

# Source the common configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../config.sh"

# Check if exactly 2 parameters are provided
if [ $# -ne 2 ]; then
    echo "Verwendung: $0 Ganzzahl_1 Ganzzahl_2" >&2
    echo "Fehler: Es wurden $# Parameter angegeben, aber genau 2 werden benötigt." >&2
    exit 1
fi

# Get the parameters
zahl1="$1"
zahl2="$2"

# Check if the first parameter is a valid integer
if ! [[ $zahl1 =~ ^-?[0-9]+$ ]]; then
    echo "Verwendung: $0 Ganzzahl_1 Ganzzahl_2" >&2
    echo "$zahl1 ist keine ganze Zahl" >&2
    exit 2
fi

# Check if the second parameter is a valid integer
if ! [[ $zahl2 =~ ^-?[0-9]+$ ]]; then
    echo "Verwendung: $0 Ganzzahl_1 Ganzzahl_2" >&2
    echo "$zahl2 ist keine ganze Zahl" >&2
    exit 2
fi

# Compare the two numbers
if [ $zahl1 -lt $zahl2 ]; then
    echo "$zahl1 ist kleiner als $zahl2"
elif [ $zahl1 -gt $zahl2 ]; then
    echo "$zahl1 ist grösser als $zahl2"
else
    echo "$zahl1 ist gleich $zahl2"
fi

exit 0
