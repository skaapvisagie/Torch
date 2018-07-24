   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  42                     ; 45 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  42                     ; 46 {
  43                     	switch	.text
  44  0000               f_TRAP_IRQHandler:
  48                     ; 50 }
  51  0000 80            	iret
  73                     ; 57 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
  73                     ; 58 
  73                     ; 59 {
  74                     	switch	.text
  75  0001               f_TLI_IRQHandler:
  79                     ; 63 }
  82  0001 80            	iret
 104                     ; 70 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 104                     ; 71 {
 105                     	switch	.text
 106  0002               f_AWU_IRQHandler:
 110                     ; 75 }
 113  0002 80            	iret
 135                     ; 82 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 135                     ; 83 {
 136                     	switch	.text
 137  0003               f_CLK_IRQHandler:
 141                     ; 87 }
 144  0003 80            	iret
 170                     ; 94 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 170                     ; 95 {
 171                     	switch	.text
 172  0004               f_EXTI_PORTA_IRQHandler:
 174  0004 8a            	push	cc
 175  0005 84            	pop	a
 176  0006 a4bf          	and	a,#191
 177  0008 88            	push	a
 178  0009 86            	pop	cc
 179  000a 3b0002        	push	c_x+2
 180  000d be00          	ldw	x,c_x
 181  000f 89            	pushw	x
 182  0010 3b0002        	push	c_y+2
 183  0013 be00          	ldw	x,c_y
 184  0015 89            	pushw	x
 187                     ; 96 	azq_readRandomBytes(0x12, 1, &Buffer_azq[0] ,STOP);
 189  0016 4b01          	push	#1
 190  0018 ae0000        	ldw	x,#_Buffer_azq
 191  001b 89            	pushw	x
 192  001c ae1201        	ldw	x,#4609
 193  001f cd0000        	call	_azq_readRandomBytes
 195  0022 5b03          	addw	sp,#3
 196                     ; 97 	TP();
 198  0024 cd0000        	call	_TP
 200                     ; 98 }
 203  0027 85            	popw	x
 204  0028 bf00          	ldw	c_y,x
 205  002a 320002        	pop	c_y+2
 206  002d 85            	popw	x
 207  002e bf00          	ldw	c_x,x
 208  0030 320002        	pop	c_x+2
 209  0033 80            	iret
 232                     ; 105 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 232                     ; 106 {
 233                     	switch	.text
 234  0034               f_EXTI_PORTB_IRQHandler:
 238                     ; 110 }
 241  0034 80            	iret
 264                     ; 117 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)														
 264                     ; 118 {
 265                     	switch	.text
 266  0035               f_EXTI_PORTC_IRQHandler:
 270                     ; 122 }
 273  0035 80            	iret
 296                     ; 129 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)																		// ZC interrupt
 296                     ; 130 {
 297                     	switch	.text
 298  0036               f_EXTI_PORTD_IRQHandler:
 302                     ; 135 }
 305  0036 80            	iret
 328                     ; 142 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 328                     ; 143 {
 329                     	switch	.text
 330  0037               f_EXTI_PORTE_IRQHandler:
 334                     ; 147 }
 337  0037 80            	iret
 359                     ; 194 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 359                     ; 195 {
 360                     	switch	.text
 361  0038               f_SPI_IRQHandler:
 365                     ; 199 }
 368  0038 80            	iret
 391                     ; 206 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 391                     ; 207 {
 392                     	switch	.text
 393  0039               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 397                     ; 211 }
 400  0039 80            	iret
 423                     ; 218 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 423                     ; 219 {
 424                     	switch	.text
 425  003a               f_TIM1_CAP_COM_IRQHandler:
 429                     ; 223 }
 432  003a 80            	iret
 455                     ; 256  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 455                     ; 257  {
 456                     	switch	.text
 457  003b               f_TIM2_UPD_OVF_BRK_IRQHandler:
 461                     ; 276 }
 464  003b 80            	iret
 487                     ; 277  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 487                     ; 278  {
 488                     	switch	.text
 489  003c               f_TIM2_CAP_COM_IRQHandler:
 493                     ; 282  }
 496  003c 80            	iret
 519                     ; 319  INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 519                     ; 320  {
 520                     	switch	.text
 521  003d               f_UART1_TX_IRQHandler:
 525                     ; 324  }
 528  003d 80            	iret
 551                     ; 331  INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 551                     ; 332  {
 552                     	switch	.text
 553  003e               f_UART1_RX_IRQHandler:
 557                     ; 336  }
 560  003e 80            	iret
 582                     ; 370 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 582                     ; 371 {
 583                     	switch	.text
 584  003f               f_I2C_IRQHandler:
 588                     ; 375 }
 591  003f 80            	iret
 613                     ; 449  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
 613                     ; 450  {
 614                     	switch	.text
 615  0040               f_ADC1_IRQHandler:
 619                     ; 458  }
 622  0040 80            	iret
 645                     ; 479  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 645                     ; 480  {
 646                     	switch	.text
 647  0041               f_TIM4_UPD_OVF_IRQHandler:
 651                     ; 484  }
 654  0041 80            	iret
 677                     ; 492 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 677                     ; 493 {
 678                     	switch	.text
 679  0042               f_EEPROM_EEC_IRQHandler:
 683                     ; 497 }
 686  0042 80            	iret
 698                     	xref	_TP
 699                     	xref	_azq_readRandomBytes
 700                     	xdef	f_EEPROM_EEC_IRQHandler
 701                     	xdef	f_TIM4_UPD_OVF_IRQHandler
 702                     	xdef	f_ADC1_IRQHandler
 703                     	xdef	f_I2C_IRQHandler
 704                     	xdef	f_UART1_RX_IRQHandler
 705                     	xdef	f_UART1_TX_IRQHandler
 706                     	xdef	f_TIM2_CAP_COM_IRQHandler
 707                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
 708                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
 709                     	xdef	f_TIM1_CAP_COM_IRQHandler
 710                     	xdef	f_SPI_IRQHandler
 711                     	xdef	f_EXTI_PORTE_IRQHandler
 712                     	xdef	f_EXTI_PORTD_IRQHandler
 713                     	xdef	f_EXTI_PORTC_IRQHandler
 714                     	xdef	f_EXTI_PORTB_IRQHandler
 715                     	xdef	f_EXTI_PORTA_IRQHandler
 716                     	xdef	f_CLK_IRQHandler
 717                     	xdef	f_AWU_IRQHandler
 718                     	xdef	f_TLI_IRQHandler
 719                     	xdef	f_TRAP_IRQHandler
 720                     	xref.b	_Buffer_azq
 721                     	xref.b	c_x
 722                     	xref.b	c_y
 741                     	end
