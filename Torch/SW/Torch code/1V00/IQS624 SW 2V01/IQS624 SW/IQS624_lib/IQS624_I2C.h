#include "stm8s_gpio.h"
#include "stm8s.h"
#include "azq_i2c.h"
#include "stm8s_itc.h"
#include "SettingsAzq.h"


#define RDY_PORT  (GPIOA) // difine ready port	
#define RDY_pin  (GPIO_PIN_3)//  define ready pin

#define SDA_PORT  (GPIOB) // difine SDA port	
#define SDA_pin  (GPIO_PIN_5)//  define SDA pin

#define SCL_PORT  (GPIOB) // difine SCL port	
#define SCL_pin  (GPIO_PIN_4)//  define SCL pin

#define SLAVE_ADDRESS  	0x44 
#define TP_Reg					0x12// bits  7 6 5  4   3  2  1  0
														// 			 0 0 t  T0  0  0  P1 p  
														
#define Touch_set			0x10 //0b0001 0000	
#define Prox_set			0x02 //0b0000 0010	
#define prox_return 	0x01	// If prox bit is set return 000 0001
#define Touch_return	0x02	// If prox bit is set return 000 0010
#define PT_return 		0x03  // if both prox and touch bits are set return 0000 0011

 


void Init_i2c(void);


void TP(void);

