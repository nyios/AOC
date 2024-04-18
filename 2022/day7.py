acc = 0

class File:
    def __init__(self, name, level):
        self.name = name
        self.level = level

class Directory(File):
    def __init__(self, name, level, parent):
        super().__init__(name, level)
        self.parent = parent
        self.children = []

    def __str__(self):
        for i in range(0,self.level):
            print("\t", end='')
        print(self.name, ":")
        for file in self.children:
            print(file)
        return ""

    def getSize(self):
        acc = 0
        for c in self.children:
            acc += c.getSize()
        return acc

    def getSize2(self):
        acc2 = 0
        for c in self.children:
           acc2 += c.getSize()
           c.getSize2()
        if acc2 <= 100000:
            global acc 
            acc += acc2

    def find_min(self):
        global min_dir_size
        if needed_space <= self.getSize() < min_dir_size:
            min_dir_size = self.getSize()
        for c in self.children:
            c.find_min()

class PlainFile(File):
    def __init__(self, name, level, size):
        super().__init__(name, level)
        self.size = size

    def __str__(self):
        for i in range(0,self.level):
            print("\t", end='')
        return "[" + str(self.size) + self.name + "]"

    def getSize(self):
        return self.size
    
    def getSize2(self):
        pass

    def find_min(self):
        pass


def doStuff(filename):
    f = open(filename, "r")
    root = Directory("/", 0, None)
    currDir = root
    i = 0
    for line in f:
        if line.startswith("$ ls"):
            continue
        elif line.startswith("$ cd"):
            if line.find("..") != -1:
                currDir = currDir.parent
            else:
                index = list(map(lambda x : x.name, currDir.children)).index(line[5:-1]);
                currDir = currDir.children[index]
        elif line.startswith("dir"):
            newDir = Directory(line[4:-1], currDir.level + 1, currDir)
            currDir.children.append(newDir)
        else:
            sizeName = line.split(" ")
            newFile = PlainFile(sizeName[1][:-1], currDir.level + 1, int(sizeName[0]))
            currDir.children.append(newFile)
        i += 1
    return root       

if __name__ == "__main__":
    fs = doStuff("input.txt")
    global min_dir_size
    min_dir_size = fs.getSize()
    print(fs.getSize())
    global needed_space
    needed_space = 30000000 - (70000000 - fs.getSize())
    print(needed_space)
    fs.find_min()
    print(min_dir_size)
    #print(doStuff("input.txt"))        
