   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  54                     ; 10 void _delay_cycl(unsigned short __ticks)
  54                     ; 11 {
  56                     	switch	.text
  57  0000               __delay_cycl:
  61                     ; 13 		_asm("nop\n $N:\n decw X\n jrne $L\n nop\n ", __ticks);
  64  0000 9d            nop
  65  0001                L6:
  66  0001 5a             decw X
  67  0002 26fd           jrne L6
  68  0004 9d             nop
  69                      
  71                     ; 14 }
  74  0005 81            	ret
 118                     ; 16 void _delay_us(const unsigned short __us)
 118                     ; 17 {
 119                     	switch	.text
 120  0006               __delay_us:
 122  0006 89            	pushw	x
 123  0007 89            	pushw	x
 124       00000002      OFST:	set	2
 127                     ; 19 	uint16_t ticks = (uint16_t)((uint32_t)F_CPU / (uint32_t)1000000);
 129  0008 ae0010        	ldw	x,#16
 130  000b 1f01          	ldw	(OFST-1,sp),x
 132                     ; 21 	ticks *= __us;
 134  000d 1e01          	ldw	x,(OFST-1,sp)
 135  000f 1603          	ldw	y,(OFST+1,sp)
 136  0011 cd0000        	call	c_imul
 138  0014 1f01          	ldw	(OFST-1,sp),x
 140                     ; 22 	ticks -= 3;
 142  0016 1e01          	ldw	x,(OFST-1,sp)
 143  0018 1d0003        	subw	x,#3
 144  001b 1f01          	ldw	(OFST-1,sp),x
 146                     ; 23 	ticks /= 3;
 148  001d 1e01          	ldw	x,(OFST-1,sp)
 149  001f a603          	ld	a,#3
 150  0021 62            	div	x,a
 151  0022 1f01          	ldw	(OFST-1,sp),x
 153                     ; 24 	_delay_cycl(ticks);
 155  0024 1e01          	ldw	x,(OFST-1,sp)
 156  0026 add8          	call	__delay_cycl
 158                     ; 25 }
 161  0028 5b04          	addw	sp,#4
 162  002a 81            	ret
 197                     ; 27 void _delay_ms(unsigned short __ms)
 197                     ; 28 {
 198                     	switch	.text
 199  002b               __delay_ms:
 201  002b 89            	pushw	x
 202       00000000      OFST:	set	0
 205  002c 2005          	jra	L17
 206  002e               L76:
 207                     ; 31 		_delay_us(1000);
 209  002e ae03e8        	ldw	x,#1000
 210  0031 add3          	call	__delay_us
 212  0033               L17:
 213                     ; 29 	while (__ms--)
 215  0033 1e01          	ldw	x,(OFST+1,sp)
 216  0035 1d0001        	subw	x,#1
 217  0038 1f01          	ldw	(OFST+1,sp),x
 218  003a 1c0001        	addw	x,#1
 219  003d a30000        	cpw	x,#0
 220  0040 26ec          	jrne	L76
 221                     ; 33 }
 224  0042 85            	popw	x
 225  0043 81            	ret
 238                     	xdef	__delay_ms
 239                     	xdef	__delay_us
 240                     	xdef	__delay_cycl
 241                     	xref.b	c_x
 260                     	xref	c_imul
 261                     	end
