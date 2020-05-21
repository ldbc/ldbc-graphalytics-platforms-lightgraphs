function cdlp(graph_vertices)

result = label_propagation(graph_vertices[1],5)
println("\nCDLP Algorithm:")

println(result)


end

example = createDirGraph(false,false,undirected_unweight_v, undirected_unweight_e)

cdlp(example)
