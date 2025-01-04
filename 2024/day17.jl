
function read_input()
    lines = readlines("input.txt")
    program = []
    instructions = split(split(lines[5], ' ')[2], ',')
    for i in 1:2:length(instructions)-1
        code = parse(Int, instructions[i])
        operand = parse(Int, instructions[i+1])
        push!(program, code)
        push!(program, operand)
    end
    return program
end

function task1(input)
    a = input
    b = 0
    c = 0
    output = []
    while (a != 0)
        b = a & 7
        b ⊻= 3
        c = a >> b
        b ⊻= c
        a >>= 3
        b ⊻= 5
        push!(output, (b & 7))
    end
    return output
end

function inverse_foo(output)
    a = 0
    for i in reverse(1:length(output))
        b = output[i]
        b ⊻= 5  # Reverse the last XOR
        c = b ⊻ (b >> 3)  # Reverse b ⊻= c (extract original c)
        b = b ⊻ c  # Reverse b ⊻= 3
        b = b ⊻ 3  # Reverse b ⊻= 3 (from foo)
        a <<= 3  # Shift a left by 3 bits to make space
        a |= (b & 7)  # Add the recovered 3 bits to a
    end
    return a
end

function task2(program)
    reverse!(program)
    println(program)
    a = 0
    for n in program
        n ⊻= 5
        for i in 0:7
            shift_a = a >> i
            b = (n ⊻ shift_a) & 7
            b ⊻= 3
            if (b == i)
                println("output number $(n ⊻= 5) and shift $i works")
                a |= b
                a <<= 3
                #println(bitstring(a))
                break
            end
        end
    end
    return a
end

#task1()
p = read_input()
original_a = 0x123456789ABC  # Example 48-bit input
output = task1(original_a)
println("Output from foo: ", output)

reconstructed_a = inverse_foo(output)
println("Reconstructed a: ", reconstructed_a)

# Verify
println("Match: ", original_a == reconstructed_a)
#a = task2([6,7])
#println(a)
#task1((a, b, c), p)
#println(task2((a,b,c), p))
#println(read_input())

