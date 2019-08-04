using GraphPlot
using LightGraphs

function mybfs(graph_vertices,starting_vertex)

    result = map(gdistances(graph_vertices[1],starting_vertex)) do x
        if x == 9223372036854775807
            return -1
        else
            return x
        end
    end

    return result

end


example = createDirGraph(false,false,undirected_weight_v, undirected_weight_e)
println(mybfs(example,1))
