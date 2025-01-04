using DataStructures

function read_input()
    lines = readlines("input.txt")
    grid = zeros(Int, (length(lines), length(lines[1])))
    src = (0, 0)
    dst = (0, 0)
    for (i, line) in enumerate(lines)
        for (j, c) in enumerate(line)
            if c == '#'
                grid[i, j] = 1
            elseif c == 'S'
                src = (i, j)
            elseif c == 'E'
                dst = (i, j)
            end
        end
    end
    return grid, src, dst
end

function add(a::Tuple{Int, Int}, b::Tuple{Int, Int})
    return a[1] + b[1], a[2] + b[2]
end

function sub(a::Tuple{Int, Int}, b::Tuple{Int, Int})
    return a[1] - b[1], a[2] - b[2]
end

function task1(grid, src, dst)
    directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]
    direction = (0, 1) #facing east
    # PriorityQueue with distances as priorities
    pq = PriorityQueue()
    enqueue!(pq, (src, direction), 0)
    distances = Dict()
    distances[src] = 0
    prevs = Dict()

    while !isempty(pq)
        current, _ = peek(pq)
        current_pos = current[1]
        current_dir = current[2]
        if  current_pos == dst
            return distances[current_pos], prevs
        end
        dequeue!(pq)

        neighbors = [(add(current_pos, d), d == current_dir ? 1 : 1001) for d in directions if grid[add(current_pos, d)...] == 0]
        #println("Neigbors and weights for position $current_pos, facing direction: $current_dir:\n $neighbors\n")
#        weights = [sub(current_pos, pos) == current_dir ? 1 : 1000]

        for (v, weight) in neighbors  # Iterate neighbors
            new_dist = distances[current_pos] + weight
            if !(v in keys(distances)) || new_dist < distances[v]
                distances[v] = new_dist
                prevs[v] = current_pos
                enqueue!(pq, (v, sub(v, current_pos)), new_dist)
            end
        end
    end
end

function task2(grid, src, dst)
    directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]
    direction = (0, 1) #facing east
    # PriorityQueue with distances as priorities
    pq = PriorityQueue()
    enqueue!(pq, (src, direction), 0)
    distances = Dict()
    distances[(src, direction)] = 0
    prevs = Dict()

    while !isempty(pq)
        current, _ = peek(pq)
        current_pos = current[1]
        current_dir = current[2]
        dequeue!(pq)

        neighbors = [(add(current_pos, d), d == current_dir ? 1 : 1001) for d in directions if grid[add(current_pos, d)...] == 0]

        for (v, weight) in neighbors  # Iterate neighbors
            d = sub(v, current_pos)
            new_dist = distances[current] + weight
            if !((v, d) in keys(distances)) || new_dist < distances[(v,d)]
                distances[(v,d)] = new_dist
                prevs[(v, d)] = [current_pos]
                if haskey(pq, (v,d))
                    setindex!(pq, new_dist, (v,d))  # Update priority
                else
                    enqueue!(pq, (v,d), new_dist)
                end
            elseif new_dist == distances[(v,d)]
                push!(prevs[(v, d)], current_pos)
            end
        end
    end
    return prevs
    # no start looking for all shortest paths
    visited_nodes = Set()  # To store distinct nodes
    
    function traverse(node)
        if node in visited_nodes || !(node in keys(prevs))
            return
        end
        push!(visited_nodes, node)  # Add the node to the set
        for pred in prevs[node]
            traverse(pred)  # Recursively visit predecessors
        end
    end

    traverse(dst)  # Start from the target node
    return length(visited_nodes)
end

function get_all_paths(paths, dst)
    if !(dst in keys(paths)) || isempty(paths[dst])
        return [[dst]]
    end

    all_paths = []
    for pred in paths[dst]
        for subpath in get_all_paths(paths, pred)
            push!(all_paths, vcat(subpath, dst))
        end
    end

    return all_paths
end

g, s, d = read_input()
paths = task2(g, s, d)
for (k,v) in paths
    if k[1] == (2, 13)
        i = length(v)
        println("node at $k has $i predecessors:")
        for j in v
            print(" $j")
        end
        println()
    end
end
# shortest_paths = get_all_paths(paths, d)
# println(length(shortest_paths))
# d, p = task1(g, s, d)
# current = ((2, 14), (-1, 0))
# while current in keys(paths)
#    println(current)
#    global current = paths[current][1]
# end
#println(d)
