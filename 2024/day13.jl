function task1()
    lines = [l for l in readlines("input.txt") if !isempty(l)]
    epsilon = 10^-4
    counter = 0
    for i in 1:3:length(lines)-2
        x1 = parse(Int64, split(split(lines[i], " ")[3], "+")[2][1:end-1])
        x2 = parse(Int64, split(split(lines[i], " ")[4], "+")[2])
        y1 = parse(Int64, split(split(lines[i+1], " ")[3], "+")[2][1:end-1])
        y2 = parse(Int64, split(split(lines[i+1], " ")[4], "+")[2])
        b1 = parse(Int64, split(split(lines[i+2], " ")[2], "=")[2][1:end-1]) + 10^13
        b2 = parse(Int64, split(split(lines[i+2], " ")[3], "=")[2]) + 10^13
        #println("x1: $x1, x2: $x2, y1: $y1, y2: $y2, b1: $b1, b2: $b2")
        A = [x1 y1; x2 y2]
        b = [b1, b2]
        x = A \ b
        if abs(x[1] - round(x[1])) < epsilon && abs(x[2] - round(x[2])) < epsilon
            counter += 3*Int(round(x[1])) + Int(round(x[2]))
        end
    end
    return counter
end

println(task1())