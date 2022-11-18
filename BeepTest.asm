; BeepTest.asm
; Sends the value from the switches to the
; tone generator peripheral once per second.

ORG 0
LOADI  337
OUT    Beep
CALL   Delay
LOADI  300
OUT    Beep
CALL   Delay
LOADI  268
OUT    Beep
CALL   Delay
CALL   Delay
LOADI  337
OUT    Beep
CALL   Delay
LOADI  300
OUT    Beep
CALL   Delay
LOADI  268
OUT    Beep
CALL   Delay
CALL   Delay
LOADI  268
OUT    Beep
LOADI  268
OUT    Beep
LOADI  268
OUT    Beep
LOADI  268
OUT    Beep
LOADI  300
OUT    Beep
LOADI  300
OUT    Beep
LOADI  300
OUT    Beep
LOADI  300
OUT    Beep
LOADI  337
OUT    Beep
CALL   Delay
LOADI  300
OUT    Beep
CALL   Delay
LOADI  268
OUT    Beep
CALL   Delay
CALL   Delay
CALL   Delay
CALL   Delay
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
