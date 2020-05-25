using LightGraphs


# Create directed graph from .v and .e files
function createDirGraph(is_directed::Bool,is_weighted::Bool,vertexfile,edgefile)
    if is_directed
        graph = DiGraph()
    else
        graph = Graph()
    end

    println("Loading the graph...")

    # Array of vertex names
    vertices = []

    # Dictionary for labels to actual node numbers
    label_to_node = Dict()

    # Open files   
    vertexfile = open(vertexfile)
    edgefile = open(edgefile)

    # Create a vertex for each line from .e file
    lines = readlines(vertexfile)
    i = 1
    nodecount = 0
    for l in lines
        nodecount = nodecount + 1
        LightGraphs.add_vertex!(graph)
        push!(vertices,parse(Int64,l))
        label_to_node["$i"] = parse(Int64,l)
        i = i + 1
    end


    # Add edges to the existing vertices
    lines = readlines(edgefile)

    if is_weighted
        weight_matrix = zeros(Float64, nodecount, nodecount)
        for l in lines
            s = split(l ,r"[\s]")
            source = parse(Int64, s[1])
            dest = parse(Int64, s[2])
            weight_current = parse(Float64, s[3])
            if is_directed
                weight_matrix[(findfirst(x -> x==source, vertices)),(findfirst(x -> x==dest, vertices))] = weight_current
            else
                weight_matrix[(findfirst(x -> x==source, vertices)),(findfirst(x -> x==dest, vertices))] = weight_current
                weight_matrix[(findfirst(x -> x==dest, vertices)),(findfirst(x -> x==source, vertices))] = weight_current
            end

            LightGraphs.add_edge!(graph, (findfirst(x -> x==source, vertices)), (findfirst(x -> x==dest, vertices)))
        end
    else
        for l in lines
            s = split(l ,r"[\s]")
            source = parse(Int64, s[1])
            dest = parse(Int64, s[2])
            LightGraphs.add_edge!(graph, (findfirst(x -> x==source, vertices)), (findfirst(x -> x==dest, vertices)))
        end
    end

    if is_weighted
        graph_vertices = [graph,vertices,label_to_node,weight_matrix]
    else
        graph_vertices = [graph,vertices, label_to_node]
    end

    # Close files
    close(vertexfile)
    close(edgefile)

    println("The graph has been loaded...")

    return graph_vertices
end
