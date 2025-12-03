#!/bin/bash

# countlines.sh - Nummeriert und zählt Zeilen einer Textdatei
# Verwendet nur Shell-Builtin-Kommandos (echo, read, while)

# Überprüfe Parameter
if [ $# -ne 1 ]; then
    echo "Verwendung: $0 <Datei>" 1>&2
    echo "Beispiel: $0 /home/u1/texte/test.txt" 1>&2
    exit 1
fi

DATEI="$1"

# Prüfe ob Datei existiert
if [ ! -f "$DATEI" ]; then
    echo "Fehler: Datei '$DATEI' existiert nicht." 1>&2
    exit 1
fi

# Prüfe ob Datei lesbar ist
if [ ! -r "$DATEI" ]; then
    echo "Fehler: Datei '$DATEI' ist nicht lesbar." 1>&2
    exit 1
fi

echo "File: $DATEI"

# Variante 1: Mit Umlenkung von stdin (while-Schleife)
# Die Datei wird an stdin umgelenkt
zeilennummer=0

while read -r zeile; do
    ((zeilennummer++))
    # Formatierte Ausgabe mit printf für rechtsbündige Nummerierung
    printf "%3d %s\n" "$zeilennummer" "$zeile"
done < "$DATEI"

echo "$DATEI: $zeilennummer Zeilen gelesen"
