using LightGraphs
using GraphPlot
using StatsBase

function mycdlp(graph::AbstractGraph, iter::Int64)

    # Dictionary that cointains the label for each node which is going to be updated
    node_to_label = Dict()
    for i = 1 : nv(graph)
        node_to_label["$i"] = i
    end


    # Calculates the labels for each node in iteartion i
    for i = 1 : iter
        for vertices in vertices(graph)
            all = vcat(outneighbors(graph,node_to_label["$vertices"]),inneighbors(graph,node_to_label["$vertices"]))
            all_dict = countmap(all)
            x = maximum(values(all_dict))
            winners = []
            for (key, value) in all_dict
                if value == x
                    push!(winners,key)
                end
            end
            node_to_label["$vertices"]= minimum(winners)
        end
    end

    for (key, value) in node_to_label
           println(key, " ==> ", value)
       end
end

example = createDirGraph(true,false,directed_weight_v, directed_weight_e)
println("\n")
mycdlp(example[1],2)
