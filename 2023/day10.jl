using Base: Enums, Enumerate
file_path = "input.txt"

file = open(file_path, "r")
line_array = readlines(file)
close(file)

@enum Direction begin
    north
    west
    south
    east
end

function task1()
    x = 0
    y = 0
    for (i, line) in enumerate(line_array)
        if occursin('S', line)
            x = i
            for (j, char) in enumerate(line)
                if char == 'S'
                    y = j
                    break
                end
            end
            break
        end
    end
    curr_tile = (x+1, y)
    curr_char = line_array[curr_tile[1]][curr_tile[2]]
    came_from = north
    i = 1
    while curr_char != 'S'
        if curr_char == '|'  
            if came_from == north
                curr_tile = (curr_tile[1] + 1, curr_tile[2])
            else 
                curr_tile = (curr_tile[1] - 1, curr_tile[2])
            end
        elseif curr_char == '-'  
            if came_from == west
                curr_tile = (curr_tile[1], curr_tile[2] + 1)
            else 
                curr_tile = (curr_tile[1], curr_tile[2] - 1)
            end
        elseif curr_char == 'J'
            if came_from == north
                curr_tile = (curr_tile[1], curr_tile[2] - 1)
                came_from = east
            else 
                curr_tile = (curr_tile[1] - 1, curr_tile[2])
                came_from = south
            end
        elseif curr_char == 'F'
            if came_from == south
                curr_tile = (curr_tile[1], curr_tile[2] + 1)
                came_from = west
            else 
                curr_tile = (curr_tile[1] + 1, curr_tile[2])
                came_from = north
            end
        elseif curr_char == '7'
            if came_from == south
                curr_tile = (curr_tile[1], curr_tile[2] - 1)
                came_from = east
            else 
                curr_tile = (curr_tile[1] + 1, curr_tile[2])
                came_from = north
            end
        elseif curr_char == 'L'
            if came_from == north
                curr_tile = (curr_tile[1], curr_tile[2] + 1)
                came_from = west
            else 
                curr_tile = (curr_tile[1] - 1, curr_tile[2])
                came_from = south
            end
        end
        curr_char = line_array[curr_tile[1]][curr_tile[2]]
        i += 1
    end
    println(i / 2)
end

function task2()
end
task1()
task2()
