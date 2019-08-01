"""
    label_propagation(g, maxiter=1000)
Community detection using the label propagation algorithm.
Return two vectors: the first is the label number assigned to each node, and
the second is the convergence history for each node. Will return after
`maxiter` iterations if convergence has not completed.
### References
- [Raghavan et al.](http://arxiv.org/abs/0709.2938)
"""
function label_propagation2(g::AbstractGraph{T}, maxiter=1000) where T
    n = nv(g)
    n == 0 && return (T[], Int[])

    label = collect(one(T):n)
    active_vs = BitSet(vertices(g))
    c = NeighComm(collect(one(T):n), fill(-1, n), one(T))
    convergence_hist = Vector{Int}()
    random_order = Vector{T}(undef, n)
    i = 0
    while !isempty(active_vs) && i < maxiter
        num_active = length(active_vs)
        push!(convergence_hist, num_active)
        i += 1

        # processing vertices in random order
        for (j, node) in enumerate(active_vs)
            random_order[j] = node
        end
        range_shuffle!(1:num_active, random_order)
        @inbounds for j = 1:num_active
            u = random_order[j]
            old_comm = label[u]
            label[u] = vote!(g, label, c, u)
            if old_comm != label[u]
                for v in outneighbors(g, u)
                    push!(active_vs, v)
                end
            else
                delete!(active_vs, u)
            end
        end
    end
    fill!(c.neigh_cnt, 0)
    renumber_labels!(label, c.neigh_cnt)
    label, convergence_hist
end

"""
    NeighComm{T}
Type to record neighbor labels and their counts.
"""
mutable struct NeighComm{T<:Integer}
    neigh_pos::Vector{T}
    neigh_cnt::Vector{Int}
    neigh_last::T
end

"""
    vote!(g, m, c, u)
Return the label with greatest frequency.
"""
function vote!(g::AbstractGraph, m::Vector, c::NeighComm, u::Integer)
    @inbounds for i = 1:c.neigh_last - 1
        c.neigh_cnt[c.neigh_pos[i]] = -1
    end
    c.neigh_last = 1
    c.neigh_pos[1] = m[u]
    c.neigh_cnt[c.neigh_pos[1]] = 0
    c.neigh_last = 2
    max_cnt = 0
    for neigh in outneighbors(g, u)
        neigh_comm = m[neigh]
        if c.neigh_cnt[neigh_comm] < 0
            c.neigh_cnt[neigh_comm] = 0
            c.neigh_pos[c.neigh_last] = neigh_comm
            c.neigh_last += 1
        end
        c.neigh_cnt[neigh_comm] += 1
        if c.neigh_cnt[neigh_comm] > max_cnt
            max_cnt = c.neigh_cnt[neigh_comm]
        end
    end
    # ties breaking not randomly
    return minimum(map(k -> c.neigh_pos[k], findall(i -> i == max_cnt, c.neigh_cnt)))


end

function renumber_labels!(membership::Vector{T}, label_counters::Vector{Int}) where {T <: Integer}
    N = length(membership)
    (maximum(membership) > N || minimum(membership) < 1) && throw(ArgumentError("Labels must between 1 and |V|")) # TODO 0.7: change to DomainError?
    j = one(T)
    @inbounds for i = 1:length(membership)
        k::T = membership[i]
        if k >= 1
            if label_counters[k] == 0
                # We have seen this label for the first time
                label_counters[k] = j
                k = j
                j += one(j)
            else
                k = label_counters[k]
            end
        end
        membership[i] = k
    end
end
