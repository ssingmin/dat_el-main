
#include <bur/plctypes.h>
#ifdef __cplusplus
	extern "C"
	{
#endif
	#include "MyTrak.h"
#ifdef __cplusplus
	};
#endif

#define FALSE 0
#define TRUE 1

void MyTrak_TicketArea(struct MyTrak_TicketArea* inst)
{
	if (inst->Enable == TRUE && inst->Active == FALSE)
	{
		inst->Internal.fbInEnable.Enable 			= TRUE;
		inst->Internal.fbOutEnable.Enable 			= TRUE;
		inst->Internal.fbBarrierReadInfo.Enable 	= TRUE;
		
		if (inst->Internal.fbInEnable.Valid == TRUE && inst->Internal.fbOutEnable.Valid == TRUE &&
			inst->Internal.fbOutEnable.Valid == TRUE)
		{
			inst->Internal.fbBarrier.Execute		= TRUE;
			inst->Internal.fbBarrier.Command 		= mcACPTRAK_BARRIER_ADD_TICKETS;
			inst->Internal.fbBarrier.AdvancedParameters.TicketCount = inst->MaximumShuttleCount;
			
			if (inst->Internal.fbBarrier.Done == TRUE)
			{
				inst->Internal.fbBarrier.Execute	= FALSE;
				inst->Active 						= TRUE;
			}
		}
	}
	else if (inst->Enable == TRUE && inst->Active == TRUE)
	{
		if (inst->Internal.fbOutGetInfo.Done == FALSE)
		{
			if (inst->Internal.fbOutEnable.EventCount > 0)
				inst->Internal.fbOutGetInfo.Execute = TRUE;
		}
		else if (inst->Internal.fbInGetInfo.Done == FALSE)
		{
			if (inst->Internal.fbInEnable.EventCount > 0)
				inst->Internal.fbInGetInfo.Execute = TRUE;
//			else
//				inst->Internal.fbOutGetInfo.Execute = FALSE;
		}
		else
		{
			if (inst->Internal.fbOutGetInfo.TrgPointInfo.Axis.controlif == inst->Internal.fbInGetInfo.TrgPointInfo.Axis.controlif
				&& inst->Internal.fbOutGetInfo.TrgPointInfo.Axis.controlif != 0
				&&inst->Internal.fbInGetInfo.TrgPointInfo.Axis.controlif != 0)
			{	
//				if (inst->Internal.fbBarrierReadInfo.BarrierInfo.RemainingTickets + inst->Internal.fbInEnable.EventCount
//					< inst->MaximumShuttleCount)
//				{					
					inst->Internal.fbBarrier.Execute		= TRUE;
					inst->Internal.fbBarrier.Command 		= mcACPTRAK_BARRIER_ADD_TICKETS;
					inst->Internal.fbBarrier.AdvancedParameters.TicketCount = 1;
//				}
				
				if (inst->Internal.fbBarrier.Done == TRUE)
				{					
					inst->Internal.fbBarrier.Execute		= FALSE;
					inst->Internal.fbInGetInfo.Execute 		= FALSE;
					inst->Internal.fbOutGetInfo.Execute 	= FALSE;
				}
			}
			else
			{
				inst->Internal.fbOutGetInfo.Execute = FALSE;
			}
		}
	}
	else if (inst->Enable == FALSE && inst->Active == TRUE)
	{
		inst->Active 								= FALSE;
	}
	else if (inst->Enable == FALSE && inst->Active == FALSE)
	{
		inst->Internal.fbInEnable.Enable 			= FALSE;
		inst->Internal.fbOutEnable.Enable 			= FALSE;
		inst->Internal.fbBarrierReadInfo.Enable 	= TRUE;
		
		if (inst->Internal.fbBarrier.Done == TRUE)
		{
			inst->Internal.fbBarrier.Execute 	= FALSE;
		}
		else if (inst->Internal.fbBarrierReadInfo.BarrierInfo.Status != mcACPTRAK_BARRIER_OPENED)
		{
			inst->Internal.fbBarrier.Command 	= mcACPTRAK_BARRIER_OPEN;
			inst->Internal.fbBarrier.Execute 	= TRUE;
		}
	}
	
	inst->Internal.fbInEnable.ProcessPoint 		 	= inst->InPoint;
	inst->Internal.fbInGetInfo.ProcessPoint 		= inst->InPoint;

	MC_BR_TrgPointEnable_AcpTrak(&inst->Internal.fbInEnable);
	MC_BR_TrgPointGetInfo_AcpTrak(&inst->Internal.fbInGetInfo);

	inst->Internal.fbOutEnable.ProcessPoint			= inst->OutPoint;
	inst->Internal.fbOutGetInfo.ProcessPoint		= inst->OutPoint;

	MC_BR_TrgPointEnable_AcpTrak(&inst->Internal.fbOutEnable);
	MC_BR_TrgPointGetInfo_AcpTrak(&inst->Internal.fbOutGetInfo);

	inst->Internal.fbBarrier.ProcessPoint 			= inst->InPoint;
	inst->Internal.fbBarrierReadInfo.ProcessPoint 	= inst->InPoint;
	MC_BR_BarrierReadInfo_AcpTrak(&inst->Internal.fbBarrierReadInfo);
	MC_BR_BarrierCommand_AcpTrak(&inst->Internal.fbBarrier);
}
