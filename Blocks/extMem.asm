; Mover para memória externa
xMem		EQU		02000H		; Primeira maneira utilizando DPTR
xMemLS		EQU		000H		; Segunda maneira utilizando registrador e porta P2
xMemMS		EQU		020H

	; Primeira maneira
	MOV		DPTR, #xMem
	MOVX	A, @DPTR		; Lê da memória o que tem na posição apontada por DPTR e salva em A
	MOVX	@DPTR, A		; Salva na memória o conteúdo de A na posição apontada por DPTR
	
	; Segunda maneira, melhor quando MS nibble é fixo
	MOV		P2, #xMemMS		; A porta P2 fica responsável por apontar a parte MS da posição da memória
	MOV		R1, #xMemLS		; Ou um valor que se altera no código. Precisa ser R0 ou R1
	MOVX	A, @R1			; Lê da memória o que tem na posição apontada por R0 ou R1 e salva em A
	MOVX	@R1, A			; Salva na memória o conteúdo de A na posição apontada por R0 ou R1