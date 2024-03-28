const fs = require('fs');

const fileCount = process.argv[2] || 500;
const fileSize = process.argv[3] || 10
const DATA_SIZE = 1024 * 1024 * fileSize;
const data = Buffer.alloc(DATA_SIZE, 1);


function syncWrite(){
    const start = Date.now();
    for(let i = 0; i < fileCount; i++) {
        const FILE_PATH = `testSync${i}.txt`;
        fs.writeFileSync(FILE_PATH, data);
    }
    console.log(`Synchronous write time: ${Date.now() - start}ms`);
}

syncWrite();
