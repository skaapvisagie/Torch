   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  14                     	bsct
  15  0000               L71_i2cTimeout_ms:
  16  0000 0a            	dc.b	10
 176                     ; 57 void i2c_init(GPIO_TypeDef *sclPortIn, uint8_t sclPinIn, GPIO_TypeDef *sdaPortIn
 176                     ; 58 							,uint8_t sdaPinIn, Comms_Speed_e commsSpeedIn)
 176                     ; 59 {
 178                     	switch	.text
 179  0000               _i2c_init:
 181  0000 89            	pushw	x
 182       00000000      OFST:	set	0
 185                     ; 61 	sclPort = sclPortIn;
 187  0001 bf05          	ldw	L7_sclPort,x
 188                     ; 62 	sclPin = sclPinIn;
 190  0003 7b05          	ld	a,(OFST+5,sp)
 191  0005 b704          	ld	L11_sclPin,a
 192                     ; 63 	sdaPort = sdaPortIn;
 194  0007 1e06          	ldw	x,(OFST+6,sp)
 195  0009 bf02          	ldw	L31_sdaPort,x
 196                     ; 64 	sdaPin = sdaPinIn;
 198  000b 7b08          	ld	a,(OFST+8,sp)
 199  000d b701          	ld	L51_sdaPin,a
 200                     ; 66 	sclPort->CR1 &= ~(sclPin);
 202  000f be05          	ldw	x,L7_sclPort
 203  0011 b604          	ld	a,L11_sclPin
 204  0013 43            	cpl	a
 205  0014 e403          	and	a,(3,x)
 206  0016 e703          	ld	(3,x),a
 207                     ; 67 	sclPort->CR2 &= ~(sclPin);
 209  0018 be05          	ldw	x,L7_sclPort
 210  001a b604          	ld	a,L11_sclPin
 211  001c 43            	cpl	a
 212  001d e404          	and	a,(4,x)
 213  001f e704          	ld	(4,x),a
 214                     ; 68 	sdaPort->CR1 &= ~(sdaPin);
 216  0021 be02          	ldw	x,L31_sdaPort
 217  0023 b601          	ld	a,L51_sdaPin
 218  0025 43            	cpl	a
 219  0026 e403          	and	a,(3,x)
 220  0028 e703          	ld	(3,x),a
 221                     ; 69 	sdaPort->CR2 &= ~(sdaPin);
 223  002a be02          	ldw	x,L31_sdaPort
 224  002c b601          	ld	a,L51_sdaPin
 225  002e 43            	cpl	a
 226  002f e404          	and	a,(4,x)
 227  0031 e704          	ld	(4,x),a
 228                     ; 71 	sclPort->DDR &= ~(sclPin);
 230  0033 be05          	ldw	x,L7_sclPort
 231  0035 b604          	ld	a,L11_sclPin
 232  0037 43            	cpl	a
 233  0038 e402          	and	a,(2,x)
 234  003a e702          	ld	(2,x),a
 235                     ; 72 	sdaPort->DDR &= ~(sdaPin);
 237  003c be02          	ldw	x,L31_sdaPort
 238  003e b601          	ld	a,L51_sdaPin
 239  0040 43            	cpl	a
 240  0041 e402          	and	a,(2,x)
 241  0043 e702          	ld	(2,x),a
 242                     ; 75 	commsSpeed = commsSpeedIn;
 244  0045 7b09          	ld	a,(OFST+9,sp)
 245  0047 b700          	ld	L12_commsSpeed,a
 246                     ; 76 }
 249  0049 85            	popw	x
 250  004a 81            	ret
 280                     ; 83 uint8_t i2c_start(void)
 280                     ; 84 {
 281                     	switch	.text
 282  004b               _i2c_start:
 286                     ; 86 	SCL_IN_FLOAT;
 288  004b be05          	ldw	x,L7_sclPort
 289  004d b604          	ld	a,L11_sclPin
 290  004f 43            	cpl	a
 291  0050 e402          	and	a,(2,x)
 292  0052 e702          	ld	(2,x),a
 293                     ; 87 	SDA_IN_FLOAT;
 295  0054 be02          	ldw	x,L31_sdaPort
 296  0056 b601          	ld	a,L51_sdaPin
 297  0058 43            	cpl	a
 298  0059 e402          	and	a,(2,x)
 299  005b e702          	ld	(2,x),a
 300                     ; 89 	if(_waitForClock() == TIMEOUT)
 302  005d cd0361        	call	L5__waitForClock
 304  0060 a102          	cp	a,#2
 305  0062 2605          	jrne	L341
 306                     ; 91 		i2c_stop();
 308  0064 ad40          	call	_i2c_stop
 310                     ; 92 		return TIMEOUT;
 312  0066 a602          	ld	a,#2
 315  0068 81            	ret
 316  0069               L341:
 317                     ; 95 	SDA_OUT_OD;		// Pull SDA low.
 319  0069 b601          	ld	a,L51_sdaPin
 320  006b 43            	cpl	a
 321  006c 92c402        	and	a,[L31_sdaPort.w]
 322  006f 92c702        	ld	[L31_sdaPort.w],a
 325  0072 be02          	ldw	x,L31_sdaPort
 326  0074 e602          	ld	a,(2,x)
 327  0076 ba01          	or	a,L51_sdaPin
 328  0078 e702          	ld	(2,x),a
 329                     ; 96 	_wait(_whole);	// Wait 1 clock period.
 331  007a a601          	ld	a,#1
 332  007c cd0350        	call	L3__wait
 334                     ; 97 	SCL_OUT_OD;		// Pull SCL low.
 336  007f b604          	ld	a,L11_sclPin
 337  0081 43            	cpl	a
 338  0082 92c405        	and	a,[L7_sclPort.w]
 339  0085 92c705        	ld	[L7_sclPort.w],a
 342  0088 be05          	ldw	x,L7_sclPort
 343  008a e602          	ld	a,(2,x)
 344  008c ba04          	or	a,L11_sclPin
 345  008e e702          	ld	(2,x),a
 346                     ; 100 	return ((SCL_SAMPLE) || (SDA_SAMPLE)); // SUCCESS if both are low.
 348  0090 be05          	ldw	x,L7_sclPort
 349  0092 e601          	ld	a,(1,x)
 350  0094 b504          	bcp	a,L11_sclPin
 351  0096 2608          	jrne	L21
 352  0098 be02          	ldw	x,L31_sdaPort
 353  009a e601          	ld	a,(1,x)
 354  009c b501          	bcp	a,L51_sdaPin
 355  009e 2704          	jreq	L01
 356  00a0               L21:
 357  00a0 a601          	ld	a,#1
 358  00a2 2001          	jra	L41
 359  00a4               L01:
 360  00a4 4f            	clr	a
 361  00a5               L41:
 364  00a5 81            	ret
 394                     ; 108 uint8_t i2c_stop(void)
 394                     ; 109 {
 395                     	switch	.text
 396  00a6               _i2c_stop:
 400                     ; 111 	SCL_OUT_OD;	// Pull SCL low.
 402  00a6 b604          	ld	a,L11_sclPin
 403  00a8 43            	cpl	a
 404  00a9 92c405        	and	a,[L7_sclPort.w]
 405  00ac 92c705        	ld	[L7_sclPort.w],a
 408  00af be05          	ldw	x,L7_sclPort
 409  00b1 e602          	ld	a,(2,x)
 410  00b3 ba04          	or	a,L11_sclPin
 411  00b5 e702          	ld	(2,x),a
 412                     ; 112 	SDA_OUT_OD;	// Pull SDA low.
 414  00b7 b601          	ld	a,L51_sdaPin
 415  00b9 43            	cpl	a
 416  00ba 92c402        	and	a,[L31_sdaPort.w]
 417  00bd 92c702        	ld	[L31_sdaPort.w],a
 420  00c0 be02          	ldw	x,L31_sdaPort
 421  00c2 e602          	ld	a,(2,x)
 422  00c4 ba01          	or	a,L51_sdaPin
 423  00c6 e702          	ld	(2,x),a
 424                     ; 113 	_wait(_quarter);	// Wait a short while
 426  00c8 a604          	ld	a,#4
 427  00ca cd0350        	call	L3__wait
 429                     ; 115 	SCL_IN_FLOAT;
 431  00cd be05          	ldw	x,L7_sclPort
 432  00cf b604          	ld	a,L11_sclPin
 433  00d1 43            	cpl	a
 434  00d2 e402          	and	a,(2,x)
 435  00d4 e702          	ld	(2,x),a
 436                     ; 117 	if(_waitForClock() == TIMEOUT)
 438  00d6 cd0361        	call	L5__waitForClock
 440  00d9 a102          	cp	a,#2
 441  00db 2605          	jrne	L551
 442                     ; 119 		i2c_stop();
 444  00dd adc7          	call	_i2c_stop
 446                     ; 120 		return TIMEOUT;
 448  00df a602          	ld	a,#2
 451  00e1 81            	ret
 452  00e2               L551:
 453                     ; 123 	_wait(_whole);
 455  00e2 a601          	ld	a,#1
 456  00e4 cd0350        	call	L3__wait
 458                     ; 124 	SDA_IN_FLOAT;
 460  00e7 be02          	ldw	x,L31_sdaPort
 461  00e9 b601          	ld	a,L51_sdaPin
 462  00eb 43            	cpl	a
 463  00ec e402          	and	a,(2,x)
 464  00ee e702          	ld	(2,x),a
 465                     ; 126 	return (!((SCL_SAMPLE) || (SDA_SAMPLE))); // SUCCESS if both are high.
 467  00f0 be05          	ldw	x,L7_sclPort
 468  00f2 e601          	ld	a,(1,x)
 469  00f4 b504          	bcp	a,L11_sclPin
 470  00f6 260c          	jrne	L02
 471  00f8 be02          	ldw	x,L31_sdaPort
 472  00fa e601          	ld	a,(1,x)
 473  00fc b501          	bcp	a,L51_sdaPin
 474  00fe 2604          	jrne	L02
 475  0100 a601          	ld	a,#1
 476  0102 2001          	jra	L22
 477  0104               L02:
 478  0104 4f            	clr	a
 479  0105               L22:
 482  0105 81            	ret
 559                     ; 134 uint8_t i2c_slaveRequest(uint8_t slaveAddress, uint8_t readOrWrite)
 559                     ; 135 {
 560                     	switch	.text
 561  0106               _i2c_slaveRequest:
 563  0106 89            	pushw	x
 564  0107 89            	pushw	x
 565       00000002      OFST:	set	2
 568                     ; 137 	uint8_t requestByte = (slaveAddress<<1) | readOrWrite;
 570  0108 9e            	ld	a,xh
 571  0109 48            	sll	a
 572  010a 1a04          	or	a,(OFST+2,sp)
 573  010c 6b01          	ld	(OFST-1,sp),a
 575                     ; 138 	uint8_t ackOrNack = 0;
 577                     ; 142 	SCL_OUT_OD;
 579  010e b604          	ld	a,L11_sclPin
 580  0110 43            	cpl	a
 581  0111 92c405        	and	a,[L7_sclPort.w]
 582  0114 92c705        	ld	[L7_sclPort.w],a
 585  0117 be05          	ldw	x,L7_sclPort
 586  0119 e602          	ld	a,(2,x)
 587  011b ba04          	or	a,L11_sclPin
 588  011d e702          	ld	(2,x),a
 589                     ; 143 	_wait(_quarter);
 591  011f a604          	ld	a,#4
 592  0121 cd0350        	call	L3__wait
 594                     ; 146 	for(i=0; i<8; i++)
 596  0124 0f02          	clr	(OFST+0,sp)
 598  0126               L512:
 599                     ; 149 		if(requestByte & 0x80)
 601  0126 7b01          	ld	a,(OFST-1,sp)
 602  0128 a580          	bcp	a,#128
 603  012a 270b          	jreq	L322
 604                     ; 151 			SDA_IN_FLOAT;
 606  012c be02          	ldw	x,L31_sdaPort
 607  012e b601          	ld	a,L51_sdaPin
 608  0130 43            	cpl	a
 609  0131 e402          	and	a,(2,x)
 610  0133 e702          	ld	(2,x),a
 612  0135 2011          	jra	L522
 613  0137               L322:
 614                     ; 155 			SDA_OUT_OD;
 616  0137 b601          	ld	a,L51_sdaPin
 617  0139 43            	cpl	a
 618  013a 92c402        	and	a,[L31_sdaPort.w]
 619  013d 92c702        	ld	[L31_sdaPort.w],a
 622  0140 be02          	ldw	x,L31_sdaPort
 623  0142 e602          	ld	a,(2,x)
 624  0144 ba01          	or	a,L51_sdaPin
 625  0146 e702          	ld	(2,x),a
 626  0148               L522:
 627                     ; 158 		SCL_IN_FLOAT;
 629  0148 be05          	ldw	x,L7_sclPort
 630  014a b604          	ld	a,L11_sclPin
 631  014c 43            	cpl	a
 632  014d e402          	and	a,(2,x)
 633  014f e702          	ld	(2,x),a
 634                     ; 160 		if(_waitForClock() == TIMEOUT)
 636  0151 cd0361        	call	L5__waitForClock
 638  0154 a102          	cp	a,#2
 639  0156 2607          	jrne	L722
 640                     ; 162 			i2c_stop();
 642  0158 cd00a6        	call	_i2c_stop
 644                     ; 163 			return TIMEOUT;
 646  015b a602          	ld	a,#2
 648  015d 2043          	jra	L62
 649  015f               L722:
 650                     ; 165 		_wait(_half);
 652  015f a602          	ld	a,#2
 653  0161 cd0350        	call	L3__wait
 655                     ; 167 		SCL_OUT_OD;
 657  0164 b604          	ld	a,L11_sclPin
 658  0166 43            	cpl	a
 659  0167 92c405        	and	a,[L7_sclPort.w]
 660  016a 92c705        	ld	[L7_sclPort.w],a
 663  016d be05          	ldw	x,L7_sclPort
 664  016f e602          	ld	a,(2,x)
 665  0171 ba04          	or	a,L11_sclPin
 666  0173 e702          	ld	(2,x),a
 667                     ; 168 		_wait(_half);
 669  0175 a602          	ld	a,#2
 670  0177 cd0350        	call	L3__wait
 672                     ; 170 		requestByte = requestByte<<1;
 674  017a 0801          	sll	(OFST-1,sp)
 676                     ; 146 	for(i=0; i<8; i++)
 678  017c 0c02          	inc	(OFST+0,sp)
 682  017e 7b02          	ld	a,(OFST+0,sp)
 683  0180 a108          	cp	a,#8
 684  0182 25a2          	jrult	L512
 685                     ; 173 	SDA_IN_FLOAT;
 687  0184 be02          	ldw	x,L31_sdaPort
 688  0186 b601          	ld	a,L51_sdaPin
 689  0188 43            	cpl	a
 690  0189 e402          	and	a,(2,x)
 691  018b e702          	ld	(2,x),a
 692                     ; 175 	SCL_IN_FLOAT;
 694  018d be05          	ldw	x,L7_sclPort
 695  018f b604          	ld	a,L11_sclPin
 696  0191 43            	cpl	a
 697  0192 e402          	and	a,(2,x)
 698  0194 e702          	ld	(2,x),a
 699                     ; 177 	if(_waitForClock() == TIMEOUT)
 701  0196 cd0361        	call	L5__waitForClock
 703  0199 a102          	cp	a,#2
 704  019b 2608          	jrne	L132
 705                     ; 179 		i2c_stop();
 707  019d cd00a6        	call	_i2c_stop
 709                     ; 180 		return TIMEOUT;
 711  01a0 a602          	ld	a,#2
 713  01a2               L62:
 715  01a2 5b04          	addw	sp,#4
 716  01a4 81            	ret
 717  01a5               L132:
 718                     ; 182 	_wait(_half);
 720  01a5 a602          	ld	a,#2
 721  01a7 cd0350        	call	L3__wait
 723                     ; 185 	ackOrNack = SDA_SAMPLE;
 725  01aa be02          	ldw	x,L31_sdaPort
 726  01ac e601          	ld	a,(1,x)
 727  01ae b401          	and	a,L51_sdaPin
 728  01b0 6b02          	ld	(OFST+0,sp),a
 730                     ; 188 	SCL_OUT_OD;
 732  01b2 b604          	ld	a,L11_sclPin
 733  01b4 43            	cpl	a
 734  01b5 92c405        	and	a,[L7_sclPort.w]
 735  01b8 92c705        	ld	[L7_sclPort.w],a
 738  01bb be05          	ldw	x,L7_sclPort
 739  01bd e602          	ld	a,(2,x)
 740  01bf ba04          	or	a,L11_sclPin
 741  01c1 e702          	ld	(2,x),a
 742                     ; 190 	return ackOrNack; // SUCCESS if Ack, FAIL if Nack.
 744  01c3 7b02          	ld	a,(OFST+0,sp)
 746  01c5 20db          	jra	L62
 805                     ; 198 uint8_t i2c_writeByte(uint8_t dataByte)
 805                     ; 199 {
 806                     	switch	.text
 807  01c7               _i2c_writeByte:
 809  01c7 88            	push	a
 810  01c8 88            	push	a
 811       00000001      OFST:	set	1
 814                     ; 200 	uint8_t ackOrNack = 0;
 816                     ; 204 	SCL_OUT_OD;
 818  01c9 b604          	ld	a,L11_sclPin
 819  01cb 43            	cpl	a
 820  01cc 92c405        	and	a,[L7_sclPort.w]
 821  01cf 92c705        	ld	[L7_sclPort.w],a
 824  01d2 be05          	ldw	x,L7_sclPort
 825  01d4 e602          	ld	a,(2,x)
 826  01d6 ba04          	or	a,L11_sclPin
 827  01d8 e702          	ld	(2,x),a
 828                     ; 205 	_wait(_quarter);
 830  01da a604          	ld	a,#4
 831  01dc cd0350        	call	L3__wait
 833                     ; 208 	for(i=0; i<8; i++)
 835  01df 0f01          	clr	(OFST+0,sp)
 837  01e1               L162:
 838                     ; 211 		if(dataByte & 0x80)
 840  01e1 7b02          	ld	a,(OFST+1,sp)
 841  01e3 a580          	bcp	a,#128
 842  01e5 270b          	jreq	L762
 843                     ; 213 			SDA_IN_FLOAT;
 845  01e7 be02          	ldw	x,L31_sdaPort
 846  01e9 b601          	ld	a,L51_sdaPin
 847  01eb 43            	cpl	a
 848  01ec e402          	and	a,(2,x)
 849  01ee e702          	ld	(2,x),a
 851  01f0 2011          	jra	L172
 852  01f2               L762:
 853                     ; 217 			SDA_OUT_OD;
 855  01f2 b601          	ld	a,L51_sdaPin
 856  01f4 43            	cpl	a
 857  01f5 92c402        	and	a,[L31_sdaPort.w]
 858  01f8 92c702        	ld	[L31_sdaPort.w],a
 861  01fb be02          	ldw	x,L31_sdaPort
 862  01fd e602          	ld	a,(2,x)
 863  01ff ba01          	or	a,L51_sdaPin
 864  0201 e702          	ld	(2,x),a
 865  0203               L172:
 866                     ; 220 		SCL_IN_FLOAT;
 868  0203 be05          	ldw	x,L7_sclPort
 869  0205 b604          	ld	a,L11_sclPin
 870  0207 43            	cpl	a
 871  0208 e402          	and	a,(2,x)
 872  020a e702          	ld	(2,x),a
 873                     ; 222 		if(_waitForClock() == TIMEOUT)
 875  020c cd0361        	call	L5__waitForClock
 877  020f a102          	cp	a,#2
 878  0211 2607          	jrne	L372
 879                     ; 224 			i2c_stop();
 881  0213 cd00a6        	call	_i2c_stop
 883                     ; 225 			return TIMEOUT;
 885  0216 a602          	ld	a,#2
 887  0218 2043          	jra	L23
 888  021a               L372:
 889                     ; 227 		_wait(_half);
 891  021a a602          	ld	a,#2
 892  021c cd0350        	call	L3__wait
 894                     ; 229 		SCL_OUT_OD;
 896  021f b604          	ld	a,L11_sclPin
 897  0221 43            	cpl	a
 898  0222 92c405        	and	a,[L7_sclPort.w]
 899  0225 92c705        	ld	[L7_sclPort.w],a
 902  0228 be05          	ldw	x,L7_sclPort
 903  022a e602          	ld	a,(2,x)
 904  022c ba04          	or	a,L11_sclPin
 905  022e e702          	ld	(2,x),a
 906                     ; 230 		_wait(_half);
 908  0230 a602          	ld	a,#2
 909  0232 cd0350        	call	L3__wait
 911                     ; 232 		dataByte = dataByte<<1;
 913  0235 0802          	sll	(OFST+1,sp)
 914                     ; 208 	for(i=0; i<8; i++)
 916  0237 0c01          	inc	(OFST+0,sp)
 920  0239 7b01          	ld	a,(OFST+0,sp)
 921  023b a108          	cp	a,#8
 922  023d 25a2          	jrult	L162
 923                     ; 235 	SDA_IN_FLOAT;
 925  023f be02          	ldw	x,L31_sdaPort
 926  0241 b601          	ld	a,L51_sdaPin
 927  0243 43            	cpl	a
 928  0244 e402          	and	a,(2,x)
 929  0246 e702          	ld	(2,x),a
 930                     ; 237 	SCL_IN_FLOAT;
 932  0248 be05          	ldw	x,L7_sclPort
 933  024a b604          	ld	a,L11_sclPin
 934  024c 43            	cpl	a
 935  024d e402          	and	a,(2,x)
 936  024f e702          	ld	(2,x),a
 937                     ; 239 	if(_waitForClock() == TIMEOUT)
 939  0251 cd0361        	call	L5__waitForClock
 941  0254 a102          	cp	a,#2
 942  0256 2607          	jrne	L572
 943                     ; 241 		i2c_stop();
 945  0258 cd00a6        	call	_i2c_stop
 947                     ; 242 		return TIMEOUT;
 949  025b a602          	ld	a,#2
 951  025d               L23:
 953  025d 85            	popw	x
 954  025e 81            	ret
 955  025f               L572:
 956                     ; 244 	_wait(_half);
 958  025f a602          	ld	a,#2
 959  0261 cd0350        	call	L3__wait
 961                     ; 247 	ackOrNack = SDA_SAMPLE;
 963  0264 be02          	ldw	x,L31_sdaPort
 964  0266 e601          	ld	a,(1,x)
 965  0268 b401          	and	a,L51_sdaPin
 966  026a 6b01          	ld	(OFST+0,sp),a
 968                     ; 250 	SCL_OUT_OD;
 970  026c b604          	ld	a,L11_sclPin
 971  026e 43            	cpl	a
 972  026f 92c405        	and	a,[L7_sclPort.w]
 973  0272 92c705        	ld	[L7_sclPort.w],a
 976  0275 be05          	ldw	x,L7_sclPort
 977  0277 e602          	ld	a,(2,x)
 978  0279 ba04          	or	a,L11_sclPin
 979  027b e702          	ld	(2,x),a
 980                     ; 252 	return ackOrNack; // SUCCESS if Ack, FAIL if Nack.
 982  027d 7b01          	ld	a,(OFST+0,sp)
 984  027f 20dc          	jra	L23
1044                     ; 261 uint8_t i2c_readByte(uint8_t *bytePointer, uint8_t ackOrNack)
1044                     ; 262 {
1045                     	switch	.text
1046  0281               _i2c_readByte:
1048  0281 89            	pushw	x
1049  0282 88            	push	a
1050       00000001      OFST:	set	1
1053                     ; 265 	*bytePointer = 0;
1055  0283 7f            	clr	(x)
1056                     ; 267 	SDA_IN_FLOAT;
1058  0284 be02          	ldw	x,L31_sdaPort
1059  0286 b601          	ld	a,L51_sdaPin
1060  0288 43            	cpl	a
1061  0289 e402          	and	a,(2,x)
1062  028b e702          	ld	(2,x),a
1063                     ; 268 	SCL_OUT_OD;
1065  028d b604          	ld	a,L11_sclPin
1066  028f 43            	cpl	a
1067  0290 92c405        	and	a,[L7_sclPort.w]
1068  0293 92c705        	ld	[L7_sclPort.w],a
1071  0296 be05          	ldw	x,L7_sclPort
1072  0298 e602          	ld	a,(2,x)
1073  029a ba04          	or	a,L11_sclPin
1074  029c e702          	ld	(2,x),a
1075                     ; 269 	_wait(_quarter);
1077  029e a604          	ld	a,#4
1078  02a0 cd0350        	call	L3__wait
1080                     ; 271 	for(i=0; i<8; i++)
1082  02a3 0f01          	clr	(OFST+0,sp)
1084  02a5               L523:
1085                     ; 274 		*bytePointer = *bytePointer<<1;
1087  02a5 1e02          	ldw	x,(OFST+1,sp)
1088  02a7 78            	sll	(x)
1089                     ; 276 		SCL_IN_FLOAT;
1091  02a8 be05          	ldw	x,L7_sclPort
1092  02aa b604          	ld	a,L11_sclPin
1093  02ac 43            	cpl	a
1094  02ad e402          	and	a,(2,x)
1095  02af e702          	ld	(2,x),a
1096                     ; 278 		if(_waitForClock() == TIMEOUT)
1098  02b1 cd0361        	call	L5__waitForClock
1100  02b4 a102          	cp	a,#2
1101  02b6 2607          	jrne	L333
1102                     ; 280 			i2c_stop();
1104  02b8 cd00a6        	call	_i2c_stop
1106                     ; 281 			return TIMEOUT;
1108  02bb a602          	ld	a,#2
1110  02bd 2064          	jra	L63
1111  02bf               L333:
1112                     ; 284 		_wait(_half);
1114  02bf a602          	ld	a,#2
1115  02c1 cd0350        	call	L3__wait
1117                     ; 285 		if(SDA_SAMPLE)
1119  02c4 be02          	ldw	x,L31_sdaPort
1120  02c6 e601          	ld	a,(1,x)
1121  02c8 b501          	bcp	a,L51_sdaPin
1122  02ca 2706          	jreq	L533
1123                     ; 287 			*bytePointer |= 0x01;
1125  02cc 1e02          	ldw	x,(OFST+1,sp)
1126  02ce f6            	ld	a,(x)
1127  02cf aa01          	or	a,#1
1128  02d1 f7            	ld	(x),a
1129  02d2               L533:
1130                     ; 290 		SCL_OUT_OD;
1132  02d2 b604          	ld	a,L11_sclPin
1133  02d4 43            	cpl	a
1134  02d5 92c405        	and	a,[L7_sclPort.w]
1135  02d8 92c705        	ld	[L7_sclPort.w],a
1138  02db be05          	ldw	x,L7_sclPort
1139  02dd e602          	ld	a,(2,x)
1140  02df ba04          	or	a,L11_sclPin
1141  02e1 e702          	ld	(2,x),a
1142                     ; 291 		_wait(_half);
1144  02e3 a602          	ld	a,#2
1145  02e5 ad69          	call	L3__wait
1147                     ; 271 	for(i=0; i<8; i++)
1149  02e7 0c01          	inc	(OFST+0,sp)
1153  02e9 7b01          	ld	a,(OFST+0,sp)
1154  02eb a108          	cp	a,#8
1155  02ed 25b6          	jrult	L523
1156                     ; 294 	if(ackOrNack == ACK)
1158  02ef 0d06          	tnz	(OFST+5,sp)
1159  02f1 2613          	jrne	L733
1160                     ; 296 		 SDA_OUT_OD;
1162  02f3 b601          	ld	a,L51_sdaPin
1163  02f5 43            	cpl	a
1164  02f6 92c402        	and	a,[L31_sdaPort.w]
1165  02f9 92c702        	ld	[L31_sdaPort.w],a
1168  02fc be02          	ldw	x,L31_sdaPort
1169  02fe e602          	ld	a,(2,x)
1170  0300 ba01          	or	a,L51_sdaPin
1171  0302 e702          	ld	(2,x),a
1173  0304 2009          	jra	L143
1174  0306               L733:
1175                     ; 300 		 SDA_IN_FLOAT;
1177  0306 be02          	ldw	x,L31_sdaPort
1178  0308 b601          	ld	a,L51_sdaPin
1179  030a 43            	cpl	a
1180  030b e402          	and	a,(2,x)
1181  030d e702          	ld	(2,x),a
1182  030f               L143:
1183                     ; 303 	SCL_IN_FLOAT;
1185  030f be05          	ldw	x,L7_sclPort
1186  0311 b604          	ld	a,L11_sclPin
1187  0313 43            	cpl	a
1188  0314 e402          	and	a,(2,x)
1189  0316 e702          	ld	(2,x),a
1190                     ; 305 	if((_waitForClock()) == TIMEOUT)
1192  0318 ad47          	call	L5__waitForClock
1194  031a a102          	cp	a,#2
1195  031c 2608          	jrne	L343
1196                     ; 307 		i2c_stop();
1198  031e cd00a6        	call	_i2c_stop
1200                     ; 308 		return TIMEOUT;
1202  0321 a602          	ld	a,#2
1204  0323               L63:
1206  0323 5b03          	addw	sp,#3
1207  0325 81            	ret
1208  0326               L343:
1209                     ; 311 	_wait(_half);
1211  0326 a602          	ld	a,#2
1212  0328 ad26          	call	L3__wait
1214                     ; 313 	SCL_OUT_OD;
1216  032a b604          	ld	a,L11_sclPin
1217  032c 43            	cpl	a
1218  032d 92c405        	and	a,[L7_sclPort.w]
1219  0330 92c705        	ld	[L7_sclPort.w],a
1222  0333 be05          	ldw	x,L7_sclPort
1223  0335 e602          	ld	a,(2,x)
1224  0337 ba04          	or	a,L11_sclPin
1225  0339 e702          	ld	(2,x),a
1226                     ; 315 	return SUCCESS;
1228  033b 4f            	clr	a
1230  033c 20e5          	jra	L63
1268                     ; 324 void i2c_setSclPort(GPIO_TypeDef *sclPortIn)
1268                     ; 325 {
1269                     	switch	.text
1270  033e               _i2c_setSclPort:
1274                     ; 326 	sclPort = sclPortIn;
1276  033e bf05          	ldw	L7_sclPort,x
1277                     ; 327 }
1280  0340 81            	ret
1315                     ; 334 void i2c_setSclPin(uint8_t sclPinIn)
1315                     ; 335 {
1316                     	switch	.text
1317  0341               _i2c_setSclPin:
1321                     ; 336 	sclPin = sclPinIn;
1323  0341 b704          	ld	L11_sclPin,a
1324                     ; 337 }
1327  0343 81            	ret
1365                     ; 344 void i2c_setSdaPort(GPIO_TypeDef *sdaPortIn)
1365                     ; 345 {
1366                     	switch	.text
1367  0344               _i2c_setSdaPort:
1371                     ; 346 	sdaPort = sdaPortIn;
1373  0344 bf02          	ldw	L31_sdaPort,x
1374                     ; 347 }
1377  0346 81            	ret
1412                     ; 354 void i2c_setSdaPin(uint8_t sdaPinIn)
1412                     ; 355 {
1413                     	switch	.text
1414  0347               _i2c_setSdaPin:
1418                     ; 356 	sdaPin = sdaPinIn;
1420  0347 b701          	ld	L51_sdaPin,a
1421                     ; 357 }
1424  0349 81            	ret
1460                     ; 364 void i2c_setCommsSpeed(Comms_Speed_e commsSpeedIn)
1460                     ; 365 {
1461                     	switch	.text
1462  034a               _i2c_setCommsSpeed:
1466                     ; 366 	commsSpeed = commsSpeedIn;
1468  034a b700          	ld	L12_commsSpeed,a
1469                     ; 367 }
1472  034c 81            	ret
1507                     ; 374 void i2c_setTimeout(uint8_t timeoutIn)
1507                     ; 375 {
1508                     	switch	.text
1509  034d               _i2c_setTimeout:
1513                     ; 376 	i2cTimeout_ms = timeoutIn;
1515  034d b700          	ld	L71_i2cTimeout_ms,a
1516                     ; 377 }
1519  034f 81            	ret
1585                     ; 386 static void _wait(Clock_Fraction_e fraction)
1585                     ; 387 {
1586                     	switch	.text
1587  0350               L3__wait:
1589  0350 88            	push	a
1590       00000000      OFST:	set	0
1593                     ; 394 	nop();
1596  0351 9d            nop
1598                     ; 395 	if(fraction == 2)
1601  0352 a102          	cp	a,#2
1602  0354 2601          	jrne	L525
1603                     ; 397 		nop();
1606  0356 9d            nop
1609  0357               L525:
1610                     ; 399 	if(fraction == 1)
1612  0357 7b01          	ld	a,(OFST+1,sp)
1613  0359 a101          	cp	a,#1
1614  035b 2602          	jrne	L725
1615                     ; 401 		nop();
1618  035d 9d            nop
1620                     ; 402 		nop();
1624  035e 9d            nop
1627  035f               L725:
1628                     ; 405 }
1631  035f 84            	pop	a
1632  0360 81            	ret
1680                     ; 412 static uint8_t _waitForClock(void)
1680                     ; 413 {
1681                     	switch	.text
1682  0361               L5__waitForClock:
1684  0361 89            	pushw	x
1685       00000002      OFST:	set	2
1688                     ; 414 	uint8_t usCounter = 0;
1690  0362 0f02          	clr	(OFST+0,sp)
1692                     ; 415 	uint8_t timeoutCounter = 0;
1694  0364 0f01          	clr	(OFST-1,sp)
1697  0366 2015          	jra	L755
1698  0368               L355:
1699                     ; 419 		_delay_us(1);
1701  0368 ae0001        	ldw	x,#1
1702  036b cd0000        	call	__delay_us
1704                     ; 420 		usCounter++;
1706  036e 0c02          	inc	(OFST+0,sp)
1708                     ; 426 		if(timeoutCounter >= i2cTimeout_ms)
1710  0370 7b01          	ld	a,(OFST-1,sp)
1711  0372 b100          	cp	a,L71_i2cTimeout_ms
1712  0374 2507          	jrult	L755
1713                     ; 428 			i2c_stop();
1715  0376 cd00a6        	call	_i2c_stop
1717                     ; 429 			return TIMEOUT;
1719  0379 a602          	ld	a,#2
1721  037b 2009          	jra	L06
1722  037d               L755:
1723                     ; 417 	while(!(SCL_SAMPLE))
1725  037d be05          	ldw	x,L7_sclPort
1726  037f e601          	ld	a,(1,x)
1727  0381 b504          	bcp	a,L11_sclPin
1728  0383 27e3          	jreq	L355
1729                     ; 432 	return SUCCESS;
1731  0385 4f            	clr	a
1733  0386               L06:
1735  0386 85            	popw	x
1736  0387 81            	ret
1812                     	switch	.ubsct
1813  0000               L12_commsSpeed:
1814  0000 00            	ds.b	1
1815  0001               L51_sdaPin:
1816  0001 00            	ds.b	1
1817  0002               L31_sdaPort:
1818  0002 0000          	ds.b	2
1819  0004               L11_sclPin:
1820  0004 00            	ds.b	1
1821  0005               L7_sclPort:
1822  0005 0000          	ds.b	2
1823                     	xref	__delay_us
1824                     	xdef	_i2c_setTimeout
1825                     	xdef	_i2c_setCommsSpeed
1826                     	xdef	_i2c_setSdaPin
1827                     	xdef	_i2c_setSdaPort
1828                     	xdef	_i2c_setSclPin
1829                     	xdef	_i2c_setSclPort
1830                     	xdef	_i2c_readByte
1831                     	xdef	_i2c_writeByte
1832                     	xdef	_i2c_slaveRequest
1833                     	xdef	_i2c_stop
1834                     	xdef	_i2c_start
1835                     	xdef	_i2c_init
1855                     	end
