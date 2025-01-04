
function get_sorted_lists()
    col1 = []
    col2 = []
    
    # Read file line by line
    open("input.txt", "r") do file
        for line in eachline(file)
            # Split each line into two values
            vals = split(line)
            push!(col1, parse(Int64, vals[1]))
            push!(col2, parse(Int64, vals[2]))
        end
    end
    
    # Sort both columns
    sorted_col1 = sort(col1)
    sorted_col2 = sort(col2)
    
    return sorted_col1, sorted_col2
end

function task1()
    list1, list2 = get_sorted_lists()
    difference = 0
    for i in eachindex(list1)
        difference += abs(list1[i] - list2[i])
    end
    
    return difference
end

function task2()
    list1, list2 = get_sorted_lists()
    i = 1
    j = 1
    score = 0
    while i <= length(list1) && j <= length(list2)
        if list1[i] == list2[j]
            # Count occurrences in list2
            value = list1[i]
            count = 0
            while j <= length(list2) && list2[j] == value
                count += 1
                j += 1
            end
            score += value * count
            i += 1
        elseif list1[i] < list2[j]
            i += 1  # Move list1 pointer if current list1[i] is smaller
        else
            j += 1  # Move list2 pointer if current list2[j] is smaller
        end
    end
    return score
end

print(task1(), "\n", task2())
