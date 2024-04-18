file_path = "input2.txt"

file = open(file_path, "r")
line_array = readlines(file)
close(file)

function is_neighbor_1((x_old,y_old), (x,y))
    if x > 0 && y > 0 && x <= length(line_array) && y <= length(line_array[1]) && line_array[x][y] != '#'
        char_old = line_array[x_old][y_old]
        char_new = line_array[x][y]
        if char_old == '.' && char_new == '.'
            return true
        end
        if char_old == '>' && y - y_old == 1
            return true
        end
        if char_old == '<' && y - y_old == -1
            return true
        end
        if char_old == '^' && x - x_old == -1
            return true
        end
        if char_old == 'v' && x - x_old == 1
            return true
        end
        if char_new == '>' && y - y_old != -1
            return true
        end
        if char_new == '<' && y - y_old != 1
            return true
        end
        if char_new == '^' && x - x_old != 1
            return true
        end
        if char_new == 'v' && x - x_old != -1
            return true
        end

    end
    return false
end

function is_neighbor_2((x,y))
    if x > 0 && y > 0 && x <= length(line_array) && y <= length(line_array[1]) && line_array[x][y] != '#'
        return true
    end
    return false
end

directions = [(1,0), (0,1), (-1,0), (0,-1)]

function DFS(curr, prev)
    max_distance = 0
    walked = 1
    while (true)
        neighbors = [(curr[1] + x[1], curr[2] + x[2]) for x in directions if is_neighbor_1(curr, (curr[1] + x[1], curr[2] + x[2]))] 
        filter!(n -> n != prev, neighbors)
        if length(neighbors) == 1
            walked += 1
            prev = curr
            curr = neighbors[1]
        else
            # we are at the end point
            if isempty(neighbors)
                max_distance = walked
            end
            for neighbor in neighbors
                max_distance = max(DFS(neighbor, curr) + walked, max_distance)
            end
            break
        end
    end
    return max_distance
end

function DFS_2(curr, prev, visited, end_point, preds)
    println("visiting $curr")
    push!(visited, curr)
    max_distance = 0
    walked = 1
    while (true)
        neighbors = [(curr[1] + x[1], curr[2] + x[2]) for x in directions if is_neighbor_2((curr[1] + x[1], curr[2] + x[2]))] 
        filter!(n -> n != prev && !(n in visited), neighbors)
        println("$curr has neighbors $neighbors")
        if length(neighbors) == 1
            walked += 1
            prev = curr
            #preds[neighbors[1]] = curr
            curr = neighbors[1]
            push!(visited, curr)
        else
            if curr == end_point
                max_distance = walked
            end
            for neighbor in neighbors
                distance = DFS_2(neighbor, curr, visited, end_point, preds) + walked
                if distance > max_distance
                    preds[neighbor] = curr
                    max_distance = distance
                end
            end
            break
        end
    end
    println("max distance to $curr is $max_distance")
    return max_distance
end

function task1()
    start = (1,2)
    println(DFS((2,2), start))
end

function task2()
    visited = Set()
    preds = Dict()
    println(DFS_2((2,2), (1,2), visited, (23,22), preds))
    start = (23,22)
    while start in keys(preds)
        println(start)
        start = preds[start]
    end
end
task1()
task2()
