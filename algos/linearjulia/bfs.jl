using MatrixMarket
using LinearAlgebra
using SparseArrays

function breadthfirstsearch(A,source::Int64)
    A = A'
    N = first(size(A))
    visited = zeros(N)
    q = zeros(N)
    q[source] = 1.0
    not_done = true
    level = 1

    while not_done && level < N
        visited += q*level
        negalt = map(x -> x == 0.0 ? 1.0 : 0.0, visited)
        t = A * q
        t = map(x -> x == 0.0 ? 0.0 : 1.0, t)
        q = negalt .* t
        not_done = sum(q) != 0.0
        level += 1
    end

    return visited .- 1
end

A = MatrixMarket.mmread("./algos/linearjulia/example-undirected.mtx")
#Adjacency
println("\n\n")
A = SparseMatrixCSC(A.m, A.n, A.colptr, A.rowval, map(x -> 1, A.nzval))
println(breadthfirstsearch(A,1))
