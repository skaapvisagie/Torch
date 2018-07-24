#include "stm8_delay.h"
#include "stm8s.h"

/* 
 * Func delayed N cycles, where N = 3 + ( ticks * 3 )
 * so, ticks = ( N - 3 ) / 3, minimum delay is 6 CLK
 * when tick = 1, because 0 equels 65535
 */

void _delay_cycl(unsigned short __ticks)
{
		//ldw X, __ticks ; insert automaticaly
		_asm("nop\n $N:\n decw X\n jrne $L\n nop\n ", __ticks);
}

void _delay_us(const unsigned short __us)
{
	//_delay_cycl((unsigned short)(T_COUNT(__us)));
	uint16_t ticks = (uint16_t)((uint32_t)F_CPU / (uint32_t)1000000);

	ticks *= __us;
	ticks -= 3;
	ticks /= 3;
	_delay_cycl(ticks);
}

void _delay_ms(unsigned short __ms)
{
	while (__ms--)
	{
		_delay_us(1000);
	}
}