using GraphPlot
using LightGraphs

function mybfs(graph_vertices,starting_vertex)

    result = gdistances(graph_vertices[1],starting_vertex)

    println("\nBFS Algorithm:")
    for l in result
        current = graph_vertices[3]
        println("Dist to node whatev: $l")
    end

end


example = createDirGraph(true,false,directed_weight_v, directed_weight_e)
mybfs(example,1)
