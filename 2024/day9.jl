function read_input()
    # Initialize the disk map and other variables
    disk_map = []  # Explicitly specify integer type for efficiency
    id = 0
    free_space = false

    # Open the file and process the single line
    open("input.txt", "r") do file
        for char in strip(read(file, String))  # Read the line as a string and strip whitespace
            count = parse(Int, char)
            if free_space
                append!(disk_map, fill(-1, count))  # Fill with -1 for free space
            else
                append!(disk_map, fill(id, count))  # Fill with ID for used space
                id += 1
            end
            free_space = !free_space
        end
    end
    return disk_map
end

function task1(disk_map)
    i = findfirst(isequal(-1), disk_map)
    j = findlast(!isequal(-1), disk_map)
    while i < j
        disk_map[i] = disk_map[j]
        disk_map[j] = -1
        i = findnext(isequal(-1), disk_map, i)
        j = findprev(!isequal(-1), disk_map, j)
    end
    return sum(val * (idx-1) for (idx, val) in enumerate(disk_map) if val != -1)
end

function find_first_free_space(arr, n, i)
    # Use a custom predicate in findfirst
    return findfirst(i -> i <= length(arr) - n && all(arr[i:i+(n-1)] .== -1), 1:i)
end

function file_size(arr, i)
    value = arr[i]
    count = 0
    
    for j in range(i, step=-1, stop=1)
        if arr[j] == value
            count += 1
        else
            break
        end
    end
    return count
end

function copy_and_replace!(arr, source_start, target_start, n)
    # Extract the chunk to copy
    chunk = arr[source_start:source_start + n - 1]

    # Place the chunk in the target location
    arr[target_start:target_start + n - 1] .= chunk

    # Replace the original chunk with -1
    arr[source_start:source_start + n - 1] .= -1
end

function task2(disk_map)
    i = findlast(!isequal(-1), disk_map)
    last_file_id = disk_map[i]
    while i > 0
        if disk_map[i] == -1 || disk_map[i] > last_file_id
            i -= 1
        else
            println("looking at file with ID $(disk_map[i])")
            n = file_size(disk_map, i)
            j = find_first_free_space(disk_map, n, i-n)
            if j !== nothing
                last_file_id = disk_map[i]
                copy_and_replace!(disk_map, i-n+1, j, n)
            end
            i -= n
        end
    end
    return sum(val * (idx-1) for (idx, val) in enumerate(disk_map) if val != -1)
end

d = read_input()
println(task1(copy(d)))
println(task2(d))