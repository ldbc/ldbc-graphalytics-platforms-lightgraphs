function pagerank2(graph_vertices)

    result = pagerank(graph_vertices[1],0.85,10)
    println("\nPageRank Algorithm:")
    return result
end

example = createDirGraph(true,false,directed_weight_v,
directed_weight_e)

println(pagerank2(example))
