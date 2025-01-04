function is_safe(values)
    is_decreasing = values[1] < values[2]
    for i in 1:length(values)-1
        if is_decreasing && values[i] > values[i+1]
            return false
        elseif !is_decreasing && values[i] < values[i+1]
            return false
        elseif !(0 < abs(values[i] - values[i+1]) < 4)
            return false
        end
    end
    return true
end

function task1()
    counter  = 0
    open("input.txt", "r") do file
        for line in eachline(file)
            vals = [parse(Int64, s) for s in split(line)]
            if is_safe(vals)
                counter += 1
            end
        end
    end
    return counter
end

function task2()
    counter  = 0
    open("input.txt", "r") do file
        for line in eachline(file)
            vals = [parse(Int64, s) for s in split(line)]
            for i in 1:length(vals)
                # Create a subarray excluding the element at index `i`
                subarray = vcat(vals[1:i-1], vals[i+1:end])
                if is_safe(subarray)
                    counter += 1
                    break
                end
            end
        end
    end
    return counter
end

print(task1(), "\n", task2())