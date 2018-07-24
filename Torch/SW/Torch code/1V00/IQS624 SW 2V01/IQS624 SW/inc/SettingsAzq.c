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
#include "SettingsAzq.h"
#include "iqs624_i2c.h"
#include "azq_i2c.h"


/*** Function Definitions ***/

	
bool iqs624_writeSettings(void)
{
	bool asdf = FALSE;  
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


	asdf = azq_writeRandomBytes(0x40, 9, transferBytes, RESTART); // write settings in regesters 0x40 - 0x49
	
	if(!asdf)
	return(asdf);
	
	// Save the ProxFusion Settings 1 settings to the transferBytes array.
	// Addresses 0x50 to 0x54.
	transferBytes[0] = PXS_UI_SETTINGS_0;
	transferBytes[1] = PXS_UI_SETTINGS_1;
	transferBytes[2] = PXS_UI_SETTINGS_2;
	transferBytes[3] = PXS_UI_SETTINGS_3;
	transferBytes[4] = PXS_UI_SETTINGS_4;

	asdf &= azq_writeRandomBytes(0x50, 4, transferBytes, RESTART); // write settings in regesters 0x50 - 0x54
	
	if(!asdf)
	return(asdf);
																		
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
	transferBytes[7] = REPORT_RATES_TIMINGS_4;

				
	asdf &= azq_writeRandomBytes(0xD0, 7, transferBytes, STOP); // write settings in regesters 0xD0 - 0xD7
	
	if(!asdf)
	return(asdf);
	
	return(asdf);

}
