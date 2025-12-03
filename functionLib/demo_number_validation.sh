#!/bin/bash
# demo_number_validation.sh - Einfache Demonstration der Funktionen

# FNCPATH setzen falls nicht gesetzt
if [ -z "$FNCPATH" ]; then
    export FNCPATH="/home/nikluy/LinuxBash/functionLib"
fi

# Funktionsbibliothek laden
source "$FNCPATH/number_validation"

echo "=========================================="
echo "  Zahlenvalidierung - Demo"
echo "=========================================="
echo ""

# Demo 1: is_int()
echo "1. is_int() - Ganze Zahlen prüfen"
echo "   -----------------------------"
for value in "42" "-17" "+5" "3.14" "abc" "0"; do
    if is_int "$value"; then
        echo "   ✓ '$value' ist eine ganze Zahl"
    else
        echo "   ✗ '$value' ist KEINE ganze Zahl"
    fi
done

echo ""

# Demo 2: is_num()
echo "2. is_num() - Zahlen (inkl. Dezimalzahlen) prüfen"
echo "   ----------------------------------------------"
for value in "42" "3.14" "-17.5" ".5" "abc" "3,14"; do
    if is_num "$value"; then
        echo "   ✓ '$value' ist eine Zahl"
    else
        echo "   ✗ '$value' ist KEINE Zahl"
    fi
done

echo ""

# Demo 3: sum_up()
echo "3. sum_up() - Ganze Zahlen summieren"
echo "   ---------------------------------"

# Beispiel 1
echo -n "   sum_up 10 20 30 40 50 = "
result=$(sum_up 10 20 30 40 50)
echo "$result (Exit-Code: $?)"

# Beispiel 2
echo -n "   sum_up 5 -3 8 -2 = "
result=$(sum_up 5 -3 8 -2)
echo "$result (Exit-Code: $?)"

# Beispiel 3: Mit ungültigen Werten
echo -n "   sum_up 10 abc 20 3.14 30 = "
result=$(sum_up 10 abc 20 3.14 30)
exit_code=$?
echo "$result (Exit-Code: $exit_code)"
echo "   → 'abc' und '3.14' wurden ignoriert"

# Beispiel 4: Alle ungültig
echo -n "   sum_up abc def xyz = "
result=$(sum_up abc def xyz)
exit_code=$?
echo "$result (Exit-Code: $exit_code)"
echo "   → Keine gültigen Zahlen gefunden"

echo ""
echo "=========================================="
echo "  Praktisches Beispiel"
echo "=========================================="
echo ""
echo "Berechnung der Summe von Argumenten:"
echo ""

# Kommandozeilen-Argumente summieren
if [ $# -eq 0 ]; then
    echo "Beispiel-Aufruf: $0 10 20 30 abc 40"
    echo ""
    echo "Teste mit Beispieldaten: 10 20 30 abc 40"
    result=$(sum_up 10 20 30 abc 40)
    exit_code=$?
else
    echo "Summiere: $@"
    result=$(sum_up "$@")
    exit_code=$?
fi

echo ""
echo "Ergebnis: $result"
if [ $exit_code -eq 0 ]; then
    echo "Status: ✓ Alle Werte waren gültige ganze Zahlen"
else
    echo "Status: ⚠ Mindestens ein Wert war ungültig und wurde ignoriert"
fi

echo ""
echo "=========================================="
