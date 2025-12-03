
MyName(){
    echo "My name is Bash Script $FUNCNAME" 
}

MyName



CalcAddition(){
    local sum=0
    for number in "$@"; do
        sum=$((sum + number))
    done
    echo "The sum is: $sum"
}

CalcAddition 1 2 3 4 5
CalcMultiplication(){
    local product=1
    for number in "$@"; do
        product=$((product * number))
    done
    echo "The product is: $product"
}

CalcMultiplication 1 2 3 4 5
GreetUser(){
    local name=$1
    echo "Hello, $name! Welcome to the Bash scripting world."
    return 10
}

var=$(GreetUser "Alice")
echo "$var"
echo "The return value of GreetUser is: $?"

Factorial(){
    local n=$1
    if [ "$n" -le 1 ]; then
        echo 1
    else
        local temp=$((n - 1))
        local result=$(Factorial $temp)
        echo $((n * result))
    fi
}
number=5
fact=$(Factorial $number)
echo "The factorial of $number is: $fact"

LocalVariableDemo(){
    local localVar="I am local"
    echo "$localVar"
}
LocalVariableDemo
# Trying to access localVar outside the function will result in an empty value
echo "Accessing localVar outside function: '$localVar'"




