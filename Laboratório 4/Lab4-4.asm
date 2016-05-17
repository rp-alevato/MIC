reset 		EQU 	000H
LTInt0 		EQU 	003H 	; local do tratador da Ext. 0
LTInt1		EQU		013H	; local do tratador da Ext. 1
flag0		EQU		PSW.5
flag1		EQU		PSW.1
delayAm		EQU		0FFH
	
	ORG 	reset 			; PC = 0 depois de reset
	JMP 	start
	
	ORG 	LTInt0			; Tratador 0
	CPL		flag0
	RETI
	
	ORG 	LTInt1			; Tratador 1
	CPL		flag1
	RETI
			
start: 	
	MOV 	IE,#10000101B 	; Habilita Int. Ext. 0 e 1
	SETB 	IT0 			; Habilita por borda
	SETB	IT1
	
	; Inicialização das variáveis
	CLR 	flag0
	CLR		flag1
	MOV 	R1, #10000000B
	MOV		P1, R1
	MOV		R3, #000H
	MOV		R4, #000H

loop:
	JNB		flag1, loop
	JB		flag0, rotL
	
; rotR
	MOV		A, R1
	RR		A
	MOV		R1, A
	MOV		P1, R1
	CALL	delay
	JMP		loop

rotL:
	MOV		A, R1
	RL		A
	MOV		R1, A
	MOV		P1, R1
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