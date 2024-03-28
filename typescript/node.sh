#!/bin/bash

program=shortestPath
filename=$1 

tsc $program.ts
node $program.js $filename
