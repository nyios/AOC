file_path = "input.txt"
file = open(file_path, "r")
line_array = readlines(file)
close(file)

digits = Dict("zero" => '0', "one" => '1', "two" => '2', "three" => '3', "four" => '4', "five" => '5', "six" => '6',
             "seven" => '7', "eight" => '8', "nine" => '9')

function task1()
    sum = 0
    for line in line_array
        first_digit = ""
        last_digit = ""
        for char in line
            if isdigit(char)
                first_digit = char
                break
            end
        end
        for char in reverse(line)
            if isdigit(char)
                last_digit = char
                break
            end
        end
        sum += parse(Int, first_digit*last_digit)
    end
    println(sum)
end

function task2()
    # Loop through each line in the file
    sum = 0
    for line in line_array
        first_digit = ""
        last_digit = ""
        # going forwards for first digit
        for char in line
            if isdigit(char)
                first_digit = char
                break
            end
            first_digit *= char
            found = false
            for key in keys(digits)
                index = findfirst(key, first_digit)
                if index !== nothing
                    first_digit = digits[key]
                    found = true
                    break
                end
            end
            if found
                break
            end
        end
        # going backwards for second digit
        for i in length(line):-1:1
            if isdigit(line[i])
                last_digit = line[i]
                break
            end
            last_digit *= line[i]
            found = false
            reversed_string = reverse(last_digit)
            for key in keys(digits)
                index = findfirst(key, reversed_string)
                if index !== nothing
                    last_digit = digits[key]
                    found = true
                    break
                end
            end
            if found
                break
            end
        end
        value = parse(Int, first_digit*last_digit)
        sum += value
    end
    println(sum)
end
task1()
task2()


