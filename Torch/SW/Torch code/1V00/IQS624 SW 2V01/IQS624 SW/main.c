
/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */

#include "stm8s.h"
#include "stm8s_gpio.h"
#include "iqs624_i2c.h"

#include "delay.h"


#define LED_GPIO_PORT  (GPIOC) // LED Control pin
#define LED_pin		(GPIO_PIN_4)

//#define I2C_SPEED 			400000

extern uint8_t Touch;

void main()
{
 delay_ms(100);// delay that the IQS624 can Stabilize 
 CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
// I2C_DeInit();
// I2C_Cmd(ENABLE);
// I2C_Init(I2C_SPEED, 0xA0, I2C_DUTYCYCLE_2, I2C_ACK_CURR, I2C_ADDMODE_7BIT, 8);
 
 
 Init_i2c();


 GPIO_Init(LED_GPIO_PORT, LED_pin, GPIO_MODE_OUT_OD_LOW_SLOW);
 
 GPIOC->ODR |= LED_pin; // Set LED pin High to put led off
 
 
 enableInterrupts();
 
while (1)
{  

	
	if(Touch)
	{
			GPIOC->ODR &= (uint8_t)~LED_pin;
			delay_ms(1000);
			GPIOC->ODR |= LED_pin;
			Touch = 0; 
	}
	
	//else 
		//GPIOC->ODR &= LED_pin;

}

}



