;程式功能:四顆七段顯示器顯示數字(2014)
#include "tx3703.inc"

	org 000h
	ajmp Start
	org 400h
Start:

	mov p0oe,#11111111b;
	mov p0,#11111111b;
	mov p2oe,#11111111b;
	mov p2,#11111111b;

S1:
	mov p0,#11100100b
	mov p2,#11111111b
	acall delay_1s
	
	mov p0,#11010001b
	mov p2,#11111111b
	acall delay_1s
	
	mov p0,#10110000b
	mov p2,#11111111b
	acall delay_1s
	
	mov p0,#01110010b
	mov p2,#11111111b
	acall delay_1s
	
	jmp S1
	
delay_1s:
	MOV R5,#3
	D1:
	MOV R6,#25
	DJNZ R6,$
	DJNZ R5,D1
	RET
	
	END