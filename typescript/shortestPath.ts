// Declare Deno namespace if targeting Deno environment
// Note that this does not provide full compatibility with Node.js
declare namespace Deno {
    function readTextFileSync(filePath: string): string;
    export const args: string[];
}

const denoEnv = typeof Deno !== 'undefined';
const fs = denoEnv ? undefined : require('fs');

type Vertex = {
    id: number;
    edges: Edge[];
};

type Edge = {
    goalVertexId: number;
    price: number;
};

function readGraphFromFile(filePath: string): { vertices: Vertex[]; startVertexId: number; finishVertexId: number } {
    const data: string = denoEnv ? Deno.readTextFileSync(filePath) : fs.readFileSync(filePath, 'utf8')
    const lines: string[] = data.split('\n');
    const [totalEdges, startVertexId, finishVertexId] = lines[0].split(' ').map(Number);

    const vertices: Vertex[] = [];
    for (let i = 1; i <= totalEdges; i++) {
        const [start, goal, price] = lines[i].split(' ').map(Number);
        if (!vertices[start]) {
            vertices[start] = { id: start, edges: [] };
        }
        vertices[start].edges.push({ goalVertexId: goal, price });
    }

    return {
        vertices,
        startVertexId,
        finishVertexId,
    };
}

function calculateMinimalCost(graph: { vertices: Vertex[]; startVertexId: number; finishVertexId: number }): number {
    const { vertices, startVertexId, finishVertexId } = graph;
    const visited: boolean[] = Array(vertices.length).fill(false);
    const discovered: boolean[] = Array(vertices.length).fill(false);
    const distances: number[] = Array(vertices.length).fill(Infinity);

    distances[startVertexId] = 0;
    const queue: number[] = [startVertexId];
    while (queue.length > 0) {
        queue.sort((a, b) => distances[a] - distances[b]);
        const currentVertexId = queue.shift()!;
        if (currentVertexId === finishVertexId) break;
        if (distances[currentVertexId] === Infinity) break;
        visited[currentVertexId] = true;
        
        for (const edge of vertices[currentVertexId].edges) {
            const goalId = edge.goalVertexId;
            if (!visited[goalId] && distances[goalId] > distances[currentVertexId] + edge.price) {
                distances[goalId] = distances[currentVertexId] + edge.price;
                if (!discovered[goalId]) {
                    queue.push(goalId);
                    discovered[goalId] = true;
                }
            }
        }
    }
    return distances[finishVertexId];
}

const filename: string = denoEnv ? Deno.args[0] : process.argv[2];
const graph = readGraphFromFile(filename);
console.log(calculateMinimalCost(graph));
