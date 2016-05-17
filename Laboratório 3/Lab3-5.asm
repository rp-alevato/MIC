;programa mostra1.asm
cs				equ 		p0.7
end0			equ 		p3.3;
end1 			equ 		p3.4;
delayam		equ		0FFH
	
				org 		000h
				setb 		end0
				clr 		end1
				clr			cs
				
start:		mov		r4, #000h
				mov		r3, #000h
				mov		r2, #00000001b
				mov		a, r2
				cpl		a
				mov		r2, a
				
movled:		mov		a, r2
				mov		p1, a
				mov		r3, #delayam
				mov		r4, #delayam
				call		delay
				rl			a
				mov		r2, a
				jmp 		movled
				
delay:		djnz		r4, delay
				mov		r4, #delayam
				djnz		r3, delay
				ret
				
				end