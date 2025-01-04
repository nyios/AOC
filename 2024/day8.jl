function read_input()
    matrix = []
    open("input.txt", "r") do file
        for line in eachline(file)
            push!(matrix, collect(chomp(line)))  # Convert each line into a vector of characters
        end
    end
    mat = permutedims(hcat(matrix...))
    return mat
end 

function character_positions(matrix)
    # Create an empty dictionary to store the mapping
    char_map = Dict{Char, Vector{CartesianIndex}}()

    # Iterate over the matrix
    for pos in CartesianIndices(matrix)
        char = matrix[pos]
        if char != '.'  # Ignore blank characters
            # Add position to the character's list
            if haskey(char_map, char)
                push!(char_map[char], pos)
            else
                char_map[char] = [pos]
            end
        end
    end
    return char_map
end

function task1(matrix, char_map)
    # Dimensions of the matrix
    rows, cols = size(matrix)

    valid_pos = Set()

    # Iterate over each character in the map
    for (_, positions) in char_map
        # Iterate over all unique pairs of positions
        for i in 1:length(positions)-1
            for j in i+1:length(positions)
                pos1, pos2 = positions[i], positions[j]

                # Compute the difference in x and y
                dx = pos2[1] - pos1[1]  # Row difference
                dy = pos2[2] - pos1[2]  # Column difference

                # Adjust positions
                new_pos1 = CartesianIndex(pos1[1] - dx, pos1[2] - dy)
                new_pos2 = CartesianIndex(pos2[1] + dx, pos2[2] + dy)

                # Check if the new positions are within matrix bounds
                if 1 <= new_pos1[1] <= rows && 1 <= new_pos1[2] <= cols
                    push!(valid_pos, new_pos1)
                end
                if 1 <= new_pos2[1] <= rows && 1 <= new_pos2[2] <= cols
                    push!(valid_pos, new_pos2)
                end
            end
        end
    end
    return length(valid_pos)
end

function task2(matrix, char_map)
    # Dimensions of the matrix
    rows, cols = size(matrix)

    valid_pos = Set()

    # Iterate over each character in the map
    for (_, positions) in char_map
        # Iterate over all unique pairs of positions
        for i in 1:length(positions)-1
            for j in i+1:length(positions)
                pos1, pos2 = positions[i], positions[j]

                # Compute the difference in x and y
                dx = pos2[1] - pos1[1]  # Row difference
                dy = pos2[2] - pos1[2]  # Column difference

                # Add all new positions from pos1 by subtracting dx/dy
                current_pos = CartesianIndex(pos1[1], pos1[2])
                while 1 <= current_pos[1] <= rows && 1 <= current_pos[2] <= cols
                    push!(valid_pos, current_pos)
                    current_pos = CartesianIndex(current_pos[1] - dx, current_pos[2] - dy)
                end

                # Add all new positions from pos2 by adding dx/dy
                current_pos = CartesianIndex(pos2[1], pos2[2])
                while 1 <= current_pos[1] <= rows && 1 <= current_pos[2] <= cols
                    push!(valid_pos, current_pos)
                    current_pos = CartesianIndex(current_pos[1] + dx, current_pos[2] + dy)
                end
            end
        end
    end

    return length(valid_pos)
end

m = read_input()
map = character_positions(m)
println(task1(m, map))
println(task2(m, map))
