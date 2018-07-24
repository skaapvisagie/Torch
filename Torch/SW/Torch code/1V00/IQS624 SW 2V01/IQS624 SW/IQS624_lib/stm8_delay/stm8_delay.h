#ifndef _STM8_DELAY_H
#define	_STM8_DELAY_H


//#include "hardware.h"
// F_CPU is declared as an extern in "hardware.h"
#ifndef F_CPU
#define F_CPU 16000000UL
#endif

/* FOR COSMIC */
//#define T_COUNT(x)	((((F_CPU * x) / 1000000UL) - 3) / 3)

void _delay_cycl(unsigned short __ticks);

void _delay_us(const unsigned short __us);

void _delay_ms(unsigned short __ms);

#endif // _STM8_DELAY_H

