#!/bin/bash
# arithmetic_operations.sh
# Demonstrates arithmetic operations in Bash

# Source the common configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../config.sh"

echo -e "${GREEN}=== Bash Arithmetic Operations Demo ===${NC}\n"

# Initialize variables
a=10
b=3
result=0

echo -e "${YELLOW}Initialisierung:${NC}"
echo "  a = $a"
echo "  b = $b"
echo ""

echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Addition (+)
echo -e "${YELLOW}Addition (+)${NC}"
echo "──────────────────────────────────────────────"
result=$((a + b))
echo "  a + b = $a + $b = $result"
echo "  Syntax: result=\$((a + b))"
echo ""

# Subtraction (-)
echo -e "${YELLOW}Subtraktion (-)${NC}"
echo "──────────────────────────────────────────────"
result=$((a - b))
echo "  a - b = $a - $b = $result"
echo "  Syntax: result=\$((a - b))"
echo ""

# Multiplication (*)
echo -e "${YELLOW}Multiplikation (*)${NC}"
echo "──────────────────────────────────────────────"
result=$((a * b))
echo "  a * b = $a * $b = $result"
echo "  Syntax: result=\$((a * b))"
echo ""

# Division (/)
echo -e "${YELLOW}Division (/) - Ganzzahldivision${NC}"
echo "──────────────────────────────────────────────"
result=$((a / b))
echo "  a / b = $a / $b = $result (nur Ganzzahl!)"
echo "  Syntax: result=\$((a / b))"
echo ""

# Modulo (%)
echo -e "${YELLOW}Modulo (%) - Rest der Division${NC}"
echo "──────────────────────────────────────────────"
result=$((a % b))
echo "  a % b = $a % $b = $result (Rest)"
echo "  Syntax: result=\$((a % b))"
echo ""

# Compound assignments
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
echo -e "${YELLOW}Compound Assignments (Zuweisungsoperatoren)${NC}"
echo ""

# += (Add and assign)
echo -e "${YELLOW}+= (Addition und Zuweisung)${NC}"
echo "──────────────────────────────────────────────"
x=10
echo "  Vorher: x = $x"
((x += 5))
echo "  x += 5  →  x = $x"
echo "  Entspricht: x = x + 5"
echo ""

# -= (Subtract and assign)
echo -e "${YELLOW}-= (Subtraktion und Zuweisung)${NC}"
echo "──────────────────────────────────────────────"
x=10
echo "  Vorher: x = $x"
((x -= 3))
echo "  x -= 3  →  x = $x"
echo "  Entspricht: x = x - 3"
echo ""

# *= (Multiply and assign)
echo -e "${YELLOW}*= (Multiplikation und Zuweisung)${NC}"
echo "──────────────────────────────────────────────"
x=10
echo "  Vorher: x = $x"
((x *= 2))
echo "  x *= 2  →  x = $x"
echo "  Entspricht: x = x * 2"
echo ""

# /= (Divide and assign)
echo -e "${YELLOW}/= (Division und Zuweisung)${NC}"
echo "──────────────────────────────────────────────"
x=10
echo "  Vorher: x = $x"
((x /= 2))
echo "  x /= 2  →  x = $x"
echo "  Entspricht: x = x / 2"
echo ""

# %= (Modulo and assign)
echo -e "${YELLOW}%= (Modulo und Zuweisung)${NC}"
echo "──────────────────────────────────────────────"
x=10
echo "  Vorher: x = $x"
((x %= 3))
echo "  x %= 3  →  x = $x"
echo "  Entspricht: x = x % 3"
echo ""

# Increment and Decrement
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
echo -e "${YELLOW}Inkrement und Dekrement${NC}"
echo ""

# ++ (Increment)
echo -e "${YELLOW}++ (Inkrement - erhöhe um 1)${NC}"
echo "──────────────────────────────────────────────"
x=10
echo "  Vorher: x = $x"
((x++))
echo "  x++  →  x = $x (Post-Inkrement)"
echo ""
x=10
echo "  Vorher: x = $x"
((++x))
echo "  ++x  →  x = $x (Pre-Inkrement)"
echo ""

# Difference between pre and post increment
echo -e "${YELLOW}Unterschied Pre- vs Post-Inkrement:${NC}"
x=10
echo "  x = $x"
y=$((x++))
echo "  y = \$((x++))  →  y = $y, x = $x (x wird NACH Zuweisung erhöht)"
echo ""
x=10
echo "  x = $x"
y=$((++x))
echo "  y = \$((++x))  →  y = $y, x = $x (x wird VOR Zuweisung erhöht)"
echo ""

# -- (Decrement)
echo -e "${YELLOW}-- (Dekrement - verringere um 1)${NC}"
echo "──────────────────────────────────────────────"
x=10
echo "  Vorher: x = $x"
((x--))
echo "  x--  →  x = $x (Post-Dekrement)"
echo ""
x=10
echo "  Vorher: x = $x"
((--x))
echo "  --x  →  x = $x (Pre-Dekrement)"
echo ""

# Practical examples
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
echo -e "${YELLOW}Praktische Beispiele:${NC}"
echo ""

# Example 1: Counter in loop
echo -e "${YELLOW}Beispiel 1: Zähler in Schleife${NC}"
counter=0
for i in {1..5}; do
    ((counter++))
    echo "  Durchlauf $i: counter = $counter"
done
echo ""

# Example 2: Calculate sum
echo -e "${YELLOW}Beispiel 2: Summe berechnen${NC}"
sum=0
for num in 1 2 3 4 5; do
    ((sum += num))
    echo "  sum += $num  →  sum = $sum"
done
echo "  Ergebnis: sum = $sum"
echo ""

# Example 3: Even/Odd check with modulo
echo -e "${YELLOW}Beispiel 3: Gerade/Ungerade Prüfung${NC}"
for num in 10 11 12 13; do
    if ((num % 2 == 0)); then
        echo "  $num ist gerade (num % 2 = $((num % 2)))"
    else
        echo "  $num ist ungerade (num % 2 = $((num % 2)))"
    fi
done
echo ""

# Example 4: Calculate factorial
echo -e "${YELLOW}Beispiel 4: Fakultät berechnen (5!)${NC}"
n=5
factorial=1
for ((i=1; i<=n; i++)); do
    ((factorial *= i))
    echo "  $i: factorial *= $i  →  factorial = $factorial"
done
echo "  Ergebnis: $n! = $factorial"
echo ""

echo -e "${GREEN}=== Arithmetic Operations Summary ===${NC}"
echo ""
echo -e "${YELLOW}Syntax-Optionen:${NC}"
echo "  result=\$((expression))    → Arithmetische Expansion"
echo "  ((expression))            → Arithmetischer Befehl"
echo "  let \"expression\"          → let-Befehl"
echo "  \$[expression]             → Veraltete Syntax"
echo ""
echo -e "${YELLOW}Operatoren:${NC}"
echo "  +    → Addition"
echo "  -    → Subtraktion"
echo "  *    → Multiplikation"
echo "  /    → Division (Ganzzahl)"
echo "  %    → Modulo (Rest)"
echo "  +=   → Addiere und weise zu"
echo "  -=   → Subtrahiere und weise zu"
echo "  *=   → Multipliziere und weise zu"
echo "  /=   → Dividiere und weise zu"
echo "  %=   → Modulo und weise zu"
echo "  ++   → Inkrement (erhöhe um 1)"
echo "  --   → Dekrement (verringere um 1)"
echo ""
echo -e "${YELLOW}Wichtig:${NC}"
echo "  • Bash unterstützt nur Ganzzahl-Arithmetik!"
echo "  • Für Fließkommazahlen verwende 'bc' oder 'awk'"
echo "  • Keine Leerzeichen um = bei Zuweisungen!"
