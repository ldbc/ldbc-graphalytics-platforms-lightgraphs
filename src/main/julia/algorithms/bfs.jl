using GraphIO

include("../ldbc_lg_bfs.jl")
include("../utils/simpleloader.jl")
include("../utils/benchmarkparameters.jl")

function bfs()
    println("Parsing algorithm parameters...")
    parameters = ParseBenchmarkParameters()
    edge_file = string(parameters["dataset"], "/datagen-7_5-fb.e")
    vertex_file = string(parameters["dataset"], "/datagen-7_5-fb.v")
    A = createDirGraph(parameters["directed"], false, vertex_file, edge_file)
    println("Algorithm started...")
    result = @time ldbc_lg_bfs(A, parameters["source_vertex"])
    println(result)
end

bfs()
