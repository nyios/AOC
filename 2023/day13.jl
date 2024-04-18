using Base: remove_linenums!
file_path = "input.txt"

file = open(file_path, "r")
line_array = readlines(file)
close(file)
patterns = [[]]
i = 1
j = 1
while i <= length(line_array)
    if line_array[i] == ""
        push!(patterns, [line_array[i + 1]])
        global i += 2
        global j += 1
    else
        push!(patterns[j], line_array[i])
        global i += 1
    end
end

function task1()
    sum = 0
    for pattern in patterns
        for i in 1:length(pattern[1])-1
            mirror = true
            pairs_to_check = [(x,(i + (i - x + 1))) for x in 1:i if (i + (i - x + 1)) <= length(pattern[1])]
            if isempty(pairs_to_check)
                break
            end
            transposed_array = permutedims(hcat([collect(str) for str in pattern]...))
            transposed_pattern = [join(transposed_array[:, i]) for i in 1:size(transposed_array, 2)]
            for (a,b) in pairs_to_check
                if transposed_pattern[a] != transposed_pattern[b]
                    mirror = false
                    break
                end
            end
            if mirror
                sum += i
            end
        end
        # look for horizontal mirror
        for i in 1:length(pattern)-1
            mirror = true
            pairs_to_check = [(x,(i + (i - x + 1))) for x in 1:i if (i + (i - x + 1)) <= length(pattern)]
            if isempty(pairs_to_check)
                break
            end
            for (a,b) in pairs_to_check
                if pattern[a] != pattern[b]
                    mirror = false
                    break
                end
            end
            if mirror 
                sum += i * 100
            end
        end
    end
    println(sum)
end

function find_mirror(pattern, smudge_x, smudge_y)
    # look for vertical mirror
    for i in 1:length(pattern[1])-1
        mirror = true
        pairs_to_check = [(x,(i + (i - x + 1))) for x in 1:i if (i + (i - x + 1)) <= length(pattern[1])]
        if isempty(filter((x) -> smudge_y in range(x[1], x[2]), pairs_to_check))
            continue
        end
        transposed_array = permutedims(hcat([collect(str) for str in pattern]...))
        transposed_pattern = [join(transposed_array[:, i]) for i in 1:size(transposed_array, 2)]
        for (a,b) in pairs_to_check
            if transposed_pattern[a] != transposed_pattern[b]
                mirror = false
                break
            end
        end
        if mirror
            return i
        end
    end
    # look for horizontal mirror
    for i in 1:length(pattern)-1
        mirror = true
#        pairs_to_check = [(x,(i + (i - x + 1))) for x in 1:i if (i + (i - x + 1)) <= length(pattern) && smudge_x in range(x, (i + (i - x + 1)))]
        pairs_to_check = [(x,(i + (i - x + 1))) for x in 1:i if (i + (i - x + 1)) <= length(pattern)]
        if isempty(filter((x) -> smudge_x in range(x[1], x[2]), pairs_to_check))
            continue
        end
        for (a,b) in pairs_to_check
            if pattern[a] != pattern[b]
                mirror = false
                break
            end
        end
        if mirror 
            return i * 100
        end
    end
    return 0
end

function task2()
    sum = 0
    for pattern in patterns
        found = false
        old_pattern = copy(pattern)
        for x in 1:length(pattern)
            for y in 1:length(pattern[1])
                pattern = copy(old_pattern)
                new_char = pattern[x][y] == '.' ? '#' : '.'
                pattern[x] = pattern[x][1:y-1] * new_char * pattern[x][y+1:end]
                add = find_mirror(pattern, x, y)
                if add > 0
                    sum += add
                    found = true
                    break
                end
            end
            if found
                break
            end
        end
    end
    println(sum)
end
task1()
task2()
