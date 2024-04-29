const fileCount = Deno.args[0] || 500;
const fileSize = Deno.args[1] || 10
const DATA_SIZE = 1024 * 1024 * fileSize;
const data = new Uint8Array(DATA_SIZE).fill(1);

function syncWrite(){
    for(let i = 0; i < fileCount; i++) {
        const FILE_PATH = `testSync${i}.txt`;
        Deno.writeFileSync(FILE_PATH, data);
    }
}

syncWrite();