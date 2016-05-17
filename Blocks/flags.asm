; Using Flags
flag0		EQU		PSW.5
flag1		EQU		PSW.1
	
	; Inicialização
	CLR 	flag0
	CLR		flag1
	
	; Conditional Jumps
	JB		flag0, branch	; Desvia se flag0 = 1
	JNB		flag0, branch	; Desvia se flag0 = 0
	JBC		flag0, branch	; Desvia se flag0 = 1 e limpa flag0 logo depois