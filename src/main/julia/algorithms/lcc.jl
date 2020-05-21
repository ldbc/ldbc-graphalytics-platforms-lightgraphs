include("../ldbc_lg_lcc.jl")
include("../utils/simpleloader.jl")
include("../utils/benchmarkparameters.jl")

function lcc()
    parameters = ParseBenchmarkParameters()
    edge_file = string(parameters["dataset"], "/example-directed.e")
    vertex_file = string(parameters["dataset"], "/example-directed.v")
    A = createDirGraph(parameters["directed"], false, vertex_file, edge_file)
    result = @time ldbc_lg_lcc(A[1])
    println(result)
end

lcc()