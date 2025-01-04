function read_input()
    matrix = []
    open("input.txt", "r") do file
        for line in eachline(file)
            push!(matrix, collect(chomp(line)))  # Convert each line into a vector of characters
        end
    end
    return permutedims(hcat(matrix...))
end 

function matches_pattern(submatrix::Matrix{Char}, pattern::Matrix{Char}, n::Int64)
    for i in 1:n
        for j in 1:n
            # Check only non-'_' positions
            if pattern[i, j] != '_' && submatrix[i, j] != pattern[i, j]
                return false
            end
        end
    end
    return true
end

function count_4x4_pattern(matrix::Matrix{Char}, patterns::Array{Matrix{Char}})
    n, m = size(matrix)
    count = 0
    
    # Slide the 4x4 window over the entire matrix
    for i in 1:(n - 3)
        for j in 1:(m - 3)
            # Extract the current 4x4 submatrix
            submatrix = matrix[i:i+3, j:j+3]
            # Check if it matches the pattern
            for pattern in patterns
                if matches_pattern(submatrix, pattern, 4)
                    count += 1
                end
            end
        end
    end
    return count
end

function count_3x3_pattern(matrix::Matrix{Char}, patterns::Array{Matrix{Char}})
    n, m = size(matrix)
    count = 0
    
    # Slide the 3x3 window over the entire matrix
    for i in 1:(n - 2)
        for j in 1:(m - 2)
            # Extract the current 3x3 submatrix
            submatrix = matrix[i:i+2, j:j+2]
            for pattern in patterns
                # Check if it matches the pattern
                if matches_pattern(submatrix, pattern, 3)
                    count += 1
                end
            end
        end
    end
    return count
end

function count_4x1_1x4_patterns(matrix::Matrix{Char}, patterns::Vector{String})
    n, m = size(matrix)
    row_count, col_count = 0, 0
    
    # Convert patterns to character arrays for easier matching
    pattern_arrays = [collect(p) for p in patterns]
    
    for i in 1:n
        for j in 1:(m-3)
            sub_row = matrix[i, j:j+3]
            if sub_row in pattern_arrays
                row_count += 1
            end
        end
    end

    # Check last three columns for vertical (4x1) patterns
    for j in 1:m
        for i in 1:(n-3) 
            sub_col = matrix[i:i+3, j]
            if sub_col in pattern_arrays
                col_count += 1
            end
        end
    end
    
    return row_count + col_count
end

patterns = [
    ['X' '_' '_' '_'
    '_' 'M' '_' '_'
    '_' '_' 'A' '_'
    '_' '_' '_' 'S'],
    ['S' '_' '_' '_'
    '_' 'A' '_' '_'
    '_' '_' 'M' '_'
    '_' '_' '_' 'X'],
    ['_' '_' '_' 'X'
    '_' '_' 'M' '_'
    '_' 'A' '_' '_'
    'S' '_' '_' '_'],
    ['_' '_' '_' 'S'
    '_' '_' 'A' '_'
    '_' 'M' '_' '_'
    'X' '_' '_' '_']
]

small_patterns = ["XMAS", "SAMX"]

x_mas_patterns = [
    ['M' '_' 'M' 
    '_' 'A' '_'
    'S' '_' 'S'],
    ['M' '_' 'S' 
    '_' 'A' '_'
    'M' '_' 'S'],
    ['S' '_' 'M' 
    '_' 'A' '_'
    'S' '_' 'M'],
    ['S' '_' 'S' 
    '_' 'A' '_'
    'M' '_' 'M']
]

input = read_input()

function task1()
    return count_4x4_pattern(input, patterns) + count_4x1_1x4_patterns(input, small_patterns)
end

function task2()
    return count_3x3_pattern(input, x_mas_patterns)
end

print(task1(), "\n", task2())
