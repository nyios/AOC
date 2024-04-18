def doStuff():
    m0 = Monkey([74, 73, 57, 77, 74], (6, 7), lambda x : x * 11, 2)
    m1 = Monkey([99, 77, 79], (6, 0), lambda x : x + 8, 3)
    m2 = Monkey([64, 67, 50, 96, 89, 82, 82], (5, 3), lambda x : x + 1, 13)
    m3 = Monkey([88], (5, 4), lambda x : x * 7, 17)
    m4 = Monkey([80, 66, 98, 83, 70, 63, 57, 66], (0, 1), lambda x : x + 4, 13)
    m5 = Monkey([81, 93, 90, 61, 62, 64], (1, 4), lambda x : x + 7, 7)
    m6 = Monkey([69, 97, 88, 93], (7, 2), lambda x : x * x, 5)
    m7 = Monkey([59, 80], (2, 3), lambda x : x + 6, 11)
    monkeys = [m0, m1, m2, m3, m4, m5, m6, m7]
    inspectedItems = [0]*8

    for i in range(10000):
        for j in range(len(monkeys)):
            for item in monkeys[j].items:
                worry = monkeys[j].operation(item)
                if worry % monkeys[j].modNumber == 0:
                    monkeys[monkeys[j].nextMonkeys[0]].items.append(worry % (monkeys[j].modNumber
                    * monkeys[monkeys[j].nextMonkeys[0]].modNumber))
                else:
                    monkeys[monkeys[j].nextMonkeys[1]].items.append(worry % (monkeys[j].modNumber
                    * monkeys[monkeys[j].nextMonkeys[1]].modNumber))
                inspectedItems[j] += 1
            monkeys[j].items = []
    return inspectedItems

class Monkey:
    def __init__(self, items, nextMonkeys, operation, modNumber):
        self.items = items
        self.nextMonkeys = nextMonkeys
        self.operation = operation
        self.modNumber = modNumber

if __name__ == "__main__":
    inspectedItems = (doStuff())        
    inspectedItems.sort()
    print(inspectedItems)
