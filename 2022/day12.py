x_max = 179 
y_max =41 

e = 20*x_max + 155
def doStuff(area, s):
    visited = [False]*x_max*y_max
    distFromSource = [0]*x_max*y_max
    currIndex = s
    area[currIndex] = ord('a')
    area[e] = ord('z')
    queue = [currIndex]
    distFromSource[currIndex] = 1
    visited[currIndex] = True
    pred = [-1]*x_max*y_max
    while(True):
        if len(queue) == 0:
            return -1
        currIndex = queue[0]
        queue.pop(0)
        neighbors = generateNeighbors(currIndex, area)
        for n in neighbors:
            if not visited[n]:
                queue.append(n)
                distFromSource[n] = distFromSource[currIndex] + 1
                visited[n] = True
                pred[n] = currIndex
            if n == e:
                return distFromSource[e]

def generateNeighbors(index, area):
    first_row = index < x_max
    last_row = index >= (y_max - 1) * x_max
    first_column = index % x_max == 0
    last_column = index % x_max == x_max - 1
    if first_row:
        if first_column:
            neighbors = [index + 1, index + x_max]
        elif last_column:
            neighbors = [index - 1, index + x_max]
        else: 
            neighbors = [index + 1, index - 1, index + x_max]
    elif last_row:
        if first_column:
            neighbors = [index + 1, index - x_max]
        elif last_column:
            neighbors = [index - 1, index - x_max]
        else: 
            neighbors = [index + 1, index - 1, index - x_max]
    elif first_column:
        neighbors = [index + 1, index + x_max, index - x_max]
    elif last_column:
        neighbors = [index - 1, index + x_max, index - x_max]
    #anywhere else:
    else:
        neighbors = [index + 1, index - 1, index + x_max, index - x_max]
    return [x for x in neighbors if area[x] <= area[index] + 1]
    
if __name__ == "__main__":
    f = open("input.txt", "r");
    area = [[0]*x_max]*y_max
    i = 0
    for line in f:
        area[i] = list(map(lambda x : ord(x), list(line[:-1])))
        i += 1
    area = [item for sublist in area for item in sublist]
    i = 0
    paths = []
    for i in range(len(area)):
        if area[i] == ord('a'):
            paths.append(doStuff(area, i))

    print(min([x for x in paths if x != -1]))
#    curr = pred[e]
#    while (curr != s):
#        area[curr] = ord('#')
#        curr = pred[curr]
#    for i in range(len(area)):
#        if i % x_max == x_max -1:
#            print(chr(area[i]))
#        else:
#            print(chr(area[i]), end='')
#    print(area.count(ord('#')))
