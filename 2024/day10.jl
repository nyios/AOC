function read_input()
    # Read the grid from a file
    return permutedims(hcat([parse.(Int, split(line, "")) for line in readlines("input.txt")]...))
end

function construct_dag(grid)
    rows, cols = size(grid)
    graph = Dict()
    
    # Define orthogonal directions: up, down, left, right
    directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
    
    for r in 1:rows
        for c in 1:cols
            current = grid[r, c]
            node = (r, c)
            graph[node] = []  # Initialize adjacency list
            # Check orthogonal neighbors
            for (dr, dc) in directions
                nr, nc = r + dr, c + dc
                # Ensure neighbor is within bounds
                if nr >= 1 && nr <= rows && nc >= 1 && nc <= cols
                    neighbor = grid[nr, nc]
                    # Add edge if the difference is exactly 1
                    if neighbor - current == 1
                        push!(graph[node], (nr, nc))
                    end
                end
            end
        end
    end
    return graph
end

function task1(graph, grid)
    start_nodes = []
    for node in keys(graph)
        if grid[Tuple(node)...] == 0
            push!(start_nodes, node)
        end
    end
    counter = 0
    for start in start_nodes
        reachable_nines = Set() # for each start node keep track how many nines are reachable
        current_nodes = copy(graph[start])
        while !isempty(current_nodes)
            current = popfirst!(current_nodes)
            if grid[Tuple(current)...] == 9
                push!(reachable_nines, current)
            end
            if current in keys(graph)
                push!(current_nodes, graph[current]...)
            end
        end
        counter += length(reachable_nines)
    end
    return counter
end

function task2(graph, grid)
    start_nodes = []
    for node in keys(graph)
        if grid[Tuple(node)...] == 0
            push!(start_nodes, node)
        end
    end
    counter = 0
    for start in start_nodes
        current_nodes = copy(graph[start])
        while !isempty(current_nodes)
            current = popfirst!(current_nodes)
            if grid[Tuple(current)...] == 9
                counter += 1
            end
            if current in keys(graph)
                push!(current_nodes, graph[current]...)
            end
        end
    end
    return counter
end

grid = read_input()
g = construct_dag(grid)
println(task1(g, grid))
println(task2(g, grid))


