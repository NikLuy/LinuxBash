#!/bin/bash
# test_cmd.sh
# Demonstrates test operators: eq, ne, lt, gt, le, ge

# Source the common configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../config.sh"

echo -e "${GREEN}=== Test Operators Demo ===${NC}\n"

# Define two variables
Var1=10
var2=20

echo -e "${YELLOW}Variables:${NC}"
echo "  Var1 = $Var1"
echo "  var2 = $var2"
echo ""

echo -e "${YELLOW}Numeric Comparisons:${NC}"
echo "──────────────────────────────────────────────"

# -eq (equal)
if [ $Var1 -eq $var2 ]; then
    echo "✓ [ $Var1 -eq $var2 ] → TRUE: $Var1 ist gleich $var2"
else
    echo "✗ [ $Var1 -eq $var2 ] → FALSE: $Var1 ist NICHT gleich $var2"
fi

# -ne (not equal)
if [ $Var1 -ne $var2 ]; then
    echo "✓ [ $Var1 -ne $var2 ] → TRUE: $Var1 ist ungleich $var2"
else
    echo "✗ [ $Var1 -ne $var2 ] → FALSE: $Var1 ist gleich $var2"
fi

# -lt (less than)
if [ $Var1 -lt $var2 ]; then
    echo "✓ [ $Var1 -lt $var2 ] → TRUE: $Var1 ist kleiner als $var2"
else
    echo "✗ [ $Var1 -lt $var2 ] → FALSE: $Var1 ist NICHT kleiner als $var2"
fi

# -gt (greater than)
if [ $Var1 -gt $var2 ]; then
    echo "✓ [ $Var1 -gt $var2 ] → TRUE: $Var1 ist größer als $var2"
else
    echo "✗ [ $Var1 -gt $var2 ] → FALSE: $Var1 ist NICHT größer als $var2"
fi

# -le (less than or equal)
if [ $Var1 -le $var2 ]; then
    echo "✓ [ $Var1 -le $var2 ] → TRUE: $Var1 ist kleiner oder gleich $var2"
else
    echo "✗ [ $Var1 -le $var2 ] → FALSE: $Var1 ist größer als $var2"
fi

# -ge (greater than or equal)
if [ $Var1 -ge $var2 ]; then
    echo "✓ [ $Var1 -ge $var2 ] → TRUE: $Var1 ist größer oder gleich $var2"
else
    echo "✗ [ $Var1 -ge $var2 ] → FALSE: $Var1 ist kleiner als $var2"
fi

echo ""
echo -e "${YELLOW}Additional Tests with Equal Values:${NC}"
echo "──────────────────────────────────────────────"

Var3=15
var4=15

echo "  Var3 = $Var3"
echo "  var4 = $var4"
echo ""

if [ $Var3 -eq $var4 ]; then
    echo "✓ [ $Var3 -eq $var4 ] → TRUE: $Var3 ist gleich $var4"
fi

if [ $Var3 -le $var4 ]; then
    echo "✓ [ $Var3 -le $var4 ] → TRUE: $Var3 ist kleiner oder gleich $var4"
fi

if [ $Var3 -ge $var4 ]; then
    echo "✓ [ $Var3 -ge $var4 ] → TRUE: $Var3 ist größer oder gleich $var4"
fi

echo ""
echo -e "${GREEN}=== Test Operators Summary ===${NC}"
echo "  -eq  →  equal (gleich)"
echo "  -ne  →  not equal (ungleich)"
echo "  -lt  →  less than (kleiner als)"
echo "  -gt  →  greater than (größer als)"
echo "  -le  →  less than or equal (kleiner oder gleich)"
echo "  -ge  →  greater than or equal (größer oder gleich)"
