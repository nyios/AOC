function read_input()
    robots = [] # movement -> position
    for line in readlines("input.txt")
        p_string = split(split(split(line, " ")[1], "=")[2], ",")
        p = (parse(Int64, p_string[1]), parse(Int64, p_string[2]))
        v_string = split(split(split(line, " ")[2], "=")[2], ",")
        v = (parse(Int64, v_string[1]), parse(Int64, v_string[2]))
        push!(robots, [p, v])
    end
    return robots
end

max_y = 103
max_x = 101

function task1(robots_to_copy)
    robots = deepcopy(robots_to_copy)
    for _ in 1:100
        for robots in robots
            px, py = robots[1]
            vx, vy = robots[2]
            robots[1] = (mod(px+vx, max_x), mod(py+vy, max_y))
        end
    end
    fourth_quadrant = [r for r in robots if 0 <= r[1][1] < div(max_x, 2) && 0 <= r[1][2] < div(max_y, 2)]
    first_quadrant = [r for r in robots if div(max_x, 2) < r[1][1] < max_x && 0 <= r[1][2] < div(max_y, 2)]
    third_quadrant = [r for r in robots if 0 <= r[1][1] < div(max_x, 2) && div(max_y, 2) < r[1][2] < max_y]
    second_quadrant = [r for r in robots if div(max_x, 2) < r[1][1] < max_x && div(max_y, 2) < r[1][2] < max_y]
    return length(fourth_quadrant) * length(first_quadrant) * length(second_quadrant) * length(third_quadrant)
end

function task2(robots_to_copy)
    robots = deepcopy(robots_to_copy)
    count_min = 501
    min_i = 0
    for i in 1:10000
        for robot in robots
            px, py = robot[1]
            vx, vy = robot[2]
            robot[1] = (mod(px+vx, max_x), mod(py+vy, max_y))
        end
        coordinates = [r[1] for r in robots]
        binned_coordinates = [(ceil(Int, x / 3), ceil(Int, y / 3)) for (x, y) in coordinates]
        count = length(unique(binned_coordinates))
        if count < count_min
            count_min = count
            min_i = i
        end
    end
    return min_i
end

r = read_input()
println(task1(r))
println(task2(r))