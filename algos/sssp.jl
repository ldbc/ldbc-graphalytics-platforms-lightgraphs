function dijkstra(graph_vertices)
    solution = dijkstra_shortest_paths(graph_vertices[1],1,graph_vertices[4]).dists
    println("\nSSSP Algorithm:")
    return solution
end

example = createDirGraph(true,true,directed_weight_v,directed_weight_e)

sol = dijkstra(example)
println(sol)
