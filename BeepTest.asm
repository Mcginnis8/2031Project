; BeepTest.asm
; Sends the value from the switches to the
; tone generator peripheral once per second.

ORG 0
LOADI  337
OUT    Beep
CALL   Delay
CALL   Delay
CALL   Delay
CALL   Delay
LOADI 0
OUT    Beep
CALL   Delay2
LOADI  300
OUT    Beep
CALL   Delay
CALL   Delay
CALL   Delay
CALL   Delay
LOADI 0
OUT    Beep
CALL   Delay2
LOADI  268
OUT    Beep
CALL   Delay
CALL   Delay
CALL   Delay
CALL   Delay
LOADI 0
OUT    Beep
CALL   Delay2
CALL   Delay
CALL   Delay
CALL   Delay
CALL   Delay
LOADI 0
OUT    Beep
CALL   Delay2
LOADI  337
OUT    Beep
CALL   Delay
CALL   Delay
CALL   Delay
CALL   Delay
LOADI 0
OUT    Beep
CALL   Delay2
LOADI  300
OUT    Beep
CALL   Delay
CALL   Delay
CALL   Delay
CALL   Delay
LOADI 0
OUT    Beep
CALL   Delay2
LOADI  268
OUT    Beep
CALL   Delay
CALL   Delay
CALL   Delay
CALL   Delay
LOADI 0
OUT    Beep
CALL   Delay2
CALL   Delay
CALL   Delay
CALL   Delay
CALL   Delay
LOADI 0
OUT    Beep
CALL   Delay2
LOADI  268
OUT    Beep
CALL   Delay
CALL   Delay
LOADI 0
OUT    Beep
CALL   Delay2
LOADI  268
OUT    Beep
CALL   Delay
CALL   Delay
LOADI 0
OUT    Beep
CALL   Delay2
LOADI  268
OUT    Beep
CALL   Delay
CALL   Delay
LOADI 0
OUT    Beep
CALL   Delay2
LOADI  268
OUT    Beep
CALL   Delay
CALL   Delay
LOADI 0
OUT    Beep
CALL   Delay2
LOADI  300
OUT    Beep
CALL   Delay
CALL   Delay
LOADI 0
OUT    Beep
CALL   Delay2
LOADI  300
OUT    Beep
CALL   Delay
CALL   Delay
LOADI 0
OUT    Beep
CALL   Delay2
LOADI  300
OUT    Beep
CALL   Delay
CALL   Delay
LOADI 0
OUT    Beep
CALL   Delay2
LOADI  300
OUT    Beep
CALL   Delay
CALL   Delay
LOADI 0
OUT    Beep
CALL   Delay2
LOADI  337
OUT    Beep
CALL   Delay
CALL   Delay
CALL   Delay
CALL   Delay
LOADI 0
OUT    Beep
CALL   Delay2
LOADI  300
OUT    Beep
CALL   Delay
CALL   Delay
CALL   Delay
CALL   Delay
LOADI 0
OUT    Beep
CALL   Delay2
LOADI  268
OUT    Beep
CALL   Delay
CALL   Delay
CALL   Delay
CALL   Delay
LOADI 0
OUT    Beep
CALL   Delay2
CALL   Delay
CALL   Delay
CALL   Delay
CALL   Delay
LOADI 0
OUT    Beep
CALL   Delay2
JUMP 0







; Subroutine to delay for 0.2 seconds.
Delay:
	OUT    Timer
WaitingLoop:
	IN     Timer
	ADDI   -2
	JNEG   WaitingLoop
	RETURN
	
Delay2:
	OUT    Timer
WaitingLoop2:
	IN     Timer
	ADDI   -1
	JNEG   WaitingLoop2
	RETURN

; IO address constants
Switches:  EQU 000
LEDs:      EQU 001
Timer:     EQU 002
Hex0:      EQU 004
Hex1:      EQU 005
Beep:      EQU &H40
