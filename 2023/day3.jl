function getValidity(i, j, line_array, line)
    coordinates = [(i-1, j-1), (i-1, j), (i, j-1), (i+1, j-1), (i-1, j+1), (i+1, j+1), (i+1, j), (i, j+1)]
    filter!((x) -> x[1] > 0 && x[2] > 0 && x[1] <= length(line_array) && x[2] <= length(line), coordinates)
    for (x, y) in coordinates
        if line_array[x][y] != '.' && !isdigit(line_array[x][y])
            return true
        end
    end
    return false
end

function nextToAsterisk(i, j, line_array, line)
    coordinates = [(i-1, j-1), (i-1, j), (i, j-1), (i+1, j-1), (i-1, j+1), (i+1, j+1), (i+1, j), (i, j+1)]
    filter!((x) -> x[1] > 0 && x[2] > 0 && x[1] <= length(line_array) && x[2] <= length(line), coordinates)
    for (x, y) in coordinates
        if line_array[x][y] == '*'
            return (x, y)
        end
    end
    return nothing
end

file_path = "input.txt"

file = open(file_path, "r")
# Loop through each line in the file
line_array = readlines(file)
function task1()
    sum = 0
    for i in 1:length(line_array)
        line = line_array[i]
        number = ""
        is_valid = false
        for j in 1:length(line)
            char = line[j]
            if !isdigit(char)
                if is_valid
                    sum += parse(Int, number)
                end
                number = ""
                is_valid = false
            else
                number *= char
                is_valid = is_valid ? is_valid : getValidity(i, j, line_array, line)
                if j == length(line) && is_valid
                    sum += parse(Int, number)
                end
            end
        end
    end
    println(sum)
end

function task2()
    map = Dict()
    for i in 1:length(line_array)
        line = line_array[i]
        number = ""
        isNextAsterisk = false
        coords = nothing
        for j in 1:length(line)
            char = line[j]
            if !isdigit(char)
                if isNextAsterisk
                    if coords in keys(map)
                        push!(map[coords], parse(Int, number))
                    else
                        map[coords] = [parse(Int, number)]
                    end
                end
                number = ""
                isNextAsterisk = false
            else
                number *= char
                if !isNextAsterisk
                    coords = nextToAsterisk(i, j, line_array, line)
                    isNextAsterisk = coords !== nothing
                end
                if j == length(line) && isNextAsterisk
                    if coords in keys(map)
                        push!(map[coords], parse(Int, number))
                    else
                        map[coords] = [parse(Int, number)]
                    end
                end
            end
        end
    end
    println(sum(map!((x) -> length(x) == 2 ? x[1] * x[2] : 0, values(map))))
end

# Close the file
close(file)
task1()
task2()
