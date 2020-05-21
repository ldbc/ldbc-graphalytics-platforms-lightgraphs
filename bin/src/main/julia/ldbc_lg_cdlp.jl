using LightGraphs
using StatsBase

function ldbc_lg_cdlp(graph::AbstractGraph, iter::Int64)

    # Dictionary init that cointains the label for each node which is going to be updated
    node_to_label = Dict()
    for i = 1 : nv(graph)
        node_to_label["$i"] = i
    end
    # A copy Dictionary that will help us to keep track of the labels when iter > 1, updated at the end of the iteration
    node_to_label_prev = copy(node_to_label)

    # Calculates the labels for each node in iteartion i
    for i = 1 : iter
        # Going through each vertex in iter i
        for vertices in vertices(graph)
            # Returns an array that contains all neighbors (in/out neighbors counted twice)
            if is_directed(graph) == true
                all = vcat(outneighbors(graph,vertices),inneighbors(graph,vertices))
            else
                all = neighbors(graph,vertices)
            end
            all_sec = []
            # Goes through the all array and the node_to_label_prev dict to find the current labels of the neighbors
            for num in all
                for (key,value) in node_to_label_prev
                    keyy = parse(Float64,key)
                        if num == keyy
                            push!(all_sec,value)
                    end
                end
            end
            # Creates a Dictionary that contains the number of labels in the neighborhood e.g 3 => 2, 4 => 1
            all_dict = countmap(all_sec)
            # Searches for the max value
            x = maximum(values(all_dict))
            # The "heaviest" labels in the neighborhood
            winners = []
            for (key, value) in all_dict
                if value == x
                    push!(winners,key)
                end
            end
            # If we have more than 1 winner, it picks the minimum
            node_to_label["$vertices"] = minimum(winners)

        end
        node_to_label_prev = copy(node_to_label)
    end

    return node_to_label
end
