import numpy as np

def doStuff(filename):
    f = open(filename, "r");
    start = ["FGVRJLD", 
         "SJHVBMPT", 
         "CPGDFMHV", 
         "QGNPDM", 
         "FNHLJ", 
         "ZTGDQVFN", 
         "LBDF", 
         "NDVSBJM", 
         "DLG"]
#    start = ["NZ", "DCM", "P"]
    start = list(map(lambda x : list(reversed(x)), start))
    for line in f:
        split_line = line.split(" ")
        amount = split_line[1]
        stack1 = split_line[3]
        stack2 = split_line[5]
        for i in range(int(amount), 0, -1):
            start[int(stack2) - 1].append(start[int(stack1) - 1][-i])
        
        for i in range(0, int(amount)):
            start[int(stack1) - 1].pop()
    return start
        

if __name__ == "__main__":
    print(list(map(lambda x: x[len(x) - 1], doStuff("input.txt"))))        
