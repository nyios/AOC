file_path = "input.txt"

file = open(file_path, "r")
grid = readlines(file)
close(file)

energized_fields = Set()
@enum Direction NORTH EAST SOUTH WEST

function is_in_grid((x,y))
    return x > 0 && y > 0 && x <= length(grid) && y <= length(grid[1])
end

function get_next((x,y), direction)
    if direction == NORTH
        if grid[x][y] in ['.', '|']
            return ((x-1,y), NORTH)
        elseif grid[x][y] == '\\'
            return ((x, y-1), WEST)
        elseif grid[x][y] == '/'
            return ((x, y+1), EAST)
        end
    elseif direction == EAST
        if grid[x][y] in ['.', '-']
            return ((x,y+1), EAST)
        elseif grid[x][y] == '\\'
            return ((x+1, y), SOUTH)
        elseif grid[x][y] == '/'
            return ((x-1, y), NORTH)
        end
    elseif direction == SOUTH
        if grid[x][y] in ['.', '|']
            return ((x+1,y), SOUTH)
        elseif grid[x][y] == '\\'
            return ((x, y+1), EAST)
        elseif grid[x][y] == '/'
            return ((x, y-1), WEST)
        end
    elseif direction == WEST
        if grid[x][y] in ['.', '-']
            return ((x,y-1), WEST)
        elseif grid[x][y] == '\\'
            return ((x-1, y), NORTH)
        elseif grid[x][y] == '/'
            return ((x+1, y), SOUTH)
        end
    end
end

function follow_beam(start, direction)
    curr = start
    while is_in_grid(curr)
        if grid[curr[1]][curr[2]] == '-' && direction in [NORTH, SOUTH] && !(curr in energized_fields)
            push!(energized_fields, curr)
            follow_beam((curr[1], curr[2] + 1), EAST)
            curr = (curr[1], curr[2] - 1)
            direction = WEST
        elseif grid[curr[1]][curr[2]] == '|' && direction in [EAST, WEST] && !(curr in energized_fields)
            push!(energized_fields, curr)
            follow_beam((curr[1] + 1, curr[2]), SOUTH)
            curr = (curr[1] - 1, curr[2])
            direction = NORTH
        else
            if (grid[curr[1]][curr[2]], direction) in [('|', WEST), ('|', EAST), ('-', NORTH), ('-', SOUTH)]
                return
            end
            push!(energized_fields, curr)
            (curr, direction) = get_next(curr, direction)
        end
    end
end

function task1()
    follow_beam((1,1), EAST)
    println(length(energized_fields))
end

function task2()
    maxi = 0
    direction = NORTH
    start_pos = [(x,y) for x in 1:length(grid), y in 1:length(grid[1]) 
                 if y == 1 || x == 1 || y == length(grid[1]) || x == length(grid)]
    for (x,y) in start_pos
        global energized_fields = Set()
        if x == 1
            direction = SOUTH
        elseif x == length(grid)
            direction = NORTH
        elseif y == 1
            direction == EAST
        else
            direction = WEST
        end
        follow_beam((x,y), direction)
        maxi = max(maxi, length(energized_fields))
    end
    println(maxi)
end
task1()
task2()
