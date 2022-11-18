; BeepTest.asm
; Sends the value from the switches to the
; tone generator peripheral once per second.

ORG 0
LOADI  357
OUT    Beep
CALL   Delay
LOADI  535
OUT    Beep
CALL   Delay
LOADI  535
OUT    Beep
CALL   Delay
LOADI  300
OUT    Beep
CALL   Delay
LOADI  300
OUT    Beep
CALL   Delay
LOADI  535
OUT    Beep
CALL   Delay
LOADI  535
OUT    Beep
CALL   Delay
LOADI  477
OUT    Beep
CALL   Delay
LOADI  477
OUT    Beep
CALL   Delay
LOADI  450
OUT    Beep
CALL   Delay
LOADI  450
OUT    Beep
CALL   Delay
LOADI  401
OUT    Beep
CALL   Delay
LOADI  401
OUT    Beep
CALL   Delay
LOADI  357
OUT    Beep
CALL   Delay
LOADI  357
OUT    Beep
CALL   Delay
LOADI  535
OUT    Beep
CALL   Delay
LOADI  535
OUT    Beep
CALL   Delay
LOADI  477
OUT    Beep
CALL   Delay
LOADI  477
OUT    Beep
CALL   Delay
LOADI  450
OUT    Beep
CALL   Delay
LOADI  450
OUT    Beep
CALL   Delay
LOADI  401
OUT    Beep
CALL   Delay
LOADI  401
OUT    Beep
CALL   Delay
LOADI  535
OUT    Beep
CALL   Delay
LOADI  535
OUT    Beep
CALL   Delay
LOADI  477
OUT    Beep
CALL   Delay
LOADI  477
OUT    Beep
CALL   Delay
LOADI  450
OUT    Beep
CALL   Delay
LOADI  450
OUT    Beep
CALL   Delay
LOADI  401
OUT    Beep
CALL   Delay
LOADI  401
OUT    Beep
CALL   Delay
LOADI  357
OUT    Beep
CALL   Delay
LOADI  357
OUT    Beep
CALL   Delay
LOADI  535
OUT    Beep
CALL   Delay
LOADI  535
OUT    Beep
CALL   Delay
LOADI  601
OUT    Beep
CALL   Delay
LOADI  601
OUT    Beep
CALL   Delay
LOADI  535
OUT    Beep
CALL   Delay
LOADI  477
OUT    Beep
CALL   Delay
LOADI  477
OUT    Beep
CALL   Delay
LOADI  450
OUT    Beep
CALL   Delay
LOADI  450
OUT    Beep
CALL   Delay
LOADI  401
OUT    Beep
CALL   Delay
LOADI  401
OUT    Beep
CALL   Delay
LOADI  357
OUT    Beep
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
