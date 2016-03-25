;ж╣╡{жбмOлЎлЎ┴фзт╝╞жr┼уе▄жbит┴√дCмq┼уе▄╛╣дWн▒
;P0▒╡иь╝╥▓╒M6е╬и╙▒▒июит┴√дCмq┼уе▄╛╣
;P3▒╡иь╝╥▓╒M9е╬и╙▒▒июлЎ┴ф
#include "tx3703.inc"

digit1 equ 20h 		;дCмq┼уе▄╛╣╝╞жrд@
digit2 equ 21h 		;дCмq┼уе▄╛╣╝╞жrдG
digit3 equ 00h
X	equ 	00H
Y	equ 	00H
sign equ 1B

org 00h

ajmp Start

org 400h
Start:

	acall IO
	mov digit1,#0f0h
	mov digit2,#0f0h
S1:	acall ShowDigits
	
	; └╦мdмOз_ж│лЎ┴ф│QлЎдU
CheckKey: 
	mov p3,#0ffh 	;▓M░глЎ┴фкм║A
	mov p3,#00fh 	;▒N┴ф╜LжCжьз}(bits4~7)┼▄жизC╣qжьбB▒N┴ф╜Lжцжьз}(bits0~3)┼▄жи░к╣qжь
	nop	   			;╝╚жs╛╣жsи·╜w╜─
	nop
	nop
	nop
	nop
	mov A,p3 		;┼ки·┴ф╜Lкм║AбAиSлЎ┴ф└│мO0FH
	add A,#0f0h 		;+F0H
	inc A 			;▓╓е[╛╣Aе[д@бAжpиSлЎ┴ф=0
	jz  S1			;зP┬_▓╓е[╛╣AмOз_=0;иSлЎ┴ф(A=0)бAж^иьS1;ж│лЎ┴флh░їжцдUжцл№еO
	ajmp DeNoise 	;ж│лЎ┴фбA╕їиьDeNoiseеh░г╝u╕ї
	 	

	; еh░г╝u╕ї
DeNoise: 
	acall delay 
	;жAж╕└╦мdмOз_ж│лЎ┴ф│QлЎдU
	mov p3,#0ffh 	;▓M░глЎ┴фкм║A
	mov p3,#00fh 	;▒N┴ф╜LжCжьз}(bits4~7)┼▄жизC╣qжьбB▒N┴ф╜Lжцжьз}(bits0~3)┼▄жи░к╣qжь
	nop	 			;╝╚жs╛╣жsи·╜w╜─
	nop
	nop
	nop
	nop
	mov A,p3 		;┼ки·┴ф╜Lкм║AбAиSлЎ┴ф└│мO0FH
	add A,#0f0h 	;+F0H
	inc A 			;▓╓е[╛╣Aе[д@бAжpиSлЎ┴ф=0
	jz S1 			;зP┬_▓╓е[╛╣AмOз_=0;иSлЎ┴ф(A=0)бAж^иьS1;ж│лЎ┴флh░їжцдUжцл№еO
	ajmp Row1 		;ж│лЎ┴фбAиьRow1└╦мdлЎдFд░╗Є┴ф
	
Row1: ; └╦мd▓─д@жCмOз_ж│лЎ┴ф│QлЎдU
	mov p3,#0ffh 		;▓M░глЎ┴фкм║A
	mov p3,#0efh 		;▒N┴ф╜L▓─д@жC(bit 4)┼▄жизC╣qжь
	nop	 				;╝╚жs╛╣жsи·╜w╜─
	nop
	nop
	nop
	nop
	mov A,p3 			;┼ки·┴ф╜Lкм║AбAиSлЎ┴ф└│мOefh
	add A,#10h 			;+10h
	inc A 				;▓╓е[╛╣Aе[д@бAжpиSлЎ┴ф=0
	jz Row2				;зP┬_▓╓е[╛╣AмOз_=0;иSлЎ┴фбA└╦мd▓─дGжC;ж│лЎ┴флh░їжцдUжцл№еO
	ajmp Key1 			;ж│лЎ┴фбA└╦мdмOз_лЎдF'1'
Key1: 
	jnb p3.0,K1 
	mov digit3,#C1H 
	JNB sign,temp;
	ajmp Key2 			;'1'иS│QлЎдUбA└╦мdмOз_лЎдF'2'
K1: 					;'1'│QлЎдUбA│]йwдCмq┼уе▄╛╣м░01
	mov  digit1,#0f1h	;│]йwдCмq┼уе▄╛╣к║▓─д@н╙╝╞жrм░2
	mov  digit2,#0f0h	;│]йwдCмq┼уе▄╛╣к║▓─д@н╙╝╞жrм░0
	ajmp WaitRelease 	;╡ел▌лЎ┴фйё╢}
	
Key2: 
	jnb p3.1,K2
	mov digit3,#F2H 
	
	ajmp Key3 			;'2'иS│QлЎдUбA└╦мdмOз_лЎдF'3'
K2:  					;'2'│QлЎдUбA│]йwдCмq┼уе▄╛╣м░02
	mov digit1,#0f2h 	;│]йwдCмq┼уе▄╛╣к║▓─д@н╙╝╞жrм░2
	mov digit2,#0f0h 	;│]йwдCмq┼уе▄╛╣к║▓─дGн╙╝╞жrм░0
	ajmp WaitRelease 	;╡ел▌лЎ┴фйё╢}
	
Key3: 
	jnb p3.2,K3			;└╦мd'3'мOз_│QлЎдU
	Mov digit3,#F3H 	
	ajmp KeyA 			;'3'иS│QлЎдUбAй╥еHмO'A'│QлЎдU
K3: 					;'3'│QлЎдUбA│]йwдCмq┼уе▄╛╣м░03
	mov digit1,#0f3h 	;│]йwдCмq┼уе▄╛╣к║▓─д@н╙╝╞жrм░3
	mov digit2,#0f0h 	;│]йwдCмq┼уе▄╛╣к║▓─дGн╙╝╞жrм░0
	ajmp WaitRelease 	;╡ел▌лЎ┴фйё╢}	
	
KeyA: 					;'A'│QлЎдUбA│]йwдCмq┼уе▄╛╣м░10
	;mov digit1,#0f0h 	;│]йwдCмq┼уе▄╛╣к║▓─д@н╙╝╞жrм░0
	;mov digit2,#0f1h	;│]йwдCмq┼уе▄╛╣к║▓─дGн╙╝╞жrм░1
	MOV X,digit3
	MOV sign,0B
	ajmp WaitRelease 	;╡ел▌лЎ┴фйё╢}
	
Row2: 					;└╦мd▓─дGжCмOз_ж│лЎ┴ф│QлЎдU
	mov p3,#0ffh 		;▓M░глЎ┴фкм║A
	mov p3,#0dfh 		;▒N┴ф╜L▓─дGжC(bit 5)┼▄жизC╣qжь
	nop	 				;╝╚жs╛╣жsи·╜w╜─
	nop
	nop
	nop
	nop
	mov A,p3 			;┼ки·┴ф╜Lкм║AбAиSлЎ┴ф└│мOdfh
	add A,#20h 			;+20h
	inc A 				;▓╓е[╛╣Aе[д@бAжpиSлЎ┴ф=0
	jz Row3				;зP┬_▓╓е[╛╣AмOз_=0;иSлЎ┴фбA└╦мd▓─дTжC;ж│лЎ┴флh░їжцдUжцл№еO
	ajmp Key4 			;ж│лЎ┴фбA└╦мdмOз_лЎдF'4'
	
Key4:
	jnb p3.0,K4 		;└╦мd'4'мOз_│QлЎдU
	Mov digit3,#F4H 
	ajmp Key5 			;'4'иS│QлЎдUбA└╦мdмOз_лЎдF'5'
K4: 					;'4'│QлЎдUбA│]йwдCмq┼уе▄╛╣м░04
	mov  digit1,#0f4h 	;│]йwдCмq┼уе▄╛╣к║▓─д@н╙╝╞жrм░4
	mov  digit2,#0f0h 	;│]йwдCмq┼уе▄╛╣к║▓─д@н╙╝╞жrм░0
	ajmp WaitRelease 	;╡ел▌лЎ┴фйё╢} 
	
Key5: 
	jnb p3.1,K5 		;└╦мd'5'мOз_│QлЎдU
	Mov digit3,#F5H 
	ajmp Key6 			;'5'иS│QлЎдUбA└╦мdмOз_лЎдF'6'
K5: 					;'5'│QлЎдUбA│]йwдCмq┼уе▄╛╣м░05
	mov  digit1,#0f5h 	;│]йwдCмq┼уе▄╛╣к║▓─д@н╙╝╞жrм░5
	mov  digit2,#0f0h 	;│]йwдCмq┼уе▄╛╣к║▓─д@н╙╝╞жrм░0
	ajmp WaitRelease 	;╡ел▌лЎ┴фйё╢} 
	
Key6: 
	jnb p3.2,K6 		;└╦мd'6'мOз_│QлЎдU
	Mov digit3,#F6H 	
	ajmp KeyB 			;'6'иS│QлЎдUбA└╦мdмOз_лЎдF'B'
K6: 					;'6'│QлЎдUбA│]йwдCмq┼уе▄╛╣м░06
	mov  digit1,#0f6h 	;│]йwдCмq┼уе▄╛╣к║▓─д@н╙╝╞жrм░6
	mov  digit2,#0f0h 	;│]йwдCмq┼уе▄╛╣к║▓─д@н╙╝╞жrм░0
	ajmp WaitRelease 	;╡ел▌лЎ┴фйё╢} 
	
KeyB:					;'B'│QлЎдUбA│]йwдCмq┼уе▄╛╣м░11 
	;mov  digit1,#0f1h 	;│]йwдCмq┼уе▄╛╣к║▓─д@н╙╝╞жrм░1
	;mov  digit2,#0f1h	;│]йwдCмq┼уе▄╛╣к║▓─д@н╙╝╞жrм░1
	MOV A,X;
	ADD A,Y;
	ajmp WaitRelease 	;╡ел▌лЎ┴фйё╢}
	
Row3: 					;└╦мd▓─дTжCмOз_ж│лЎ┴ф│QлЎдU
	mov p3,#0ffh 		;▓M░глЎ┴фкм║A
	mov p3,#0bfh 		;▒N┴ф╜L▓─д@жC(bit 6)┼▄жизC╣qжь
	nop	 				;╝╚жs╛╣жsи·╜w╜─
	nop
	nop
	nop
	nop
	mov A,p3 			;┼ки·┴ф╜Lкм║AбAиSлЎ┴ф└│мObfh
	add A,#40h 			;+40h
   	inc A 				;▓╓е[╛╣Aе[д@бAжpиSлЎ┴ф=0 
	jz Row4				;зP┬_▓╓е[╛╣AмOз_=0;иSлЎ┴фбA└╦мd▓─е|жC;ж│лЎ┴флh░їжцдUжцл№еO
	ajmp Key7 			;ж│лЎ┴фбA└╦мdмOз_лЎдF'7'
Key7:
	jnb p3.0,K7 		;└╦мd'7'мOз_│QлЎдU
	Mov digit3,#F7H 
	ajmp Key8 			;'7'иS│QлЎдUбA└╦мdмOз_лЎдF'8'
K7: 					;'7'│QлЎдUбA│]йwдCмq┼уе▄╛╣м░07
	mov  digit1,#0f7h 	;│]йwдCмq┼уе▄╛╣к║▓─д@н╙╝╞жrм░7
	mov  digit2,#0f0h 	;│]йwдCмq┼уе▄╛╣к║▓─д@н╙╝╞жrм░0
	ajmp WaitRelease 	;╡ел▌лЎ┴фйё╢}
Key8:
	jnb p3.1,K8 		;└╦мd'8'мOз_│QлЎд
	mov digit3,#F8H 
	
	ajmp Key9 			;'8'иS│QлЎдUбA└╦мdмOз_лЎдF'9'
K8: 					;'8'│QлЎдUбA│]йwдCмq┼уе▄╛╣м░08
	mov  digit1,#0f8h 	;│]йwдCмq┼уе▄╛╣к║▓─д@н╙╝╞жrм░8
	mov  digit2,#0f0h 	;│]йwдCмq┼уе▄╛╣к║▓─д@н╙╝╞жrм░0
	ajmp WaitRelease 	;╡ел▌лЎ┴фйё╢}  
Key9:
	jnb p3.2,K9 		;└╦мd'9'мOз_│QлЎдU
	ajmp KeyC 			;'9'иS│QлЎдUбA└╦мdмOз_лЎдF'C'
K9: 					;'9'│QлЎдUбA│]йwдCмq┼уе▄╛╣м░09
	mov  digit1,#0f9h	;│]йwдCмq┼уе▄╛╣к║▓─д@н╙╝╞жrм░9
	mov digit3,#F9H 
	mov  digit2,#0f0h	;│]йwдCмq┼уе▄╛╣к║▓─д@н╙╝╞жrм░0
	ajmp WaitRelease 	;╡ел▌лЎ┴фйё╢} 
KeyC: 					;'C'│QлЎдUбA│]йwдCмq┼уе▄╛╣м░12
	mov  digit1,#0f2h 	;│]йwдCмq┼уе▄╛╣к║▓─д@н╙╝╞жrм░2
	mov  digit2,#0f1h 	;│]йwдCмq┼уе▄╛╣к║▓─д@н╙╝╞жrм░1
	ajmp WaitRelease 	;╡ел▌лЎ┴фйё╢}
Row4: 					;└╦мd▓─е|жCмOз_ж│лЎ┴ф│QлЎдU
	mov p3,#0ffh 		;▓M░глЎ┴фкм║A
	mov p3,#07fh 		;▒N┴ф╜L▓─д@жC(bit 7)┼▄жизC╣qжь
	nop					;╝╚жs╛╣жsи·╜w╜─
	nop
	nop
	nop
	nop
	mov A,p3 			;┼ки·┴ф╜Lкм║AбAиSлЎ┴ф└│мObfh
	add A,#8h 			;+40h
	inc A 				;▓╓е[╛╣Aе[д@бAжpиSлЎ┴ф=0
	jz WaitRelease		;зP┬_▓╓е[╛╣AмOз_=0;иSлЎ┴фбA╡ел▌лЎ┴фйё╢};ж│лЎ┴флh░їжцдUжцл№еO
	ajmp Key99 			;ж│лЎ┴фбA└╦мdмOз_лЎдF'*' 
Key99:
	jnb p3.0,K99 		;└╦мd'*'мOз_│QлЎдU
	ajmp Key0 			;'*'иS│QлЎдUбA└╦мdмOз_лЎдF'0'
K99: 					;'*'│QлЎдUбA│]йwдCмq┼уе▄╛╣м░99
	mov  digit1,#0f9h	;│]йwдCмq┼уе▄╛╣к║▓─д@н╙╝╞жrм░9
	mov  digit2,#0f9h	;│]йwдCмq┼уе▄╛╣к║▓─д@н╙╝╞жrм░9
	ajmp WaitRelease 	;╡ел▌лЎ┴фйё╢} 
Key0:
	jnb p3.1,K0 		;└╦мd'0'мOз_│QлЎдU
	ajmp Key20 			;'0'иS│QлЎдUбA└╦мdмOз_лЎдF'#'
K0: 					;'0'│QлЎдUбA│]йwдCмq┼уе▄╛╣м░00
	mov  digit1,#0f0h	;│]йwдCмq┼уе▄╛╣к║▓─д@н╙╝╞жrм░0
	mov  digit2,#0f0h	;│]йwдCмq┼уе▄╛╣к║▓─д@н╙╝╞жrм░0
	ajmp WaitRelease 	;╡ел▌лЎ┴фйё╢} 
Key20:
	jnb p3.2,K20 		;└╦мd'#'мOз_│QлЎдU
	ajmp KeyD 			;'#'иS│QлЎдUбA└╦мdмOз_лЎдF'D'
K20: 					;'20'│QлЎдUбA│]йwдCмq┼уе▄╛╣м░20
	mov  digit1,#0f0h	;│]йwдCмq┼уе▄╛╣к║▓─д@н╙╝╞жrм░0
	mov  digit2,#0f2h	;│]йwдCмq┼уе▄╛╣к║▓─д@н╙╝╞жrм░2
	ajmp WaitRelease 	;╡ел▌лЎ┴фйё╢} 
KeyD: 					;'D'│QлЎдUбA│]йwдCмq┼уе▄╛╣м░13
	mov  digit1,#0f3h 	;│]йwдCмq┼уе▄╛╣к║▓─д@н╙╝╞жrм░3
	mov  digit2,#0f1h 	;│]йwдCмq┼уе▄╛╣к║▓─д@н╙╝╞жrм░1
	ajmp WaitRelease 	;╡ел▌лЎ┴фйё╢}
	
; ╡ел▌и╧е╬к╠йё╢}лЎ┴ф
WaitRelease: 
	acall ShowDigits 	;┼уе▄дCмq┼уе▄╛╣д║оe
	mov p3,#0ffh 		;▓M░глЎ┴фкм║A
	mov p3,#0fh  		;▒N0fh╝gдJPDD
	nop	 				;╝╚жs╛╣жsи·╜w╜─
	nop
	nop
	nop
	nop
	mov A,p3   			;┼ки·┴ф╜Lкм║AбAнYйё╢}лЎ┴ф└│мO0fh
	add A,#0f0h			;+f0h
	inc A				;и·▒oлЎ┴фкм║AбAнYйё╢}лЎ┴ф└│мOffh; нYлЎ┴фкм║A+1╡ейє0бAкэе▄йё╢}лЎ┴ф
	jz S11 				;ж^иьS1
	ajmp WaitRelease	;иSйё╢}лЎ┴фбA─~─Є╡ел▌
S11:
	ajmp S1;ж^иьS1
	

temp:
    MOV,Y,digit3
	RET
	
	
	
ShowDigits: 
						;┼уе▄дCмq┼уе▄╛╣▓─д@н╙╝╞жr
	mov P0,X 		;┐щеX▓─д@н╙╝╞жrк║д║оe
	clr P0.4 			;▒N▓─д@н╙дCмq┼уе▄╛╣┬IлG
	acall delay 		;╡ел▌5ms
	setb P0.4 			;▒N▓─д@н╙дCмq┼уе▄╛╣├Ў▒╝
						;┼уе▄дCмq┼уе▄╛╣▓─дGн╙╝╞жr
	mov P0,Y	;┐щеX▓─дGн╙╝╞жrк║д║оe
	clr P0.5 			;▒N▓─дGн╙дCмq┼уе▄╛╣┬IлG
	acall delay 		;╡ел▌5ms
	setb P0.5 			;▒N▓─дGн╙дCмq┼уе▄╛╣├Ў▒╝
	ret 				;кЁж^еD╡{жб

IO:						;│]йwIOеHд╬кьйlн╚
	mov p0oe,#11111111b	;│]йwP0м░CMOS┐щеX
	mov p0,#00000000b
	mov p3modl,#00000000b ;│]йwP3.0~3м░pull up input  ;20140123 debug
	mov p3modh,#10101010b ;│]йwP3.4~7м░CMOS output    ;20140123 debug
	mov p3,#11111111b
	ret
delay:
	MOV R5,#10
D1:	MOV R6,#20
	DJNZ R6,$
	DJNZ R5,D1
	RET	

	END
