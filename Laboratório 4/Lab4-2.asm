reset 		EQU 	000H
LTInt0 		EQU 	003H ; local do tratador da Ext. 0
delayAm		EQU		0FFH

	ORG 	reset ; PC=0 depois de reset
	JMP 	start
	
	ORG 	LTInt0
	CPL 	F0
	RETI
	
start:
	MOV		IE, #10000001B
	SETB	IT0
	MOV 	P1, #000H
	MOV 	R2, #000H
	MOV		R3, #000H
	MOV		R4, #000H

loop: 		
	JNB		F0, loop
	INC		R2
	MOV		P1, R2
	CALL	delay
	JMP		loop
		
delay: 
	MOV		R3, delayAm
	MOV		R4, delayAm
delayL:
	DJNZ	R3, delayL
	MOV		R3, delayAm
	DJNZ	R4, delayL
	RET

	END