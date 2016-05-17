;programa mostra1.asm
cs				equ 		p0.7
end0			equ 		p3.3;
end1 			equ 		p3.4;
	
				org 		000h
				setb 		end0
				clr 		end1
				setb 		cs
				
				mov 		a, #001h
				call 		converte
				mov 		p1, a
				jmp 		$
				
converte: 	inc		a
				movc 	a, @a+pc
				ret
				
tabela: 		db 		040h, 079h, 024h, 030h, 019h, 012h, 002h, 078h, 000h, 010h, 008h, 003h, 046h, 021h, 006h, 00eh
				end