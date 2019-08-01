function pagerank1(
    g::AbstractGraph{U},
    α=0.85,
    n::Integer=2,
    ) where U <: Integer
    α_div_outdegree = Vector{Float64}(undef,nv(g))
    dangling_nodes = Vector{U}()
    for v in vertices(g)
        if outdegree(g, v) == 0
            push!(dangling_nodes, v)
        end
        α_div_outdegree[v] = (α/outdegree(g, v))
    end
    N = Int(nv(g))
    # solution vector and temporary vector
    x = fill(1.0 / N, N)
    xlast = copy(x)
    println(dangling_nodes)
    for _ in 1:n
        dangling_sum = 0.0
        for v in dangling_nodes
            dangling_sum += x[v]
        end
        # flow from teleprotation

        for v in vertices(g)
            xlast[v] = (1 - α + α * dangling_sum) * (1.0 / N)
        end
        # flow from edges

        for v in vertices(g)
            for u in inneighbors(g, v)
                xlast[v] += (x[u] * α_div_outdegree[u])
            end
        end


        # l1 change in solution convergence criterion
        err = 0.0
        for v in vertices(g)
            err += abs(xlast[v] - x[v])
            x[v] = xlast[v]
        end

        return xlast

    end
    error("Pagerank did not converge after $n iterations.") # TODO 0.7: change to InexactError with appropriate msg.
end
