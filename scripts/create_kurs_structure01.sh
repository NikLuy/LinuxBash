#!/bin/bash
#create_kurs_structure01.sh
# Creates the course folder structure in the working_dir
# This variant checks the result of the first mkdir and exits with code 1 on failure
# Parameters: Kursname AnzahlBlöcke

# Check parameters
if [ $# -ne 2 ]; then
    echo "Verwendung: $0 <Kursname> <AnzahlBlöcke>" 1>&2
    echo "Beispiel: $0 MeinKurs 5" 1>&2
    exit 1
fi

KURSNAME="$1"
ANZAHL_BLOECKE="$2"

# Validate that AnzahlBlöcke is a positive number
if ! [[ "$ANZAHL_BLOECKE" =~ ^[1-9][0-9]*$ ]]; then
    echo "Fehler: AnzahlBlöcke muss eine positive Zahl sein." 1>&2
    exit 1
fi

# Source the common configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$PROJECT_ROOT"
source "$SCRIPT_DIR/../config.sh"

# Ensure working directory exists
ensure_working_dir

# Base directory - output to working_dir with custom course name
BASE_DIR="$WD/$KURSNAME"

# Create the base directory (this is the first mkdir — if it fails, exit with code 1)
# -p option ensures no error if the directory exists
mkdir -p "$BASE_DIR"
if [ $? -ne 0 ]; then
    echo "Fehler: Konnte Verzeichnis '$BASE_DIR' nicht anlegen." 1>&2
    exit 1
fi

# Loop through blocks 1 to AnzahlBlöcke
for ((i=1; i<=ANZAHL_BLOECKE; i++)); do
  mkdir -p "$BASE_DIR/block$i/aufgaben"
  if [ $? -ne 0 ]; then
    echo "Fehler: Konnte Verzeichnis '$BASE_DIR/block$i/aufgaben' nicht anlegen." 1>&2
    exit 1
  fi
  
  mkdir -p "$BASE_DIR/block$i/loesungen"
  if [ $? -ne 0 ]; then
    echo "Fehler: Konnte Verzeichnis '$BASE_DIR/block$i/loesungen' nicht anlegen." 1>&2
    exit 1
  fi
done

echo "Ordnerstruktur für Kurs '$KURSNAME' mit $ANZAHL_BLOECKE Blöcken wurde erfolgreich erstellt!"

# Check if tree command is available
if command -v tree &> /dev/null; then
  tree "$BASE_DIR"
else
  echo "Tree command not found. Showing structure with find:"
  find "$BASE_DIR" -type d | sort
fi

# End successfully
exit 0
