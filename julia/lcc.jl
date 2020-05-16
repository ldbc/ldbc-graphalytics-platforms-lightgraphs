function lcc(graph_vertices)

    result = local_clustering_coefficient(graph_vertices[1],2)
    println("\nLCC Algorithm:")
    println(result)

end



example = createDirGraph(true,false,undirected_weight_v, undirected_weight_e)

lcc(example)
