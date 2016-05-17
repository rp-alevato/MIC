enDisp		EQU 		P0.7	; Bit CS que ativa os displays 7 seg.
decodDL		EQU 		P3.3	; Least significant bit do decoder dos displays
decodDM 	EQU 		P3.4;	; Most significant bit do decoder dos displays
	
	ORG		000H
	SETB	enDisp		; Ativa o display
	CLR		decodDL		; Escolhe o primeiro display pelo decoder -LSB = 0
	CLR		decodDM		; Escolhe o primeiro display pelo decoder -MSB = 0
	

; Subrotina que retorna em R0 o valor do dígito pressionado no teclado do EDSIM51
; (Obs: retorna A para * e C para #)
; teclado
; linhas
; +----+----+----+
; | 1 | 2 | 3 | P0.3
; +----+----+----+
; | 4 | 5 | 6 | P0.2
; +----+----|----+
; | 7 | 8 | 9 | P0.1
; +----+----+----+
; | A | 0 | C | P0.0
; +----+----+----+
; colunas P0.6 P0.5 P0.4
keypad:

	ORL		P0,#07FH 	; Escreve ‘1’ em 7 pinos da porta P0
	CLR		F0			; Limpa flag que identifica tecla pressionada
	MOV		R0, #000H	; Limpa R0 – retorna o número da tecla foi pressionada
	
	; Varre primeira linha
	CLR		P0.3		; Coloca ‘0’ na linha P0.3
	CALL	colScan		; Chama rotina para varredura de coluna
	JB		F0, finish	; Se flag F0 = ‘1’, tecla identificada => retorna
	
	; Varre segunda linha
	SETB P0.3			; Seta linha P0.3
	CLR P0.2			; Coloca ‘0’ na linha P0.2
	CALL colScan		; Chama rotina para varredura de coluna
	JB F0, finish		; Se flag F0 = ‘1’, tecla identificada => retorna
	
	; Varre terceira linha
	SETB P0.2 			; Seta linha P0.2
	CLR P0.1 			; Coloca ‘0’ na linha P0.1
	CALL colScan 		; Chama rotina para varredura de coluna
	JB F0, finish 		; Se flag F0 = ‘1’, tecla identificada => retorna

	; Varre quarta linha
	SETB P0.1			; Seta linha P0.1
	CLR P0.0			; Coloca ‘0’ na linha P0.0
	CALL colScan		; Chama rotina para varredura de coluna
	JB F0, finish		; Se flag F0 = ‘1’, tecla identificada => retorna
	JMP keypad			; Se flag F0 = ‘0’, tecla não identificada => repete varredura

; Subrotina que coloca o keypad no display 0
finish:
	MOV		A, 	R0
	CALL	converte
	MOV		P1, A
	JMP		keypad
	
; Subrotina que varre as colunas para identificar a qual pertence a tecla pressionada
; o registrador R0 é incrementado a cada insucesso de forma a conter o nro. da tecla
; pressionada
colScan:

	JNB P0.6, gotKey	; Tecla pressionada pertence a esta coluna – retornar
	INC R0
	JNB P0.5, gotKey	; Tecla pressionada pertence a esta coluna – retornar
	INC R0
	JNB P0.4, gotKey	; Tecla pressionada pertence a esta coluna – retornar
	INC R0
	RET					; Tecla pressionada não pertence a esta linha – retornar
	
gotKey:

	SETB F0				; Faz flag F0 = ‘1’ => tecla identificada
	RET
	
; Subrotina converte com tabela modificada para o exercício solicitado
converte:

	INC A
	MOVC A,@A+PC
	RET
	
tabela:

	DB 079H, 024H, 030H, 019H, 012H, 002H, 078H, 000H, 010H, 008H, 040H, 046H
		
	END