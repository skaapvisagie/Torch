/******************************************************************************
*                                                                             *
*                            Module specification                             *
*                                                                             *
*                                Copyright by                                 *
*                                                                             *
*                              Azoteq (Pty) Ltd                               *
*                          Republic of South Africa                           *
*                                                                             *
*                           Tel: +27(0)21 863 0033                            *
*                        	    www.azoteq.com                             	  *
*                                                                             *
*******************************************************************************
Refer to module specification of main.c for more information
*******************************************************************************/

/* Includes ------------------------------------------------------------------*/
#include "stm8s.h"
#include "delay.h"

void delay_100clk(void)
{
	u8 i = 0;
	nop();
	nop();
	for (i = 0; i < 19; i++)
		nop();
}

void delay_1ms(void){
	u8 i = 0;
	for (i = 0; i < 150; i++)
		delay_100clk();
}

void delay_ms(u16 milliseconds)
{
	u16 i;
	for (i = 0; i < milliseconds; i++)
	{
		delay_1ms();
	}

}
