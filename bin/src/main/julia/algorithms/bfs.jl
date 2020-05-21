include("../ldbc_lg_bfs.jl")
include("../utils/simpleloader.jl")
include("../utils/benchmarkparameters.jl")

function bfs()
    parameters = ParseBenchmarkParameters()
    edge_file = string(parameters["dataset"], "/example-undirected.e")
    vertex_file = string(parameters["dataset"], "/example-undirected.v")
    A = createDirGraph(parameters["directed"], false, vertex_file, edge_file)
    result = @time ldbc_lg_bfs(A, parameters["source_vertex"])
    println(result)
end

bfs()
