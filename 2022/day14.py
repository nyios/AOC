y_max = 162
x_max = 110

def doStuff(filename):
    f = open(filename, "r");
    area = [['.']*x_max for i in range(y_max)]
    area[0][500-470] = '+'
    for line in f:
        coords = line.split(' -> ')
        x_coord_before = 0
        y_coord_before = 0
        first = True
        for coord in coords:
            x = int(coord.split(',')[0])
            y = int(coord.split(',')[1])
            if first:
                x_coord_before = x
                y_coord_before = y
            y_diff = abs(y - y_coord_before)
            x_diff = abs(x - x_coord_before)
            for i in range(y_diff + 1):
                if y > y_coord_before:
                    area[y-i][x-470] = '#'
                else:
                    area[y+i][x-470] = '#'
            for i in range(x_diff + 1):
                if x > x_coord_before:
                    area[y][x-470-i] = '#'
                else:
                    area[y][x-470+i] = '#'
            first = False
            x_coord_before = x
            y_coord_before = y
    i = 0
    while(True):
        sand = (30, 0)
#        if i % 100 == 0:
#            printArea(area)
        while(True):
            if nextPos(sand, area)[0] == -1:
                if nextPos(sand, area)[1] != -1:
                    return i
                else:
                    break
            else:
                sand = nextPos(sand, area)
        area[sand[1]][sand[0]] = 'o'
        i += 1

def nextPos(sand, area):
    #first down
    if area[sand[1] + 1][sand[0]] == '.':
        pos = (sand[0], sand[1] + 1)
    #second down left
    elif area[sand[1] + 1][sand[0] - 1] == '.':
        pos = (sand[0] - 1, sand[1] + 1)
    #third down right
    elif area[sand[1] + 1][sand[0] + 1] == '.':
        pos = (sand[0] + 1, sand[1] + 1)
    else:
        pos = (-1, -1)
    if pos[1] >= y_max - 1:
        pos = (-1, 0)

    return pos

def printArea(area):
    for i in range(len(area)):
        for j in range(len(area[0])):
            print(area[i][j], end='')
        print("")


if __name__ == "__main__":
    print(doStuff('input.txt'))

