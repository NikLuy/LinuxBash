#!/bin/bash

# beersong.sh - Gibt das Bierlied mit der angegebenen Anzahl Strophen aus

# Überprüfe Parameter
if [ $# -ne 1 ]; then
    echo "Verwendung: $0 <Anzahl Flaschen>" 1>&2
    echo "Beispiel: $0 3" 1>&2
    exit 1
fi

ANZAHL=$1

# Validiere dass die Anzahl eine positive Zahl ist
if ! [[ "$ANZAHL" =~ ^[1-9][0-9]*$ ]]; then
    echo "Fehler: Anzahl muss eine positive Zahl sein." 1>&2
    exit 1
fi

# Funktion für korrekte Singular/Plural
get_flaschen_text() {
    local anzahl=$1
    if [ $anzahl -eq 1 ]; then
        echo "Flasche"
    else
        echo "Flaschen"
    fi
}

# Funktion für korrekte Pronomen
get_pronomen() {
    local anzahl=$1
    if [ $anzahl -eq 1 ]; then
        echo "sie"
    else
        echo "eine"cl
    fi
}

# Hauptschleife - von ANZAHL bis 1
for ((i=ANZAHL; i>=1; i--)); do
    flaschen=$(get_flaschen_text $i)
    pronomen=$(get_pronomen $i)
    
    echo "$i $flaschen Bier im Kühlschrank"
    echo "$i $flaschen Bier"
    echo "Nimm $pronomen raus"
    echo "Trink sie aus"
    echo
done

echo "Der Kühlschrank ist leer ..."
