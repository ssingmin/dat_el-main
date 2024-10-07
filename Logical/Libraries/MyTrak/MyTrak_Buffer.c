/********************************************************************
 * COPYRIGHT -- B&R Korea
 ********************************************************************
 * File: MyTrak_Buffer.c
 * Author: Taeryoung Ok
 * Created: 2021/11/06
 ********************************************************************
 * Description: Manager Buffer Area for Trak System
 ********************************************************************/

#include <bur/plctypes.h>
#ifdef __cplusplus
	extern "C"
	{
#endif
	#include "MyTrak.h"
	#include "MyTrakFunc.h"
#ifdef __cplusplus
	};
#endif

#define NULL 0
#define FALSE 0
#define TRUE 1

/* Buffer System */
void MyTrak_Buffer(struct MyTrak_Buffer* inst)
{
	int loop = 0, unuseableSlotCount = 0;
	
	MyTrakSlotType* slot;
	
	MyTrakSlotTransType* 	newSlotMove;

	if (inst->Enable == TRUE && inst->Active == FALSE)
	{	//Disabled -> Enable
		inst->Internal.CheckInPointEnable.Enable 	= TRUE;
		inst->Internal.CheckOutBarrier.Execute 		= TRUE;
		inst->Internal.CheckOutBarrier.Command 		= mcACPTRAK_BARRIER_CLOSE;
		inst->CountOfSupplied 						= 0;
		
		if (inst->Internal.CheckInPointEnable.Valid == TRUE && inst->Internal.CheckOutBarrier.Done == TRUE)
		{
			inst->Active = TRUE;
		}
	}
	else if (inst->Enable == FALSE && inst->Active == TRUE)
	{	//Enable ->Disable
		inst->Internal.CheckInPointEnable.Enable 	= FALSE;
		inst->Internal.GetShuttleInfo.Enable		= FALSE;
		inst->Internal.GetCheckInShuttleInfo.Execute= FALSE;
		inst->Internal.CheckOutBarrier.Execute 		= TRUE;
		inst->Internal.CheckOutBarrier.Command 		= mcACPTRAK_BARRIER_OPEN;
		inst->Internal.GetShuttleInfo.Enable		= FALSE;
		inst->Internal.outReqCount					= 0;
		
		if (inst->Internal.CheckInPointEnable.Valid == FALSE && inst->Internal.CheckOutBarrier.Done == TRUE)
		{
			releaseMyTrakSlotTran(&inst->Internal.slotMoveFc);

			for (loop = 0; loop < inst->TargetSlotCount; loop++)
			{
				slot 			= (MyTrakSlotType*)(inst->TargetStage + sizeof(MyTrakSlotType) * loop);
				brsmemset((UDINT)&slot->Shuttle, 0, sizeof(McAxisType));
				slot->Interface = E_SLOT_UNKNOWN;
			}
			inst->Active = FALSE;
		}
	}
	else if (inst->Enable == TRUE && inst->Active == TRUE)
	{		
		//Error Check
		
		//Shuttle Count Check in Target Stage
		for (loop = 0; loop < inst->TargetSlotCount; loop++)
		{
			slot = (MyTrakSlotType*)(inst->TargetStage + sizeof(MyTrakSlotType) * loop);
				
			if (slot->Shuttle.controlif != 0)
				unuseableSlotCount++;
		}

		//Add Request Count of Buffer
		if (inst->Process == TRUE)
		{				
			// Auto Mode Handle
			if (inst->Feeding == FALSE)
			{
				inst->ErrorID = MyTrakIdle;				
			}
			else
			{				
				if (inst->Internal.Tmr.Q == TRUE) 
				{ 
					if (inst->CountOfShuttle + unuseableSlotCount >= inst->MaximumShuttleCount)
					{	//Checking Max Controller Setting
						inst->ErrorID = MyTrakMaximumControllerOverflow;
					}
					else if ((inst->Internal.outReqCount + inst->CountOfOneShot) > inst->Internal.CheckInPointEnable.EventCount)
					{	//Checking Shuttle Count in Buffer
						inst->ErrorID = MyTrakNotEnoughShuttle;
					}
					else
					{
						inst->Internal.Tmr.IN 			= FALSE;
						inst->Internal.outReqCount		= inst->Internal.outReqCount + inst->CountOfOneShot;
						inst->ErrorID 					= MyTrakRun;
					}
				}
				else
				{
					//Resetarting Timer
					inst->Interval 						= 60000.0 / ((float)inst->SetPPM / (float)inst->CountOfOneShot);
		
					inst->Internal.Tmr.IN 				= TRUE;
					inst->Internal.Tmr.PT 				= inst->Interval;
					inst->ErrorID 						= MyTrakRun;
				}
			}
		}
		else
		{	//Manual Mode Handle
			inst->ErrorID = MyTrakManual;
			
			if (inst->Internal.manualCmd.Q == TRUE && 
				inst->Internal.CheckInPointEnable.EventCount > 0)
			{
				if (inst->CountOfShuttle + unuseableSlotCount >= inst->MaximumShuttleCount)
				{	//Checking Max Controller Setting
					inst->ErrorID = MyTrakMaximumControllerOverflow;
				}
				else if ((inst->Internal.outReqCount + inst->CountOfOneShot) > inst->Internal.CheckInPointEnable.EventCount)
				{	//Checking Shuttle Count in Buffer
					inst->ErrorID = MyTrakNotEnoughShuttle;
				}
				else
				{
					//Manual Operating
					inst->Internal.outReqCount = 1;
				}
			}
		}
		
		if (inst->Internal.outReqCount > 0 && inst->Internal.CheckInPointEnable.EventCount > 0)
			inst->Internal.GetCheckInShuttleInfo.Execute = TRUE;
		
		if (inst->Internal.GetCheckInShuttleInfo.Done == TRUE)
		{
			inst->Internal.GetShuttleInfo.Axis = &inst->Internal.GetCheckInShuttleInfo.TrgPointInfo.Axis;
			inst->Internal.GetShuttleInfo.Enable = TRUE;
				
			if (inst->Internal.GetShuttleInfo.Valid == TRUE)
			{
				if (inst->Internal.GetShuttleInfo.ShuttleInfo.AdditionalInfo.PLCopenState == mcAXIS_CONTINUOUS_MOTION)
				{
					//Select Target Slot
					if ((inst->NextSlotNo = SearchNextSlot(inst->TargetStage, inst->NextSlotNo, inst->TargetSlotCount)) != -1)
					{
						slot = (MyTrakSlotType*)(inst->TargetStage + sizeof(MyTrakSlotType) * inst->NextSlotNo);

						//Get New Last Slot Transfer Structure From FcBank
						newSlotMove = attachRoutedAbsFc(&inst->Internal.slotMoveFc);
					
						//Set Command Parameters
						newSlotMove->axis 					= inst->Internal.GetCheckInShuttleInfo.TrgPointInfo.Axis;
						newSlotMove->targetSlot 			= slot;

						newSlotMove->moveAbs.Axis			= &newSlotMove->axis;
						newSlotMove->moveAbs.Sector	 		= (McSectorType*)(newSlotMove->targetSlot->Sector);
						newSlotMove->moveAbs.Position	 	= newSlotMove->targetSlot->Position;
						newSlotMove->moveAbs.Velocity 		= inst->Velocity;
						newSlotMove->moveAbs.Acceleration 	= inst->Acceleration;
						newSlotMove->moveAbs.Deceleration 	= inst->Deceleration;
						newSlotMove->moveAbs.AdvancedParameters = inst->AdvancedParameters;
				
						newSlotMove->moveAbs.Execute 		= TRUE;
						
						//Add Ticket
						inst->Internal.CheckOutBarrier.AdvancedParameters.TicketCount = 1;
						inst->Internal.CheckOutBarrier.Command = mcACPTRAK_BARRIER_ADD_TICKETS;
						inst->Internal.CheckOutBarrier.Execute = TRUE;
					
						//Out Request Count
						inst->Internal.outReqCount--;
						inst->CountOfSupplied++;
							
						//Off Shuttle Info
						inst->Internal.GetCheckInShuttleInfo.Execute 					= FALSE;
						inst->Internal.GetShuttleInfo.Enable 							= FALSE;
					}
				}
				else
				{
					//Add Ticket
					inst->Internal.CheckOutBarrier.AdvancedParameters.TicketCount = 1;
					inst->Internal.CheckOutBarrier.Command = mcACPTRAK_BARRIER_ADD_TICKETS;
					inst->Internal.CheckOutBarrier.Execute = TRUE;
							
					//Off Shuttle Info
					inst->Internal.GetCheckInShuttleInfo.Execute 					= FALSE;
					inst->Internal.GetShuttleInfo.Enable 							= FALSE;
				}
			}
		}
		
		inst->CountOfBuffer = inst->Internal.CheckInPointEnable.EventCount;
		inst->CountOfShuttle = execMyTrakSlotTrans(&inst->Internal.slotMoveFc);	
	}
	else if (inst->Enable == FALSE && inst->Active == FALSE)
	{	//Disabled
		releaseMyTrakSlotTran(&inst->Internal.slotMoveFc);
		inst->ErrorID = MyTrakDisabled;
	}
	
	inst->Internal.manualCmd.CLK = inst->Manual;
	R_TRIG(&inst->Internal.manualCmd);
	
	TON(&inst->Internal.Tmr);
	
	if (inst->Internal.CheckOutBarrier.Done == TRUE)
		inst->Internal.CheckOutBarrier.Execute = FALSE;
	
	//Exection Function Blocks
	inst->Internal.CheckInPointEnable.ProcessPoint = inst->CheckInProcessPoint;
	inst->Internal.GetCheckInShuttleInfo.ProcessPoint = inst->CheckInProcessPoint;
	inst->Internal.CheckOutBarrier.ProcessPoint = inst->CheckOutProcessPoint;
	
	MC_BR_TrgPointEnable_AcpTrak(&inst->Internal.CheckInPointEnable);
	MC_BR_TrgPointGetInfo_AcpTrak(&inst->Internal.GetCheckInShuttleInfo);
	MC_BR_ShReadInfo_AcpTrak(&inst->Internal.GetShuttleInfo);
	MC_BR_BarrierCommand_AcpTrak(&inst->Internal.CheckOutBarrier);
}
