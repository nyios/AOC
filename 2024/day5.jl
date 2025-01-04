function read_input()
    update = false
    updates = []
    ordering_rules = []
    open("input.txt", "r") do file
        for line in eachline(file)
            if isempty(line)
                update = true
            elseif update
                push!(updates, split(line, ','))
            else
                push!(ordering_rules, split(line, '|'))
            end

        end 
    end
    return ordering_rules, updates
end

function get_valid_and_invalid_orderings(ordering_rules, updates)
    valid_updates = []
    invalid_updates = []
    for update in updates
        valid = true
        for ordering in ordering_rules
            first = findfirst(==(ordering[1]), update)
            second = findfirst(==(ordering[2]), update)
            if !(first === nothing || second === nothing || first < second)
                valid = false
                break
            end
        end
        if valid
            push!(valid_updates, update)
        else
            push!(invalid_updates, update)
        end
    end
    return valid_updates, invalid_updates
end

function task1(valid_updates)
    count = 0
    for v in valid_updates
        count += parse(Int64, v[length(v) ÷ 2 + 1])
    end
    return count
end

function task2(ordering_rules, invalid_updates)
    lt(x,y) = [x,y] ∈ ordering_rules
    sorted_updates = [sort(update, lt=lt) for update ∈ invalid_updates]
    count = 0
    for s in sorted_updates
        count += parse(Int64, s[length(s) ÷ 2 + 1])
    end
    return count
end

o, u = read_input()
valid, invalid = get_valid_and_invalid_orderings(o, u)
println(task1(valid))
println(task2(o, invalid))
