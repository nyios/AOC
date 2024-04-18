def doStuff(filename):
    f = open(filename, "r");
    acc = 0
    for line in f:
        me = line[2]
        acc += getValue(me) + outcomeValue(line)
    return acc

def getValue(me):
    if me == 'X':
        return 0
    if me == 'Y':
        return 3
    if me == 'Z':
        return 6
    return 0

def outcomeValue(line):
    # rock
    if line in ["B X\n", "A Y\n", "C Z\n"]:
        return 1
    # paper
    elif line in ["B Y\n", "A Z\n", "C X\n"]:
        return 2
    # scissor
    else:
        return 3


if __name__ == "__main__":
    print(doStuff('input.txt'))        
