def doStuff(filename):
    f = open(filename, "r");
    acc = 0
    line_count = 0
    lines = []
    for line in f:
        if line_count == 3:
            badge = findBadge(lines[0], lines[1], lines[2])
            print(badge)
            if badge.islower():
                value = ord(badge) - 96
            else:
                value = ord(badge) - 38
            line_count = 1
            lines.clear()
            lines.append(line)
            acc += value
        else:
            lines.append(line)
            line_count += 1
    badge = findBadge(lines[0], lines[1], lines[2])        
    print(badge)
    if badge.islower():
        value = ord(badge) - 96
    else:
        value = ord(badge) - 38
    acc += value
    return acc

def findDouble(first_comp, second_comp):
    for char in first_comp:
        for char2 in second_comp:
            if char == char2:
                return char


def findBadge(first, second, third):
    for char1 in first:
        for char2 in second:
            for char3 in third:
                if char1 == char2 and char2 == char3:
                    return char1

if __name__ == "__main__":
    print(doStuff('input.txt'))        
