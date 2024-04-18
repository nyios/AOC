file_path = "input.txt"

file = open(file_path, "r")
line_array = readlines(file)
close(file)

function splitNumbers(numberString)
    number = ""
    numbers = []
    for char in numberString
        if isdigit(char)
            number *= char
        else
            if number != ""
                push!(numbers, number)
                number = ""
            end
        end
    end
    return numbers
end

function task1()
    sum = 0
    for line in line_array 
        winning_numbers = splitNumbers(strip(split(split(line, ':')[2], '|')[1])*' ')
        given_numbers = splitNumbers(strip(split(split(line, ':')[2], '|')[2])*' ')
        points = 0
        for number in given_numbers
            if number in winning_numbers
                points += 1
            end
        end
        if points != 0
            sum += 2^(points-1)
        end
    end
    println(sum)
end

function task2()
    instances = fill(1, length(line_array))
    for i in 1:length(line_array)
        line = line_array[i]
        winning_numbers = splitNumbers(strip(split(split(line, ':')[2], '|')[1])*' ')
        given_numbers = splitNumbers(strip(split(split(line, ':')[2], '|')[2])*' ')
        points = 0
        for number in given_numbers
            if number in winning_numbers
                points += 1
            end
        end
        for j in (i+1):(i+points)
            if j > length(instances)
                break
            end
            instances[j] += instances[i] 
        end
    end
    println(sum(instances))
end
task1()
task2()
