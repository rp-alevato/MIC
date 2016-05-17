;Programa ADDVECT.asm
RESET 		EQU 	0H
VETOR 		EQU 	60H
	
			ORG 	RESET ; PC = 0000H ao se resetar o 8051
			MOV 	DPTR, #NRO ; endereco nro parcelas a ser somado
			MOV 	A, #0
			MOVC 	A, @A+DPTR
			MOV 	R3, A ; R3 = nro parcelas a ser somado
			MOV 	DPTR, #DADOS ; end. vetor de dados a ser somado
			MOV 	R0, #50H ; Endereço da memória interna
			MOV 	R2, #0 ; especifica parcela a ser lida do vetor de dados
			MOV		R1, #0H ; Endereço da memória externa
			MOV		P2, #22H	; Move o MSB a ser salvo na posição externa
			
			CJNE	R3, #0H, VOLTA
			JMP		FIM
			
VOLTA: 		MOV 	A, R2
			MOVC 	A, @A+DPTR ; le parcela
			MOV 	@R0, A
			MOVX	@R1, A
			INC 	R0
			INC		R2
			INC		R1
			DJNZ 	R3, VOLTA
			
FIM: 		JMP 	FIM

			ORG 	VETOR
NRO: 		DB 		05H
DADOS: 		DB 		01H, 02H, 03H, 04H, 05H
			END