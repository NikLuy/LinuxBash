#!/bin/bash
# test_cmd_extended.sh
# Demonstrates extended test operators with [[ ... ]]

# Source the common configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../config.sh"

echo -e "${GREEN}=== Extended Test Operators Demo [[...]] ===${NC}\n"

# Define test variables
a="Hello World"
b="Hello World"
c="Goodbye"
d="hello world"
e="test123"
f="My email is user@example.com"
g="file.txt"
h="script.sh"

echo -e "${YELLOW}Test Variables:${NC}"
echo "  a = \"$a\""
echo "  b = \"$b\""
echo "  c = \"$c\""
echo "  d = \"$d\" (lowercase)"
echo "  e = \"$e\""
echo "  f = \"$f\""
echo "  g = \"$g\""
echo "  h = \"$h\""
echo ""

echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Test == (equality)
echo -e "${YELLOW}Test: [[ \$a == \$b ]] → String equality (no quotes needed!)${NC}"
echo "──────────────────────────────────────────────"

if [[ $a == $b ]]; then
    echo "✓ [[ $a == $b ]] → TRUE: Strings sind gleich"
else
    echo "✗ [[ $a == $b ]] → FALSE: Strings sind nicht gleich"
fi

if [[ $a == $c ]]; then
    echo "✓ [[ $a == $c ]] → TRUE: Strings sind gleich"
else
    echo "✗ [[ $a == $c ]] → FALSE: Strings sind nicht gleich"
fi

# Case sensitive
if [[ $a == $d ]]; then
    echo "✓ [[ $a == $d ]] → TRUE: Strings sind gleich"
else
    echo "✗ [[ $a == $d ]] → FALSE: Groß-/Kleinschreibung wird beachtet!"
fi

echo ""

# Test != (inequality)
echo -e "${YELLOW}Test: [[ \$a != \$b ]] → String inequality${NC}"
echo "──────────────────────────────────────────────"

if [[ $a != $c ]]; then
    echo "✓ [[ $a != $c ]] → TRUE: Strings sind ungleich"
else
    echo "✗ [[ $a != $c ]] → FALSE: Strings sind gleich"
fi

if [[ $a != $b ]]; then
    echo "✓ [[ $a != $b ]] → TRUE: Strings sind ungleich"
else
    echo "✗ [[ $a != $b ]] → FALSE: Strings sind gleich"
fi

echo ""

# Test == with pattern matching (wildcards)
echo -e "${YELLOW}Test: [[ \$a == pattern ]] → Pattern matching (wildcards)${NC}"
echo "──────────────────────────────────────────────"

if [[ $a == Hello* ]]; then
    echo "✓ [[ $a == Hello* ]] → TRUE: String beginnt mit 'Hello'"
else
    echo "✗ [[ $a == Hello* ]] → FALSE: String beginnt nicht mit 'Hello'"
fi

if [[ $a == *World ]]; then
    echo "✓ [[ $a == *World ]] → TRUE: String endet mit 'World'"
else
    echo "✗ [[ $a == *World ]] → FALSE: String endet nicht mit 'World'"
fi

if [[ $a == *llo* ]]; then
    echo "✓ [[ $a == *llo* ]] → TRUE: String enthält 'llo'"
else
    echo "✗ [[ $a == *llo* ]] → FALSE: String enthält nicht 'llo'"
fi

if [[ $e == test[0-9]* ]]; then
    echo "✓ [[ $e == test[0-9]* ]] → TRUE: String passt auf Muster 'test[0-9]*'"
else
    echo "✗ [[ $e == test[0-9]* ]] → FALSE: String passt nicht auf Muster"
fi

if [[ $g == *.txt ]]; then
    echo "✓ [[ $g == *.txt ]] → TRUE: Dateiname endet mit '.txt'"
else
    echo "✗ [[ $g == *.txt ]] → FALSE: Dateiname endet nicht mit '.txt'"
fi

if [[ $h == *.sh ]]; then
    echo "✓ [[ $h == *.sh ]] → TRUE: Dateiname endet mit '.sh'"
else
    echo "✗ [[ $h == *.sh ]] → FALSE: Dateiname endet nicht mit '.sh'"
fi

echo ""

# Test =~ (regex matching)
echo -e "${YELLOW}Test: [[ \$a =~ regexp ]] → Regular expression matching${NC}"
echo "──────────────────────────────────────────────"

if [[ $a =~ ^Hello ]]; then
    echo "✓ [[ $a =~ ^Hello ]] → TRUE: String beginnt mit 'Hello' (regex)"
else
    echo "✗ [[ $a =~ ^Hello ]] → FALSE: String beginnt nicht mit 'Hello'"
fi

if [[ $a =~ World$ ]]; then
    echo "✓ [[ $a =~ World\$ ]] → TRUE: String endet mit 'World' (regex)"
else
    echo "✗ [[ $a =~ World\$ ]] → FALSE: String endet nicht mit 'World'"
fi

if [[ $e =~ ^test[0-9]+$ ]]; then
    echo "✓ [[ $e =~ ^test[0-9]+\$ ]] → TRUE: String ist 'test' gefolgt von Zahlen"
else
    echo "✗ [[ $e =~ ^test[0-9]+\$ ]] → FALSE: Muster passt nicht"
fi

# Email validation
if [[ $f =~ [a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,} ]]; then
    echo "✓ [[ \$f =~ email-regex ]] → TRUE: String enthält gültige E-Mail"
else
    echo "✗ [[ \$f =~ email-regex ]] → FALSE: Keine gültige E-Mail gefunden"
fi

# Extract matched parts with BASH_REMATCH
if [[ $f =~ ([a-z]+)@([a-z]+\.[a-z]+) ]]; then
    echo "  └─ Gefunden: User='${BASH_REMATCH[1]}', Domain='${BASH_REMATCH[2]}'"
fi

# Test numbers in string
num="42"
if [[ $num =~ ^[0-9]+$ ]]; then
    echo "✓ [[ $num =~ ^[0-9]+\$ ]] → TRUE: String enthält nur Zahlen"
else
    echo "✗ [[ $num =~ ^[0-9]+\$ ]] → FALSE: String enthält nicht nur Zahlen"
fi

echo ""
echo -e "${GREEN}=== Extended Test Operators Summary ===${NC}"
echo "Syntax: [[ expression ]] (double brackets!)"
echo ""
echo "  ==         →  equality (keine Quotes nötig)"
echo "  !=         →  inequality (keine Quotes nötig)"
echo "  == pattern →  pattern matching mit * ? [ ]"
echo "               Beispiele: *txt, Hello*, test[0-9]*"
echo "  =~ regexp  →  regular expression matching"
echo "               Beispiele: ^start, end\$, [0-9]+, .*"
echo ""
echo -e "${YELLOW}Vorteile von [[ ... ]] vs [ ... ]:${NC}"
echo "  • Keine Quotes bei Variablen nötig"
echo "  • Pattern matching mit Wildcards (*)"
echo "  • Regular expressions mit =~"
echo "  • Besserer Umgang mit Leerzeichen"
echo "  • Logische Operatoren: && || statt -a -o"
echo ""
echo -e "${YELLOW}Pattern Wildcards:${NC}"
echo "  *       →  beliebig viele Zeichen"
echo "  ?       →  genau ein Zeichen"
echo "  [abc]   →  ein Zeichen aus der Liste"
echo "  [0-9]   →  eine Ziffer"
echo "  [a-z]   →  ein Kleinbuchstabe"
echo ""
echo -e "${YELLOW}Regex Syntax (mit =~):${NC}"
echo "  ^       →  Anfang des Strings"
echo "  \$       →  Ende des Strings"
echo "  .       →  beliebiges Zeichen"
echo "  +       →  eins oder mehr"
echo "  *       →  null oder mehr"
echo "  [0-9]   →  eine Ziffer"
echo "  [a-z]   →  ein Kleinbuchstabe"
echo "  |       →  ODER"
