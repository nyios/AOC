file_path = "input.txt"

file = open(file_path, "r")
line_array = readlines(file)
close(file)

function task1()
    sum = 0
    for line in line_array
        game_id = split(line, ':')[1][6:end]
        games = split(split(line, ':')[2], [',', ';'])
        possible = true
        for game in games
            g = split(strip(game), ' ')
            number = parse(Int, g[1]);
            if g[2] == "red"
                if number > 12
                    possible = false
                    break
                end
            elseif g[2] == "green"
                if number > 13
                    possible = false
                    break
                end
            elseif g[2] == "blue"
                if number > 14
                    possible = false
                    break
                end
            end
        end
        if possible
            sum += parse(Int, game_id)
        end
    end
    println(sum)
end

function task2()
    sum = 0
    for line in line_array
        game_id = split(line, ':')[1][6:end]
        games = split(split(line, ':')[2], ';')
        min_green = 0
        min_red = 0
        min_blue = 0
        for game in games
            colors = split(game, ',')
            for color in colors
                color = strip(color)
                if findfirst("green", color) !== nothing
                    amount = parse(Int, color[1:(length(color) - 6)])
                    min_green = max(min_green, amount)
                elseif findfirst("red", color) !== nothing
                    amount = parse(Int, color[1:(length(color) - 4)])
                    min_red = max(min_red, amount)
                elseif findfirst("blue", color) !== nothing
                    amount = parse(Int, color[1:(length(color) - 5)])
                    min_blue = max(min_blue, amount)
                end
            end
        end
        sum += min_red*min_blue*min_green 
    end
    println(sum)
end
task1()
task2()


