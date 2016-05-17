;Programa ADDVECT.asm
RESET 		EQU 	000H
MEM1M		EQU		021H	; Endereço do byte mais significante da memória 1
MEM1L		EQU		000H	; Endereço do byte menos significante da memória 1
MEM2M		EQU		023H	; Endereço do byte mais significante da memória 2
MEM2L		EQU		000H	; Endereço do byte menos significante da memória 2
TOTAL		EQU		010H	; Total de vezes que ele anda pela tabela + 1
VETOR		EQU		060H
	
			ORG 	RESET 			; PC = 0000H ao se resetar o 8051	
			MOV		R0, #MEM1L		
			MOV		R1, #MEM2L		
			MOV		R2, #000H		; Anda pelas parcelas
			MOV		DPTR, #DADOS	; Coloca a tabela em DPTR
			
			MOV		P2, #MEM1M		; Necessário para o MOVX
SALVAT1:	MOV		A, R2			; Anda pela tabela e salva em MEM1
			MOVC	A, @A+DPTR
			MOVX	@R0, A
			INC		R2
			INC		R0
			CJNE	R2, #TOTAL, SALVAT1
			
			MOV		R2, #000H
			MOV		R0, #MEM1L
			
SALVA12:	MOV		P2, #MEM1M		; Anda pela MEM1 e salva em MEM2
			MOVX	A, @R0
			MOV		P2, #MEM2M
			MOVX	@R1, A
			INC		R2
			INC		R0
			INC		R1
			CJNE	R2, #TOTAL, SALVA12
			
FIM: 		JMP 	FIM
			
			ORG		VETOR
DADOS: 		DB 		001H, 003H, 005H, 006H, 0AH, 0E2H, 0FFH, 003H, 0AFH, 002H, 01FH, 04BH, 04CH, 089H, 00DH, 004H

			END