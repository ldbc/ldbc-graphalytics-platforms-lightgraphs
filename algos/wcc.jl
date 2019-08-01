using LightGraphs
using GraphPlot

function wcc(graph_vertices)

    result = weakly_connected_components(graph_vertices[1])
    println("\nWCC Algorithm:")

    for i = 1:length(result)
        min = string(Base.minimum(result[i]))
        actual_node = graph_vertices[3]["$min"]
        println("Minimum value in component $i is $actual_node ")
    end



end

#example2 = createDirGraph(false,"Code/Atom/Julia/example-undirected/example-unweighted.v",
#"Code/Atom/Julia/example-undirected/example-unweighted.e")

example2 = createDirGraph(true,false,undirected_weight_v, undirected_weight_e)

wcc(example2)
