using Images
using ColorTypes
using ImageMorphology
using ImageFiltering

# Function to read file and extract unique letters
function read_input()
    return permutedims(hcat([split(line, "") for line in readlines("input.txt")]...))
end

function flood_fill(matrix)
    # Get the size of the matrix
    rows, cols = size(matrix)

    # Initialize the result matrix with -1 (indicating unvisited cells)
    result = fill(-1, rows, cols)

    # Directions for the four neighbors: up, down, left, right
    directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]

    # Helper function for Depth First Search (DFS)
    function dfs(x, y, component_id)
        # Stack for DFS, starting with the initial (x, y)
        stack = [(x, y)]

        while !isempty(stack)
            cx, cy = pop!(stack)

            # If the current position is out of bounds or already visited, skip it
            if cx < 1 || cx > rows || cy < 1 || cy > cols || result[cx, cy] != -1
                continue
            end

            # Mark the current cell with the component id
            result[cx, cy] = component_id

            # Explore the four neighbors
            for (dx, dy) in directions
                nx, ny = cx + dx, cy + dy
                # If the neighbor is within bounds and has the same value
                if nx >= 1 && nx <= rows && ny >= 1 && ny <= cols && matrix[nx, ny] == matrix[cx, cy]
                    push!(stack, (nx, ny))  # Add the neighbor to the stack
                end
            end
        end
    end

    # Component id counter
    component_id = 0

    # Perform DFS for each unvisited cell
    for i in 1:rows
        for j in 1:cols
            if result[i, j] == -1  # If this cell has not been visited yet
                component_id += 1    # New component
                dfs(i, j, component_id)  # Flood-fill the component
            end
        end
    end

    return result
end

function convolution(image, kernel)
    rows, cols = size(image)
    krows, kcols = size(kernel)
    
    # Create a padded image
    padded_image = zeros(Int, rows + 2, cols + 2)
    padded_image[2:1 + rows, 2:1 + cols] .= image
    
    # Prepare output array
    result = zeros(Int, rows, cols)
    
    # Perform convolution
    for i in 1:rows
        for j in 1:cols
            # Extract the window
            window = padded_image[i:i + krows - 1, j:j + kcols - 1]
            # Compute the convolution for the current position
            result[i, j] = sum(window .* kernel)
        end
    end
    return result
end

function task1(matrix)
    max_id = max(matrix...)
    println(max_id)
    rows, cols = size(matrix)
    counter = 0
    for i in 1:max_id
        isolated_component = zeros(Int, rows, cols)

        for j in 1:rows
            for k in 1:cols
                if matrix[j, k] == i
                    isolated_component[j, k] = 1
                end
            end
        end
        # Define the kernel for boundary detection
        kernel = [0 -1  0;
                -1 4  -1;
                0  -1  0]

        # Perform the convolution
        perimeter_map = convolution(isolated_component, kernel)

        perimeter = sum(value for value in perimeter_map if value > 0)
        area = sum(isolated_component)
        counter += perimeter * area
    end
    return counter
end

function corner_count(submatrix)
    kernel = [
        0 -1 0;
        -1 4 -1;
        0 -1 0;
    ]
    if sum(submatrix .* kernel) == 3
        return 2
    end
    if sum(submatrix .* kernel) == 4
        return 4
    end
    kernel_ur = [
        -1 -1 0;
        -1 4 0;
        0 0 0;
    ]
    kernel_ul = [
        0 -1 -1;
        0 4 -1;
        0 0 0;
    ]
    kernel_ll = [
        0 0 0;
        0 4 -1;
        0 -1 -1;
    ]
    kernel_lr = [
        0 0 0;
        -1 4 0;
        -1 -1 0;
    ]
    kernels = [kernel_ll, kernel_lr, kernel_ul, kernel_ur]
    for k in kernels
        if sum(submatrix .*k) == 4
            return 1
        end
    end
    return 0
end

function corner_count_inv(submatrix)
    kernel = [
        0 -1 0;
        -1 4 -1;
        0 -1 0;
    ]
    if sum(submatrix .* kernel) == 3
        return 2
    end
    if sum(submatrix .* kernel) == 4
        return 4
    end
    kernel_ur = [
        0 -1 0;
        -1 4 0;
        0 0 0;
    ]
    kernel_ul = [
        0 -1 0;
        0 4 -1;
        0 0 0;
    ]
    kernel_ll = [
        0 0 0;
        0 4 -1;
        0 -1 0;
    ]
    kernel_lr = [
        0 0 0;
        -1 4 0;
        0 -1 0;
    ]
    kernels = [kernel_ll, kernel_lr, kernel_ul, kernel_ur]
    for k in kernels
        if sum(submatrix .*k) == 4
            return 1
        end
    end
    return 0
end

function task2(matrix)
    max_id = max(matrix...)
    # Create a padded image
    n, m = size(matrix)
    padded_matrix = zeros(Int, n + 2, m + 2)
    padded_matrix[2:n+1, 2:m+1] .= matrix
    rows, cols = size(padded_matrix)
    counter = 0
    for i in 1:max_id
        isolated_component = zeros(Int, rows, cols)
        area = 0
        sides = 0 
        for j in 2:rows-1
            for k in 2:cols-1
                if padded_matrix[j, k] == i
                    area += 1
                    isolated_component[j, k] = 1
                end
            end
        end
        for j in 2:rows-1
            for k in 2:cols-1
                if isolated_component[j, k] == 1
                    a = corner_count(isolated_component[j-1:j+1, k-1:k+1])
                    #println("pixel at ($j, $k) has corner count $a")
                    sides += a
                end
            end
        end
        inv_component = 1 .-isolated_component
        for j in 2:rows-1
            for k in 2:cols-1
                if inv_component[j, k] == 1
                    b = corner_count(inv_component[j-1:j+1, k-1:k+1])
                    #println("pixel at ($j, $k) has inverse corner count $b")
                    sides += b
                end
            end
        end
        # println("area $area for component with ID $i")
        # println("sides $sides for component with ID $i")
        counter += sides * area
    end
    return counter
end

g = read_input()
flooded = flood_fill(g)
println(task2(flooded))

