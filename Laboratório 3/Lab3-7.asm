;programa mostra1.asm
cs				equ 		p0.7
end0			equ 		p3.3
end1 			equ 		p3.4
enrot			equ		p2.7
bitrot			equ		p2.6
delayam		equ		0FFH

				org 		000h
				clr			cs
				
				mov		r4, #000h
				mov		r3, #000h
				mov		r2, #00000001b
				mov		a, r2
				cpl		a
				mov		p1, a
				
rotled:		jb			enrot, ending

				mov		a, p2
				cpl		a
				anl		a, #00Fh
				mov		r3, a
				
				jnb		bitrot, crotright
				call		rotleft
				jmp		ending
crotright:	call		rotright

ending:		jmp		rotled

rotleft:		mov		a, r2
				cpl		a
rln:			rl			a
				djnz		r3, rln
				mov		p1, a
				cpl		a
				mov		r2, a
				call		delayini
				ret
				
rotright:		mov		a, r2
				cpl		a
rrn:			rr			a
				djnz		r3, rrn
				mov		p1, a
				cpl		a
				mov		r2, a
				call		delayini
				ret

delayini:		mov		r3, #delayam
				mov		r4, #delayam
delay:		djnz		r4, delay
				mov		r4, #delayam
				djnz		r3, delay
				ret
				
				end