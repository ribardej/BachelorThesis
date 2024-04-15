#!/bin/bash

run_solution() {
    local benchmarkName=$1
    local runtime=$2
    local filename=$3
    local expectedValue=$4

    local output=$( { time $runtime $filename; } 2>&1 )
    local elapsedTime=$(echo "$output" | grep real | awk '{print $2}')
    local solution=$(echo "$output" | head -n 1)

    if [[ $solution == $expectedValue ]]; then
        echo -e "$benchmarkName solution is correct. Elapsed time: $elapsedTime"
    else
        echo -e "$benchmarkName solution is incorrect. Expected: $expectedValue, Actual: $solution"
        exit 1
    fi
}

graph=$1
expectedValue=$2

run_solution "Node TS" "bash node.sh" "$graph" "$expectedValue"
run_solution "Deno TS" "deno run --allow-read shortestPath.ts" "$graph" "$expectedValue"
run_solution "Bun TS" "bun shortestPath.ts" "$graph" "$expectedValue"

run_solution "Node JS" "node shortestPath.js" "$graph" "$expectedValue"
run_solution "Deno JS" "deno run --allow-read shortestPath.js" "$graph" "$expectedValue"
run_solution "Bun JS" "bun shortestPath.js" "$graph" "$expectedValue"


