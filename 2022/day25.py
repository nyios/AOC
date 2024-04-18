def doStuff():
    acc = readFile('input.txt')
    print(acc)
    curr = acc
    rests = []
    while curr > 5:
        rests.append(curr % 5)
        if curr % 5 < 3:
            curr = curr // 5
        else:
            curr = curr // 5 + 1
    rests.append(curr)
    dic = {2:'2', 1:'1', 0:'0', 3:'=', 4:'-'}
    digits = list(map(lambda x : dic[x], rests))
    digits.reverse()
    print(digits)
    acc_num = getSNAFU(digits)
    print(acc - acc_num)

def readFile(filename):
    f = open(filename, 'r')
    acc = 0
    for line in f:
        line = line[:-1]
        acc += getSNAFU(line)
    return acc

def getSNAFU(digits):
    power_five = []
    digit_dic = {'2': 2, '1': 1, '0': 0, '-': -1, '=': -2}
    for i in range(22):
        power_five.append(5**i)
    acc_num = 0
    for i in range(len(digits)):
        acc_num += power_five[len(digits)-1-i] * digit_dic[digits[i]]        
    return acc_num

if __name__ == "__main__":
    doStuff()      
