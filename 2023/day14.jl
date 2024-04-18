file_path = "input.txt"

file = open(file_path, "r")
line_array = readlines(file)
close(file)

function task1()
    for i in 2:length(line_array)
        for j in 1:length(line_array[i])
            if line_array[i][j] == 'O'
                line_nr = i
                while line_nr-1 > 0 && line_array[line_nr-1][j] == '.'
                    line_nr -= 1
                end
                if line_nr != i
                    line_array[line_nr] = line_array[line_nr][1:j-1] * 'O' * line_array[line_nr][j+1:end]
                    line_array[i] = line_array[i][1:j-1] * '.' * line_array[i][j+1:end]
                end
            end
        end
    end
    sum = 0
    for (i, line) in enumerate(line_array[end:-1:1])
        sum += count((x) -> x == 'O', line) * i
    end
    println(sum)
end

function tilt_north(line_array)
    for i in 2:length(line_array)
        for j in 1:length(line_array[i])
            if line_array[i][j] == 'O'
                line_nr = i
                while line_nr-1 > 0 && line_array[line_nr-1][j] == '.'
                    line_nr -= 1
                end
                if line_nr != i
                    line_array[line_nr] = line_array[line_nr][1:j-1] * 'O' * line_array[line_nr][j+1:end]
                    line_array[i] = line_array[i][1:j-1] * '.' * line_array[i][j+1:end]
                end
            end
        end
    end
    return line_array
end

function tilt_east(line_array)
    for i in 2:length(line_array[1])
        for j in 1:length(line_array)
            if line_array[j][i] == 'O'
                column_nr = i
                while column_nr-1 > 0 && line_array[j][column_nr-1] == '.'
                    column_nr -= 1
                end
                if column_nr != i
                    line_array[j] = line_array[j][1:column_nr-1] * 'O' * line_array[j][column_nr+1:end]
                    line_array[j] = line_array[j][1:i-1] * '.' * line_array[j][i+1:end]
                end
            end
        end
    end
    return line_array
end

function tilt_west(line_array)
    for i in length(line_array[1])-1:-1:1
        for j in 1:length(line_array)
            if line_array[j][i] == 'O'
                column_nr = i
                while column_nr+1 <= length(line_array[1]) && line_array[j][column_nr+1] == '.'
                    column_nr += 1
                end
                if column_nr != i
                    line_array[j] = line_array[j][1:column_nr-1] * 'O' * line_array[j][column_nr+1:end]
                    line_array[j] = line_array[j][1:i-1] * '.' * line_array[j][i+1:end]
                end
            end
        end
    end
    return line_array
end

function tilt_south(line_array)
    for i in length(line_array)-1:-1:1
        for j in 1:length(line_array[i])
            if line_array[i][j] == 'O'
                line_nr = i
                while line_nr+1 <= length(line_array) && line_array[line_nr+1][j] == '.'
                    line_nr += 1
                end
                if line_nr != i
                    line_array[line_nr] = line_array[line_nr][1:j-1] * 'O' * line_array[line_nr][j+1:end]
                    line_array[i] = line_array[i][1:j-1] * '.' * line_array[i][j+1:end]
                end
            end
        end
    end
    return line_array
end

function task2()
    global line_array
    lines = line_array
    for _ in 1:1000
        # tilt north
        lines = tilt_north(lines)
        # tilt east
        lines = tilt_east(lines)
        # tilt south
        lines = tilt_south(lines)
        # tilt west
        lines = tilt_west(lines)
    end
    sum = 0
    for (i, line) in enumerate(line_array[end:-1:1])
        sum += count((x) -> x == 'O', line) * i
    end
    println(sum)
end
task1()
task2()
