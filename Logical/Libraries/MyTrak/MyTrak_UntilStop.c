
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

void MyTrak_UntilStop(struct MyTrak_UntilStop* inst)
{
	MyTrakSerializeType* newSerialMove;
	
	if (inst->Execute == TRUE && inst->Active == FALSE)
	{
		inst->Internal.getShuttle.Sector 							= inst->SourceSector;
		
		inst->Internal.getShuttle.AdvancedParameters.StartPosition 	= inst->SourceStart;
		inst->Internal.getShuttle.AdvancedParameters.EndPosition 	= inst->SourceEnd;
		
		inst->Internal.getShuttle.Enable = TRUE;
		
		inst->Active = TRUE;
	}
	else if (inst->Execute == FALSE && inst->Active == TRUE)
	{
	}
	else if (inst->Execute == TRUE && inst->Active == TRUE)
	{
		if (inst->Internal.getShuttle.Valid == TRUE && inst->Internal.getShuttle.RemainingCount > 0)
		{
			if (inst->Internal.getShuttle.RemainingCount + inst->CountOfShuttle < inst->Internal.getShuttle.TotalCount)
			{
				newSerialMove = attachRoutedVelFc(&inst->Internal.serialMoveFc);
				newSerialMove->axis = inst->Internal.getShuttle.Axis;
				
				newSerialMove->moveVel.Axis 				= &newSerialMove->axis;
				
				newSerialMove->moveVel.Sector 				= inst->TargetSector;
				newSerialMove->moveVel.Position 			= inst->TargetPosition;
				newSerialMove->moveVel.RouteVelocity 		= inst->RoutedVelocity;
				newSerialMove->moveVel.Velocity 			= inst->Velocity;
				newSerialMove->moveVel.Acceleration 		= inst->Acceleration;
				newSerialMove->moveVel.Deceleration 		= inst->Deceleration;
				newSerialMove->moveVel.AdvancedParameters 	= inst->AdvancedParameters;	
								
				newSerialMove->moveVel.Execute 				= TRUE;

				inst->Internal.getShuttle.Next = FALSE;

				inst->CountOfShuttle++;
			}
			else
			{
				inst->Internal.getShuttle.Next = TRUE;
			}
		}
		else
		{
			
		}
		execMyTrakSerialize(&inst->Internal.serialMoveFc);
	}
}
