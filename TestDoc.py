import math
romSize = 1024
outArr = []
outArr.append("=-- Altera Memory Initialization File (MIF)")
outArr.append("DEPTH = " +str(romSize)+";")
outArr.append("WIDTH = 10;")
outArr.append("ADDRESS_RADIX = DEC;")
outArr.append("DATA_RADIX = DEC;")
outArr.append(" ")
outArr.append("CONTENT")
outArr.append("BEGIN")
for i in range(0,romSize):
    temp = (i/romSize)*2*math.pi
    temp = (math.floor((romSize-1) * math.sin(temp))//2)
    temp = str(temp)
    temp = str(i) + " : " + temp + ';'
    outArr.append(temp)
outArr.append("END;")
with open("output.txt", "w") as txt_file:
    for line in outArr:
        txt_file.write("".join(line) + "\n")
