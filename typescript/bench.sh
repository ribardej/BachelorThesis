#!/bin/bash

filename=$1
expectedValue=$2

run() {
    local benchmarkName=$1
    local runCommand=$2

    local output=$( { time $runCommand $filename; } 2>&1 )
    local elapsedTime=$(echo "$output" | grep real | awk '{print $2}')
    local solution=$(echo "$output" | head -n 1)

    if [[ $solution == $expectedValue ]]; then
        echo -e "$benchmarkName solution is correct. Elapsed time: $elapsedTime"
    else
        echo -e "$benchmarkName solution is incorrect. Expected: $expectedValue, Actual: $solution"
        exit 1
    fi
}

echo -e "\nTypeScript:"
run "Node" "bash node.sh"
run "Deno" "deno run --allow-read shortestPath.ts"
run "Bun" "bun shortestPath.ts"

echo -e "\nJavaScript:"
run "Node" "node shortestPath.js"
run "Deno" "deno run --allow-read shortestPath.js"
run "Bun" "bun shortestPath.js"
echo ""


