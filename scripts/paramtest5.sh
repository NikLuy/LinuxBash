#!/bin/bash

echo "$0 $@"
echo

initial_count=$#
echo "Anzahl Parameter: $initial_count"
echo


counter=1
while [ $# -gt 0 ]; do
    echo "Parameter $counter: $1"
    shift
    ((counter++))
done

echo
echo "Nach allen shifts: \$# = $#"
