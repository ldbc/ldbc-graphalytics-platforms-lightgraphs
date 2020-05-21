using LightGraphs

example = createDirGraph(true,false,directed_weight_v, directed_weight_e)
sol = LightGraphs.pagerank(example[1], 0.85, 15)
println(sol)