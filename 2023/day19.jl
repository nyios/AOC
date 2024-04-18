file_path = "input.txt"

file = open(file_path, "r")
line_array = readlines(file)
close(file)
workflows = Dict()
start = 0
for (i, line) in enumerate(line_array)
    global start = i
    if isempty(line)
        break
    end
    workflow = split(line, '{')[1]
    rules = split(split(line, '{')[2][1:end-1], ',')
    workflows[workflow] = rules
end

ratings = line_array[start+1:end]

function task1()
    sum = 0
    for rating in ratings
        curr = "in"
        x = parse(Int, split(split(rating, ',')[1], '=')[2])
        m = parse(Int, split(split(rating, ',')[2], '=')[2])
        a = parse(Int, split(split(rating, ',')[3], '=')[2])
        s = parse(Int, split(split(rating, ',')[4], '=')[2][1:end-1])
        values = Dict("x" => x, "m" => m, "a" => a, "s" => s)
        println("rating with values $x, $m, $a, $s")
        while !(curr in ["A", "R"])
            for workflow in workflows[curr]
                println("looking at workflow $workflow")
                if contains(workflow, ':')
                    predicate = split(workflow, ':')[1]
                    next_workflow = split(workflow, ':')[2]
                    if contains(predicate, '>')
                        if values[split(predicate, '>')[1]] > parse(Int, split(predicate, '>')[2])
                            println("workflow predicate true, continue to $next_workflow")
                            curr = next_workflow
                            break
                        end
                    else
                        number = split(predicate, '<')[1]
                        if values[number] < parse(Int, split(predicate, '<')[2])
                            println("end of workloads, continue to $next_workflow")
                            curr = next_workflow
                            break
                        end
                    end
                else
                    curr = workflow
                end
            end
        end
        if curr == "A"
            sum += x + m + a + s
        end
    end
    println(sum)
end

function task2()
    dimensions = (4000, 4000, 4000, 4000)
end
task1()
task2()
