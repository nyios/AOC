def doStuff(filename, length):
    f = open(filename, "r");
    positions = {(0,0)}
    pos_knots = [(0,0)]*length
    for lines in f:
        direction = lines.split(" ")[0]
        steps = int(lines.split(" ")[1])
        for i in range(0,steps):
            if direction == "R":
                pos_knots[0] = (pos_knots[0][0] + 1, pos_knots[0][1])
            elif direction == "D":
                pos_knots[0] = (pos_knots[0][0], pos_knots[0][1] - 1)
            elif direction == "L":
                pos_knots[0] = (pos_knots[0][0] - 1, pos_knots[0][1])
            elif direction == "U":
                pos_knots[0] = (pos_knots[0][0], pos_knots[0][1] + 1)


            for j in range(0,length-1):
                x_diff = pos_knots[j+1][0] - pos_knots[j][0]
                y_diff = pos_knots[j+1][1] - pos_knots[j][1]
                x_add = 0
                y_add = 0

                if x_diff < -1:
                    x_add = 1
                    if y_diff != 0:
                        if y_diff <= -1:
                            y_add = 1
                        elif y_diff >= 1:
                            y_add = -1
                elif x_diff > 1:
                    x_add = -1
                    if y_diff != 0:
                        if y_diff <= -1:
                            y_add = 1
                        elif y_diff >= 1:
                            y_add = -1
                elif y_diff < -1:
                    y_add = 1
                    if x_diff != 0:
                        if x_diff <= -1:
                            x_add = 1
                        elif x_diff >= 1:
                            x_add = -1
                elif y_diff > 1:
                    y_add = -1
                    if x_diff != 0:
                        if x_diff <= -1:
                            x_add = 1
                        elif x_diff >= 1:
                            x_add = -1

                pos_knots[j+1] = (pos_knots[j+1][0] + x_add, pos_knots[j+1][1] + y_add)
                #if x_diff < -1:                                   
                #    if y_diff == 0:                                    
                #        pos_knots[j + 1] = (pos_knots[j + 1][0] + 1, pos_knots[j + 1][1])          
                #    else:        
                #        #move diagonally
                #        pos_knots[j + 1] = (pos_knots[j + 1][0] + 1, pos_knots[j][1])              
                #elif x_diff > 1:                                  
                #    if y_diff == 0:                                    
                #        pos_knots[j + 1] = (pos_knots[j + 1][0] - 1, pos_knots[j + 1][1])          
                #    else:                                                                          
                #        pos_knots[j + 1] = (pos_knots[j][0] - 1, pos_knots[j][1])              
                #elif y_diff > 1:                                  
                #    if x_diff == 0:                                    
                #        pos_knots[j + 1] = (pos_knots[j + 1][0], pos_knots[j + 1][1] - 1)          
                #    else:                                                                          
                #        pos_knots[j + 1] = (pos_knots[j][0], pos_knots[j + 1][1] - 1)              
                #elif y_diff < -1:                                 
                #    if x_diff == 0:                                    
                #        pos_knots[j + 1] = (pos_knots[j + 1][0], pos_knots[j + 1][1] + 1)          
                #    else:                                                                          
                #        pos_knots[j + 1] = (pos_knots[j][0], pos_knots[j + 1][1] + 1)    
            print(pos_knots[-1])
            positions.add(pos_knots[-1])
    return positions

if __name__ == "__main__":
    print(len(doStuff('input.txt', 10)))        
