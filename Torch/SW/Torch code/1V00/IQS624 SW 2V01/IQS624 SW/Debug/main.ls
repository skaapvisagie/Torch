   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  48                     ; 21 void main()
  48                     ; 22 {
  50                     	switch	.text
  51  0000               _main:
  55                     ; 23  delay_ms(100);// delay that the IQS624 can Stabilize 
  57  0000 ae0064        	ldw	x,#100
  58  0003 cd0000        	call	_delay_ms
  60                     ; 24  CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
  62  0006 4f            	clr	a
  63  0007 cd0000        	call	_CLK_HSIPrescalerConfig
  65                     ; 30  Init_i2c();
  67  000a cd0000        	call	_Init_i2c
  69                     ; 33  GPIO_Init(LED_GPIO_PORT, LED_pin, GPIO_MODE_OUT_OD_LOW_SLOW);
  71  000d 4b80          	push	#128
  72  000f 4b10          	push	#16
  73  0011 ae500a        	ldw	x,#20490
  74  0014 cd0000        	call	_GPIO_Init
  76  0017 85            	popw	x
  77                     ; 35  GPIOC->ODR |= LED_pin; // Set LED pin High to put led off
  79  0018 7218500a      	bset	20490,#4
  80                     ; 38  enableInterrupts();
  83  001c 9a            rim
  85  001d               L72:
  86                     ; 44 	if(Touch)
  88  001d 3d00          	tnz	_Touch
  89  001f 27fc          	jreq	L72
  90                     ; 46 			GPIOC->ODR &= (uint8_t)~LED_pin;
  92  0021 7219500a      	bres	20490,#4
  93                     ; 47 			delay_ms(1000);
  95  0025 ae03e8        	ldw	x,#1000
  96  0028 cd0000        	call	_delay_ms
  98                     ; 48 			GPIOC->ODR |= LED_pin;
 100  002b 7218500a      	bset	20490,#4
 101                     ; 49 			Touch = 0; 
 103  002f 3f00          	clr	_Touch
 104  0031 20ea          	jra	L72
 117                     	xdef	_main
 118                     	xref.b	_Touch
 119                     	xref	_delay_ms
 120                     	xref	_Init_i2c
 121                     	xref	_GPIO_Init
 122                     	xref	_CLK_HSIPrescalerConfig
 141                     	end
