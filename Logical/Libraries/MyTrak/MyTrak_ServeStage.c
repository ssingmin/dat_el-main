/********************************************************************
 * COPYRIGHT -- B&R Korea
 ********************************************************************
 * File: MyTrak_ServeStage.c
 * Author: Taeryoung Ok
 * Created: 2021/11/06
 ********************************************************************
 * Description: Serve Shuttle to Slot that is pass Source Process Point
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

#define NULL
#define FALSE 0
#define TRUE 1

void MyTrak_ServeStage(struct MyTrak_ServeStage* inst)
{
	int loop = 0, unuseableSlotCount = 0;
	MyTrakSlotType* 		slot;
	
	MyTrakSlotTransType* 	newSlotMove;
	
	//////////////////////////////////////////////////////////////////////
	if (inst->Enable == TRUE && inst->Active == FALSE)
	{
		inst->Internal.fbTrgEnable.Enable 	= TRUE;
		
		if (inst->Internal.fbTrgEnable.Valid == TRUE)
			inst->Active = TRUE;
	}
	else if (inst->Enable == FALSE && inst->Active == TRUE)
	{
		inst->Active 						= FALSE;
		inst->CountOfShuttle 				= 0;
		inst->NextSlotNo 					= 0;
		inst->Internal.fbTrgEnable.Enable 	= FALSE;
		
		releaseMyTrakSlotTran(&inst->Internal.slotMoveFc);
		
		for (loop = 0; loop < inst->TargetSlotCount; loop++)
		{
			slot 			= (MyTrakSlotType*)(inst->TargetStage + sizeof(MyTrakSlotType) * loop);
			brsmemset((UDINT)&slot->Shuttle, 0, sizeof(McAxisType));
			slot->Interface = E_SLOT_UNKNOWN;
		}
	}
	else if (inst->Enable == TRUE && inst->Active == TRUE)
	{
		//Trig Point Check
		
		//Slot Setting Check(Target Sector, Target Slot)
		
		//Shuttle Count Check in Target Stage
		for (loop = 0; loop < inst->TargetSlotCount; loop++)
		{
			slot = (MyTrakSlotType*)(inst->TargetStage + sizeof(MyTrakSlotType) * loop);
			
			if (slot->Shuttle.controlif != 0)
				unuseableSlotCount++;
		}
		
		//Shuttle Check
		if (inst->Internal.fbTrgEnable.EventCount > 0)
		{
			if (inst->CountOfShuttle + unuseableSlotCount >= inst->MaximumShuttleCount)
			{
				inst->ErrorID = MyTrakMaximumControllerOverflow;
			}
			else if ((inst->MinimumShuttleCount != 0 && inst->Internal.fbTrgEnable.EventCount + inst->CountOfShuttle < inst->MinimumShuttleCount))
			{
				inst->ErrorID = MyTrakMinimumControllerUnderflow;	
			}
			else
			{
				inst->Internal.fbTrgInfo.Execute = TRUE;
		
				if ((inst->Internal.fbTrgInfo.Done == TRUE)
					&& ((inst->NextSlotNo = SearchNextSlot(inst->TargetStage, inst->NextSlotNo, inst->TargetSlotCount)) != -1))
				{
					slot = (MyTrakSlotType*)(inst->TargetStage + sizeof(MyTrakSlotType) * inst->NextSlotNo);
			
					//Get New Last Slot Transfer Structure From FcBank
					newSlotMove = attachRoutedAbsFc(&inst->Internal.slotMoveFc);

			
					//Set Command Parameters
					newSlotMove->axis 					= inst->Internal.fbTrgInfo.TrgPointInfo.Axis;
					newSlotMove->targetSlot 			= slot;
			
					newSlotMove->moveAbs.Axis	 		= &newSlotMove->axis;
					newSlotMove->moveAbs.Sector	 		= (McSectorType*)(newSlotMove->targetSlot->Sector);
					newSlotMove->moveAbs.Position	 	= newSlotMove->targetSlot->Position;
					newSlotMove->moveAbs.Velocity 		= inst->Velocity;
					newSlotMove->moveAbs.Acceleration 	= inst->Acceleration;
					newSlotMove->moveAbs.Deceleration 	= inst->Deceleration;
					newSlotMove->moveAbs.AdvancedParameters = inst->AdvancedParameters;
			
					newSlotMove->moveAbs.Execute 		= TRUE;
			
					inst->Internal.fbTrgInfo.Execute 	= FALSE;
				}
				
				if (inst->CountOfShuttle > 0)
					inst->ErrorID = MyTrakRun;
				else
					inst->ErrorID = MyTrakIdle;
			}
		}
		else
		{
			if (inst->CountOfShuttle > 0)
				inst->ErrorID = MyTrakRun;
			else
				inst->ErrorID = MyTrakIdle;
		}
		
		inst->CountOfShuttle = execMyTrakSlotTrans(&inst->Internal.slotMoveFc);
	}
	else if (inst->Enable == FALSE && inst->Active == FALSE)
	{
		releaseMyTrakSlotTran(&inst->Internal.slotMoveFc);
		inst->ErrorID = MyTrakDisabled;
	}
	
	//Execute Trigger Point FunctionBlocks
	inst->Internal.fbTrgEnable.ProcessPoint 	= inst->SourceProcessPoint;
	inst->Internal.fbTrgInfo.ProcessPoint 		= inst->SourceProcessPoint;
	
	MC_BR_TrgPointEnable_AcpTrak(&inst->Internal.fbTrgEnable);
	MC_BR_TrgPointGetInfo_AcpTrak(&inst->Internal.fbTrgInfo);
}
