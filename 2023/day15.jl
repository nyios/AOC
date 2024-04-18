file_path = "input.txt"

file = open(file_path, "r")
line_array = readlines(file)
close(file)

function hash(string)
    cur = 0
    for char in string
        value = UInt8(char)
        cur = ((cur + value) * 17) % 256
    end
    return cur
end

function task1()
    sum = 0
    strings = vcat(map((x) -> split(x, ','), line_array)...)
    for string in strings
        sum += hash(string)
    end
    println(sum)
end

function task2()
    hmap = [[] for _ in 1:256]
    strings = vcat(map((x) -> split(x, ','), line_array)...)
    for string in strings
        regex = r"([^-=]*)(=|-)(.*)"
        label = match(regex, string)[1]
        op = match(regex, string)[2]
        h = hash(label) + 1
        if op == "-"
            index = findfirst(map((x) -> x[1] == label, hmap[h]))
            if index !== nothing
                deleteat!(hmap[h], index)
            end
        else
            focal_length = match(regex, string)[3]
            index = findfirst(map((x) -> x[1] == label, hmap[h]))
            if findfirst(map((x) -> x[1] == label, hmap[h])) === nothing
                push!(hmap[h], (label, focal_length))
            else
                hmap[h][index] = (label, focal_length)
            end
                
        end
    end
    sum = 0
    for (i, box) in enumerate(hmap)
        for (j, (_, focal_length)) in enumerate(box)
            sum += i * j * parse(Int, focal_length)
         end
    end
    println(sum)
end
task1()
task2()
