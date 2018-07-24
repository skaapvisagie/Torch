/*
* This file contains all the necessary settings for the IQS624 and this file can
* be changed from the GUI or edited here
* File:   IQS624_init.h
* Author: Azoteq
*/

//#ifndef IQS624_INIT_H
//#define IQS624_INIT_H





/* Change the Prox Sensor Settings */
/* Memory Map Position 0x40 - 0x49 */

#define PXS_SETTINGS_1						0x02
#define PXS_SETTINGS_2						0x5B
#define PXS_SETTINGS_3						0x4A
#define PXS_SETTINGS_4						0x50
#define PXS_SETTINGS_5						0x01
#define PXS_SETTINGS_6						0x04
#define PXS_SETTINGS_7						0x95
#define PXS_SETTINGS_8						0xC3
#define PXS_SETTINGS_9						0x41

/* Change the Prox UI Settings */
/* Memory Map Position 0x50 - 0x54 */
#define PXS_UI_SETTINGS_0					0x16
#define PXS_UI_SETTINGS_1					0x1C
#define PXS_UI_SETTINGS_2					0x33
#define PXS_UI_SETTINGS_3					0x69
#define PXS_UI_SETTINGS_4					0x28


/* Change the Device & PMU Settings */
/* Memory Map Position 0xD0 - 0xD7 */
#define SYSTEM_SETTINGS						0x38
#define ACTIVE_CHS								0x01
#define PMU_SETTINGS							0x03
#define REPORT_RATES_TIMINGS_0				0x0A
#define REPORT_RATES_TIMINGS_1				0x30
#define REPORT_RATES_TIMINGS_2				0x08
#define REPORT_RATES_TIMINGS_3				0x14
#define REPORT_RATES_TIMINGS_4				0x07

//#endif	/* IQS624_INIT_H */

void iqs624_writeSettings(void);