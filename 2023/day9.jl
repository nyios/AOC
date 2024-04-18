file_path = "input.txt"

file = open(file_path, "r")
line_array = readlines(file)
close(file)

function task1()
    s = 0
    for line in line_array
        numbers = split(line, ' ')
        diffs = map(x -> parse(Int, x[2])-parse(Int, x[1]), zip(numbers[1:end-1], numbers[2:end]))
        last_numbers = [parse(Int, numbers[end])]
        while !(all(==(0), diffs))
            push!(last_numbers, diffs[end])
            diffs = map(x -> x[2]-x[1], zip(diffs[1:end-1], diffs[2:end]))
        end
        s += sum(last_numbers)
    end
    println(s)
end

function task2()
    s = 0
    for line in line_array
        numbers = split(line, ' ')
        diffs = map(x -> parse(Int, x[2])-parse(Int, x[1]), zip(numbers[1:end-1], numbers[2:end]))
        first_numbers = [parse(Int, numbers[1])]
        while !(all(==(0), diffs))
            push!(first_numbers, diffs[1])
            diffs = map(x -> x[2]-x[1], zip(diffs[1:end-1], diffs[2:end]))
        end
        s += foldr(-, vcat(first_numbers, [0])) 
    end
    println(s)
end
task1()
task2()
