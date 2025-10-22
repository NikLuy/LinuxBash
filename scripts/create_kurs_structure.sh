#!/bin/bash
#create_kurs_structure.sh
# Creates the course folder structure in the working_dir

# Base directory - output to working_dir
BASE_DIR="working_dir/Kurs"

# Create the base directory
mkdir -p "$BASE_DIR"

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
