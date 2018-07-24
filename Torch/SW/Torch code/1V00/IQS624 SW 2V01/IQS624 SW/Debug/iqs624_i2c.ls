   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  14                     	bsct
  15  0000               _Touch:
  16  0000 00            	dc.b	0
  17  0001               _Prox:
  18  0001 00            	dc.b	0
  51                     ; 7 void Init_i2c(void)
  51                     ; 8 {
  53                     	switch	.text
  54  0000               _Init_i2c:
  58                     ; 9 	azq_init_s(SLAVE_ADDRESS, 				// initilize the I2C 130Khz
  58                     ; 10 									RDY_PORT, RDY_pin,
  58                     ; 11 									SCL_PORT, SCL_pin,
  58                     ; 12 									SDA_PORT, SDA_pin,
  58                     ; 13 									_100kHz);
  60  0000 4b04          	push	#4
  61  0002 4b20          	push	#32
  62  0004 ae5005        	ldw	x,#20485
  63  0007 89            	pushw	x
  64  0008 4b10          	push	#16
  65  000a ae5005        	ldw	x,#20485
  66  000d 89            	pushw	x
  67  000e 4b08          	push	#8
  68  0010 ae5000        	ldw	x,#20480
  69  0013 89            	pushw	x
  70  0014 a644          	ld	a,#68
  71  0016 cd0000        	call	_azq_init_s
  73  0019 5b0a          	addw	sp,#10
  74                     ; 15 	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOA, EXTI_SENSITIVITY_FALL_ONLY);
  76  001b ae0002        	ldw	x,#2
  77  001e cd0000        	call	_EXTI_SetExtIntSensitivity
  79                     ; 20 	ITC_SetSoftwarePriority(ITC_IRQ_PORTA, ITC_PRIORITYLEVEL_1);
  81  0021 ae0301        	ldw	x,#769
  82  0024 cd0000        	call	_ITC_SetSoftwarePriority
  85  0027               L13:
  86                     ; 22 	while(!iqs624_writeSettings());
  88  0027 cd0000        	call	_iqs624_writeSettings
  90  002a 4d            	tnz	a
  91  002b 27fa          	jreq	L13
  92                     ; 24 }
  95  002d 81            	ret
 120                     ; 27 void TP()
 120                     ; 28 {
 121                     	switch	.text
 122  002e               _TP:
 126                     ; 30 	if(Buffer_azq[0] & Touch_set)
 128  002e b600          	ld	a,_Buffer_azq
 129  0030 a510          	bcp	a,#16
 130  0032 2706          	jreq	L54
 131                     ; 31 	Touch = 1;
 133  0034 35010000      	mov	_Touch,#1
 135  0038 2002          	jra	L74
 136  003a               L54:
 137                     ; 33 	Touch = 0;
 139  003a 3f00          	clr	_Touch
 140  003c               L74:
 141                     ; 34 }
 144  003c 81            	ret
 187                     	switch	.ubsct
 188  0000               _Buffer_azq:
 189  0000 00            	ds.b	1
 190                     	xdef	_Buffer_azq
 191                     	xdef	_Prox
 192                     	xdef	_Touch
 193                     	xdef	_TP
 194                     	xdef	_Init_i2c
 195                     	xref	_iqs624_writeSettings
 196                     	xref	_azq_init_s
 197                     	xref	_ITC_SetSoftwarePriority
 198                     	xref	_EXTI_SetExtIntSensitivity
 218                     	end
