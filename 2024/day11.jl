function read_input()
    multi_set = Dict()
    line = readline("input.txt")
    stones = [parse(Int, x) for x in split(line, " ")]
    for stone in stones
        multi_set[stone] = 1
    end
    return multi_set
end

function split_integer(x, digits)
    k = 10^(digits ÷ 2)
    left = div(x, k)
    right = x % k
    return left, right
end

function task1and2(stones, blinks)
    current_stones = stones
    for _ in 1:blinks
        new_stones = Dict()
        if (0 in keys(current_stones))
            new_stones[1] = current_stones[0]
        end
        for (k,v) in current_stones
            digits = length(string(k))
            if iseven(digits)
                left, right = split_integer(k, digits)
                new_stones[left] = get(new_stones, left, 0) + v
                new_stones[right] = get(new_stones, right, 0) + v
            elseif (k != 0)
                new_stones[k*2024] = get(new_stones, k*2024, 0) + v
            end
        end
        current_stones = new_stones
    end
    sum(values(current_stones))
end

stones = read_input()
@time task1and2(copy(stones), 25)
@time task1and2(copy(stones), 75)
println(task1and2(copy(stones), 75))