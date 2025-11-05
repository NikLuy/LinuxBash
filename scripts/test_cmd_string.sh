#!/bin/bash
# test_cmd_string.sh
# Demonstrates string test operators: =, !=, -z, -n

# Source the common configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../config.sh"

echo -e "${GREEN}=== String Test Operators Demo ===${NC}\n"

# Define test variables
var1="Hello"
var2="World"
var3="Hello"
var4=""
var5="   "

echo -e "${YELLOW}Test Variables:${NC}"
echo "  var1 = \"$var1\""
echo "  var2 = \"$var2\""
echo "  var3 = \"$var3\""
echo "  var4 = \"$var4\" (empty string)"
echo "  var5 = \"$var5\" (spaces)"
echo ""

echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Test = (equal)
echo -e "${YELLOW}Test: [ \"\$var1\" = \"\$var2\" ] → String equality${NC}"
echo "──────────────────────────────────────────────"

if [ "$var1" = "$var2" ]; then
    echo "✓ [ \"$var1\" = \"$var2\" ] → TRUE: Strings sind gleich"
else
    echo "✗ [ \"$var1\" = \"$var2\" ] → FALSE: Strings sind NICHT gleich"
fi

if [ "$var1" = "$var3" ]; then
    echo "✓ [ \"$var1\" = \"$var3\" ] → TRUE: Strings sind gleich"
else
    echo "✗ [ \"$var1\" = \"$var3\" ] → FALSE: Strings sind NICHT gleich"
fi

# Empty string comparison
if [ "$var4" = "" ]; then
    echo "✓ [ \"$var4\" = \"\" ] → TRUE: var4 ist ein leerer String"
else
    echo "✗ [ \"$var4\" = \"\" ] → FALSE: var4 ist nicht leer"
fi

echo ""

# Test != (not equal)
echo -e "${YELLOW}Test: [ \"\$var1\" != \"\$var2\" ] → String inequality${NC}"
echo "──────────────────────────────────────────────"

if [ "$var1" != "$var2" ]; then
    echo "✓ [ \"$var1\" != \"$var2\" ] → TRUE: Strings sind ungleich"
else
    echo "✗ [ \"$var1\" != \"$var2\" ] → FALSE: Strings sind gleich"
fi

if [ "$var1" != "$var3" ]; then
    echo "✓ [ \"$var1\" != \"$var3\" ] → TRUE: Strings sind ungleich"
else
    echo "✗ [ \"$var1\" != \"$var3\" ] → FALSE: Strings sind gleich"
fi

echo ""

# Test -z (zero length - string is empty)
echo -e "${YELLOW}Test: [ -z \"\$var\" ] → String is empty (zero length)${NC}"
echo "──────────────────────────────────────────────"

if [ -z "$var4" ]; then
    echo "✓ [ -z \"$var4\" ] → TRUE: String ist leer (Länge = 0)"
else
    echo "✗ [ -z \"$var4\" ] → FALSE: String ist nicht leer"
fi

if [ -z "$var1" ]; then
    echo "✓ [ -z \"$var1\" ] → TRUE: String ist leer"
else
    echo "✗ [ -z \"$var1\" ] → FALSE: String ist nicht leer (enthält: \"$var1\")"
fi

if [ -z "$var5" ]; then
    echo "✓ [ -z \"$var5\" ] → TRUE: String ist leer"
else
    echo "✗ [ -z \"$var5\" ] → FALSE: String ist nicht leer (enthält Leerzeichen)"
fi

# Test with undefined variable
unset var_undefined
if [ -z "$var_undefined" ]; then
    echo "✓ [ -z \"\$var_undefined\" ] → TRUE: Undefinierte Variable ist leer"
else
    echo "✗ [ -z \"\$var_undefined\" ] → FALSE: Variable ist nicht leer"
fi

echo ""

# Test -n (non-zero length - string is not empty)
echo -e "${YELLOW}Test: [ -n \"\$var\" ] → String is not empty (non-zero length)${NC}"
echo "──────────────────────────────────────────────"

if [ -n "$var1" ]; then
    echo "✓ [ -n \"$var1\" ] → TRUE: String ist nicht leer (enthält: \"$var1\")"
else
    echo "✗ [ -n \"$var1\" ] → FALSE: String ist leer"
fi

if [ -n "$var4" ]; then
    echo "✓ [ -n \"$var4\" ] → TRUE: String ist nicht leer"
else
    echo "✗ [ -n \"$var4\" ] → FALSE: String ist leer (Länge = 0)"
fi

if [ -n "$var5" ]; then
    echo "✓ [ -n \"$var5\" ] → TRUE: String ist nicht leer (enthält Leerzeichen)"
else
    echo "✗ [ -n \"$var5\" ] → FALSE: String ist leer"
fi

# Test with undefined variable
if [ -n "$var_undefined" ]; then
    echo "✓ [ -n \"\$var_undefined\" ] → TRUE: Variable ist nicht leer"
else
    echo "✗ [ -n \"\$var_undefined\" ] → FALSE: Undefinierte Variable ist leer"
fi

echo ""
echo -e "${GREEN}=== String Test Operators Summary ===${NC}"
echo "  =   →  equal (Strings sind gleich)"
echo "  !=  →  not equal (Strings sind ungleich)"
echo "  -z  →  zero length (String ist leer / Länge = 0)"
echo "  -n  →  non-zero length (String ist nicht leer / Länge > 0)"
echo ""
echo -e "${YELLOW}Wichtig:${NC}"
echo "  • Immer Anführungszeichen verwenden: [ \"\$var\" = \"text\" ]"
echo "  • -z gibt TRUE bei leeren Strings und undefinierten Variablen"
echo "  • -n gibt TRUE bei allen nicht-leeren Strings (auch Leerzeichen)"
echo "  • Leerzeichen im String zählen als Inhalt"
