using LightGraphs

function ldbc_lg_wcc(graph_vertices)

    result = weakly_connected_components(graph_vertices[1])

    for i = 1:length(result)
        min = string(Base.minimum(result[i]))
        actual_node = graph_vertices[3]["$min"]
        println("Minimum value in component $i is $actual_node ")
    end

end