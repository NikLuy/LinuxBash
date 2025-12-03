#!/bin/bash
Schnelltest ohne Interaktion

# FNCPATH setzen falls nicht gesetzt
if [ -z "$FNCPATH" ]; then
    export FNCPATH="/home/nikluy/LinuxBash/functionLib"
fi

source "$FNCPATH/number_validation"

echo "=== Quick Test: number_validation ==="
echo ""

# Test is_int()
echo "is_int() Tests:"
echo "  is_int '42'    => $(is_int '42' && echo 'TRUE (0)' || echo 'FALSE (1)')"
echo "  is_int '-17'   => $(is_int '-17' && echo 'TRUE (0)' || echo 'FALSE (1)')"
echo "  is_int '3.14'  => $(is_int '3.14' && echo 'TRUE (0)' || echo 'FALSE (1)')"
echo "  is_int 'abc'   => $(is_int 'abc' && echo 'TRUE (0)' || echo 'FALSE (1)')"
echo ""

# Test is_num()
echo "is_num() Tests:"
echo "  is_num '42'    => $(is_num '42' && echo 'TRUE (0)' || echo 'FALSE (1)')"
echo "  is_num '3.14'  => $(is_num '3.14' && echo 'TRUE (0)' || echo 'FALSE (1)')"
echo "  is_num '.5'    => $(is_num '.5' && echo 'TRUE (0)' || echo 'FALSE (1)')"
echo "  is_num 'abc'   => $(is_num 'abc' && echo 'TRUE (0)' || echo 'FALSE (1)')"
echo "  is_num '3,14'  => $(is_num '3,14' && echo 'TRUE (0)' || echo 'FALSE (1)')"
echo ""

# Test sum_up()
echo "sum_up() Tests:"
echo "  sum_up 1 2 3 4 5           => $(sum_up 1 2 3 4 5) (exit: $?)"
echo "  sum_up 10 -5 3             => $(sum_up 10 -5 3) (exit: $?)"
echo "  sum_up 10 abc 20 3.14 30   => $(sum_up 10 abc 20 3.14 30) (exit: $?)"
echo "  sum_up abc def xyz         => $(sum_up abc def xyz) (exit: $?)"
echo ""

echo "=== Tests abgeschlossen ==="
