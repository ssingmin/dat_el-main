
#include <bur/plctypes.h>
#ifdef __cplusplus
	extern "C"
	{
#endif
	#include "MyTrak.h"
#ifdef __cplusplus
	};
#endif

#define NULL 0
#define FALSE 0
#define TRUE 1

void MyTrak_ShInfeeder(struct MyTrak_ShInfeeder* inst)
{
	if (inst->Enable == TRUE && inst->Active == FALSE)
	{ //Disabled -> Enable
		inst->Active = TRUE;
	}
	else if (inst->Enable == FALSE && inst->Active == TRUE)
	{ //Enabled -> Disable
		inst->Active = FALSE;
	}
	else if (inst->Enable == TRUE && inst->Active == TRUE)
	{ //Enabled
		inst->Internal.BarReadInfo.Enable = TRUE;
		
		if (inst->Process == TRUE)
		{
			//Auto Feeding
			if (inst->Internal.Tmr.Q == TRUE && inst->Pause == FALSE && 
				inst->Internal.BarReadInfo.BarrierInfo.RemainingTickets <= (UDINT)inst->CountOfOneShot)
			{
				inst->Internal.BarCmd.Command 	= mcACPTRAK_BARRIER_ADD_TICKETS;
				inst->Internal.BarCmd.Execute 	= TRUE;
				inst->Internal.BarCmd.AdvancedParameters.TicketCount = (DINT)inst->CountOfOneShot;
			
				inst->Internal.Tmr.IN 			= FALSE;
			}
			else
			{
				inst->Interval 					= 60000.0 / ((float)inst->SetPPM / (float)inst->CountOfOneShot);
		
				inst->Internal.Tmr.IN 			= TRUE;
				inst->Internal.Tmr.PT 			= inst->Interval;
			}
			inst->ErrorID 	= MyTrakRun;
		}
		else
		{
			//Manual Feeding
			if (inst->Internal.manualCmd.Q == TRUE)
			{
				inst->Internal.BarCmd.Command 	= mcACPTRAK_BARRIER_ADD_TICKETS;
				inst->Internal.BarCmd.Execute 	= TRUE;
				inst->Internal.BarCmd.AdvancedParameters.TicketCount = 1;
			
				inst->Internal.Tmr.IN 			= FALSE;
			}
			inst->Internal.Tmr.IN 			= FALSE;
			
			inst->ErrorID 	= MyTrakIdle;
		}
	}
	else if (inst->Enable == FALSE && inst->Active == FALSE)
	{ //Disabled
		inst->ErrorID 	= MyTrakDisabled;
	}
	
	inst->Internal.manualCmd.CLK = inst->Manual;
	R_TRIG(&inst->Internal.manualCmd);
	
	if (inst->Internal.BarCmd.Done == TRUE)		
		inst->Internal.BarCmd.Execute = FALSE;

	inst->Internal.BarCmd.ProcessPoint		= inst->ProcessPoint;
	inst->Internal.BarReadInfo.ProcessPoint	= inst->ProcessPoint;	
	
	TON(&inst->Internal.Tmr);
	MC_BR_BarrierCommand_AcpTrak(&inst->Internal.BarCmd);
	MC_BR_BarrierReadInfo_AcpTrak(&inst->Internal.BarReadInfo);
}
