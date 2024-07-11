using DataStructures

# Dijkstra's algorithm using a priority queue
function Dijkstra(graph, start)
    # Initialization
    n = length(graph)
    dist = fill(Inf, n)
    prev = fill(0, n)
    dist[start] = 0
    
    # Create priority queue and add start node
    pq = PriorityQueue{Int, Float64}()
    enqueue!(pq, start, 0.0)
    
    # Go over graph
    while !isempty(pq)
        u = dequeue!(pq)
        
        println("Visiting node: ",u)
        
        # Visit neighbors of root node
        for (v, weight) in graph[u]
            alt = dist[u] + weight
            println("   Neighbor ",v," has distance ",alt)
            
            # If shorter distance, add it or update queue
            if alt < dist[v]
                dist[v] = alt
                prev[v] = u
                if v in keys(pq)
                    pq[v] = alt
                else
                    enqueue!(pq, v, alt)
                end
            end
        end
    end
    
    return dist, prev
end

# Graph
graph = [
    [(2, 4), (3, 2)],                         # Node 1
    [(1, 4), (3, 1), (4, 5)],                 # Node 2
    [(1, 2), (2, 1), (4, 8), (5, 10)],        # Node 3
    [(2, 5), (3, 8), (5, 2), (6, 6)],         # Node 4
    [(3,10), (4, 2), (6, 3)],                 # Node 5
    [(4, 6)]                                  # Node 6
]

# Compute
start_node = 1
distances, predecessors = Dijkstra(graph, start_node)

# Print results
println("")
println("Distances from node $start_node:")
for (node, distance) in enumerate(distances)
    println("To node $node: $distance")
end

println("\nPredecessors:")
for (node, pred) in enumerate(predecessors)
    println("Node $node: $pred")
end
