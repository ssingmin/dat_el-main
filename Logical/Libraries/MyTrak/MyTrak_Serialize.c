/********************************************************************
 * COPYRIGHT -- B&R Korea
 ********************************************************************
 * File: MyTrak_Serialize.c
 * Author: Taeryoung Ok
 * Created: 2021/11/06
 ********************************************************************
 * Description: Transfer Shuttles from Source Stage to Target Point of Sector
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

void MyTrak_Serialize(struct MyTrak_Serialize* inst)
{
	int loop = 0,prestage;
	
	MyTrakSlotType* slot;
	
	MyTrakSerializeType* newSerialMove;
	
	if (inst->Enable == TRUE && inst->Active == FALSE)
	{	//Disabled -> Enabled
		inst->Active = TRUE;
	}
	else if (inst->Enable == FALSE && inst->Active == TRUE)
	{	//Enabled -> Disabled
		inst->Active = FALSE;
		inst->Internal.manualCmd.CLK = FALSE; R_TRIG(&inst->Internal.manualCmd);
		
		releaseMyTrakSerialize(&inst->Internal.serialMoveFc);
	}
	else if (inst->Enable == TRUE && inst->Active == TRUE)
	{	//Enabled
		//Manual Command Checking
		inst->Internal.manualCmd.CLK = inst->Manual; R_TRIG(&inst->Internal.manualCmd);
		
		if (inst->Process == TRUE || inst->Internal.manualCmd.Q) 
		{
			for (prestage = 0; prestage < 10; prestage++)
			{	
				for (loop = inst->SourceSlotCount[prestage] - 1; loop >= 0; loop--)
				{
					slot = (MyTrakSlotType*)(inst->SourceStage[prestage] + sizeof(MyTrakSlotType) * loop);
	
					if (slot->Interface == E_SLOT_TAKEOUT_READY || 
						(slot->Interface == E_SLOT_MANUAL && slot->Shuttle.controlif != 0))
					{
						//Get New Last Slot Transfer Structure From FcBank
						newSerialMove = attachRoutedVelFc(&inst->Internal.serialMoveFc);
										
						//Set Command Parameters
						newSerialMove->sourceSlot				= slot;
						newSerialMove->axis 					= slot->Shuttle;
					
						newSerialMove->moveVel.Axis	 			= &newSerialMove->axis;
						newSerialMove->moveVel.Sector	 		= inst->TargetSector;
						newSerialMove->moveVel.Position	 		= inst->TargetPosition;
						newSerialMove->moveVel.RouteVelocity 	= inst->RoutedVelocity;				
						newSerialMove->moveVel.Velocity 		= inst->Velocity;
						newSerialMove->moveVel.Acceleration 	= inst->Acceleration;
						newSerialMove->moveVel.Deceleration 	= inst->Deceleration;
						newSerialMove->moveVel.AdvancedParameters = inst->AdvancedParameters;
					
						newSerialMove->moveVel.Execute		 	= TRUE;
					
						//Clear PreslotInformation and Status
						slot->Interface							= E_SLOT_IDLE;
						brsmemset((UDINT)&slot->Shuttle, 0, sizeof(McAxisType));
					}
				}
			}
		
			if (inst->Internal.serialMoveFc == NULL)
				inst->ErrorID = MyTrakIdle;
			else
				inst->ErrorID = MyTrakRun;	
		}
		else if (inst->Process == FALSE)
		{
			inst->ErrorID = MyTrakManual;	
		}
		
		//Execute Serialize Function
		inst->CountOfShuttle = execMyTrakSerialize(&inst->Internal.serialMoveFc);
	}
	else if (inst->Enable == FALSE && inst->Active == FALSE)
	{	//Disabled
		releaseMyTrakSerialize(&inst->Internal.serialMoveFc);
		inst->ErrorID = MyTrakDisabled;				
	}
}
