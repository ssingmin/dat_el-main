/********************************************************************
 * COPYRIGHT -- B&R Korea
 ********************************************************************
 * File: MyTrak_TransStage.c
 * Author: Taeryoung Ok
 * Created: 2021/11/06
 ********************************************************************
 * Description: Transfer Shuttle from Source stage to Target Stage
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

void MyTrak_TransStage(struct MyTrak_TransStage* inst)
{
	int 					preloop = 0, loop = 0, prestage = 0, unuseableSlotCount = 0;
	
	MyTrakSlotType* 		slot;
	MyTrakSlotType*			preslot;
	MyTrakSlotTransType*	newSlotMove;
	
	if (inst->Enable == TRUE && inst->Active == FALSE)
	{ //Disabled -> Enable
		inst->Active 		= TRUE;
	}
	else if (inst->Enable == FALSE && inst->Active == TRUE)
	{ //Enabled -> Disable
		inst->Active 		= FALSE;
		inst->ErrorID = MyTrakDisabled;
		inst->CountOfShuttle = 0;
		inst->NextSlotNo = 0;
		inst->Internal.manualCmd.CLK = FALSE; R_TRIG(&inst->Internal.manualCmd);
		
		releaseMyTrakSlotTran(&inst->Internal.slotMoveFc);
		
		for (loop = 0; loop < inst->TargetSlotCount; loop++)
		{
			slot 			= (MyTrakSlotType*)(inst->TargetStage + sizeof(MyTrakSlotType) * loop);
			brsmemset((UDINT)&slot->Shuttle, 0, sizeof(McAxisType));
			slot->Interface = E_SLOT_UNKNOWN;
		}
	}
	else if (inst->Enable == TRUE && inst->Active == TRUE)
	{ //Enabled
		//Manual Command Checking
		inst->Internal.manualCmd.CLK = inst->Manual; R_TRIG(&inst->Internal.manualCmd);
		
		if (inst->Process == TRUE || inst->Internal.manualCmd.Q)
		{
			//Slot Setting Check(Target Sector, Target Slot)

			//Shuttle Count Check in Target Stage
			for (loop = 0; loop < inst->TargetSlotCount; loop++)
			{
				slot = (MyTrakSlotType*)(inst->TargetStage + sizeof(MyTrakSlotType) * loop);
				
				if (slot->Shuttle.controlif != 0)
					unuseableSlotCount++;
			}
			
			for (prestage = 0; prestage < 10; prestage++)
			{
				for (preloop = inst->SourceSlotCount[prestage] - 1; preloop >= 0; preloop--)
				{
					//Source Slot Check
					preslot = (MyTrakSlotType*)(inst->SourceStage[prestage] + sizeof(MyTrakSlotType) * preloop);
			
					if ((preslot->Interface == E_SLOT_TAKEOUT_READY || 
						(preslot->Interface == E_SLOT_MANUAL && preslot->Shuttle.controlif != 0)) 
						&& preslot->NextStage == inst->TargetStage)
					{
						if (inst->CountOfShuttle + unuseableSlotCount >= inst->MaximumShuttleCount)
						{
							inst->ErrorID = MyTrakMaximumControllerOverflow;
						}
						else
						{
							inst->ErrorID = MyTrakBusy;

							//Select Target Slot
							if ((inst->NextSlotNo = SearchNextSlot(inst->TargetStage, inst->NextSlotNo, inst->TargetSlotCount)) == -1)
								break;
							else
								slot = (MyTrakSlotType*)(inst->TargetStage + sizeof(MyTrakSlotType) * inst->NextSlotNo);
				
							//Get New Last Slot Transfer Structure From FcBank
							newSlotMove = attachRoutedAbsFc(&inst->Internal.slotMoveFc);
								
							//Set Command Parameters
							newSlotMove->axis 					= preslot->Shuttle;
							newSlotMove->targetSlot 			= slot;

							newSlotMove->moveAbs.Axis			= &newSlotMove->axis;
							newSlotMove->moveAbs.Sector	 		= (McSectorType*)(newSlotMove->targetSlot->Sector);
							newSlotMove->moveAbs.Position	 	= newSlotMove->targetSlot->Position;
							newSlotMove->moveAbs.Velocity 		= inst->Velocity;
							newSlotMove->moveAbs.Acceleration 	= inst->Acceleration;
							newSlotMove->moveAbs.Deceleration 	= inst->Deceleration;
							newSlotMove->moveAbs.AdvancedParameters = inst->AdvancedParameters;
				
							newSlotMove->moveAbs.Execute 		= TRUE;
						
							//Clear PreslotInformation and Status
							preslot->Interface					= E_SLOT_IDLE;
							brsmemset((UDINT)&preslot->Shuttle, 0, sizeof(McAxisType));
						}
					}
					else if (preslot->Interface != E_SLOT_IDLE && preslot->Interface != E_SLOT_MANUAL)
					{
						break;
					}
				}					
			}
			
			if (inst->CountOfShuttle == 0)
				inst->ErrorID = MyTrakIdle;
			else
				inst->ErrorID = MyTrakRun;
		}
		else
		{
			inst->ErrorID = MyTrakManual;	
		}
		
		//Execute Slot Transfer Function
		inst->CountOfShuttle = execMyTrakSlotTrans(&inst->Internal.slotMoveFc);
	}
	else if (inst->Enable == FALSE && inst->Active == FALSE)
	{ //Disabled
		releaseMyTrakSlotTran(&inst->Internal.slotMoveFc);
		inst->ErrorID = MyTrakDisabled;
	}
}
