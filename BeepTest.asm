; BeepTest.asm
; Sends the value from the switches to the
; tone generator peripheral once per second.

ORG 0

	; Get the switch values
	ADDI	70
	; Send to the peripheral
	OUT    Beep
	; Delay for 1 second
	CALL   Delay
	ADDI	5
	; Send to the peripheral
	OUT    Beep
	; Delay for 1 second
	CALL   Delay
	ADDI	4
	; Send to the peripheral
	OUT    Beep
	; Delay for 1 second
	CALL   Delay
	ADDI	6
	; Send to the peripheral
	OUT    Beep
	; Delay for 1 second
	CALL   Delay
	ADDI	3
	; Send to the peripheral
	OUT    Beep
	; Delay for 1 second
	CALL   Delay
	; Do it again
	ADDI	5
	; Send to the peripheral
	OUT    Beep
	; Delay for 1 second
	CALL   Delay
	ADDI	6
	; Send to the peripheral
	OUT    Beep
	; Delay for 1 second
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
