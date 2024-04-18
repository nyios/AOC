file_path = "input.txt"

file = open(file_path, "r")
line_array = readlines(file)
close(file)

function task1()
    left_right = line_array[1]
    nodes = Dict()
    for line in line_array[3:end]
        split_line = split(line, " = ")
        nodes[split_line[1]] = map((x) -> startswith(x, '(') ? x[2:end] : x[1:end-1], split(split_line[2], ", "))
    end
    i = 0
    current_node = nodes["AAA"]
    while true
        direction = left_right[i % (length(left_right)) + 1]
        dest_node = direction == 'L' ? current_node[1] : current_node[2]
        if dest_node == "ZZZ"
            println(i + 1)
            return
        else
            current_node = nodes[dest_node]
            i += 1
        end
    end

end

function task2()
    left_right = line_array[1]
    nodes = Dict()
    for line in line_array[3:end]
        split_line = split(line, " = ")
        nodes[split_line[1]] = map((x) -> startswith(x, '(') ? x[2:end] : x[1:end-1], split(split_line[2], ", "))
    end
    steps = []
    for node in keys(nodes)
        if node[end] != 'A'
            continue
        end
        current_node = nodes[node]
        i = 0
        while true
            direction = left_right[i % (length(left_right)) + 1]
            dest_node = direction == 'L' ? current_node[1] : current_node[2]
            if dest_node[end] == 'Z'
                push!(steps, i+1)
                break
            else
                current_node = nodes[dest_node]
                i += 1
            end
        end
    end
    println(lcm(steps...))
end
#task1()
task2()
