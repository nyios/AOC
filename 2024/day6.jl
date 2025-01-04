function read_input()
    matrix = []
    open("input.txt", "r") do file
        for line in eachline(file)
            push!(matrix, collect(chomp(line)))  # Convert each line into a vector of characters
        end
    end
    mat = permutedims(hcat(matrix...))
    n, m = size(mat)
    
    # Create the bordered matrix
    bordered_matrix = fill('.', n + 2, m + 2)
    
    bordered_matrix[2:end-1, 2:end-1] .= mat
    
    return bordered_matrix
end 

function get_inital_path(plan)
    curr_pos = findfirst(isequal('^'), plan)
    direction = "up"
    visited = Set()
    n, m = size(plan)
    while 1 < curr_pos[1] < n && 1 < curr_pos[2] < m
        if direction == "up"
            if plan[curr_pos[1] - 1, curr_pos[2]] == '#'
                direction = "right"
            else
                push!(visited, curr_pos)
                curr_pos = (curr_pos[1] - 1, curr_pos[2])
            end
        elseif direction == "right"
            if plan[curr_pos[1], curr_pos[2] + 1] == '#'
                direction = "down"
            else
                push!(visited, curr_pos)
                curr_pos = (curr_pos[1], curr_pos[2] + 1)
            end
        elseif direction == "left"
            if plan[curr_pos[1], curr_pos[2] - 1] == '#'
                direction = "up"
            else
                push!(visited, curr_pos)
                curr_pos = (curr_pos[1], curr_pos[2] - 1)
            end
        elseif direction == "down"
            if plan[curr_pos[1] + 1, curr_pos[2]] == '#'
                direction = "left"
            else
                push!(visited, curr_pos)
                curr_pos = (curr_pos[1] + 1, curr_pos[2])
            end
        end
    end
    return visited
end

function task1(path)
    return length(path)
end

function task2(path, plan)
    counter = 0
    for coordinate in path
        # visited set for cycle detection
        visited = Set()
        # place new obstacle
        new_plan = copy(plan)
        new_plan[Tuple(coordinate)...] = '#'
        curr_pos = findfirst(isequal('^'), plan)
        direction = "up"
        n, m = size(plan)
        # check if this introduces a cycle
        while 1 < curr_pos[1] < n && 1 < curr_pos[2] < m
            if (curr_pos, direction) in visited
                counter += 1
                break
            end
            if direction == "up"
                if new_plan[curr_pos[1] - 1, curr_pos[2]] == '#'
                    direction = "right"
                else
                    push!(visited, (curr_pos, direction))
                    curr_pos = (curr_pos[1] - 1, curr_pos[2])
                end
            elseif direction == "right"
                if new_plan[curr_pos[1], curr_pos[2] + 1] == '#'
                    direction = "down"
                else
                    push!(visited, (curr_pos, direction))
                    curr_pos = (curr_pos[1], curr_pos[2] + 1)
                end
            elseif direction == "left"
                if new_plan[curr_pos[1], curr_pos[2] - 1] == '#'
                    direction = "up"
                else
                    push!(visited, (curr_pos, direction))
                    curr_pos = (curr_pos[1], curr_pos[2] - 1)
                end
            elseif direction == "down"
                if new_plan[curr_pos[1] + 1, curr_pos[2]] == '#'
                    direction = "left"
                else
                    push!(visited, (curr_pos, direction))
                    curr_pos = (curr_pos[1] + 1, curr_pos[2])
                end
            end
        end
    end
    return counter
end

plan = read_input()
path = get_inital_path(plan)
println(task1(path))
println(task2(path, plan))