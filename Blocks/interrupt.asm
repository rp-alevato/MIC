; Interrupção externa
TrInt0		EQU		003H
TrInt1		EQU		013H
RESET		EQU		000H

	ORG 	RESET
	JMP		start
	
	ORG		TrInt0
	JMP		handler0
	
	ORG		TrInt1
	JMP		handler1

start:
	MOV 	IE,#10000101B 	; Habilita Int. Ext. 1 e 0
	SETB 	IT0 			; Habilita por borda int0
	SETB	IT1				; Habilita por borda int1

handler0:
	; Código do tratador 0 aqui. Utilizar flags ou states.
	RETI

handler1:
	; Código do tratador 1 aqui. Utilizar flags ou states.
	RETI
	
	END