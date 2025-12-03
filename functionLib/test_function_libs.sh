#!/bin/bash
# test_function_libs.sh - Testet die Funktionsbibliotheken

# FNCPATH setzen
export FNCPATH="/home/nikluy/LinuxBash/functionLib"

# Funktionsbibliotheken laden
. "$FNCPATH/util_functions"
. "$FNCPATH/file_functions"
. "$FNCPATH/math_functions"

echo "=========================================="
echo "TEST: util_functions"
echo "=========================================="

# Test: Ja/Nein-Abfrage (wird übersprungen für automatischen Test)
# ask_yes_no "Möchten Sie den Test fortsetzen?"

# Test: Fehlermeldungen
info "Dies ist eine Info-Meldung"
warning "Dies ist eine Warnung"

# Test: String-Prüfungen
if is_empty ""; then
    info "Leerer String wurde korrekt erkannt"
fi

if is_number "42"; then
    info "Zahl wurde korrekt erkannt"
fi

if ! is_number "abc"; then
    info "Nicht-Zahl wurde korrekt erkannt"
fi

# Test: Fortschrittsbalken
echo -n "Fortschrittsbalken: "
for i in {1..10}; do
    progress_bar $i 10
    sleep 0.1
done

echo ""
echo "=========================================="
echo "TEST: file_functions"
echo "=========================================="

# Test-Datei erstellen
TEST_FILE="/tmp/test_file_$$.txt"
echo "Test-Inhalt" > "$TEST_FILE"

# Datei-Tests
if file_exists "$TEST_FILE"; then
    info "Datei existiert: $TEST_FILE"
fi

if is_regular_file "$TEST_FILE"; then
    info "Ist reguläre Datei"
fi

if is_readable "$TEST_FILE"; then
    info "Datei ist lesbar"
fi

if is_writable "$TEST_FILE"; then
    info "Datei ist schreibbar"
fi

size=$(get_file_size "$TEST_FILE")
info "Dateigröße: $size Bytes"

filename=$(get_filename "$TEST_FILE")
info "Dateiname: $filename"

dir=$(get_directory "$TEST_FILE")
info "Verzeichnis: $dir"

perms=$(get_file_permissions "$TEST_FILE")
info "Berechtigungen: $perms"

# Aufräumen
rm -f "$TEST_FILE"

echo ""
echo "=========================================="
echo "TEST: math_functions"
echo "=========================================="

# Grundrechenarten
info "Addition: 5 + 3 = $(add 5 3)"
info "Subtraktion: 10 - 4 = $(subtract 10 4)"
info "Multiplikation: 6 * 7 = $(multiply 6 7)"
info "Division: 20 / 4 = $(divide 20 4)"
info "Modulo: 17 % 5 = $(modulo 17 5)"

# Erweiterte Funktionen
info "Potenz: 2^8 = $(power 2 8)"
info "Fakultät: 5! = $(factorial 5)"
info "Absolut: |-15| = $(abs -15)"
info "Maximum: max(42, 17) = $(max 42 17)"
info "Minimum: min(42, 17) = $(min 42 17)"

# Listen-Operationen
nums="10 20 30 40 50"
info "Summe von ($nums) = $(sum $nums)"
info "Durchschnitt von ($nums) = $(average $nums)"
info "Maximum von ($nums) = $(find_max $nums)"
info "Minimum von ($nums) = $(find_min $nums)"

# Spezielle Prüfungen
if is_even 42; then
    info "42 ist gerade"
fi

if is_odd 17; then
    info "17 ist ungerade"
fi

if is_prime 17; then
    info "17 ist eine Primzahl"
fi

if ! is_prime 18; then
    info "18 ist keine Primzahl"
fi

info "GCD von 48 und 18 = $(gcd 48 18)"

# Gleitkomma-Berechnung (wenn bc verfügbar)
if command -v bc >/dev/null 2>&1; then
    info "Gleitkomma: 10/3 = $(calc '10/3' 4)"
fi

echo ""
echo "=========================================="
echo "Alle Tests abgeschlossen!"
echo "=========================================="
