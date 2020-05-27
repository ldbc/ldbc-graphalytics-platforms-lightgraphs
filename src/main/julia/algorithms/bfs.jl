using GraphIO

include("../ldbc_lg_bfs.jl")
include("../utils/simpleloader.jl")
include("../utils/benchmarkparameters.jl")

function bfs()
    println("Parsing algorithm parameters...")
    parameters = ParseBenchmarkParameters()
    # edge_file = string(parameters["dataset"], "/example-directed.e")
    # vertex_file = string(parameters["dataset"], "/example-directed.v")
    # A = createDirGraph(parameters["directed"], false, vertex_file, edge_file)
    A = loadgraph("/Users/adamatyi/graphs/example-directed.txt", "graph", GraphIO.EdgeList.EdgeListFormat())
    println(A)
    println("Algorithm started...")
    result = @time ldbc_lg_bfs(A, parameters["source_vertex"])
    println(result)
end

bfs()
