#!/bin/bash

fileCount=$1
fileSize=$2

nodeSync=$( { time node nodeSync.js $fileCount $fileSize;} 2>&1 | grep real | awk '{print $2}' )
nodeAsync=$( { time node nodeAsync.js $fileCount $fileSize;} 2>&1 | grep real | awk '{print $2}' )
rm test*

denoSync=$( { time deno run --allow-write denoSync.js $fileCount $fileSize;} 2>&1 | grep real | awk '{print $2}' )
denoAsync=$( { time deno run --allow-write denoAsync.js $fileCount $fileSize;} 2>&1 | grep real | awk '{print $2}' )
rm test*

bunSync=$( { time bun bunSync.js $fileCount $fileSize;} 2>&1 | grep real | awk '{print $2}' )
bunAsync=$( { time bun bunAsync.js $fileCount $fileSize;} 2>&1 | grep real | awk '{print $2}' )
rm test*

echo -e "1) Synchronous write of" $fileCount "files of size" $fileSize "MB\n Elapsed times:\n  Node.js: " $nodeSync "\n  Deno: " $denoSync "\n  Bun: " $bunSync "\n"
echo -e "2) Aynchronous write of" $fileCount "files of size" $fileSize "MB\n Elapsed times:\n  Node.js: " $nodeAsync "\n  Deno: " $denoAsync "\n  Bun: " $bunAsync "\n"
