using LightGraphs

# LightGraphs does not implement bfs in a way LDBC defines the returnable value
function ldbc_lg_bfs(graph_vertices,starting_vertex)

    result = map(gdistances(graph_vertices,starting_vertex)) do x
        if x == 9223372036854775807
            return -1
        else
            return x
        end
    end

    return result

end