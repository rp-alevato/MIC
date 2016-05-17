; Rafael Pintar Alevato - Turma A
TrInt1		EQU		013H
RESET		EQU		000H
flag0		EQU		PSW.5
flag1		EQU		PSW.1

	ORG 	RESET
	JMP		start
	
	ORG		TrInt1
	SETB	flag0
	RETI

start:
	; Inicialização
	MOV 	IE,#10000100B 	; Habilita Int. Ext. 1
	SETB	IT1				; Habilita por borda int1
	CLR		flag0
	MOV		R2, #000H
	MOV		R3, #000H
	MOV		R1, #11111110B
	MOV		P2, R1
	
main:
	JNB		flag0, main
	
	CLR		flag0
	JBC		flag1, secTime
	
	SETB	flag1
	MOV		R2, P1
	JMP		main

secTime:
	MOV		R3, P1
	CJNE	R2, #000H, rotRight

rotLeft:
	MOV		A, R1
	RL		A
	MOV		R1, A
	MOV		P2, R1
	DJNZ	R3, rotLeft
	JMP 	main
	
rotRight:
	MOV		A, R1
	RR		A
	MOV		R1, A
	MOV		P2, R1
	DJNZ	R3, rotRight
	JMP		main	
	
	END