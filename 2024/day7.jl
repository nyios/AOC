function read_input()
    numbers = []
    open("input.txt", "r") do file
        for line in eachline(file)
            number_line = []
            s_numbers = split(line, ' ')
            push!(number_line, parse(Int64, s_numbers[1][1:end-1]))
            for n ∈ s_numbers[2:end]
                push!(number_line, parse(Int64, n))
            end
            push!(numbers, number_line)
        end
    end
    return numbers
end

f = +
g = *
h(a, b) = parse(Int64, (string(a)*string(b)))

function combine_numbers_base2(numbers, current, n)
    # Ensure the number of numbers is n+1
    @assert length(numbers) == n + 1 "There must be n+1 numbers for n operators."

    # Convert binary number to array of functions
    binary = digits(current, base=2, pad=n)
    operators = map(b -> b == 0 ? f : g, reverse(binary))

    # Apply the operators to the numbers
    result = numbers[1]
    for i in 1:n
        result = operators[i](result, numbers[i + 1])
    end
    return result
end

function combine_numbers_base3(numbers, current, n)
    # Ensure the number of numbers is n+1
    @assert length(numbers) == n + 1 "There must be n+1 numbers for n operators."

    # Convert binary number to array of functions
    binary = digits(current, base=3, pad=n)
    operator_map = Dict(0 => +, 1 => *, 2 => h)
    operators = map(b -> operator_map[b], reverse(binary))

    # Apply the operators to the numbers
    result = numbers[1]
    for i in 1:n
        result = operators[i](result, numbers[i + 1])
    end
    return result
end

function task1(numbers)
    valid_lines = []
    for number_line in numbers
        n = length(number_line) - 2
        for i in 0:2^n
            result = combine_numbers_base2(number_line[2:end], i, n)
            if result == number_line[1]
                push!(valid_lines, number_line)
                break
            end
        end
    end
    return valid_lines, sum(map(v -> v[1], valid_lines))
end

function task2(numbers)
    valid_lines = []
    j = 0
    for number_line in numbers
        println(j)
        n = length(number_line) - 2
        for i in 0:3^n
            result = combine_numbers_base3(number_line[2:end], i, n)
            if result == number_line[1]
                push!(valid_lines, number_line[1])
                break
            end
        end
        j += 1
    end
    return sum(valid_lines)
end

lines = read_input()
valid_lines, valid_sum = task1(lines)
println(valid_sum)
possible_lines = setdiff(lines, valid_lines)
println(task2(possible_lines) + valid_sum)