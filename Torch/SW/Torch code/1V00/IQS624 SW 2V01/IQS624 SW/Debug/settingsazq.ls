   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.10 - 06 Jul 2017
   3                     ; Generator (Limited) V4.4.7 - 05 Oct 2017
  87                     ; 23 bool iqs624_writeSettings(void)
  87                     ; 24 {
  89                     	switch	.text
  90  0000               _iqs624_writeSettings:
  92  0000 520b          	subw	sp,#11
  93       0000000b      OFST:	set	11
  96                     ; 25 	bool asdf = FALSE;  
  98                     ; 29 	transferBytes[0] = PXS_SETTINGS_0;
 100  0002 a601          	ld	a,#1
 101  0004 6b02          	ld	(OFST-9,sp),a
 103                     ; 30 	transferBytes[1] = PXS_SETTINGS_1;
 105  0006 a602          	ld	a,#2
 106  0008 6b03          	ld	(OFST-8,sp),a
 108                     ; 31 	transferBytes[2] = PXS_SETTINGS_2;
 110  000a a65b          	ld	a,#91
 111  000c 6b04          	ld	(OFST-7,sp),a
 113                     ; 32 	transferBytes[3] = PXS_SETTINGS_3;
 115  000e a64a          	ld	a,#74
 116  0010 6b05          	ld	(OFST-6,sp),a
 118                     ; 33 	transferBytes[4] = PXS_SETTINGS_4;
 120  0012 a650          	ld	a,#80
 121  0014 6b06          	ld	(OFST-5,sp),a
 123                     ; 34 	transferBytes[5] = PXS_SETTINGS_5;
 125  0016 a601          	ld	a,#1
 126  0018 6b07          	ld	(OFST-4,sp),a
 128                     ; 35 	transferBytes[6] = PXS_SETTINGS_6;
 130  001a a604          	ld	a,#4
 131  001c 6b08          	ld	(OFST-3,sp),a
 133                     ; 36 	transferBytes[7] = PXS_SETTINGS_7;
 135  001e a695          	ld	a,#149
 136  0020 6b09          	ld	(OFST-2,sp),a
 138                     ; 37 	transferBytes[8] = PXS_SETTINGS_8;
 140  0022 a6c3          	ld	a,#195
 141  0024 6b0a          	ld	(OFST-1,sp),a
 143                     ; 38 	transferBytes[9] = PXS_SETTINGS_9;
 145  0026 a641          	ld	a,#65
 146  0028 6b0b          	ld	(OFST+0,sp),a
 148                     ; 41 	asdf = azq_writeRandomBytes(0x40, 9, transferBytes, RESTART); // write settings in regesters 0x40 - 0x49
 150  002a 4b00          	push	#0
 151  002c 96            	ldw	x,sp
 152  002d 1c0003        	addw	x,#OFST-8
 153  0030 89            	pushw	x
 154  0031 ae4009        	ldw	x,#16393
 155  0034 cd0000        	call	_azq_writeRandomBytes
 157  0037 5b03          	addw	sp,#3
 158  0039 6b01          	ld	(OFST-10,sp),a
 160                     ; 43 	if(!asdf)
 162  003b 0d01          	tnz	(OFST-10,sp)
 163  003d 2604          	jrne	L15
 164                     ; 44 	return(asdf);
 166  003f 7b01          	ld	a,(OFST-10,sp)
 168  0041 202d          	jra	L6
 169  0043               L15:
 170                     ; 48 	transferBytes[0] = PXS_UI_SETTINGS_0;
 172  0043 a616          	ld	a,#22
 173  0045 6b02          	ld	(OFST-9,sp),a
 175                     ; 49 	transferBytes[1] = PXS_UI_SETTINGS_1;
 177  0047 a61c          	ld	a,#28
 178  0049 6b03          	ld	(OFST-8,sp),a
 180                     ; 50 	transferBytes[2] = PXS_UI_SETTINGS_2;
 182  004b a633          	ld	a,#51
 183  004d 6b04          	ld	(OFST-7,sp),a
 185                     ; 51 	transferBytes[3] = PXS_UI_SETTINGS_3;
 187  004f a669          	ld	a,#105
 188  0051 6b05          	ld	(OFST-6,sp),a
 190                     ; 52 	transferBytes[4] = PXS_UI_SETTINGS_4;
 192  0053 a628          	ld	a,#40
 193  0055 6b06          	ld	(OFST-5,sp),a
 195                     ; 54 	asdf &= azq_writeRandomBytes(0x50, 4, transferBytes, RESTART); // write settings in regesters 0x50 - 0x54
 197  0057 4b00          	push	#0
 198  0059 96            	ldw	x,sp
 199  005a 1c0003        	addw	x,#OFST-8
 200  005d 89            	pushw	x
 201  005e ae5004        	ldw	x,#20484
 202  0061 cd0000        	call	_azq_writeRandomBytes
 204  0064 5b03          	addw	sp,#3
 205  0066 1401          	and	a,(OFST-10,sp)
 206  0068 6b01          	ld	(OFST-10,sp),a
 208                     ; 56 	if(!asdf)
 210  006a 0d01          	tnz	(OFST-10,sp)
 211  006c 2605          	jrne	L35
 212                     ; 57 	return(asdf);
 214  006e 7b01          	ld	a,(OFST-10,sp)
 216  0070               L6:
 218  0070 5b0b          	addw	sp,#11
 219  0072 81            	ret
 220  0073               L35:
 221                     ; 62 	transferBytes[0] = SYSTEM_SETTINGS;
 223  0073 a638          	ld	a,#56
 224  0075 6b02          	ld	(OFST-9,sp),a
 226                     ; 63 	transferBytes[1] = ACTIVE_CHS;
 228  0077 a601          	ld	a,#1
 229  0079 6b03          	ld	(OFST-8,sp),a
 231                     ; 64 	transferBytes[2] = PMU_SETTINGS;
 233  007b a603          	ld	a,#3
 234  007d 6b04          	ld	(OFST-7,sp),a
 236                     ; 65 	transferBytes[3] = REPORT_RATES_TIMINGS_0;
 238  007f a60a          	ld	a,#10
 239  0081 6b05          	ld	(OFST-6,sp),a
 241                     ; 66 	transferBytes[4] = REPORT_RATES_TIMINGS_1;
 243  0083 a630          	ld	a,#48
 244  0085 6b06          	ld	(OFST-5,sp),a
 246                     ; 67 	transferBytes[5] = REPORT_RATES_TIMINGS_2;
 248  0087 a608          	ld	a,#8
 249  0089 6b07          	ld	(OFST-4,sp),a
 251                     ; 68 	transferBytes[6] = REPORT_RATES_TIMINGS_3;
 253  008b a614          	ld	a,#20
 254  008d 6b08          	ld	(OFST-3,sp),a
 256                     ; 69 	transferBytes[7] = REPORT_RATES_TIMINGS_4;
 258  008f a607          	ld	a,#7
 259  0091 6b09          	ld	(OFST-2,sp),a
 261                     ; 72 	asdf &= azq_writeRandomBytes(0xD0, 7, transferBytes, STOP); // write settings in regesters 0xD0 - 0xD7
 263  0093 4b01          	push	#1
 264  0095 96            	ldw	x,sp
 265  0096 1c0003        	addw	x,#OFST-8
 266  0099 89            	pushw	x
 267  009a aed007        	ldw	x,#53255
 268  009d cd0000        	call	_azq_writeRandomBytes
 270  00a0 5b03          	addw	sp,#3
 271  00a2 1401          	and	a,(OFST-10,sp)
 272  00a4 6b01          	ld	(OFST-10,sp),a
 274                     ; 74 	if(!asdf)
 276  00a6 0d01          	tnz	(OFST-10,sp)
 277  00a8 2604          	jrne	L55
 278                     ; 75 	return(asdf);
 280  00aa 7b01          	ld	a,(OFST-10,sp)
 282  00ac 20c2          	jra	L6
 283  00ae               L55:
 284                     ; 77 	return(asdf);
 286  00ae 7b01          	ld	a,(OFST-10,sp)
 288  00b0 20be          	jra	L6
 301                     	xdef	_iqs624_writeSettings
 302                     	xref	_azq_writeRandomBytes
 321                     	end
