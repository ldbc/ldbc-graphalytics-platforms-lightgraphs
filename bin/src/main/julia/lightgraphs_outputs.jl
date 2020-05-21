using LightGraphs
include("./utils/filepaths.jl")
include("./utils/simpleloader.jl")
include("./ldbc_lg_bfs.jl")
include("./ldbc_lg_pagerank.jl")
include("./ldbc_lg_wcc.jl")
include("./ldbc_lg_cdlp.jl")
include("./ldbc_lg_lcc.jl")

# LDBC example graphs. Params: (is_directed, is_weighted, vertex_file_path, edge_file_path)
# Paths at ./filepaths.jl
example_directed_weighted = createDirGraph(true,true,directed_weighted_v,directed_weighted_e)
example_directed_unweighted = createDirGraph(true,false,directed_unweighted_v,directed_unweighted_e)
example_undirected_weighted = createDirGraph(false,true,undirected_weighted_v,undirected_weighted_e)
example_undirected_unweighted = createDirGraph(false,false,undirected_unweighted_v,undirected_unweighted_e)

# BFS
println("Breadth-First-Search algorithm (shows -1 if the vertex is unreachable)")

@time bfs_directed_solution = ldbc_lg_bfs(example_directed_unweighted, 1)
println("| Directed unweighted output: ",bfs_directed_solution)

@time bfs_undirected_solution = ldbc_lg_bfs(example_undirected_unweighted, 1)
println("| Undirected unweighted output: ",bfs_undirected_solution)

println("")
# PR
println("PageRank algorithm")

@time pr_directed_solution = ldbc_lg_pagerank(example_directed_unweighted[1],0.85,2)
println("| Directed unweighted output: ", pr_directed_solution)

@time pr_undirected_solution = ldbc_lg_pagerank(example_undirected_unweighted[1],0.85,2)
println("| Unirected unweighted output: ", pr_undirected_solution)

println("")
# WCC
println("Weekly Connected Components algorithm")

print("| Directed unweighted output: ")
@time ldbc_lg_wcc(example_directed_unweighted)

print("| Unirected unweighted output: ")
@time ldbc_lg_wcc(example_undirected_unweighted)

println("")
# CDLP

println("Community Detection using Label Propagation algorithm")

@time cdlp_directed_solution = ldbc_lg_cdlp(example_directed_unweighted[1], 2)
println("| Directed unweighted output: ", cdlp_directed_solution)

# cdlp_undirected_solution = ldbc_lg_cdlp(example_undirected_unweighted[1], 2)
# println("| Undirected unweighted output: ", cdlp_undirected_solution)
println("| Undirected unweighted output: ####")

println("")
# LCC 

println("Local Clustering Coefficient algorithm")

@time lcc_directed_solution = ldbc_lg_lcc(example_directed_unweighted[1])
println("| Directed unweighted output: ", lcc_directed_solution)

@time lcc_undirected_solution = ldbc_lg_lcc(example_undirected_unweighted[1])
println("| Undirected unweighted output: ", lcc_undirected_solution)

println("")
# SSSP

println("Single-Source Shortest Path algorithm")

@time sssp_directed_solution = dijkstra_shortest_paths(example_directed_weighted[1],1,example_directed_weighted[4]).dists
sssp_directed_solution = map(x -> round(x, digits=2), sssp_directed_solution)
println("| Directed weighted output: ", sssp_directed_solution)

@time sssp_undirected_solution = dijkstra_shortest_paths(example_undirected_weighted[1],1,example_undirected_weighted[4]).dists
sssp_undirected_solution = map(x -> round(x, digits=2), sssp_undirected_solution)
println("| Undirected weighted output: ", sssp_undirected_solution)







