def doStuff(filename):
    f = open(filename, "r");
    calories = []
    acc = 0
    for line in f:
        if line == '\n':
            calories.append(acc)
            acc = 0
        else:
            acc += int(line)
    first = max(calories)
    calories.remove(first)
    second = max(calories)
    calories.remove(second)
    third = max(calories)
    return first+second+third
    
if __name__ == "__main__":
    print(doStuff('inputday1.txt'))        

