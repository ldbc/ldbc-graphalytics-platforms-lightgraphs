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
        node_to_label_prev = copy(node_to_label)
        for vertices in vertices(graph)
            all = vcat(outneighbors(graph,vertices),inneighbors(graph,vertices))
            if i == 1
                all_dict = countmap(all)
                x = maximum(values(all_dict))
                winners = []
                for (key, value) in all_dict
                    if value == x
                        push!(winners,key)
                    end
                end
                node_to_label["$vertices"] = minimum(winners)
            else
                all_sec = []
                for num in all
                    for (key,value) in node_to_label_prev
                        keyy = parse(Float64,key)
                            if num == keyy
                                push!(all_sec,value)
                        end
                    end
                end
                all_dict = countmap(all_sec)
                x = maximum(values(all_dict))
                winners = []
                for (key, value) in all_dict
                    if value == x
                        push!(winners,key)
                    end
                end
                node_to_label["$vertices"] = minimum(winners)
            end
        end
        node_to_label_prev = copy(node_to_label)
    end

    return node_to_label
end

example = createDirGraph(true,false,directed_weight_v, directed_weight_e)
println("\n")
println(mycdlp(example[1],2))
