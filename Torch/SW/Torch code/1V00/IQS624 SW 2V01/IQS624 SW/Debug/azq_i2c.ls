   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  14                     	bsct
  15  0000               L71__holdStart:
  16  0000 00            	dc.b	0
  17  0001               L12_azqTimeout_ms:
  18  0001 64            	dc.b	100
 222                     ; 46  void azq_init_m(AZQ_Device_t *azqDevice,
 222                     ; 47 								GPIO_TypeDef *sclPortIn, uint8_t sclPinIn,
 222                     ; 48 								GPIO_TypeDef *sdaPortIn, uint8_t sdaPinIn,
 222                     ; 49 																Comms_Speed_e commsSpeedIn)
 222                     ; 50 {
 224                     	switch	.text
 225  0000               _azq_init_m:
 227  0000 89            	pushw	x
 228       00000000      OFST:	set	0
 231                     ; 52 	i2c_init(sclPortIn, sclPinIn, sdaPortIn, sdaPinIn, commsSpeedIn);
 233  0001 7b0b          	ld	a,(OFST+11,sp)
 234  0003 88            	push	a
 235  0004 7b0b          	ld	a,(OFST+11,sp)
 236  0006 88            	push	a
 237  0007 1e0a          	ldw	x,(OFST+10,sp)
 238  0009 89            	pushw	x
 239  000a 7b0b          	ld	a,(OFST+11,sp)
 240  000c 88            	push	a
 241  000d 1e0a          	ldw	x,(OFST+10,sp)
 242  000f cd0000        	call	_i2c_init
 244  0012 5b05          	addw	sp,#5
 245                     ; 54 	azq_setActiveDevice(azqDevice);
 247  0014 1e01          	ldw	x,(OFST+1,sp)
 248  0016 cd042a        	call	_azq_setActiveDevice
 250                     ; 58 	_readyPort->CR1 &= ~(_readyPin);
 252  0019 be01          	ldw	x,L31__readyPort
 253  001b b600          	ld	a,L51__readyPin
 254  001d 43            	cpl	a
 255  001e e403          	and	a,(3,x)
 256  0020 e703          	ld	(3,x),a
 257                     ; 59 	_readyPort->CR2 &= ~(_readyPin);
 259  0022 be01          	ldw	x,L31__readyPort
 260  0024 b600          	ld	a,L51__readyPin
 261  0026 43            	cpl	a
 262  0027 e404          	and	a,(4,x)
 263  0029 e704          	ld	(4,x),a
 264                     ; 60 	_readyPort->DDR &= ~(_readyPin);
 266  002b be01          	ldw	x,L31__readyPort
 267  002d b600          	ld	a,L51__readyPin
 268  002f 43            	cpl	a
 269  0030 e402          	and	a,(2,x)
 270  0032 e702          	ld	(2,x),a
 271                     ; 61 }
 274  0034 85            	popw	x
 275  0035 81            	ret
 387                     ; 77 void azq_init_s(uint8_t deviceAddressIn, 
 387                     ; 78 						GPIO_TypeDef *readyPortIn, uint8_t readyPinIn,
 387                     ; 79 								GPIO_TypeDef *sclPortIn, uint8_t sclPinIn,
 387                     ; 80 								GPIO_TypeDef *sdaPortIn, uint8_t sdaPinIn,
 387                     ; 81 																Comms_Speed_e commsSpeedIn)
 387                     ; 82 {
 388                     	switch	.text
 389  0036               _azq_init_s:
 391  0036 88            	push	a
 392       00000000      OFST:	set	0
 395                     ; 84 	i2c_init(sclPortIn, sclPinIn, sdaPortIn, sdaPinIn, commsSpeedIn);
 397  0037 7b0d          	ld	a,(OFST+13,sp)
 398  0039 88            	push	a
 399  003a 7b0d          	ld	a,(OFST+13,sp)
 400  003c 88            	push	a
 401  003d 1e0c          	ldw	x,(OFST+12,sp)
 402  003f 89            	pushw	x
 403  0040 7b0d          	ld	a,(OFST+13,sp)
 404  0042 88            	push	a
 405  0043 1e0c          	ldw	x,(OFST+12,sp)
 406  0045 cd0000        	call	_i2c_init
 408  0048 5b05          	addw	sp,#5
 409                     ; 86 	_deviceAddress = deviceAddressIn;
 411  004a 7b01          	ld	a,(OFST+1,sp)
 412  004c b703          	ld	L11__deviceAddress,a
 413                     ; 87 	_readyPort = readyPortIn;
 415  004e 1e04          	ldw	x,(OFST+4,sp)
 416  0050 bf01          	ldw	L31__readyPort,x
 417                     ; 88 	_readyPin = readyPinIn;
 419  0052 7b06          	ld	a,(OFST+6,sp)
 420  0054 b700          	ld	L51__readyPin,a
 421                     ; 95 	GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_IN_FL_IT);
 423  0056 4b20          	push	#32
 424  0058 4b08          	push	#8
 425  005a ae5000        	ldw	x,#20480
 426  005d cd0000        	call	_GPIO_Init
 428  0060 85            	popw	x
 429                     ; 97 }
 432  0061 84            	pop	a
 433  0062 81            	ret
 492                     ; 104 bool azq_waitForReady(void)
 492                     ; 105 {
 493                     	switch	.text
 494  0063               _azq_waitForReady:
 496  0063 88            	push	a
 497       00000001      OFST:	set	1
 500                     ; 106 	uint8_t timeoutCounter = 0;	// Keeps track of how much time has passed.
 502  0064 0f01          	clr	(OFST+0,sp)
 505  0066 2012          	jra	L172
 506  0068               L562:
 507                     ; 112 		_delay_ms(1);
 509  0068 ae0001        	ldw	x,#1
 510  006b cd0000        	call	__delay_ms
 512                     ; 113 		timeoutCounter++;
 514  006e 0c01          	inc	(OFST+0,sp)
 516                     ; 114 		if(timeoutCounter > azqTimeout_ms)
 518  0070 7b01          	ld	a,(OFST+0,sp)
 519  0072 b101          	cp	a,L12_azqTimeout_ms
 520  0074 2304          	jrule	L172
 521                     ; 115 			return FALSE;
 523  0076 4f            	clr	a
 526  0077 5b01          	addw	sp,#1
 527  0079 81            	ret
 528  007a               L172:
 529                     ; 109 	while(RDY_SAMPLE)
 531  007a be01          	ldw	x,L31__readyPort
 532  007c e601          	ld	a,(1,x)
 533  007e b500          	bcp	a,L51__readyPin
 534  0080 26e6          	jrne	L562
 535                     ; 118 	return TRUE;
 537  0082 a601          	ld	a,#1
 540  0084 5b01          	addw	sp,#1
 541  0086 81            	ret
 581                     ; 129 bool azq_requestComms(void)
 581                     ; 130 {
 582                     	switch	.text
 583  0087               _azq_requestComms:
 585  0087 88            	push	a
 586       00000001      OFST:	set	1
 589                     ; 132 	uint8_t timeoutCounter = 5;
 591  0088 a605          	ld	a,#5
 592  008a 6b01          	ld	(OFST+0,sp),a
 594                     ; 134 	_toggleReady();
 596  008c cd043d        	call	L7__toggleReady
 599  008f 2029          	jra	L713
 600  0091               L513:
 601                     ; 139 		_delay_ms(1);
 603  0091 ae0001        	ldw	x,#1
 604  0094 cd0000        	call	__delay_ms
 606                     ; 140 		timeoutCounter++;
 608  0097 0c01          	inc	(OFST+0,sp)
 610                     ; 142 		if(timeoutCounter >= azqTimeout_ms)
 612  0099 7b01          	ld	a,(OFST+0,sp)
 613  009b b101          	cp	a,L12_azqTimeout_ms
 614  009d 2504          	jrult	L323
 615                     ; 144 			return FALSE;
 617  009f 4f            	clr	a
 620  00a0 5b01          	addw	sp,#1
 621  00a2 81            	ret
 622  00a3               L323:
 623                     ; 146 		else if(timeoutCounter%10 == 0)
 625  00a3 7b01          	ld	a,(OFST+0,sp)
 626  00a5 5f            	clrw	x
 627  00a6 97            	ld	xl,a
 628  00a7 a60a          	ld	a,#10
 629  00a9 cd0000        	call	c_smodx
 631  00ac a30000        	cpw	x,#0
 632  00af 2609          	jrne	L713
 633                     ; 148 			_toggleReady();
 635  00b1 cd043d        	call	L7__toggleReady
 637                     ; 149 			timeoutCounter += 5;
 639  00b4 7b01          	ld	a,(OFST+0,sp)
 640  00b6 ab05          	add	a,#5
 641  00b8 6b01          	ld	(OFST+0,sp),a
 643  00ba               L713:
 644                     ; 136 	while((RDY_SAMPLE))
 646  00ba be01          	ldw	x,L31__readyPort
 647  00bc e601          	ld	a,(1,x)
 648  00be b500          	bcp	a,L51__readyPin
 649  00c0 26cf          	jrne	L513
 650                     ; 153 	return TRUE;
 652  00c2 a601          	ld	a,#1
 655  00c4 5b01          	addw	sp,#1
 656  00c6 81            	ret
 718                     ; 163 bool azq_poll(void)
 718                     ; 164 {
 719                     	switch	.text
 720  00c7               _azq_poll:
 722  00c7 5203          	subw	sp,#3
 723       00000003      OFST:	set	3
 726                     ; 165 	uint8_t timeoutCounter = 0;	// Keep track of time for timeout.
 728  00c9 0f02          	clr	(OFST-1,sp)
 730                     ; 166 	uint8_t commsStatus = 0; 		// Keep track of comms status from i2c operations.
 732                     ; 167 	uint8_t readByte = 0;
 734  00cb 0f01          	clr	(OFST-2,sp)
 736                     ; 170 	commsStatus = i2c_start();
 738  00cd cd0000        	call	_i2c_start
 740  00d0 6b03          	ld	(OFST+0,sp),a
 742                     ; 171 	if(commsStatus != SUCCESS)
 744  00d2 0d03          	tnz	(OFST+0,sp)
 745  00d4 2706          	jreq	L753
 746                     ; 173 		i2c_stop();
 748  00d6 cd0000        	call	_i2c_stop
 750                     ; 174 		return FALSE;
 752  00d9 4f            	clr	a
 754  00da 2023          	jra	L61
 755  00dc               L753:
 756                     ; 177 	commsStatus = i2c_slaveRequest(_deviceAddress, WRITE);
 758  00dc b603          	ld	a,L11__deviceAddress
 759  00de 5f            	clrw	x
 760  00df 95            	ld	xh,a
 761  00e0 cd0000        	call	_i2c_slaveRequest
 763  00e3 6b03          	ld	(OFST+0,sp),a
 766  00e5 2030          	jra	L563
 767  00e7               L163:
 768                     ; 180 		i2c_stop();
 770  00e7 cd0000        	call	_i2c_stop
 772                     ; 181 		_delay_ms(1);
 774  00ea ae0001        	ldw	x,#1
 775  00ed cd0000        	call	__delay_ms
 777                     ; 182 		timeoutCounter++;
 779  00f0 0c02          	inc	(OFST-1,sp)
 781                     ; 184 		commsStatus = i2c_start();
 783  00f2 cd0000        	call	_i2c_start
 785  00f5 6b03          	ld	(OFST+0,sp),a
 787                     ; 185 		if(commsStatus != SUCCESS)
 789  00f7 0d03          	tnz	(OFST+0,sp)
 790  00f9 2707          	jreq	L173
 791                     ; 187 			i2c_stop();
 793  00fb cd0000        	call	_i2c_stop
 795                     ; 188 			return FALSE;
 797  00fe 4f            	clr	a
 799  00ff               L61:
 801  00ff 5b03          	addw	sp,#3
 802  0101 81            	ret
 803  0102               L173:
 804                     ; 191 		commsStatus = i2c_slaveRequest(_deviceAddress, WRITE);
 806  0102 b603          	ld	a,L11__deviceAddress
 807  0104 5f            	clrw	x
 808  0105 95            	ld	xh,a
 809  0106 cd0000        	call	_i2c_slaveRequest
 811  0109 6b03          	ld	(OFST+0,sp),a
 813                     ; 192 		if(timeoutCounter >= azqTimeout_ms)
 815  010b 7b02          	ld	a,(OFST-1,sp)
 816  010d b101          	cp	a,L12_azqTimeout_ms
 817  010f 2506          	jrult	L563
 818                     ; 194 			i2c_stop();
 820  0111 cd0000        	call	_i2c_stop
 822                     ; 195 			return FALSE;
 824  0114 4f            	clr	a
 826  0115 20e8          	jra	L61
 827  0117               L563:
 828                     ; 178 	while(commsStatus != SUCCESS)
 830  0117 0d03          	tnz	(OFST+0,sp)
 831  0119 26cc          	jrne	L163
 832                     ; 200 	commsStatus = i2c_writeByte(0x00);
 834  011b 4f            	clr	a
 835  011c cd0000        	call	_i2c_writeByte
 837  011f 6b03          	ld	(OFST+0,sp),a
 839                     ; 201 	if(commsStatus != SUCCESS)
 841  0121 0d03          	tnz	(OFST+0,sp)
 842  0123 2706          	jreq	L573
 843                     ; 203 		i2c_stop();
 845  0125 cd0000        	call	_i2c_stop
 847                     ; 204 		return FALSE;
 849  0128 4f            	clr	a
 851  0129 20d4          	jra	L61
 852  012b               L573:
 853                     ; 207 	commsStatus = i2c_start();
 855  012b cd0000        	call	_i2c_start
 857  012e 6b03          	ld	(OFST+0,sp),a
 859                     ; 208 	if(commsStatus != SUCCESS)
 861  0130 0d03          	tnz	(OFST+0,sp)
 862  0132 2706          	jreq	L773
 863                     ; 210 		i2c_stop();
 865  0134 cd0000        	call	_i2c_stop
 867                     ; 211 		return FALSE;
 869  0137 4f            	clr	a
 871  0138 20c5          	jra	L61
 872  013a               L773:
 873                     ; 214 	commsStatus = i2c_slaveRequest(_deviceAddress, READ);
 875  013a b603          	ld	a,L11__deviceAddress
 876  013c ae0001        	ldw	x,#1
 877  013f 95            	ld	xh,a
 878  0140 cd0000        	call	_i2c_slaveRequest
 880  0143 6b03          	ld	(OFST+0,sp),a
 882                     ; 215 	if(commsStatus != SUCCESS)
 884  0145 0d03          	tnz	(OFST+0,sp)
 885  0147 2706          	jreq	L104
 886                     ; 217 		i2c_stop();
 888  0149 cd0000        	call	_i2c_stop
 890                     ; 218 		return FALSE;
 892  014c 4f            	clr	a
 894  014d 20b0          	jra	L61
 895  014f               L104:
 896                     ; 221 	commsStatus = i2c_readByte(&readByte, NACK);
 898  014f 4b01          	push	#1
 899  0151 96            	ldw	x,sp
 900  0152 1c0002        	addw	x,#OFST-1
 901  0155 cd0000        	call	_i2c_readByte
 903  0158 5b01          	addw	sp,#1
 904  015a 6b03          	ld	(OFST+0,sp),a
 906                     ; 222 	if(commsStatus != SUCCESS)
 908  015c 0d03          	tnz	(OFST+0,sp)
 909  015e 2706          	jreq	L304
 910                     ; 224 		i2c_stop();
 912  0160 cd0000        	call	_i2c_stop
 914                     ; 225 		return FALSE;
 916  0163 4f            	clr	a
 918  0164 2099          	jra	L61
 919  0166               L304:
 920                     ; 229 	commsStatus = i2c_start();
 922  0166 cd0000        	call	_i2c_start
 924  0169 6b03          	ld	(OFST+0,sp),a
 926                     ; 230 	if(commsStatus != SUCCESS)
 928  016b 0d03          	tnz	(OFST+0,sp)
 929  016d 2706          	jreq	L504
 930                     ; 232 		i2c_stop();
 932  016f cd0000        	call	_i2c_stop
 934                     ; 233 		return FALSE;
 936  0172 4f            	clr	a
 938  0173 208a          	jra	L61
 939  0175               L504:
 940                     ; 238 	_holdStart = TRUE;
 942  0175 35010000      	mov	L71__holdStart,#1
 943                     ; 239 	return TRUE;
 945  0179 a601          	ld	a,#1
 947  017b 2082          	jra	L61
1018                     ; 252 bool azq_poll_PN(uint8_t productNumber)
1018                     ; 253 {
1019                     	switch	.text
1020  017d               _azq_poll_PN:
1022  017d 88            	push	a
1023  017e 5203          	subw	sp,#3
1024       00000003      OFST:	set	3
1027                     ; 254 	uint8_t timeoutCounter = 0;	// Keep track of time for timeout.
1029  0180 0f02          	clr	(OFST-1,sp)
1031                     ; 255 	uint8_t commsStatus = 0; 		// Keep track of comms status from i2c operations.
1033                     ; 256 	uint8_t readByte = 0;
1035  0182 0f01          	clr	(OFST-2,sp)
1037                     ; 259 	commsStatus = i2c_start();
1039  0184 cd0000        	call	_i2c_start
1041  0187 6b03          	ld	(OFST+0,sp),a
1043                     ; 260 	if(commsStatus != SUCCESS)
1045  0189 0d03          	tnz	(OFST+0,sp)
1046  018b 2706          	jreq	L144
1047                     ; 262 		i2c_stop();
1049  018d cd0000        	call	_i2c_stop
1051                     ; 263 		return FALSE;
1053  0190 4f            	clr	a
1055  0191 2023          	jra	L22
1056  0193               L144:
1057                     ; 266 	commsStatus = i2c_slaveRequest(_deviceAddress, WRITE);
1059  0193 b603          	ld	a,L11__deviceAddress
1060  0195 5f            	clrw	x
1061  0196 95            	ld	xh,a
1062  0197 cd0000        	call	_i2c_slaveRequest
1064  019a 6b03          	ld	(OFST+0,sp),a
1067  019c 2030          	jra	L744
1068  019e               L344:
1069                     ; 269 		i2c_stop();
1071  019e cd0000        	call	_i2c_stop
1073                     ; 270 		_delay_ms(1);
1075  01a1 ae0001        	ldw	x,#1
1076  01a4 cd0000        	call	__delay_ms
1078                     ; 271 		timeoutCounter++;
1080  01a7 0c02          	inc	(OFST-1,sp)
1082                     ; 273 		commsStatus = i2c_start();
1084  01a9 cd0000        	call	_i2c_start
1086  01ac 6b03          	ld	(OFST+0,sp),a
1088                     ; 274 		if(commsStatus != SUCCESS)
1090  01ae 0d03          	tnz	(OFST+0,sp)
1091  01b0 2707          	jreq	L354
1092                     ; 276 			i2c_stop();
1094  01b2 cd0000        	call	_i2c_stop
1096                     ; 277 			return FALSE;
1098  01b5 4f            	clr	a
1100  01b6               L22:
1102  01b6 5b04          	addw	sp,#4
1103  01b8 81            	ret
1104  01b9               L354:
1105                     ; 280 		commsStatus = i2c_slaveRequest(_deviceAddress, WRITE);
1107  01b9 b603          	ld	a,L11__deviceAddress
1108  01bb 5f            	clrw	x
1109  01bc 95            	ld	xh,a
1110  01bd cd0000        	call	_i2c_slaveRequest
1112  01c0 6b03          	ld	(OFST+0,sp),a
1114                     ; 281 		if(timeoutCounter >= azqTimeout_ms)
1116  01c2 7b02          	ld	a,(OFST-1,sp)
1117  01c4 b101          	cp	a,L12_azqTimeout_ms
1118  01c6 2506          	jrult	L744
1119                     ; 283 			i2c_stop();
1121  01c8 cd0000        	call	_i2c_stop
1123                     ; 284 			return FALSE;
1125  01cb 4f            	clr	a
1127  01cc 20e8          	jra	L22
1128  01ce               L744:
1129                     ; 267 	while(commsStatus != SUCCESS)
1131  01ce 0d03          	tnz	(OFST+0,sp)
1132  01d0 26cc          	jrne	L344
1133                     ; 289 	commsStatus = i2c_writeByte(0x00);
1135  01d2 4f            	clr	a
1136  01d3 cd0000        	call	_i2c_writeByte
1138  01d6 6b03          	ld	(OFST+0,sp),a
1140                     ; 290 	if(commsStatus != SUCCESS)
1142  01d8 0d03          	tnz	(OFST+0,sp)
1143  01da 2706          	jreq	L754
1144                     ; 292 		i2c_stop();
1146  01dc cd0000        	call	_i2c_stop
1148                     ; 293 		return FALSE;
1150  01df 4f            	clr	a
1152  01e0 20d4          	jra	L22
1153  01e2               L754:
1154                     ; 296 	commsStatus = i2c_start();
1156  01e2 cd0000        	call	_i2c_start
1158  01e5 6b03          	ld	(OFST+0,sp),a
1160                     ; 297 	if(commsStatus != SUCCESS)
1162  01e7 0d03          	tnz	(OFST+0,sp)
1163  01e9 2706          	jreq	L164
1164                     ; 299 		i2c_stop();
1166  01eb cd0000        	call	_i2c_stop
1168                     ; 300 		return FALSE;
1170  01ee 4f            	clr	a
1172  01ef 20c5          	jra	L22
1173  01f1               L164:
1174                     ; 303 	commsStatus = i2c_slaveRequest(_deviceAddress, READ);
1176  01f1 b603          	ld	a,L11__deviceAddress
1177  01f3 ae0001        	ldw	x,#1
1178  01f6 95            	ld	xh,a
1179  01f7 cd0000        	call	_i2c_slaveRequest
1181  01fa 6b03          	ld	(OFST+0,sp),a
1183                     ; 304 	if(commsStatus != SUCCESS)
1185  01fc 0d03          	tnz	(OFST+0,sp)
1186  01fe 2706          	jreq	L364
1187                     ; 306 		i2c_stop();
1189  0200 cd0000        	call	_i2c_stop
1191                     ; 307 		return FALSE;
1193  0203 4f            	clr	a
1195  0204 20b0          	jra	L22
1196  0206               L364:
1197                     ; 310 	commsStatus = i2c_readByte(&readByte, NACK);
1199  0206 4b01          	push	#1
1200  0208 96            	ldw	x,sp
1201  0209 1c0002        	addw	x,#OFST-1
1202  020c cd0000        	call	_i2c_readByte
1204  020f 5b01          	addw	sp,#1
1205  0211 6b03          	ld	(OFST+0,sp),a
1207                     ; 311 	if(commsStatus != SUCCESS)
1209  0213 0d03          	tnz	(OFST+0,sp)
1210  0215 2706          	jreq	L564
1211                     ; 313 		i2c_stop();
1213  0217 cd0000        	call	_i2c_stop
1215                     ; 314 		return FALSE;
1217  021a 4f            	clr	a
1219  021b 2099          	jra	L22
1220  021d               L564:
1221                     ; 317 	if(readByte != productNumber)
1223  021d 7b01          	ld	a,(OFST-2,sp)
1224  021f 1104          	cp	a,(OFST+1,sp)
1225  0221 2706          	jreq	L764
1226                     ; 319 		i2c_stop();
1228  0223 cd0000        	call	_i2c_stop
1230                     ; 320 		return FALSE;
1232  0226 4f            	clr	a
1234  0227 208d          	jra	L22
1235  0229               L764:
1236                     ; 324 	commsStatus = i2c_start();
1238  0229 cd0000        	call	_i2c_start
1240  022c 6b03          	ld	(OFST+0,sp),a
1242                     ; 325 	if(commsStatus != SUCCESS)
1244  022e 0d03          	tnz	(OFST+0,sp)
1245  0230 2708          	jreq	L174
1246                     ; 327 		i2c_stop();
1248  0232 cd0000        	call	_i2c_stop
1250                     ; 328 		return FALSE;
1252  0235 4f            	clr	a
1254  0236 acb601b6      	jpf	L22
1255  023a               L174:
1256                     ; 333 	_holdStart = TRUE;
1258  023a 35010000      	mov	L71__holdStart,#1
1259                     ; 334 	return TRUE;
1261  023e a601          	ld	a,#1
1263  0240 acb601b6      	jpf	L22
1314                     ; 345 bool azq_forceComms(void)
1314                     ; 346 {
1315                     	switch	.text
1316  0244               _azq_forceComms:
1318  0244 88            	push	a
1319       00000001      OFST:	set	1
1322                     ; 347 	bool pollStatus = FALSE; // Keeps track of the comms status.
1324                     ; 348 	bool readyIsLow = FALSE;
1326                     ; 350 	RDY_OUT_OD;
1328  0245 b600          	ld	a,L51__readyPin
1329  0247 43            	cpl	a
1330  0248 92c401        	and	a,[L31__readyPort.w]
1331  024b 92c701        	ld	[L31__readyPort.w],a
1334  024e be01          	ldw	x,L31__readyPort
1335  0250 e602          	ld	a,(2,x)
1336  0252 ba00          	or	a,L51__readyPin
1337  0254 e702          	ld	(2,x),a
1338                     ; 352 	pollStatus = azq_poll();
1340  0256 cd00c7        	call	_azq_poll
1342  0259 6b01          	ld	(OFST+0,sp),a
1344                     ; 354 	RDY_IN_FLOAT;
1346  025b be01          	ldw	x,L31__readyPort
1347  025d b600          	ld	a,L51__readyPin
1348  025f 43            	cpl	a
1349  0260 e402          	and	a,(2,x)
1350  0262 e702          	ld	(2,x),a
1351                     ; 355 	if(!pollStatus)
1353  0264 0d01          	tnz	(OFST+0,sp)
1354  0266 2607          	jrne	L515
1355                     ; 357 		i2c_stop();
1357  0268 cd0000        	call	_i2c_stop
1359                     ; 358 		return FALSE;
1361  026b 4f            	clr	a
1364  026c 5b01          	addw	sp,#1
1365  026e 81            	ret
1366  026f               L515:
1367                     ; 361 	readyIsLow = azq_waitForReady();
1369  026f cd0063        	call	_azq_waitForReady
1371  0272 6b01          	ld	(OFST+0,sp),a
1373                     ; 362 	if(!readyIsLow)
1375  0274 0d01          	tnz	(OFST+0,sp)
1376  0276 2607          	jrne	L715
1377                     ; 364 		i2c_stop();
1379  0278 cd0000        	call	_i2c_stop
1381                     ; 365 		return FALSE;
1383  027b 4f            	clr	a
1386  027c 5b01          	addw	sp,#1
1387  027e 81            	ret
1388  027f               L715:
1389                     ; 368 	return TRUE;
1391  027f a601          	ld	a,#1
1394  0281 5b01          	addw	sp,#1
1395  0283 81            	ret
1455                     ; 382 bool azq_forceComms_PN(uint8_t productNumber)
1455                     ; 383 {
1456                     	switch	.text
1457  0284               _azq_forceComms_PN:
1459  0284 88            	push	a
1460  0285 88            	push	a
1461       00000001      OFST:	set	1
1464                     ; 384 	bool pollStatus = FALSE; // Keeps track of the comms status.
1466                     ; 385 	bool readyIsLow = FALSE;
1468                     ; 387 	RDY_OUT_OD;
1470  0286 b600          	ld	a,L51__readyPin
1471  0288 43            	cpl	a
1472  0289 92c401        	and	a,[L31__readyPort.w]
1473  028c 92c701        	ld	[L31__readyPort.w],a
1476  028f be01          	ldw	x,L31__readyPort
1477  0291 e602          	ld	a,(2,x)
1478  0293 ba00          	or	a,L51__readyPin
1479  0295 e702          	ld	(2,x),a
1480                     ; 389 	pollStatus = azq_poll_PN(productNumber);
1482  0297 7b02          	ld	a,(OFST+1,sp)
1483  0299 cd017d        	call	_azq_poll_PN
1485  029c 6b01          	ld	(OFST+0,sp),a
1487                     ; 391 	RDY_IN_FLOAT;
1489  029e be01          	ldw	x,L31__readyPort
1490  02a0 b600          	ld	a,L51__readyPin
1491  02a2 43            	cpl	a
1492  02a3 e402          	and	a,(2,x)
1493  02a5 e702          	ld	(2,x),a
1494                     ; 392 	if(!pollStatus)
1496  02a7 0d01          	tnz	(OFST+0,sp)
1497  02a9 2606          	jrne	L745
1498                     ; 394 		i2c_stop();
1500  02ab cd0000        	call	_i2c_stop
1502                     ; 395 		return FALSE;
1504  02ae 4f            	clr	a
1506  02af 200d          	jra	L03
1507  02b1               L745:
1508                     ; 398 	readyIsLow = azq_waitForReady();
1510  02b1 cd0063        	call	_azq_waitForReady
1512  02b4 6b01          	ld	(OFST+0,sp),a
1514                     ; 399 	if(!readyIsLow)
1516  02b6 0d01          	tnz	(OFST+0,sp)
1517  02b8 2606          	jrne	L155
1518                     ; 401 		i2c_stop();
1520  02ba cd0000        	call	_i2c_stop
1522                     ; 402 		return FALSE;
1524  02bd 4f            	clr	a
1526  02be               L03:
1528  02be 85            	popw	x
1529  02bf 81            	ret
1530  02c0               L155:
1531                     ; 405 	return TRUE;
1533  02c0 a601          	ld	a,#1
1535  02c2 20fa          	jra	L03
1624                     ; 419 bool azq_writeRandomBytes(uint8_t registerAddress, uint8_t numberOfBytes,
1624                     ; 420 																	uint8_t bytesArray[], bool stopOrRestart)
1624                     ; 421 {
1625                     	switch	.text
1626  02c4               _azq_writeRandomBytes:
1628  02c4 89            	pushw	x
1629  02c5 89            	pushw	x
1630       00000002      OFST:	set	2
1633                     ; 423 	uint8_t commsStatus = 0;
1635                     ; 428 	if(!_holdStart)
1637  02c6 3d00          	tnz	L71__holdStart
1638  02c8 260f          	jrne	L516
1639                     ; 430 		commsStatus = i2c_start();
1641  02ca cd0000        	call	_i2c_start
1643  02cd 6b02          	ld	(OFST+0,sp),a
1645                     ; 431 		if((commsStatus != SUCCESS))
1647  02cf 0d02          	tnz	(OFST+0,sp)
1648  02d1 2708          	jreq	L126
1649                     ; 433 			i2c_stop();
1651  02d3 cd0000        	call	_i2c_stop
1653                     ; 434 			return FALSE;
1655  02d6 4f            	clr	a
1657  02d7 2013          	jra	L63
1658  02d9               L516:
1659                     ; 439 		_holdStart = FALSE;
1661  02d9 3f00          	clr	L71__holdStart
1662  02db               L126:
1663                     ; 443 	commsStatus = i2c_slaveRequest(_deviceAddress, WRITE);
1665  02db b603          	ld	a,L11__deviceAddress
1666  02dd 5f            	clrw	x
1667  02de 95            	ld	xh,a
1668  02df cd0000        	call	_i2c_slaveRequest
1670  02e2 6b02          	ld	(OFST+0,sp),a
1672                     ; 444 	if(commsStatus != SUCCESS)
1674  02e4 0d02          	tnz	(OFST+0,sp)
1675  02e6 2707          	jreq	L326
1676                     ; 446 		i2c_stop();
1678  02e8 cd0000        	call	_i2c_stop
1680                     ; 447 		return FALSE;
1682  02eb 4f            	clr	a
1684  02ec               L63:
1686  02ec 5b04          	addw	sp,#4
1687  02ee 81            	ret
1688  02ef               L326:
1689                     ; 451 	commsStatus = i2c_writeByte(registerAddress);
1691  02ef 7b03          	ld	a,(OFST+1,sp)
1692  02f1 cd0000        	call	_i2c_writeByte
1694  02f4 6b02          	ld	(OFST+0,sp),a
1696                     ; 452 	if((commsStatus != SUCCESS))
1698  02f6 0d02          	tnz	(OFST+0,sp)
1699  02f8 2706          	jreq	L526
1700                     ; 454 		i2c_stop();
1702  02fa cd0000        	call	_i2c_stop
1704                     ; 455 		return FALSE;
1706  02fd 4f            	clr	a
1708  02fe 20ec          	jra	L63
1709  0300               L526:
1710                     ; 459 	for(i=0; i<numberOfBytes; i++)
1712  0300 0f01          	clr	(OFST-1,sp)
1715  0302 201d          	jra	L336
1716  0304               L726:
1717                     ; 461 		commsStatus = i2c_writeByte(bytesArray[i]);
1719  0304 7b07          	ld	a,(OFST+5,sp)
1720  0306 97            	ld	xl,a
1721  0307 7b08          	ld	a,(OFST+6,sp)
1722  0309 1b01          	add	a,(OFST-1,sp)
1723  030b 2401          	jrnc	L43
1724  030d 5c            	incw	x
1725  030e               L43:
1726  030e 02            	rlwa	x,a
1727  030f f6            	ld	a,(x)
1728  0310 cd0000        	call	_i2c_writeByte
1730  0313 6b02          	ld	(OFST+0,sp),a
1732                     ; 462 		if((commsStatus != SUCCESS))
1734  0315 0d02          	tnz	(OFST+0,sp)
1735  0317 2706          	jreq	L736
1736                     ; 464 			i2c_stop();
1738  0319 cd0000        	call	_i2c_stop
1740                     ; 465 			return FALSE;
1742  031c 4f            	clr	a
1744  031d 20cd          	jra	L63
1745  031f               L736:
1746                     ; 459 	for(i=0; i<numberOfBytes; i++)
1748  031f 0c01          	inc	(OFST-1,sp)
1750  0321               L336:
1753  0321 7b01          	ld	a,(OFST-1,sp)
1754  0323 1104          	cp	a,(OFST+2,sp)
1755  0325 25dd          	jrult	L726
1756                     ; 469 	if(stopOrRestart)
1758  0327 0d09          	tnz	(OFST+7,sp)
1759  0329 2703          	jreq	L146
1760                     ; 470 		i2c_stop();
1762  032b cd0000        	call	_i2c_stop
1764  032e               L146:
1765                     ; 473 	return TRUE;
1767  032e a601          	ld	a,#1
1769  0330 20ba          	jra	L63
1877                     ; 487 bool azq_readRandomBytes(uint8_t registerAddress, uint8_t numberOfBytes,
1877                     ; 488 																	uint8_t bytesArray[], bool stopOrRestart)
1877                     ; 489 {
1878                     	switch	.text
1879  0332               _azq_readRandomBytes:
1881  0332 89            	pushw	x
1882  0333 5204          	subw	sp,#4
1883       00000004      OFST:	set	4
1886                     ; 491 	uint8_t commsStatus = 0;
1888                     ; 492 	uint8_t readByte = 0;
1890                     ; 493 	uint8_t ackOrNack = ACK;
1892  0335 0f02          	clr	(OFST-2,sp)
1894                     ; 498 	if(!_holdStart)
1896  0337 3d00          	tnz	L71__holdStart
1897  0339 260f          	jrne	L517
1898                     ; 500 		commsStatus = i2c_start();
1900  033b cd0000        	call	_i2c_start
1902  033e 6b04          	ld	(OFST+0,sp),a
1904                     ; 501 		if((commsStatus != SUCCESS))
1906  0340 0d04          	tnz	(OFST+0,sp)
1907  0342 2708          	jreq	L127
1908                     ; 503 			i2c_stop();
1910  0344 cd0000        	call	_i2c_stop
1912                     ; 504 			return FALSE;
1914  0347 4f            	clr	a
1916  0348 2013          	jra	L44
1917  034a               L517:
1918                     ; 509 		_holdStart = FALSE;
1920  034a 3f00          	clr	L71__holdStart
1921  034c               L127:
1922                     ; 512 	commsStatus = i2c_slaveRequest(_deviceAddress, WRITE);
1924  034c b603          	ld	a,L11__deviceAddress
1925  034e 5f            	clrw	x
1926  034f 95            	ld	xh,a
1927  0350 cd0000        	call	_i2c_slaveRequest
1929  0353 6b04          	ld	(OFST+0,sp),a
1931                     ; 513 	if(commsStatus != SUCCESS)
1933  0355 0d04          	tnz	(OFST+0,sp)
1934  0357 2707          	jreq	L327
1935                     ; 515 		i2c_stop();
1937  0359 cd0000        	call	_i2c_stop
1939                     ; 516 		return FALSE;
1941  035c 4f            	clr	a
1943  035d               L44:
1945  035d 5b06          	addw	sp,#6
1946  035f 81            	ret
1947  0360               L327:
1948                     ; 519 	commsStatus = i2c_writeByte(registerAddress);
1950  0360 7b05          	ld	a,(OFST+1,sp)
1951  0362 cd0000        	call	_i2c_writeByte
1953  0365 6b04          	ld	(OFST+0,sp),a
1955                     ; 520 	if(commsStatus != SUCCESS)
1957  0367 0d04          	tnz	(OFST+0,sp)
1958  0369 2706          	jreq	L527
1959                     ; 522 		i2c_stop();
1961  036b cd0000        	call	_i2c_stop
1963                     ; 523 		return FALSE;
1965  036e 4f            	clr	a
1967  036f 20ec          	jra	L44
1968  0371               L527:
1969                     ; 526 	commsStatus = i2c_start();
1971  0371 cd0000        	call	_i2c_start
1973  0374 6b04          	ld	(OFST+0,sp),a
1975                     ; 527 	if((commsStatus != SUCCESS))
1977  0376 0d04          	tnz	(OFST+0,sp)
1978  0378 2706          	jreq	L727
1979                     ; 529 		i2c_stop();
1981  037a cd0000        	call	_i2c_stop
1983                     ; 530 		return FALSE;
1985  037d 4f            	clr	a
1987  037e 20dd          	jra	L44
1988  0380               L727:
1989                     ; 533 	commsStatus = i2c_slaveRequest(_deviceAddress, READ);
1991  0380 b603          	ld	a,L11__deviceAddress
1992  0382 ae0001        	ldw	x,#1
1993  0385 95            	ld	xh,a
1994  0386 cd0000        	call	_i2c_slaveRequest
1996  0389 6b04          	ld	(OFST+0,sp),a
1998                     ; 534 	if(commsStatus != SUCCESS)
2000  038b 0d04          	tnz	(OFST+0,sp)
2001  038d 2706          	jreq	L137
2002                     ; 536 		i2c_stop();
2004  038f cd0000        	call	_i2c_stop
2006                     ; 537 		return FALSE;
2008  0392 4f            	clr	a
2010  0393 20c8          	jra	L44
2011  0395               L137:
2012                     ; 540 	for(i=0;i<numberOfBytes;i++)
2014  0395 0f03          	clr	(OFST-1,sp)
2017  0397 2037          	jra	L737
2018  0399               L337:
2019                     ; 542 		if(i == (numberOfBytes-1))
2021  0399 7b06          	ld	a,(OFST+2,sp)
2022  039b 5f            	clrw	x
2023  039c 97            	ld	xl,a
2024  039d 5a            	decw	x
2025  039e 7b03          	ld	a,(OFST-1,sp)
2026  03a0 905f          	clrw	y
2027  03a2 9097          	ld	yl,a
2028  03a4 90bf00        	ldw	c_y,y
2029  03a7 b300          	cpw	x,c_y
2030  03a9 2604          	jrne	L347
2031                     ; 543 			ackOrNack = NACK;
2033  03ab a601          	ld	a,#1
2034  03ad 6b02          	ld	(OFST-2,sp),a
2036  03af               L347:
2037                     ; 545 		commsStatus = i2c_readByte(&bytesArray[i], ackOrNack);
2039  03af 7b02          	ld	a,(OFST-2,sp)
2040  03b1 88            	push	a
2041  03b2 7b0a          	ld	a,(OFST+6,sp)
2042  03b4 97            	ld	xl,a
2043  03b5 7b0b          	ld	a,(OFST+7,sp)
2044  03b7 1b04          	add	a,(OFST+0,sp)
2045  03b9 2401          	jrnc	L24
2046  03bb 5c            	incw	x
2047  03bc               L24:
2048  03bc 02            	rlwa	x,a
2049  03bd cd0000        	call	_i2c_readByte
2051  03c0 5b01          	addw	sp,#1
2052  03c2 6b04          	ld	(OFST+0,sp),a
2054                     ; 546 		if((commsStatus != SUCCESS))
2056  03c4 0d04          	tnz	(OFST+0,sp)
2057  03c6 2706          	jreq	L547
2058                     ; 548 			i2c_stop();
2060  03c8 cd0000        	call	_i2c_stop
2062                     ; 549 			return FALSE;
2064  03cb 4f            	clr	a
2066  03cc 208f          	jra	L44
2067  03ce               L547:
2068                     ; 540 	for(i=0;i<numberOfBytes;i++)
2070  03ce 0c03          	inc	(OFST-1,sp)
2072  03d0               L737:
2075  03d0 7b03          	ld	a,(OFST-1,sp)
2076  03d2 1106          	cp	a,(OFST+2,sp)
2077  03d4 25c3          	jrult	L337
2078                     ; 554 	if(stopOrRestart)
2080  03d6 0d0b          	tnz	(OFST+7,sp)
2081  03d8 2703          	jreq	L747
2082                     ; 555 		i2c_stop();
2084  03da cd0000        	call	_i2c_stop
2086  03dd               L747:
2087                     ; 558 	return TRUE;
2089  03dd a601          	ld	a,#1
2091  03df ac5d035d      	jpf	L44
2151                     ; 569 bool azq_writeCommand(uint8_t commandByte, bool stopOrRestart)
2151                     ; 570 {
2152                     	switch	.text
2153  03e3               _azq_writeCommand:
2155  03e3 89            	pushw	x
2156  03e4 88            	push	a
2157       00000001      OFST:	set	1
2160                     ; 572 	uint8_t commsStatus = 0;
2162                     ; 576 	if(!_holdStart)
2164  03e5 3d00          	tnz	L71__holdStart
2165  03e7 260f          	jrne	L777
2166                     ; 578 		commsStatus = i2c_start();
2168  03e9 cd0000        	call	_i2c_start
2170  03ec 6b01          	ld	(OFST+0,sp),a
2172                     ; 579 		if((commsStatus != SUCCESS))
2174  03ee 0d01          	tnz	(OFST+0,sp)
2175  03f0 2708          	jreq	L3001
2176                     ; 581 			i2c_stop();
2178  03f2 cd0000        	call	_i2c_stop
2180                     ; 582 			return FALSE;
2182  03f5 4f            	clr	a
2184  03f6 2013          	jra	L05
2185  03f8               L777:
2186                     ; 587 		_holdStart = FALSE;
2188  03f8 3f00          	clr	L71__holdStart
2189  03fa               L3001:
2190                     ; 591 	commsStatus = i2c_slaveRequest(_deviceAddress, WRITE);
2192  03fa b603          	ld	a,L11__deviceAddress
2193  03fc 5f            	clrw	x
2194  03fd 95            	ld	xh,a
2195  03fe cd0000        	call	_i2c_slaveRequest
2197  0401 6b01          	ld	(OFST+0,sp),a
2199                     ; 592 	if(commsStatus != SUCCESS)
2201  0403 0d01          	tnz	(OFST+0,sp)
2202  0405 2707          	jreq	L5001
2203                     ; 594 		i2c_stop();
2205  0407 cd0000        	call	_i2c_stop
2207                     ; 595 		return FALSE;
2209  040a 4f            	clr	a
2211  040b               L05:
2213  040b 5b03          	addw	sp,#3
2214  040d 81            	ret
2215  040e               L5001:
2216                     ; 599 	commsStatus = i2c_writeByte(commandByte);
2218  040e 7b02          	ld	a,(OFST+1,sp)
2219  0410 cd0000        	call	_i2c_writeByte
2221  0413 6b01          	ld	(OFST+0,sp),a
2223                     ; 600 	if((commsStatus != SUCCESS))
2225  0415 0d01          	tnz	(OFST+0,sp)
2226  0417 2706          	jreq	L7001
2227                     ; 602 		i2c_stop();
2229  0419 cd0000        	call	_i2c_stop
2231                     ; 603 		return FALSE;
2233  041c 4f            	clr	a
2235  041d 20ec          	jra	L05
2236  041f               L7001:
2237                     ; 607 	if(stopOrRestart)
2239  041f 0d03          	tnz	(OFST+2,sp)
2240  0421 2703          	jreq	L1101
2241                     ; 608 		i2c_stop();
2243  0423 cd0000        	call	_i2c_stop
2245  0426               L1101:
2246                     ; 611 	return TRUE;
2248  0426 a601          	ld	a,#1
2250  0428 20e1          	jra	L05
2291                     ; 622 void azq_setActiveDevice(AZQ_Device_t *azqDevice)
2291                     ; 623 {
2292                     	switch	.text
2293  042a               _azq_setActiveDevice:
2295  042a 89            	pushw	x
2296       00000000      OFST:	set	0
2299                     ; 624 	_deviceAddress = azqDevice->deviceAddress;
2301  042b f6            	ld	a,(x)
2302  042c b703          	ld	L11__deviceAddress,a
2303                     ; 625 	_readyPort = azqDevice->readyPort;
2305  042e ee01          	ldw	x,(1,x)
2306  0430 bf01          	ldw	L31__readyPort,x
2307                     ; 626 	_readyPin = azqDevice->readyPin;
2309  0432 1e01          	ldw	x,(OFST+1,sp)
2310  0434 e603          	ld	a,(3,x)
2311  0436 b700          	ld	L51__readyPin,a
2312                     ; 627 }
2315  0438 85            	popw	x
2316  0439 81            	ret
2351                     ; 634 void azq_setTimeout(uint8_t timeoutIn)
2351                     ; 635 {
2352                     	switch	.text
2353  043a               _azq_setTimeout:
2357                     ; 636 	azqTimeout_ms = timeoutIn;
2359  043a b701          	ld	L12_azqTimeout_ms,a
2360                     ; 637 }
2363  043c 81            	ret
2390                     ; 646 static void _toggleReady(void)
2390                     ; 647 {
2391                     	switch	.text
2392  043d               L7__toggleReady:
2396                     ; 649 	RDY_OUT_OD;
2398  043d b600          	ld	a,L51__readyPin
2399  043f 43            	cpl	a
2400  0440 92c401        	and	a,[L31__readyPort.w]
2401  0443 92c701        	ld	[L31__readyPort.w],a
2404  0446 be01          	ldw	x,L31__readyPort
2405  0448 e602          	ld	a,(2,x)
2406  044a ba00          	or	a,L51__readyPin
2407  044c e702          	ld	(2,x),a
2408                     ; 651 	_delay_ms(5);
2410  044e ae0005        	ldw	x,#5
2411  0451 cd0000        	call	__delay_ms
2413                     ; 653 	RDY_IN_FLOAT;
2415  0454 be01          	ldw	x,L31__readyPort
2416  0456 b600          	ld	a,L51__readyPin
2417  0458 43            	cpl	a
2418  0459 e402          	and	a,(2,x)
2419  045b e702          	ld	(2,x),a
2420                     ; 655 	_delay_us(10);
2422  045d ae000a        	ldw	x,#10
2423  0460 cd0000        	call	__delay_us
2425                     ; 656 }
2428  0463 81            	ret
2492                     	switch	.ubsct
2493  0000               L51__readyPin:
2494  0000 00            	ds.b	1
2495  0001               L31__readyPort:
2496  0001 0000          	ds.b	2
2497  0003               L11__deviceAddress:
2498  0003 00            	ds.b	1
2499                     	xref	__delay_ms
2500                     	xref	__delay_us
2501                     	xdef	_azq_setTimeout
2502                     	xdef	_azq_setActiveDevice
2503                     	xdef	_azq_writeCommand
2504                     	xdef	_azq_readRandomBytes
2505                     	xdef	_azq_writeRandomBytes
2506                     	xdef	_azq_forceComms_PN
2507                     	xdef	_azq_forceComms
2508                     	xdef	_azq_poll_PN
2509                     	xdef	_azq_poll
2510                     	xdef	_azq_requestComms
2511                     	xdef	_azq_waitForReady
2512                     	xdef	_azq_init_s
2513                     	xdef	_azq_init_m
2514                     	xref	_i2c_readByte
2515                     	xref	_i2c_writeByte
2516                     	xref	_i2c_slaveRequest
2517                     	xref	_i2c_stop
2518                     	xref	_i2c_start
2519                     	xref	_i2c_init
2520                     	xref	_GPIO_Init
2521                     	xref.b	c_x
2522                     	xref.b	c_y
2542                     	xref	c_smodx
2543                     	end
