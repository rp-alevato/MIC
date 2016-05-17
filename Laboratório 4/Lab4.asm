reset 		EQU 	000H
lTInt0 		EQU 	003H ; local do tratador da Ext. 0
state0 		EQU 	020H
	
	ORG 	reset 			; PC = 0 depois de reset
	JMP 	inicio
	
	ORG 	lTInt0
	JMP 	handler0
			
inicio: 	
	MOV 	IE,#10000001B 	; Habilita Int. Ext. 0
	SETB 	IT0 			; Habilita por borda
	MOV 	state0, #000H 	; Inicialização
	MOV 	R0, #state0
	MOV 	DPTR, #tabela
	MOV 	R1, #000H

volta: 		
	CJNE 	@R0, #001H, volta
	MOV 	state0, #000H
	MOV 	A, R1
	MOVC 	A, @A+DPTR
	MOV 	P1, A
	INC 	R1
	CJNE 	R1, #016H, volta
	JMP 	$

handler0: 
	MOV 	state0, #001H
	RETI

tabela: 	
	DB 		'Microcontrolador'
	
	END