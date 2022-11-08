; BeepTest.asm
; Sends the value from the switches to the
; tone generator peripheral once per second.

ORG 0
ADDI  71
OUT    Beep
CALL   Delay
ADDI  4
OUT    Beep
CALL   Delay
ADDI  5
OUT    Beep
CALL   Delay
ADDI  4
OUT    Beep
CALL   Delay
ADDI  5
OUT    Beep
CALL   Delay
ADDI  6
OUT    Beep
CALL   Delay
ADDI  5
OUT    Beep
CALL   Delay
ADDI  6
OUT    Beep
CALL   Delay
ADDI  7
OUT    Beep
CALL   Delay
ADDI  6
OUT    Beep
CALL   Delay
ADDI  7
OUT    Beep
CALL   Delay
ADDI  8
OUT    Beep
CALL   Delay
ADDI  8
OUT    Beep
CALL   Delay
ADDI  8
OUT    Beep
CALL   Delay
ADDI  9
OUT    Beep
CALL   Delay
ADDI  10
OUT    Beep
CALL   Delay
ADDI  10
OUT    Beep
CALL   Delay
ADDI  10
OUT    Beep
CALL   Delay
ADDI  11
OUT    Beep
CALL   Delay
ADDI  12
OUT    Beep
CALL   Delay
ADDI  13
OUT    Beep
CALL   Delay
ADDI  13
OUT    Beep
CALL   Delay
ADDI  15
OUT    Beep
CALL   Delay
ADDI  15
OUT    Beep
CALL   Delay
ADDI  16
OUT    Beep
CALL   Delay
ADDI  16
OUT    Beep
CALL   Delay
ADDI  18
OUT    Beep
CALL   Delay
ADDI  19
OUT    Beep
CALL   Delay
ADDI  20
OUT    Beep
CALL   Delay
ADDI  21
OUT    Beep
CALL   Delay
ADDI  23
OUT    Beep
CALL   Delay
ADDI  24
OUT    Beep
CALL   Delay
ADDI  25
OUT    Beep
CALL   Delay
ADDI  27
OUT    Beep
CALL   Delay
ADDI  28
OUT    Beep
CALL   Delay
ADDI  30
OUT    Beep
CALL   Delay
ADDI  32
OUT    Beep
CALL   Delay
ADDI  34
OUT    Beep
CALL   Delay
ADDI  35
OUT    Beep
CALL   Delay
ADDI  38
OUT    Beep
CALL   Delay
ADDI  40
OUT    Beep
CALL   Delay
ADDI  43
OUT    Beep
CALL   Delay
ADDI  45
OUT    Beep
CALL   Delay
ADDI  48
OUT    Beep
CALL   Delay
ADDI  50
OUT    Beep
CALL   Delay
ADDI  54
OUT    Beep
CALL   Delay
ADDI  56
OUT    Beep
CALL   Delay
ADDI  60
OUT    Beep
CALL   Delay
ADDI  64
OUT    Beep
CALL   Delay
ADDI  67
OUT    Beep
CALL   Delay
ADDI  72
OUT    Beep
CALL   Delay
ADDI  76
OUT    Beep
CALL   Delay
ADDI  80
OUT    Beep
CALL   Delay
ADDI  85
OUT    Beep
CALL   Delay
ADDI  90
OUT    Beep
CALL   Delay
ADDI  95
OUT    Beep
CALL   Delay
ADDI  101
OUT    Beep
CALL   Delay
ADDI  107
OUT    Beep
CALL   Delay
ADDI  114
OUT    Beep
CALL   Delay
ADDI  120
OUT    Beep
CALL   Delay
ADDI  127
OUT    Beep
CALL   Delay
ADDI  135
OUT    Beep
CALL   Delay
ADDI  143
OUT    Beep
CALL   Delay
ADDI  151
OUT    Beep
CALL   Delay
ADDI  161
OUT    Beep
CALL   Delay
ADDI  170
OUT    Beep
CALL   Delay
ADDI  180
OUT    Beep
CALL   Delay
ADDI  190
OUT    Beep
CALL   Delay
JUMP 0

; Subroutine to delay for 0.2 seconds.
Delay:
	OUT    Timer
WaitingLoop:
	IN     Timer
	ADDI   -2
	JNEG   WaitingLoop
	RETURN

; IO address constants
Switches:  EQU 000
LEDs:      EQU 001
Timer:     EQU 002
Hex0:      EQU 004
Hex1:      EQU 005
Beep:      EQU &H40
