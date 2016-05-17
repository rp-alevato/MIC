; Utilizar vetor de dados
vecStart 	EQU 	60H		; Posição que inicia o vetor de dados. Opcional

	MOV 	DPTR, #vector	; Coloca a posição do vetor em DPTR
	MOVC	A, @A+DPTR		; Anda pelos elementos do vetor
	
	
	
	ORG		vecStart
	
vector:
	DB		000H, 001H, 0F2H	; Elementos do vetor separados por vírgula