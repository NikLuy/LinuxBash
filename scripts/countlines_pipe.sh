#!/bin/bash

# countlines_pipe.sh - Nummeriert und zählt Zeilen einer Textdatei
# Variante mit Pipe anstatt stdin-Umlenkung

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

# Variante 2: Mit Pipe (cat leitet Inhalt an while-Schleife weiter)
# Beachte: Variablen in einer Pipe laufen in einer Subshell
zeilennummer=0

cat "$DATEI" | while read -r zeile; do
    ((zeilennummer++))
    printf "%3d %s\n" "$zeilennummer" "$zeile"
done

# Problem: zeilennummer aus der Subshell ist hier nicht verfügbar
# Daher müssen wir die Zeilen nochmal zählen oder eine andere Lösung verwenden

# Alternative Lösung mit process substitution um Subshell-Problem zu vermeiden
zeilennummer=0
while read -r zeile; do
    ((zeilennummer++))
done < <(cat "$DATEI")

echo "$DATEI: $zeilennummer Zeilen gelesen"
