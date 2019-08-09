using LightGraphs
using GraphPlot

function mylcc(graph::AbstractGraph)

    lcc = []
    for vertex in vertices(graph)

        neighs = unique!(vcat(inneighbors(graph,vertex),outneighbors(graph,vertex)))
        Nv = length(neighs)
        tcount = 0
        @show vertex neighs Nv

        if length(neighs)<=1
            push!(lcc,0.0)
            continue
        end

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
