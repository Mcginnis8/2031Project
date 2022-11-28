outArr = []
import math
temp2 = 0
lines = 'GWGWGWDWEWEWDZWBWBWAWAWGZZWDWGWGWGWDWEWEWDZWBWBWAWAWGZZWXWXWGWGWGWXWXWGWGWGZRWYWYWGLWYWYWGRWYWYWYWYWLGWGWQ'
myDict = {'A':880,'B':987.77,'C':523.25,'D':587.33,'E':659.25,'F':698.46,'G':783.99,'V':1046.5,'W':3, 'Y':2,'X':1,'Z':0, 'R':4,'L':5,    'Q':6}


for line in lines:
    temp = myDict[line]
    if temp == 1:
        temp = 587.33
        temp = temp * (2**15)/48000
        temp2 = round(temp)
        temp = str(temp2)
        temp = "LOADI  " + temp
        outArr.append(temp)
        outArr.append("OUT    Beep")
        outArr.append("LOADI 4")
        outArr.append("OUT duration")
        outArr.append("CALL    Delay")
        
    elif temp == 2:
        temp = 783.99
        temp = temp * (2**15)/48000
        temp2 = round(temp)
        temp = str(temp2)
        temp = "LOADI  " + temp
        outArr.append(temp)
        outArr.append("OUT    Beep")
        outArr.append("LOADI 2")
        outArr.append("OUT duration")
        outArr.append("CALL    Delay")
    elif temp == 3:
        outArr.append("LOADI 0")
        outArr.append("OUT    Beep")
        outArr.append("LOADI 1")
        outArr.append("OUT duration")
        outArr.append("CALL    Delay")
    elif temp == 4:
        outArr.append("LOADI 01")
        outArr.append("OUT    ChnSel")
    elif temp == 5:
        outArr.append("LOADI 10")
        outArr.append("OUT    ChnSel")
    elif temp == 6:
        outArr.append("LOADI 11")
        outArr.append("OUT    ChnSel")
    elif temp:
        temp = temp * (2**15)/48000
        temp2 = round(temp)
        temp = str(temp2)
        temp = "LOADI  " + temp
        outArr.append(temp)
        outArr.append("OUT    Beep")
        outArr.append("LOADI 4")
        outArr.append("OUT duration")
        outArr.append("CALL    Delay")
    else:
        outArr.append("LOADI 4")
        outArr.append("OUT duration")
        outArr.append("CALL    Delay")

outArr.append("JUMP 0")

with open("BinaryToFreq.txt", "w") as txt_file:
    for line in outArr:
        txt_file.write("".join(line) + "\n")