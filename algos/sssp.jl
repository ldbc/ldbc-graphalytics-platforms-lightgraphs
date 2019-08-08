function dijkstra(graph_vertices)
    solution = dijkstra_shortest_paths(graph_vertices[1],1,graph_vertices[4]).dists
    println("\nSSSP Algorithm:")
    return solution
end

example = createDirGraph(false,true,undirected_weight_v,undirected_weight_e)
println(dijkstra(example))
