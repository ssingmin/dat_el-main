
#include <bur/plctypes.h>
#ifdef __cplusplus
	extern "C"
	{
#endif
	#include "MyTrak.h"
#ifdef __cplusplus
	};
#endif

#define TRUE 1
#define FALSE 0

/* TODO: Add your comment here */
void MyTrak_ChangeVel(struct MyTrak_ChangeVel* inst)
{
	switch(inst->Internal.step)
	{
		case 0:
			if (inst->Enable == TRUE)
			{
				inst->Internal.TrgEnable.Enable = TRUE;
				
				if (inst->Internal.TrgEnable.Valid)
					inst->Internal.step = 100;
			}
			break;
		
		case 100:
			if (inst->Internal.TrgEnable.EventCount > 0)
			{
				inst->Internal.TrgGetInfo.Execute = TRUE;
				inst->Internal.step = 200;
			}
			break;
		
		case 200:
			if (inst->Internal.TrgGetInfo.Done == TRUE) 
			{
				inst->Internal.ElasticMoveVel.Axis 			= (McAxisType*)&inst->Internal.TrgGetInfo.TrgPointInfo.Axis;
			
				inst->Internal.ElasticMoveVel.Velocity 		= inst->Velocity;
				inst->Internal.ElasticMoveVel.Acceleration 	= inst->Acceleration;
				inst->Internal.ElasticMoveVel.Deceleration 	= inst->Deceleration;
				inst->Internal.ElasticMoveVel.Direction 	= inst->Direction;
				inst->Internal.ElasticMoveVel.Execute	 	= TRUE;
			
				if ((inst->Internal.ElasticMoveVel.Active == TRUE && inst->Internal.preActive == FALSE) 
				|| inst->Internal.ElasticMoveVel.Error == TRUE)
				{
					inst->Internal.TrgGetInfo.Execute 		= FALSE;
					inst->Internal.ElasticMoveVel.Execute	= FALSE;
					inst->Internal.step 					= 100;
				}
			}
			break;
	}
	
	inst->Internal.TrgEnable.ProcessPoint = inst->ProcessPoint;
	inst->Internal.TrgGetInfo.ProcessPoint = inst->ProcessPoint;
	inst->Internal.preActive = inst->Internal.ElasticMoveVel.Active;
	
	MC_BR_TrgPointEnable_AcpTrak(&inst->Internal.TrgEnable);
	MC_BR_TrgPointGetInfo_AcpTrak(&inst->Internal.TrgGetInfo);
	MC_BR_ElasticMoveVel_AcpTrak(&inst->Internal.ElasticMoveVel);
}
