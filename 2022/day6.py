import numpy as np

def doStuff(filename):
    f = open(filename, "r");
    string = f.readline()
    i = 1
    substring = ""
    for char in string:
        if i < 13:
            substring += char
            i += 1
        else:
            substring = substring[-13:] + char
            if len(set(substring)) == len(substring):
                return i
            i += 1

if __name__ == "__main__":
    print(doStuff("input.txt"))        
