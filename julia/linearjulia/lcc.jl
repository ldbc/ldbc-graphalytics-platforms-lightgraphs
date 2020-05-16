using MatrixMarket
using LinearAlgebra
using SparseArrays

function localClusteirngCoefficientUndirected(A)

    degree = sum(A,dims=1)[:]
    denom = degree .* (degree .- 1)
    triangles = (A * A) .* A
    numerator = sum(triangles,dims=1)[:]
    lcc = numerator ./ denom
    lcc = map(x -> isnan(x) ? 0.0 : x,lcc)
    return Vector(lcc)

end

A = MatrixMarket.mmread("./algos/linearjulia/example-undirected.mtx")
#Adjacency
A = SparseMatrixCSC(A.m, A.n, A.colptr, A.rowval, map(x -> 1, A.nzval))
println(localClusteirngCoefficientUndirected(A))
