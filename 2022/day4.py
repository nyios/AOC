def doStuff(filename):
    f = open(filename, "r");
    acc = 0
    for line in f:
        ranges = line.split(',')
        first_elf_range = [x for x in range(int(ranges[0].split('-')[0]), int(ranges[0].split('-')[1]) + 1)]
        second_elf_range = [x for x in range(int(ranges[1].split('-')[0]), int(ranges[1].split('-')[1]) + 1)]
        if not set(first_elf_range).isdisjoint(set(second_elf_range)): 
                acc += 1
    return acc
        

if __name__ == "__main__":
    print(doStuff('input.txt'))        
