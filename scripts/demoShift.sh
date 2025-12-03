#!/bin/bash

# Demo script for the shift command
# The shift command moves positional parameters to the left
# shift n moves parameters n positions (default is 1)

echo "=== Demo: shift command ==="
echo

# Demo 1: Basic shift usage
echo "Demo 1: Basic shift"
echo "-------------------"
set -- "First" "Second" "Third" "Fourth" "Fifth"
echo "Initial parameters: $@"
echo "Number of parameters: $#"
echo "First parameter: $1"
echo

shift
echo "After 'shift':"
echo "All parameters: $@"
echo "Number of parameters: $#"
echo "First parameter: $1"
echo

# Demo 2: shift with a number
echo "Demo 2: shift with number"
echo "-------------------------"
set -- "Apple" "Banana" "Cherry" "Date" "Elderberry"
echo "Initial parameters: $@"
echo "Number of parameters: $#"
echo

shift 2
echo "After 'shift 2':"
echo "All parameters: $@"
echo "Number of parameters: $#"
echo "First parameter: $1"
echo

# Demo 3: Processing all parameters with shift in a loop
echo "Demo 3: Processing parameters with shift in a loop"
echo "---------------------------------------------------"
set -- "Item1" "Item2" "Item3" "Item4"
echo "Processing all parameters using shift:"
counter=1
while [ $# -gt 0 ]; do
    echo "  Processing parameter $counter: $1"
    shift
    ((counter++))
done
echo "After loop, number of parameters: $#"
echo

# Demo 4: Practical example - script with options
echo "Demo 4: Practical example - processing script arguments"
echo "--------------------------------------------------------"
process_args() {
    local verbose=false
    local output_file=""
    local input_files=()
    
    while [ $# -gt 0 ]; do
        case $1 in
            -v|--verbose)
                verbose=true
                shift
                ;;
            -o|--output)
                output_file="$2"
                shift 2  # Skip both the flag and its argument
                ;;
            -*)
                echo "Unknown option: $1"
                shift
                ;;
            *)
                input_files+=("$1")
                shift
                ;;
        esac
    done
    
    echo "Verbose mode: $verbose"
    echo "Output file: ${output_file:-not specified}"
    echo "Input files: ${input_files[*]}"
}

echo "Simulating: script.sh -v -o output.txt file1.txt file2.txt"
process_args -v -o output.txt file1.txt file2.txt
echo

# Demo 5: shift with error handling
echo "Demo 5: shift with error handling"
echo "----------------------------------"
set -- "OnlyOne"
echo "Parameters: $@"
echo "Number of parameters: $#"
echo "Attempting shift..."
shift
echo "After first shift, parameters: $# remaining"

if [ $# -eq 0 ]; then
    echo "No more parameters to shift"
else
    shift
fi
echo

echo "=== Demo completed ==="
