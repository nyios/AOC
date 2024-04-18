using Base: visit, step_hp
file_path = "input.txt"

file = open(file_path, "r")
line_array = readlines(file)
close(file)

function is_in_grid((x,y))
    return x > 0 && y > 0 && x <= length(line_array) && y <= length(line_array[1])
end

function bfs(plots)
    end_points = Set()
    visited = Set()
    while true
        (plot, steps_left) = popfirst!(plots)
        #println("visiting $plot with $steps_left steps left")
        if steps_left == 0
            push!(end_points, plot)
        end
        if steps_left == -1
            return end_points
        end
        push!(visited, plot)
        for direction in [(0, 1), (1, 0), (0, -1), (-1, 0)]
            new_plot = (plot[1] + direction[1], plot[2] + direction[2])
            if is_in_grid(new_plot) && line_array[new_plot[1]][new_plot[2]] != '#'
                push!(plots, (new_plot, steps_left-1))
            end
        end
    end
end

function task1()
    result = bfs([((66, 66), 64)])
    println(length(result))
end

function task2()
end
task1()
task2()
