using MatrixMarket
using LinearAlgebra
using SparseArrays

function  pageRank(A, iter::Int64, d::Float64)

    N = first(size(A))
    degrees = A*ones(N)
    D = map(x -> x == 0 ? 1.0 : 0.0, degrees)

    pr = ones(N)/N
    teleport = (1-d) / N
    for i = 1 : iter
        importance = d * A' * (pr ./ degrees)
        dangling = d/N * ((pr.*D)'*ones(N))
        pr = teleport .+ importance .+ dangling
    end

    return pr
end

A = MatrixMarket.mmread("./algos/linearjulia/example-undirected.mtx")
#Adjacency
A = SparseMatrixCSC(A.m, A.n, A.colptr, A.rowval, map(x -> 1, A.nzval))
println(pageRank(A,2,0.85))
