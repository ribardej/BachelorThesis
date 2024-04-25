#!/bin/bash

run() {
    local runtimeName=$1
    local runCommand=$2

    local elapsedTime=$( { time $runCommand; } 2>&1 | grep real | awk '{print $2}')
    echo "$runtimeName: $elapsedTime"
}

echo -e "\n1) Recursive computation of 43rd fibonacci number"
run "Node" "node fibonacci.js"
run "Deno" "deno run fibonacci.js"
run "Bun" "bun fibonacci.js"

echo -e "\n2) 10x10 matrix multiplication for 1s"
echo "Node: $(node matrixMult.js) iterations made"
echo "Deno: $(deno run matrixMult.js) iterations made"
echo "Bun: $(bun matrixMult.js) iterations made"
echo ""
