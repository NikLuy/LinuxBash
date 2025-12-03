#!/bin/bash

# collect.sh - Durchsucht ein Quell-Verzeichnis nach Dateien mit bestimmter Endung
#              und kopiert sie in ein Ziel-Verzeichnis

# Überprüfe Anzahl der Parameter
if [ $# -ne 3 ]; then
    echo "Verwendung: $0 <Datei-Endung> <Quell-Verzeichnis> <Ziel-Verzeichnis>" 1>&2
    echo "Beispiel: $0 .sh /home/user/scripts /home/user/backup" 1>&2
    exit 1
fi

ENDUNG="$1"
QUELL_DIR="$2"
ZIEL_DIR="$3"

# Prüfe ob Quell-Verzeichnis existiert
if [ ! -d "$QUELL_DIR" ]; then
    echo "Fehler: Quell-Verzeichnis '$QUELL_DIR' existiert nicht." 1>&2
    exit 1
fi

# Prüfe ob Quell-Verzeichnis lesbar ist
if [ ! -r "$QUELL_DIR" ]; then
    echo "Fehler: Quell-Verzeichnis '$QUELL_DIR' ist nicht lesbar." 1>&2
    exit 1
fi

# Erstelle Ziel-Verzeichnis falls es nicht existiert
if [ ! -d "$ZIEL_DIR" ]; then
    echo "Ziel-Verzeichnis '$ZIEL_DIR' existiert nicht. Lege es an..."
    mkdir -p "$ZIEL_DIR"
    if [ $? -ne 0 ]; then
        echo "Fehler: Konnte Ziel-Verzeichnis '$ZIEL_DIR' nicht anlegen." 1>&2
        exit 1
    fi
    echo "Ziel-Verzeichnis wurde erfolgreich angelegt."
fi

# Prüfe ob Ziel-Verzeichnis schreibbar ist
if [ ! -w "$ZIEL_DIR" ]; then
    echo "Fehler: Ziel-Verzeichnis '$ZIEL_DIR' ist nicht schreibbar." 1>&2
    exit 1
fi

# Stelle sicher, dass die Endung mit einem Punkt beginnt
if [[ ! "$ENDUNG" =~ ^\. ]]; then
    ENDUNG=".$ENDUNG"
fi

echo "Suche nach Dateien mit Endung '$ENDUNG' in '$QUELL_DIR'..."
echo

# Zähler für gefundene und kopierte Dateien
gefunden=0
kopiert=0
fehler=0

# Durchsuche Quell-Verzeichnis mit find und verarbeite mit for-Schleife
for datei in $(find "$QUELL_DIR" -type f -name "*$ENDUNG" 2>/dev/null); do
    ((gefunden++))
    
    # Extrahiere nur den Dateinamen ohne Pfad
    dateiname=$(basename "$datei")
    
    echo "Gefunden: $datei"
    
    # Kopiere die Datei
    cp "$datei" "$ZIEL_DIR/$dateiname"
    
    if [ $? -eq 0 ]; then
        echo "  -> Kopiert nach: $ZIEL_DIR/$dateiname"
        ((kopiert++))
    else
        echo "  -> Fehler beim Kopieren!" 1>&2
        ((fehler++))
    fi
    echo
done

# Zusammenfassung
echo "================================"
echo "Zusammenfassung:"
echo "================================"
echo "Gefundene Dateien:  $gefunden"
echo "Kopierte Dateien:   $kopiert"
echo "Fehler:             $fehler"
echo "================================"

if [ $gefunden -eq 0 ]; then
    echo "Keine Dateien mit Endung '$ENDUNG' gefunden."
    exit 0
fi

if [ $fehler -gt 0 ]; then
    exit 1
fi

exit 0


# ./scripts/collect.sh .sh /nonexistent /tmp/test
# ./scripts/collect.sh .sh ./scripts ./working_dir/backup_scripts
# ./scripts/collect.sh md . ./working_dir/backup_md
# ./scripts/collect.sh .xyz ./scripts ./working_dir/backup_xyz