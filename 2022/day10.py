def doStuff(filename):
    f = open(filename, "r");
    cycleCount = 0
    xValues = [0]*240
    xValue = 1
    for line in f:
        if cycleCount >= 240:
            break
        if line == "noop\n":
            xValues[cycleCount] = xValue
            cycleCount += 1
        else:
            const = line.split(" ")[1]
            xValues[cycleCount] = xValue
            cycleCount += 1
            xValues[cycleCount] = xValue
            xValue += int(const)
            cycleCount += 1
    return xValues

def drawStuff(xValues):
    for i in range(0,240):
        vertPosCRT = i % 40
        if (i+1) % 40 == 0:
            endchar = '\n'
        else:
            endchar = ''
        vertPos = xValues[i]
        if vertPosCRT-1 <= vertPos <= vertPosCRT+1:
            print('#', end=endchar)
        else:
            print('.', end=endchar)
    print('\n')
if __name__ == "__main__":
    drawStuff(doStuff('input.txt'))        
