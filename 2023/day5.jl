file_path = "input.txt"

file = open(file_path, "r")
line_array = readlines(file)
close(file)

function get_new_numbers(old_numbers, mappings)
    new_numbers = []
    for number in old_numbers
        found_mapping = false
        for mapping in mappings
            if number in range(mapping[2], mapping[2]+mapping[3]-1)
                push!(new_numbers, mapping[1] + (number - mapping[2]))
                found_mapping = true
                break
            end
        end
        if !found_mapping
            push!(new_numbers, number)
        end
    end
    return new_numbers
end

function task1()
    global line_array
    seeds = map((x) -> parse(Int, x), (split(line_array[1][8:end], ' ')))
    # seed to soil
    line_array = line_array[4:end]
    seed_dest_source_range = []
    for line in line_array[1:12]
        push!(seed_dest_source_range, map((x) -> parse(Int, x), split(line, ' ')))
    end
    soil = get_new_numbers(seeds, seed_dest_source_range)
    # soil to fertilizer
    line_array = line_array[15:end]
    soil_dest_source_range = []
    for line in line_array[1:29]
        push!(soil_dest_source_range, map((x) -> parse(Int, x), split(line, ' ')))
    end
    fertilizers = get_new_numbers(soil, soil_dest_source_range)
    # fertilizer to water 
    line_array = line_array[32:end]
    fertilizer_dest_source_range = []
    for line in line_array[1:17]
        push!(fertilizer_dest_source_range, map((x) -> parse(Int, x), split(line, ' ')))
    end
    waters = get_new_numbers(fertilizers, fertilizer_dest_source_range)
    # water to light  
    line_array = line_array[20:end]
    water_dest_source_range = []
    for line in line_array[1:18]
        push!(water_dest_source_range, map((x) -> parse(Int, x), split(line, ' ')))
    end
    lights = get_new_numbers(waters, water_dest_source_range)
    # light to temperature 
    line_array = line_array[21:end]
    light_dest_source_range = []
    for line in line_array[1:34]
        push!(light_dest_source_range, map((x) -> parse(Int, x), split(line, ' ')))
    end
    temperatures = get_new_numbers(lights, light_dest_source_range)
    # temperature to humidity 
    line_array = line_array[37:end]
    temperature_dest_source_range = []
    for line in line_array[1:35]
        push!(temperature_dest_source_range, map((x) -> parse(Int, x), split(line, ' ')))
    end
    humiditys = get_new_numbers(temperatures, temperature_dest_source_range)
    # humidity to location 
    line_array = line_array[38:end]
    humidity_dest_source_range = []
    for line in line_array[1:12]
        push!(humidity_dest_source_range, map((x) -> parse(Int, x), split(line, ' ')))
    end
    locations = get_new_numbers(humiditys, humidity_dest_source_range)
    println(findmin(locations)[1])
end

function task2()
end
task1()
task2()
