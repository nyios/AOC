function read_file()
    content = ""
    open("input.txt", "r") do file
        for line in eachline(file)
            content *= line
        end
    end
    return content
end

function task1()
    str = read_file()
    regex = r"mul\((\d+),(\d+)\)"
    count = 0
    for m in eachmatch(regex, str)
        count += parse(Int64, m.captures[1]) * parse(Int64, m.captures[2])
    end
    return count
end

function task2()
    str = read_file()
    regex = r"mul\((\d+),(\d+)\)|don't\(\)|do\(\)"
    mul = true
    count = 0
    for m in eachmatch(regex, str)
        if m.match == "don't()"
            mul = false
        elseif m.match == "do()"
            mul = true
        elseif mul
            count += parse(Int64, m.captures[1]) * parse(Int64, m.captures[2])
        end
    end
    return count
end
    

print(task1(), "\n", task2())