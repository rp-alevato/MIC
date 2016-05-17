;programa mostra1.asm
cs				equ 		p0.7
end0			equ 		p3.3;
end1 			equ 		p3.4;
delayam		equ		0FFH
	
				org 		000h
				setb 		end0
				clr 		end1
				setb 		cs
start:		mov		r0, #000h
				mov		r1, #000h
				mov		r2, #00Ah
				
show90:		mov		a, r2
				subb		a, #001h
				call 		converte
				mov 		p1, a
				mov		r1, #delayam
				mov		r0, #delayam
				call		delay
				djnz		r2, show90
				
				jmp 		start
				
delay:		djnz		r1, delay
				mov		r1, #delayam
				djnz		r0, delay
				ret
				
converte: 	inc		a
				movc 	a, @a+pc
				ret
				
tabela: 		db 		040h, 079h, 024h, 030h, 019h, 012h, 002h, 078h, 000h, 010h, 008h, 003h, 046h, 021h, 006h, 00Eh
				end