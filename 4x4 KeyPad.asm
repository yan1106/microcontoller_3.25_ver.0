;���{���O�������Ʀr��ܦb�����C�q��ܾ��W��
;P0����Ҳ�M6�Ψӱ�������C�q��ܾ�
;P3����Ҳ�M9�Ψӱ������
#include "tx3703.inc"

digit1 equ 20h 		;�C�q��ܾ��Ʀr�@
digit2 equ 21h 		;�C�q��ܾ��Ʀr�G
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
	
	; �ˬd�O�_������Q���U
CheckKey: 
	mov p3,#0ffh 	;�M�����䪬�A
	mov p3,#00fh 	;�N��L�C��}(bits4~7)�ܦ��C�q��B�N��L���}(bits0~3)�ܦ����q��
	nop	   			;�Ȧs���s���w��
	nop
	nop
	nop
	nop
	mov A,p3 		;Ū����L���A�A�S�������O0FH
	add A,#0f0h 		;+F0H
	inc A 			;�֥[��A�[�@�A�p�S����=0
	jz  S1			;�P�_�֥[��A�O�_=0;�S����(A=0)�A�^��S1;������h����U����O
	ajmp DeNoise 	;������A����DeNoise�h���u��
	 	

	; �h���u��
DeNoise: 
	acall delay 
	;�A���ˬd�O�_������Q���U
	mov p3,#0ffh 	;�M�����䪬�A
	mov p3,#00fh 	;�N��L�C��}(bits4~7)�ܦ��C�q��B�N��L���}(bits0~3)�ܦ����q��
	nop	 			;�Ȧs���s���w��
	nop
	nop
	nop
	nop
	mov A,p3 		;Ū����L���A�A�S�������O0FH
	add A,#0f0h 	;+F0H
	inc A 			;�֥[��A�[�@�A�p�S����=0
	jz S1 			;�P�_�֥[��A�O�_=0;�S����(A=0)�A�^��S1;������h����U����O
	ajmp Row1 		;������A��Row1�ˬd���F������
	
Row1: ; �ˬd�Ĥ@�C�O�_������Q���U
	mov p3,#0ffh 		;�M�����䪬�A
	mov p3,#0efh 		;�N��L�Ĥ@�C(bit 4)�ܦ��C�q��
	nop	 				;�Ȧs���s���w��
	nop
	nop
	nop
	nop
	mov A,p3 			;Ū����L���A�A�S�������Oefh
	add A,#10h 			;+10h
	inc A 				;�֥[��A�[�@�A�p�S����=0
	jz Row2				;�P�_�֥[��A�O�_=0;�S����A�ˬd�ĤG�C;������h����U����O
	ajmp Key1 			;������A�ˬd�O�_���F'1'
Key1: 
	jnb p3.0,K1 
	mov digit3,#C1H 
	JNB sign,temp;
	ajmp Key2 			;'1'�S�Q���U�A�ˬd�O�_���F'2'
K1: 					;'1'�Q���U�A�]�w�C�q��ܾ���01
	mov  digit1,#0f1h	;�]�w�C�q��ܾ����Ĥ@�ӼƦr��2
	mov  digit2,#0f0h	;�]�w�C�q��ܾ����Ĥ@�ӼƦr��0
	ajmp WaitRelease 	;���ݫ����}
	
Key2: 
	jnb p3.1,K2
	mov digit3,#F2H 
	
	ajmp Key3 			;'2'�S�Q���U�A�ˬd�O�_���F'3'
K2:  					;'2'�Q���U�A�]�w�C�q��ܾ���02
	mov digit1,#0f2h 	;�]�w�C�q��ܾ����Ĥ@�ӼƦr��2
	mov digit2,#0f0h 	;�]�w�C�q��ܾ����ĤG�ӼƦr��0
	ajmp WaitRelease 	;���ݫ����}
	
Key3: 
	jnb p3.2,K3			;�ˬd'3'�O�_�Q���U
	Mov digit3,#F3H 	
	ajmp KeyA 			;'3'�S�Q���U�A�ҥH�O'A'�Q���U
K3: 					;'3'�Q���U�A�]�w�C�q��ܾ���03
	mov digit1,#0f3h 	;�]�w�C�q��ܾ����Ĥ@�ӼƦr��3
	mov digit2,#0f0h 	;�]�w�C�q��ܾ����ĤG�ӼƦr��0
	ajmp WaitRelease 	;���ݫ����}	
	
KeyA: 					;'A'�Q���U�A�]�w�C�q��ܾ���10
	;mov digit1,#0f0h 	;�]�w�C�q��ܾ����Ĥ@�ӼƦr��0
	;mov digit2,#0f1h	;�]�w�C�q��ܾ����ĤG�ӼƦr��1
	MOV X,digit3
	MOV sign,0B
	ajmp WaitRelease 	;���ݫ����}
	
Row2: 					;�ˬd�ĤG�C�O�_������Q���U
	mov p3,#0ffh 		;�M�����䪬�A
	mov p3,#0dfh 		;�N��L�ĤG�C(bit 5)�ܦ��C�q��
	nop	 				;�Ȧs���s���w��
	nop
	nop
	nop
	nop
	mov A,p3 			;Ū����L���A�A�S�������Odfh
	add A,#20h 			;+20h
	inc A 				;�֥[��A�[�@�A�p�S����=0
	jz Row3				;�P�_�֥[��A�O�_=0;�S����A�ˬd�ĤT�C;������h����U����O
	ajmp Key4 			;������A�ˬd�O�_���F'4'
	
Key4:
	jnb p3.0,K4 		;�ˬd'4'�O�_�Q���U
	Mov digit3,#F4H 
	ajmp Key5 			;'4'�S�Q���U�A�ˬd�O�_���F'5'
K4: 					;'4'�Q���U�A�]�w�C�q��ܾ���04
	mov  digit1,#0f4h 	;�]�w�C�q��ܾ����Ĥ@�ӼƦr��4
	mov  digit2,#0f0h 	;�]�w�C�q��ܾ����Ĥ@�ӼƦr��0
	ajmp WaitRelease 	;���ݫ����} 
	
Key5: 
	jnb p3.1,K5 		;�ˬd'5'�O�_�Q���U
	Mov digit3,#F5H 
	ajmp Key6 			;'5'�S�Q���U�A�ˬd�O�_���F'6'
K5: 					;'5'�Q���U�A�]�w�C�q��ܾ���05
	mov  digit1,#0f5h 	;�]�w�C�q��ܾ����Ĥ@�ӼƦr��5
	mov  digit2,#0f0h 	;�]�w�C�q��ܾ����Ĥ@�ӼƦr��0
	ajmp WaitRelease 	;���ݫ����} 
	
Key6: 
	jnb p3.2,K6 		;�ˬd'6'�O�_�Q���U
	Mov digit3,#F6H 	
	ajmp KeyB 			;'6'�S�Q���U�A�ˬd�O�_���F'B'
K6: 					;'6'�Q���U�A�]�w�C�q��ܾ���06
	mov  digit1,#0f6h 	;�]�w�C�q��ܾ����Ĥ@�ӼƦr��6
	mov  digit2,#0f0h 	;�]�w�C�q��ܾ����Ĥ@�ӼƦr��0
	ajmp WaitRelease 	;���ݫ����} 
	
KeyB:					;'B'�Q���U�A�]�w�C�q��ܾ���11 
	;mov  digit1,#0f1h 	;�]�w�C�q��ܾ����Ĥ@�ӼƦr��1
	;mov  digit2,#0f1h	;�]�w�C�q��ܾ����Ĥ@�ӼƦr��1
	MOV A,X;
	ADD A,Y;
	ajmp WaitRelease 	;���ݫ����}
	
Row3: 					;�ˬd�ĤT�C�O�_������Q���U
	mov p3,#0ffh 		;�M�����䪬�A
	mov p3,#0bfh 		;�N��L�Ĥ@�C(bit 6)�ܦ��C�q��
	nop	 				;�Ȧs���s���w��
	nop
	nop
	nop
	nop
	mov A,p3 			;Ū����L���A�A�S�������Obfh
	add A,#40h 			;+40h
   	inc A 				;�֥[��A�[�@�A�p�S����=0 
	jz Row4				;�P�_�֥[��A�O�_=0;�S����A�ˬd�ĥ|�C;������h����U����O
	ajmp Key7 			;������A�ˬd�O�_���F'7'
Key7:
	jnb p3.0,K7 		;�ˬd'7'�O�_�Q���U
	Mov digit3,#F7H 
	ajmp Key8 			;'7'�S�Q���U�A�ˬd�O�_���F'8'
K7: 					;'7'�Q���U�A�]�w�C�q��ܾ���07
	mov  digit1,#0f7h 	;�]�w�C�q��ܾ����Ĥ@�ӼƦr��7
	mov  digit2,#0f0h 	;�]�w�C�q��ܾ����Ĥ@�ӼƦr��0
	ajmp WaitRelease 	;���ݫ����}
Key8:
	jnb p3.1,K8 		;�ˬd'8'�O�_�Q���
	mov digit3,#F8H 
	
	ajmp Key9 			;'8'�S�Q���U�A�ˬd�O�_���F'9'
K8: 					;'8'�Q���U�A�]�w�C�q��ܾ���08
	mov  digit1,#0f8h 	;�]�w�C�q��ܾ����Ĥ@�ӼƦr��8
	mov  digit2,#0f0h 	;�]�w�C�q��ܾ����Ĥ@�ӼƦr��0
	ajmp WaitRelease 	;���ݫ����}  
Key9:
	jnb p3.2,K9 		;�ˬd'9'�O�_�Q���U
	ajmp KeyC 			;'9'�S�Q���U�A�ˬd�O�_���F'C'
K9: 					;'9'�Q���U�A�]�w�C�q��ܾ���09
	mov  digit1,#0f9h	;�]�w�C�q��ܾ����Ĥ@�ӼƦr��9
	mov digit3,#F9H 
	mov  digit2,#0f0h	;�]�w�C�q��ܾ����Ĥ@�ӼƦr��0
	ajmp WaitRelease 	;���ݫ����} 
KeyC: 					;'C'�Q���U�A�]�w�C�q��ܾ���12
	mov  digit1,#0f2h 	;�]�w�C�q��ܾ����Ĥ@�ӼƦr��2
	mov  digit2,#0f1h 	;�]�w�C�q��ܾ����Ĥ@�ӼƦr��1
	ajmp WaitRelease 	;���ݫ����}
Row4: 					;�ˬd�ĥ|�C�O�_������Q���U
	mov p3,#0ffh 		;�M�����䪬�A
	mov p3,#07fh 		;�N��L�Ĥ@�C(bit 7)�ܦ��C�q��
	nop					;�Ȧs���s���w��
	nop
	nop
	nop
	nop
	mov A,p3 			;Ū����L���A�A�S�������Obfh
	add A,#8h 			;+40h
	inc A 				;�֥[��A�[�@�A�p�S����=0
	jz WaitRelease		;�P�_�֥[��A�O�_=0;�S����A���ݫ����};������h����U����O
	ajmp Key99 			;������A�ˬd�O�_���F'*' 
Key99:
	jnb p3.0,K99 		;�ˬd'*'�O�_�Q���U
	ajmp Key0 			;'*'�S�Q���U�A�ˬd�O�_���F'0'
K99: 					;'*'�Q���U�A�]�w�C�q��ܾ���99
	mov  digit1,#0f9h	;�]�w�C�q��ܾ����Ĥ@�ӼƦr��9
	mov  digit2,#0f9h	;�]�w�C�q��ܾ����Ĥ@�ӼƦr��9
	ajmp WaitRelease 	;���ݫ����} 
Key0:
	jnb p3.1,K0 		;�ˬd'0'�O�_�Q���U
	ajmp Key20 			;'0'�S�Q���U�A�ˬd�O�_���F'#'
K0: 					;'0'�Q���U�A�]�w�C�q��ܾ���00
	mov  digit1,#0f0h	;�]�w�C�q��ܾ����Ĥ@�ӼƦr��0
	mov  digit2,#0f0h	;�]�w�C�q��ܾ����Ĥ@�ӼƦr��0
	ajmp WaitRelease 	;���ݫ����} 
Key20:
	jnb p3.2,K20 		;�ˬd'#'�O�_�Q���U
	ajmp KeyD 			;'#'�S�Q���U�A�ˬd�O�_���F'D'
K20: 					;'20'�Q���U�A�]�w�C�q��ܾ���20
	mov  digit1,#0f0h	;�]�w�C�q��ܾ����Ĥ@�ӼƦr��0
	mov  digit2,#0f2h	;�]�w�C�q��ܾ����Ĥ@�ӼƦr��2
	ajmp WaitRelease 	;���ݫ����} 
KeyD: 					;'D'�Q���U�A�]�w�C�q��ܾ���13
	mov  digit1,#0f3h 	;�]�w�C�q��ܾ����Ĥ@�ӼƦr��3
	mov  digit2,#0f1h 	;�]�w�C�q��ܾ����Ĥ@�ӼƦr��1
	ajmp WaitRelease 	;���ݫ����}
	
; ���ݨϥΪ̩�}����
WaitRelease: 
	acall ShowDigits 	;��ܤC�q��ܾ����e
	mov p3,#0ffh 		;�M�����䪬�A
	mov p3,#0fh  		;�N0fh�g�JPDD
	nop	 				;�Ȧs���s���w��
	nop
	nop
	nop
	nop
	mov A,p3   			;Ū����L���A�A�Y��}�������O0fh
	add A,#0f0h			;+f0h
	inc A				;���o���䪬�A�A�Y��}�������Offh; �Y���䪬�A+1����0�A��ܩ�}����
	jz S11 				;�^��S1
	ajmp WaitRelease	;�S��}����A�~�򵥫�
S11:
	ajmp S1;�^��S1
	

temp:
    MOV,Y,digit3
	RET
	
	
	
ShowDigits: 
						;��ܤC�q��ܾ��Ĥ@�ӼƦr
	mov P0,X 		;��X�Ĥ@�ӼƦr�����e
	clr P0.4 			;�N�Ĥ@�ӤC�q��ܾ��I�G
	acall delay 		;����5ms
	setb P0.4 			;�N�Ĥ@�ӤC�q��ܾ�����
						;��ܤC�q��ܾ��ĤG�ӼƦr
	mov P0,Y	;��X�ĤG�ӼƦr�����e
	clr P0.5 			;�N�ĤG�ӤC�q��ܾ��I�G
	acall delay 		;����5ms
	setb P0.5 			;�N�ĤG�ӤC�q��ܾ�����
	ret 				;��^�D�{��

IO:						;�]�wIO�H�Ϊ�l��
	mov p0oe,#11111111b	;�]�wP0��CMOS��X
	mov p0,#00000000b
	mov p3modl,#00000000b ;�]�wP3.0~3��pull up input  ;20140123 debug
	mov p3modh,#10101010b ;�]�wP3.4~7��CMOS output    ;20140123 debug
	mov p3,#11111111b
	ret
delay:
	MOV R5,#10
D1:	MOV R6,#20
	DJNZ R6,$
	DJNZ R5,D1
	RET	

	END
