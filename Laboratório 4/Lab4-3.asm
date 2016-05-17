reset 		EQU 	000H
LTInt0 		EQU 	003H 	; local do tratador da Ext. 0
LTInt1		EQU		013H	; local do tratador da Ext. 1
state0 		EQU 	020H
flag0		EQU		PSW.5
flag1		EQU		PSW.1
memxL		EQU		000H
memxM		EQU		020H	
	
	ORG 	reset 			; PC = 0 depois de reset
	JMP 	inicio
	
	ORG 	LTInt0			; Tratador 0
	JMP 	handler0
	
	ORG 	LTInt1			; Tratador 1
	JMP 	handler1
			
inicio: 	
	MOV 	IE,#10000101B 	; Habilita Int. Ext. 0 e 1
	SETB 	IT0 			; Habilita por borda
	SETB	IT1
	
	; Inicialização das variáveis
	CLR 	flag0
	CLR		flag1
	MOV 	DPTR, #tabela
	MOV 	R1, #000H
	MOV		P2, #memxM

; Programa principal que coloca 'Microprocessadores' na P1 com a interrupção
loop: 		
	JB	 	flag0, movTab
	JB		flag1, saveTab
	JMP 	loop

movTab:
	CLR 	flag0
	MOV 	A, R1
	MOVC 	A, @A+DPTR
	MOV 	P1, A
	INC 	R1
	CJNE 	R1, #016H, loop
	MOV		R1, 000H
	JMP		loop

saveTab:
	CLR		flag1
	MOV		A, P1
	DEC		R1
	MOVX	@R1, A
	INC		R1
	JMP		loop

; Se houver interrupção, set o flag0 permitindo colocar outra letra
handler0:
	SETB 	flag0
	RETI

; Se houver interrupção, troca o enable do flag0
handler1: 	
	SETB	flag1
	RETI

tabela: 	
	DB 		'Microcontrolador'
	
	END