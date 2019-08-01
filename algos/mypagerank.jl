using LightGraphs
using GraphPlot

function mypagerank(graph::AbstractGraph, damping_factor::Float64, iter::Int64)

    # Number of vertices in the graph
    V = nv(graph)
    # Fills the |V| long array with the starting Page Rank values
    pr_current = fill((1.0/V),V)
    pr_prev = copy(pr_current)
    # Vector of dangling nodes
    dangling_nodes = Vector{}()
    # 1-damping_factor/v
    const_first_part = (1-damping_factor)/V
    const_last_part = damping_factor/V

    if iter == 0
        error("Cannot output result after 0 iterations")
    end

    #
    dangling_sum = 0
    for v in vertices(graph)
        if outdegree(graph, v) == 0
            push!(dangling_nodes, v)
            dangling_sum = dangling_sum + pr_current[v]
        end
    end


    # Dangling start
    dangling_next = 0

    # PageRank algo iteration = iter
    for i = 1 : iter
        for nodes in vertices(graph)
            summapart = 0
            if isempty(inneighbors(graph,nodes))==false
                for j in inneighbors(graph,nodes)
                    summapart = pr_prev[j]/outdegree(graph,j) + summapart
                end
                pr_current[nodes] = const_first_part + damping_factor * summapart + const_last_part * dangling_sum
            else
                pr_current[nodes] =  const_first_part + const_last_part * dangling_sum
            end

            if outdegree(graph,nodes) == 0
                dangling_next = dangling_next + pr_current[nodes]
            end

        end
        dangling_sum = dangling_next
        pr_prev = copy(pr_current)

    end

    @show pr_current

end

example = createDirGraph(true,false,directed_weight_v, directed_weight_e)

println("\n")
mypagerank(example[1],0.85,2)
