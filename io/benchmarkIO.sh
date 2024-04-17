#!/bin/bash

fileCount=$1
fileSize=$2
echo -e "Benchmarking write of" $fileCount "files of size" $fileSize "MB\n"

function run() {
    local runtimeName=$1
    local cmd=$2

    local runtime=$( { time $cmd $fileCount $fileSize;} 2>&1 | grep real | awk '{print $2}' )
    echo -e "$runtimeName: $runtime"
    rm test*
}

run "Node.js synchronously" "node nodeSync.js"
run "Node.js asynchronously" "node nodeAsync.js"

run "Deno synchronously" "deno run --allow-write denoSync.js"
run "Deno asynchronously" "deno run --allow-write denoAsync.js"

run "Bun synchronously" "bun bunSync.js"
run "Bun asynchronously" "bun bunAsync.js"
