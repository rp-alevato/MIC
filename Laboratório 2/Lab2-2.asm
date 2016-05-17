;Programa ADDVECT.asm
RESET 		EQU 	0H
VETOR 		EQU 	60H
	
			ORG 	RESET ; PC = 0000H ao se resetar o 8051
			MOV 	DPTR, #NRO ; endereco nro parcelas a ser somado
			MOV 	A, #0
			MOVC 	A, @A+DPTR
			MOV 	R1, A ; R1 = nro parcelas a ser somado
			MOV 	DPTR, #DADOS ; end. vetor de dados a ser somado
			MOV 	R2, #0 ; guarda resultado das somas realizadas
			MOV 	R0, #0 ; especifica parcela a ser lida do vetor de dados
			
			CJNE	R1, #0H, VOLTA
			JMP		FIM
			
VOLTA: 		MOV 	A, R0
			MOVC 	A, @A+DPTR ; le parcela
			ADD 	A, R2
			MOV 	R2, A
			INC 	R0
			DJNZ 	R1, VOLTA
			
			MOV		P2, #0000H
			MOV		R1, #0000H
			MOV		A, R2
			MOVX	@R1, A
			
FIM: 		JMP 	FIM

			ORG 	VETOR
NRO: 		DB 		03H
DADOS: 		DB 		01H, 03H, 05H, 06H, 0AH, 0E2H
			END