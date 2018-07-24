#include "iqs624_i2c.h"

uint8_t Touch  = 0x00;
uint8_t Prox   = 0x00;
uint8_t Buffer_azq[1];

void Init_i2c(void)
{
	azq_init_s(SLAVE_ADDRESS, 				// initilize the I2C 130Khz
									RDY_PORT, RDY_pin,
									SCL_PORT, SCL_pin,
									SDA_PORT, SDA_pin,
									_100kHz);
									
	EXTI_SetExtIntSensitivity(EXTI_PORT_GPIOA, EXTI_SENSITIVITY_FALL_ONLY);
									
	//Set interrupt on ready pin
	
	
	ITC_SetSoftwarePriority(ITC_IRQ_PORTA, ITC_PRIORITYLEVEL_1);
	
	while(!iqs624_writeSettings());
	
}


void TP()
{
	
	if(Buffer_azq[0] & Touch_set)
	Touch = 1;
	else
	Touch = 0;
}

