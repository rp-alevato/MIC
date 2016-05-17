;programa mostra1.asm
cs				equ 		p0.7
end0			equ 		p3.3;
end1 			equ 		p3.4;
	
				org 		000h
				setb 		end0
				clr 		end1
				setb 		cs
				mov		r0, #000h
				mov		r1, #000h
				mov		r2, #008h
				
getp2:		mov 		a, p2
				cpl		a
				mov		r0, a
				
count1:		mov		a, r0
				rlc			a
				mov		r0, a
				mov		a, #000h
				addc		a, r1
				mov		r1, a
				djnz		r2, count1
				
				call 		converte
				mov 		p1, a
				mov		r2, #008h
				mov		r1, #000h
				jmp 		getp2
				
converte: 	inc		a
				movc 	a, @a+pc
				ret
				
tabela: 		db 		040h, 079h, 024h, 030h, 019h, 012h, 002h, 078h, 000h, 010h, 008h, 003h, 046h, 021h, 006h, 00eh
				end