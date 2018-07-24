   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  56                     ; 21 void delay_100clk(void)
  56                     ; 22 {
  58                     	switch	.text
  59  0000               _delay_100clk:
  61  0000 88            	push	a
  62       00000001      OFST:	set	1
  65                     ; 23 	u8 i = 0;
  67                     ; 24 	nop();
  70  0001 9d            nop
  72                     ; 25 	nop();
  76  0002 9d            nop
  78                     ; 26 	for (i = 0; i < 19; i++)
  81  0003 0f01          	clr	(OFST+0,sp)
  83  0005               L72:
  84                     ; 27 		nop();
  87  0005 9d            nop
  89                     ; 26 	for (i = 0; i < 19; i++)
  91  0006 0c01          	inc	(OFST+0,sp)
  95  0008 7b01          	ld	a,(OFST+0,sp)
  96  000a a113          	cp	a,#19
  97  000c 25f7          	jrult	L72
  98                     ; 28 }
 102  000e 84            	pop	a
 103  000f 81            	ret
 138                     ; 30 void delay_1ms(void){
 139                     	switch	.text
 140  0010               _delay_1ms:
 142  0010 88            	push	a
 143       00000001      OFST:	set	1
 146                     ; 31 	u8 i = 0;
 148                     ; 32 	for (i = 0; i < 150; i++)
 150  0011 0f01          	clr	(OFST+0,sp)
 152  0013               L35:
 153                     ; 33 		delay_100clk();
 155  0013 adeb          	call	_delay_100clk
 157                     ; 32 	for (i = 0; i < 150; i++)
 159  0015 0c01          	inc	(OFST+0,sp)
 163  0017 7b01          	ld	a,(OFST+0,sp)
 164  0019 a196          	cp	a,#150
 165  001b 25f6          	jrult	L35
 166                     ; 34 }
 169  001d 84            	pop	a
 170  001e 81            	ret
 214                     ; 36 void delay_ms(u16 milliseconds)
 214                     ; 37 {
 215                     	switch	.text
 216  001f               _delay_ms:
 218  001f 89            	pushw	x
 219  0020 89            	pushw	x
 220       00000002      OFST:	set	2
 223                     ; 39 	for (i = 0; i < milliseconds; i++)
 225  0021 5f            	clrw	x
 226  0022 1f01          	ldw	(OFST-1,sp),x
 229  0024 2009          	jra	L701
 230  0026               L301:
 231                     ; 41 		delay_1ms();
 233  0026 ade8          	call	_delay_1ms
 235                     ; 39 	for (i = 0; i < milliseconds; i++)
 237  0028 1e01          	ldw	x,(OFST-1,sp)
 238  002a 1c0001        	addw	x,#1
 239  002d 1f01          	ldw	(OFST-1,sp),x
 241  002f               L701:
 244  002f 1e01          	ldw	x,(OFST-1,sp)
 245  0031 1303          	cpw	x,(OFST+1,sp)
 246  0033 25f1          	jrult	L301
 247                     ; 44 }
 250  0035 5b04          	addw	sp,#4
 251  0037 81            	ret
 264                     	xdef	_delay_ms
 265                     	xdef	_delay_1ms
 266                     	xdef	_delay_100clk
 285                     	end
