#!/bin/bash
#create_kurs_structure01.sh
# Creates the course folder structure in the working_dir
# This variant checks the result of the first mkdir and exits with code 1 on failure

# Source the common configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../config.sh"

# Ensure working directory exists
ensure_working_dir

# Base directory - output to working_dir
BASE_DIR="$KURS_DIR"

# Create the base directory (this is the first mkdir — if it fails, exit with code 1)
mkdir -p "$BASE_DIR"
if [ $? -ne 0 ]; then
    echo "Fehler: Konnte Verzeichnis '$BASE_DIR' nicht anlegen." 1>&2
    exit 1
fi

# Loop through blocks 1 to 5
for i in {1..5}; do
  mkdir -p "$BASE_DIR/block$i/aufgaben"
  mkdir -p "$BASE_DIR/block$i/loesungen"
done

echo "Ordnerstruktur wurde erfolgreich erstellt!"

# Check if tree command is available
if command -v tree &> /dev/null; then
  tree "$BASE_DIR"
else
  echo "Tree command not found. Showing structure with find:"
  find "$BASE_DIR" -type d | sort
fi

# End successfully
exit 0
