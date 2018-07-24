/*******************************************************************************
 * @file	iqs620.c
 * @brief Provides functionality for the IQS620 and IQS620A.
 * @note	This library builds on the azq_i2c library and uses i2c operations
 *				to acheive operations with the IQS620 and IQS620A.
 *				Some addresses are not available for the IQS620, see the 
 *				iqs620_addresses.h file for comments alongside addresses.
 * @conv	Any functions or variables which are meant to be used outside of this
 *				file are preceeded with 'iqs620_' in order to identify them when used
 *				in other files.
 *
 ******************************************************************************/
 
/*** Includes ***/
#include "iqs624Settings.h"
#include "IQS624_Init.h"
#include  "IQS624_I2C.h"

/*** Function Definitions ***/


/** @brief	Writes all the settings from the "iqs620_settings.h" file to the
 *					IQS620 device.
 *  @param 	stopOrRestart	Specifies whether the comms window should be stopped
 *												or restarted. Use STOP and RESTART definitions.
 *  @ret		TRUE if I2C operations were a success, FALSE if otherwise.
 *  @note		You must define which UIs will be used in the iqs620_settings.h
 *					file, by default the PXS settings and PXS UI settings will always be
 *					be written. Any further UI settings must be specified. All UI 
 *					UI settings cannot be written because values will be overwritten.
 *					This function automatically closes the comms window to allow for 
 *					the settings to be applied. A short delay should be implemented
 *					after calling this function.
 */
	
void iqs624_writeSettings(void)
{
	uint8_t transferBytes[10]; // Holds the bytes to be transferred.
	// Save the ProxFusion Settings 0 settings to the transferBytes array.
	// Addresses 0x40 to 0x49.
	transferBytes[0] = PXS_SETTINGS_0;
	transferBytes[1] = PXS_SETTINGS_1;
	transferBytes[2] = PXS_SETTINGS_2;
	transferBytes[3] = PXS_SETTINGS_3;
	transferBytes[4] = PXS_SETTINGS_4;
	transferBytes[5] = PXS_SETTINGS_5;
	transferBytes[6] = PXS_SETTINGS_6;
	transferBytes[7] = PXS_SETTINGS_7;
	transferBytes[8] = PXS_SETTINGS_8;
	transferBytes[9] = PXS_SETTINGS_9;

	Startup_I2C(transferBytes, 9, 0x40);
	
	
	// Save the ProxFusion Settings 1 settings to the transferBytes array.
	// Addresses 0x50 to 0x54.
	transferBytes[0] = PXS_SETTINGS_0;
	transferBytes[1] = PXS_SETTINGS_1;
	transferBytes[2] = PXS_SETTINGS_2;
	transferBytes[3] = PXS_SETTINGS_3;
	transferBytes[4] = PXS_SETTINGS_4;

	Startup_I2C(transferBytes, 4, 0x50);
																		
	// Save the Device and PMU settings to the transferBytes array.
	// Addresses 0xD0 to 0xD7.
	//bytesAmount = 9;
	transferBytes[0] = SYSTEM_SETTINGS;
	transferBytes[1] = ACTIVE_CHS;
	transferBytes[2] = PMU_SETTINGS;
	transferBytes[3] = REPORT_RATES_TIMINGS_0;
	transferBytes[4] = REPORT_RATES_TIMINGS_1;
	transferBytes[5] = REPORT_RATES_TIMINGS_2;
	transferBytes[6] = REPORT_RATES_TIMINGS_3;
	transferBytes[7] = GLOBAL_EVENT_MASK_ADD;

				
	Startup_I2C(transferBytes, 7, 0xD0);

}
