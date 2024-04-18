LEN = 99 

def doStuff(filename):
    acc = 0
    forest = [[0]*LEN]*LEN
    f = open(filename, "r");
    i = 0
    for line in f:
        forest[i] = list(map(lambda x : int(x), list(line[:-1])))
        i += 1
    for i in range(0,LEN):
        for j in range (0,LEN):
            scenic_score = checkDirections(forest, i, j)
            if scenic_score > acc:
                acc = scenic_score
    return acc

def checkDirections(forest, i, j):
    score = checkUp(forest, i, j) * checkDown(forest, i, j) * checkLeft(forest, i, j) * checkRight(forest, i, j)
    print(score, i, j)
    return score

def checkUp(forest, i, j):
    height = forest[i][j]
    for u in range(i-1, -1, -1):
        if forest[u][j] >= height:
            return abs(u - i)
    return i

def checkRight(forest, i, j):
    height = forest[i][j]
    for r in range(j+1,LEN):
        if forest[i][r] >= height:
            return r - j
    return LEN - 1 - j 

def checkDown(forest, i, j):
    height = forest[i][j]
    for d in range(i+1,LEN):
        if forest[d][j] >= height:
            return d - i
    return LEN - 1 - i

def checkLeft(forest, i, j):
    height = forest[i][j]
    for l in range(j-1,-1, -1):
        if forest[i][l] >= height:
            return abs(l - j)
    return j 

if __name__ == "__main__":
    print(doStuff("input.txt"))        
