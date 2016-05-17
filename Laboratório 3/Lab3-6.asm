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
				
movleft:		mov		a, r2
				cpl		a
				mov		p1, a
				call		delayini
				cpl		a
				rlc			a
				orl			a, r2
				mov		r2, a
				jnc 		movleft
				
				mov		r2, #01111111b
moveright:	mov		a, r2
				cpl		a
				mov		p1, a
				call		delayini
				cpl		a
				rrc		a
				anl		a, r2
				mov		r2, a
				jc 			moveright
				
				jmp		start
				
delayini:		mov		r3, #delayam
				mov		r4, #delayam
delay:		djnz		r4, delay
				mov		r4, #delayam
				djnz		r3, delay
				ret
				
				end