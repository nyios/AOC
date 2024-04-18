file_path = "input.txt"

file = open(file_path, "r")
line_array = readlines(file)
close(file)

function task1()
    all_space_x = []
    for (i, line) in enumerate(line_array)
        if (all(==('.'), line))
            push!(all_space_x, i)
        end
    end
    all_space_y = []
    for j in 1:length(line_array[1])
        column = [line_array[x][j] for x in 1:length(line_array)]
        if (all(==('.'), column))
            push!(all_space_y, j)
        end
    end
    galaxies = []
    expansion_x = 0
    for (x, line) in enumerate(line_array)
        expansion_y = 0
        if x in all_space_x
            expansion_x += 1
        end
        for (y, char) in enumerate(line)
            if y in all_space_y
                expansion_y += 1
            end
            if char == '#'
                push!(galaxies, (x+expansion_x,y+expansion_y))
            end
        end
    end
    pairs = [(galaxies[i], galaxies[j]) for i in 1:length(galaxies), j in 1:length(galaxies) if j > i]
    println(sum(map((x) -> (abs(x[1][1] - x[2][1]) + abs(x[1][2] - x[2][2])), pairs)))
end

function task2()
    all_space_x = []
    for (i, line) in enumerate(line_array)
        if (all(==('.'), line))
            push!(all_space_x, i)
        end
    end
    all_space_y = []
    for j in 1:length(line_array[1])
        column = [line_array[x][j] for x in 1:length(line_array)]
        if (all(==('.'), column))
            push!(all_space_y, j)
        end
    end
    galaxies = []
    expansion_x = 0
    for (x, line) in enumerate(line_array)
        expansion_y = 0
        if x in all_space_x
            expansion_x += 999999
        end
        for (y, char) in enumerate(line)
            if y in all_space_y
                expansion_y += 999999
            end
            if char == '#'
                push!(galaxies, (x+expansion_x,y+expansion_y))
            end
        end
    end
    pairs = [(galaxies[i], galaxies[j]) for i in 1:length(galaxies), j in 1:length(galaxies) if j > i]
    println(sum(map((x) -> (abs(x[1][1] - x[2][1]) + abs(x[1][2] - x[2][2])), pairs)))
end
task1()
task2()
