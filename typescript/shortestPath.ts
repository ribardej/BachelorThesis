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

function readGraphFromFile(filePath: string): { vertices: Vertex[]; startVertexId: number; goalVertexId: number } {
    const data: string = denoEnv ? Deno.readTextFileSync(filePath) : fs.readFileSync(filePath, 'utf8')
    const lines: string[] = data.split('\n');
    const [totalEdges, startVertexId, goalVertexId] = lines[0].split(' ').map(Number);

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
        goalVertexId,
    };
}

function calculateMinimalCost(graph: { vertices: Vertex[]; startVertexId: number; goalVertexId: number }): number {
    const { vertices, startVertexId, goalVertexId } = graph;
    const visited: boolean[] = [];
    const distances: number[] = [];

    for (let i = 0; i < vertices.length; i++) {
        visited[i] = false;
        distances[i] = Infinity;
    }

    distances[startVertexId] = 0;
    const queue: number[] = [startVertexId];
    while (queue.length > 0) {
        const currentVertexId = queue.shift()!;
        visited[currentVertexId] = true;
        for (const edge of vertices[currentVertexId]?.edges || []) {
            if (!visited[edge.goalVertexId] && distances[edge.goalVertexId] > distances[currentVertexId] + edge.price) {
                distances[edge.goalVertexId] = distances[currentVertexId] + edge.price;
                queue.push(edge.goalVertexId);
            }
        }
    }

    return distances[goalVertexId];
}

const filename: string = denoEnv ? Deno.args[0] : process.argv[2];
const graph = readGraphFromFile(filename);
console.log(calculateMinimalCost(graph));
