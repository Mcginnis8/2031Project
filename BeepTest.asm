; BeepTest.asm
; Sends the value from the switches to the
; tone generator peripheral once per second.

ORG 0
	LOADI 50
	OUT Duration
	; Get the switch values
	IN     	Switches
	; Send to the peripheral
	OUT		Hex0
	OUT 	chnSel
	OUT    	Beep
	; Delay for 1 second
	;CALL   	Delay
	; Do it again
	;JUMP 0
	JUMP END
	
; Subroutine to delay for 0.2 seconds.
Delay:
	OUT    Timer
WaitingLoop:
	IN     Timer
	ADDI   -2
	JNEG   WaitingLoop
	RETURN
	
END:
	;JUMP END

; IO address constants
Switches:  EQU 000
LEDs:      EQU 001
Timer:     EQU 002
Hex0:      EQU 004
Hex1:      EQU 005
Left:	   DW  &B01
Beep:      EQU &H40
ChnSel:	   EQU &H41
Duration:  EQU &H42
