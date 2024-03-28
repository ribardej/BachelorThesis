#!/bin/bash

nodeFib=$( { time node fibonacci.js; } 2>&1 | grep real | awk '{print $2}' )
nodeMatrix=$( node matrixMult.js )

denoFib=$( { time deno run fibonacci.js; } 2>&1 | grep real | awk '{print $2}' )
denoMatrix=$( deno run matrixMult.js )

bunFib=$( { time bun fibonacci.js; } 2>&1 | grep real | awk '{print $2}' )
bunMatrix=$( bun matrixMult.js )

echo -e "1) Recursive calculation of 43. fibonnaci number\n Elapsed times:\n  Node.js: " $nodeFib "\n  Deno: " $denoFib "\n  Bun: " $bunFib "\n"
echo -e "2) 10x10 Matrix multiplication for 1s\n Total iterations made:\n  Node.js: " $nodeMatrix "\n  Deno: " $denoMatrix "\n  Bun: " $bunMatrix "\n"