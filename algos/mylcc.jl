using LightGraphs
using GraphPlot

function mylcc(graph::AbstractGraph)
    # Array that stores the outpot of the LCC algorithm for each vertex
    lcc = []
    # Iterates through vertices of the graph pushing its LCC(vertex) in the lcc[] array
    for vertex in vertices(graph)
        # Array of one vertex's neighbors
        neighs = unique!(vcat(inneighbors(graph,vertex),outneighbors(graph,vertex)))
        # Degree of a vertex / if directed i->j j->i counted once
        Nv = length(neighs)
        # Trianle count
        tcount = 0
        @show vertex neighs Nv

        # If a vertex has les than 2 neighbors its pushing 0.0 as its LCC(vertex) value
        if length(neighs)<=1
            push!(lcc,0.0)
            continue
        end

        # Itarets through the neigbors of neighbors
        for i in neighs
            neighs_neighs = outneighbors(graph,i)
            for j in neighs_neighs
                if j ∈ neighs
                    tcount = tcount + 1
                end
            end
        end
        push!(lcc,tcount/(Nv*(Nv-1)))
    end

    return lcc
end

example = createDirGraph(false,false,undirected_weight_v,undirected_weight_e)
println(mylcc(example[1]))
