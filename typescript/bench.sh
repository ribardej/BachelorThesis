#!/bin/bash

graph=$1
expectedValue=$2

nodeTs=$( { time bash node.sh $graph; } 2>&1 | grep real | awk '{print $2}' )
nodeJs=$( { time node shortestPath.js $graph; } 2>&1 | grep real | awk '{print $2}' )
nodeTsOutput=$(node shortestPath.js $graph)
if [[ $nodeTsOutput == $expectedValue ]]; then
    echo -e "Node.js TypeScript solution is correct. elapsed times:\n typescript: " $nodeTs "\n javascript: " $nodeJs "\n"
else
    echo "Node.js TypeScript solution is incorrect. Expected: $expectedValue, Actual: $nodeTsOutput"
    exit 1
fi

denoTs=$( { time deno run --allow-read shortestPath.ts $graph; } 2>&1 | grep real | awk '{print $2}' )
denoJs=$( { time deno run --allow-read shortestPath.js $graph; } 2>&1 | grep real | awk '{print $2}' )
denoTsOutput=$(deno run --allow-read shortestPath.ts $graph)
if [[ $denoTsOutput == $expectedValue ]]; then
    echo -e "Deno TypeScript solution is correct. elapsed times:\n typescript: " $denoTs "\n javascript: " $denoJs "\n"
else
    echo "Deno TypeScript solution is incorrect. Expected: $expectedValue, Actual: $denoTsOutput"
    exit 1
fi

bunTs=$( { time bun shortestPath.ts $graph; } 2>&1 | grep real | awk '{print $2}' )
bunJs=$( { time bun shortestPath.js $graph; } 2>&1 | grep real | awk '{print $2}' )
bunTsOutput=$(bun shortestPath.ts $graph)
if [[ $bunTsOutput == $expectedValue ]]; then
    echo -e "Bun TypeScript solution is correct. elapsed times:\n typescript: " $bunTs "\n javascript: " $bunJs "\n"
else
    echo "Bun TypeScript solution is incorrect. Expected: $expectedValue, Actual: $bunTsOutput"
    exit 1
fi
