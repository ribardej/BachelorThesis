let matrixA = [
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
    [10, 1, 2, 3, 4, 5, 6, 7, 8, 9],
    [9, 10, 1, 2, 3, 4, 5, 6, 7, 8],
    [8, 9, 10, 1, 2, 3, 4, 5, 6, 7],
    [7, 8, 9, 10, 1, 2, 3, 4, 5, 6],
    [6, 7, 8, 9, 10, 1, 2, 3, 4, 5],
    [5, 6, 7, 8, 9, 10, 1, 2, 3, 4],
    [4, 5, 6, 7, 8, 9, 10, 1, 2, 3],
    [3, 4, 5, 6, 7, 8, 9, 10, 1, 2],
    [2, 3, 4, 5, 6, 7, 8, 9, 10, 1]
];

function matrixMultiplication(a, b) {
    const result = [];
    for (let i = 0; i < a.length; i++) {
        result[i] = [];
        for (let j = 0; j < b[0].length; j++) {
            let sum = 0;
            for (let k = 0; k < a[0].length; k++) {
                sum += a[i][k] * b[k][j];
            }
            result[i][j] = sum;
        }
    }
    return result;
}


function cpuBenchmark() {
    const start = Date.now();
    let count = 0;
    while(Date.now() - start < 1000) {
        matrixMultiplication(matrixA, matrixA);
        count++;
    }
    console.log(count);
}

cpuBenchmark();