function read_input()
    moves = Dict('^' => (-1, 0), 'v' => (1, 0), '>' => (0, 1), '<' => (0, -1))
    lines = readlines("input.txt")
    grid = zeros(Int, (length(lines), length(lines[1])))
    pos = (0, 0)
    movements = []
    read_grid = true
    for (i, line) in enumerate(lines)
        if read_grid
            if isempty(line)
                read_grid = false
                continue
            end
            for (j, c) in enumerate(line)
                if c == '#'
                    grid[i, j] = 1
                elseif c == 'O'
                    grid[i, j] = 2
                elseif c == '@'
                    pos = (i, j)
                end
            end
        else
            for c in line
                push!(movements, moves[c])
            end
        end
    end
    return grid, pos, movements
end

function add(a::Tuple{Int, Int}, b::Tuple{Int, Int})
    return a[1] + b[1], a[2] + b[2]
end

function print_grid(grid, pos)
    rows, cols = size(grid)
    for i in 1:rows
        for j in 1:cols
            if (i, j) == pos
                print("@")
            else
                char = grid[i, j] == 0 ? "." :
                       grid[i, j] == 1 ? "#" : "O"
                print(char)
            end
        end
        println()  # Add a line break after each row
    end
end

function compute_number(matrix)
    total = 0
    rows, cols = size(matrix)
    for x in 1:rows
        for y in 1:cols
            if matrix[x, y] == 2
                total += 100 * (x - 1) + (y - 1)
            end
        end
    end
    return total
end

function task1(grid, start_pos, moves)
    current_pos = start_pos
    for move in moves
        next = grid[add(current_pos, move)...]
        # case: robot is in front of wall
        if next == 1
            continue
        # case: robot is in front of free space
        elseif next == 0
            current_pos = add(current_pos, move)
        # case: robot is in front of box
        elseif next == 2
            # get the correct row/column
            if move == (-1, 0)
                subgrid = @view grid[1:current_pos[1]-1, current_pos[2]]
                after_box_chain = findlast(x -> (x != 2), subgrid)
                box_index = -1
            elseif move == (1, 0)
                subgrid = @view grid[current_pos[1]+1:end, current_pos[2]]
                after_box_chain = findfirst(x -> (x != 2), subgrid)
                box_index = 1
            elseif move == (0, 1)
                subgrid = @view grid[current_pos[1], current_pos[2]+1:end]
                after_box_chain = findfirst(x -> (x != 2), subgrid)
                box_index = 1
            else
                subgrid = @view grid[current_pos[1], 1:current_pos[2]-1]
                after_box_chain = findlast(x -> (x != 2), subgrid)
                box_index = -1
            end
            # first index after boxes
            # check if there is a free space in that direction
            free_space = subgrid[after_box_chain] == 0
            if free_space
                if box_index == 1
                    subgrid[1] = 0
                else
                    subgrid[end] = 0
                end
                subgrid[after_box_chain] = 2
                current_pos = add(current_pos, move)
            end
        end
    end
    return compute_number(grid)
end

g, p, m = read_input()
println(task1(g, p, m))