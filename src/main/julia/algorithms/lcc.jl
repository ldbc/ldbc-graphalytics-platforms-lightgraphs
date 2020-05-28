include("../ldbc_lg_lcc.jl")
include("../utils/simpleloader.jl")
include("../utils/benchmarkparameters.jl")

using GraphIO

function lcc()
    parameters = ParseBenchmarkParameters()
    # edge_file = string(parameters["dataset"], "/example-directed.e")
    # vertex_file = string(parameters["dataset"], "/example-directed.v")
    # A = createDirGraph(parameters["directed"], false, vertex_file, edge_file)

    println("Loading graph...")
    (G, forwardmapping) = loadgraph(parameters["dataset"], "graph", GraphIO.EdgeList.EdgeListFormat())

    println("Forward mapping...")
    forwardmapping = Dict(parse(Int64, k) => v  for (k,v) in pairs(forwardmapping))

    println("Backward mapping...")
    backwardmapping = Dict(forwardmapping[k] => k for k in keys(forwardmapping))

    println("Algorithm started...")
    result = @time ldbc_lg_lcc(G)

    result_dict = Dict()
    for i in 1 : length(result)
        result_dict[backwardmapping[i]] = result[i]
    end
    result_dict = sort(result_dict)
    
    println(result_dict)
end

lcc()