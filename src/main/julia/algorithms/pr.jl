include("../ldbc_lg_pagerank.jl")
include("../utils/simpleloader.jl")
include("../utils/benchmarkparameters.jl")

using GraphIO

function pagerank()
    parameters = ParseBenchmarkParameters()
    # edge_file = string(parameters["dataset"], "/wiki-Talk.e")
    # vertex_file = string(parameters["dataset"], "/wiki-Talk.v")
    # A = createDirGraph(parameters["directed"], false, vertex_file, edge_file)
    A = loadgraph("/Users/adamatyi/graphs/example-directed.txt", "graph_key", GraphIO.EdgeList.EdgeListFormat())
    result = @time ldbc_lg_pagerank(A, parameters["damping_factor"], parameters["max_iteration"])
    println(result)
end

pagerank()
