include("../utils/benchmarkparameters.jl")
include("../ldbc_lg_wcc.jl")

using GraphIO
using LightGraphs

function wcc()
    parameters = ParseBenchmarkParameters()
    println("Loading graph...")
    (G, forwardmapping) = loadgraph(parameters["dataset"], "graph", GraphIO.EdgeList.EdgeListFormat())

    println("Forward mapping...")
    forwardmapping = Dict(parse(Int64, k) => v  for (k,v) in pairs(forwardmapping))

    println("Backward mapping...")
    backwardmapping = Dict(forwardmapping[k] => k for k in keys(forwardmapping))

    println("Algorithm started...")
    result = @time weakly_connected_components(G)

    result_dict = Dict()
    for i in 1 : length(result)
        result_dict[backwardmapping[i]] = result[i]
    end
    result_dict = sort(result_dict)
    
    println(result_dict)
end

wcc()