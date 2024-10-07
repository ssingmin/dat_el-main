/********************************************************************
 * COPYRIGHT -- B&R Korea
 ********************************************************************
 * File: InitializeFunctionblockBank.c
 * Author: Taeryoung Ok
 * Created: 2021/11/07
 ********************************************************************
 * Description: Functions for Functionblock Banking System
 ********************************************************************/

#include <bur/plctypes.h>
#ifdef __cplusplus
	extern "C"
	{
#endif
#include "MyTrak.h"
#include "AsBrStr.h"
#include "sys_lib.h"
#include "MyTrakFunc.h"
#ifdef __cplusplus
	};
#endif

#define NULL 0
#define FALSE 0
#define TRUE 1

MyTrakSlotTransType defaultSlotTransFc;
MyTrakSerializeType defaultSerializeFc;

UDINT _adrRoutedAbsFunc = 0;
UDINT _adrRoutedVelFunc = 0;

plcbit InitializeFcBank(unsigned short shuttleCount)
{
	int loop = 0;
	MyTrakSlotTransType* routedAbsFc;
	MyTrakSerializeType* routedVelFc;
	
	if (shuttleCount == 0)
	{
		return FALSE;
	}
	else
	{
		TMP_alloc((UDINT)sizeof(MyTrakSlotTransType), (void*)&_adrRoutedAbsFunc);	
		brsmemcpy((UDINT)_adrRoutedAbsFunc, (UDINT)&defaultSlotTransFc, (UDINT)sizeof(MyTrakSlotTransType));
		
		TMP_alloc((UDINT)sizeof(MyTrakSerializeType), (void*)&_adrRoutedVelFunc);	
		brsmemcpy((UDINT)_adrRoutedVelFunc, (UDINT)&defaultSerializeFc, (UDINT)sizeof(MyTrakSerializeType));		
	}

	routedAbsFc = (MyTrakSlotTransType*)_adrRoutedAbsFunc;
	
	for (loop = 1; loop < shuttleCount; loop++)
	{
		TMP_alloc(sizeof(MyTrakSlotTransType), (void*)&routedAbsFc->next);
		brsmemcpy((UDINT)routedAbsFc->next, (UDINT)&defaultSlotTransFc, (UDINT)sizeof(MyTrakSlotTransType));
		routedAbsFc = routedAbsFc->next;
	}
	
	routedVelFc = (MyTrakSerializeType*)_adrRoutedVelFunc;
	
	for (loop = 1; loop < shuttleCount; loop++)
	{
		TMP_alloc(sizeof(MyTrakSerializeType), (void*)&routedVelFc->next);
		brsmemcpy((UDINT)routedVelFc->next, (UDINT)&defaultSerializeFc, (UDINT)sizeof(MyTrakSerializeType));
		routedVelFc = routedVelFc->next;
	}
	return TRUE;
}

MyTrakSlotTransType* rentRoutedAbsFc()
{
	MyTrakSlotTransType* returnValue;
	
	returnValue 		= (MyTrakSlotTransType*)_adrRoutedAbsFunc;
	_adrRoutedAbsFunc 	= (UDINT)((MyTrakSlotTransType*)_adrRoutedAbsFunc)->next;
	returnValue->next 	= 0;
	
	return returnValue;
}

MyTrakSlotTransType* attachRoutedAbsFc(MyTrakSlotTransType** rootSlotMove)
{
	MyTrakSlotTransType* returnValue = *rootSlotMove;
	
	if (returnValue == NULL)
	{
		(*rootSlotMove) = rentRoutedAbsFc();
		return (*rootSlotMove);
	}
	else
	{
		while (returnValue->next != NULL)
			returnValue = returnValue->next;
		
		returnValue->next = rentRoutedAbsFc();
		
		return returnValue->next;
	}
}

void rtnRoutedAbsFc(MyTrakSlotTransType* rtnFc)
{
	rtnFc->moveAbs.Axis 		= NULL;
	rtnFc->moveAbs.Sector 		= NULL;
	rtnFc->moveAbs.Execute 		= FALSE;
	
	MC_BR_RoutedMoveAbs_AcpTrak(&rtnFc->moveAbs);
	rtnFc->next 		= (MyTrakSlotTransType*)_adrRoutedAbsFunc;
	_adrRoutedAbsFunc 	= (UDINT)rtnFc;
}

MyTrakSerializeType* rentRoutedVelFc()
{
	MyTrakSerializeType* returnValue;
	
	returnValue 		= (MyTrakSerializeType*)_adrRoutedVelFunc;
	_adrRoutedVelFunc 	= (UDINT)((MyTrakSerializeType*)_adrRoutedVelFunc)->next;
	returnValue->next 	= 0;
	
	return returnValue;
}

MyTrakSerializeType* attachRoutedVelFc(MyTrakSerializeType** rootSerialize)
{
	MyTrakSerializeType* returnValue = *rootSerialize;
	
	if (returnValue == NULL)
	{
		(*rootSerialize) = rentRoutedVelFc();
		return (*rootSerialize);
	}
	else
	{
		while (returnValue->next != NULL)
			returnValue = returnValue->next;
		
		returnValue->next = rentRoutedVelFc();
		
		return returnValue->next;
	}
}

void rtnRoutedVelFc(MyTrakSerializeType* rtnFc)
{
	rtnFc->moveVel.Axis 		= NULL;
	rtnFc->moveVel.Sector 		= NULL;
	rtnFc->moveVel.Execute 		= FALSE;

	MC_BR_RoutedMoveVel_AcpTrak(&rtnFc->moveVel);
	rtnFc->next 		= (MyTrakSerializeType*)_adrRoutedVelFunc;
	_adrRoutedVelFunc 	= (UDINT)rtnFc;
}

int SearchNextSlot(UDINT firstSlot, int currentSlot, unsigned int slotCount)
{
	int loop = 0;
	
	MyTrakSlotType* slot = 0;
	
	for (loop = currentSlot - 1; loop >= 0; loop--)
	{
		slot = (MyTrakSlotType*)(firstSlot + sizeof(MyTrakSlotType) * loop);
		
		if (slot->Enable == TRUE)
			return loop;
	}
	
	for (loop = slotCount - 1; loop >= currentSlot; loop--)
	{
		slot = (MyTrakSlotType*)(firstSlot + sizeof(MyTrakSlotType) * loop);
		
		if (slot->Enable == TRUE)
			return loop;
	}
	return -1;
}

DINT execMyTrakSlotTrans(MyTrakSlotTransType** executeList)
{
	DINT returnValue = 0;
	
	if (*executeList == NULL) return 0;
	
	//Execute Slot Transfer Function
	MyTrakSlotTransType* preSlotMove 	= NULL;
	MyTrakSlotTransType* slotMove 		= *executeList;
	
	while (slotMove != 0)
	{
		//Execution
		MC_BR_RoutedMoveAbs_AcpTrak(&slotMove->moveAbs);
		
		if (slotMove->moveAbs.Done == TRUE)
		{ //Move Done Case 
			//Slot Information
			slotMove->targetSlot->Shuttle 		= slotMove->axis;
			
			if (slotMove->targetSlot->Interface == E_SLOT_IDLE) 
				slotMove->targetSlot->Interface 	= E_SLOT_PROCESS_READY;

			//Reconection List and Return to bank
			if (preSlotMove != NULL)
			{
				preSlotMove->next 	= slotMove->next;
				rtnRoutedAbsFc(slotMove);
				slotMove			= preSlotMove->next;
			}
			else if (preSlotMove == NULL && slotMove->next != NULL)
			{
				(*executeList) 		= slotMove->next;
				rtnRoutedAbsFc(slotMove);
				slotMove			= (*executeList);
			}
			else if (preSlotMove == NULL && slotMove->next == NULL)
			{
				(*executeList) 		= NULL;
				rtnRoutedAbsFc(slotMove);
				slotMove			= NULL;
			}
		} 
		else if (slotMove->moveAbs.CommandAborted == TRUE)
		{ //Move Abort Case
			slotMove->moveAbs.Execute 			= FALSE;			
		}
		else if (slotMove->moveAbs.Error == TRUE)
		{ //Move Error Case 
			
		}
		else
		{
			preSlotMove = slotMove;
			slotMove 	= slotMove->next;
		}
		returnValue++;
	}
	return returnValue;
}

void releaseMyTrakSlotTran(MyTrakSlotTransType** executeList)
{
	if (*executeList == NULL) return;
	
	//Execute Slot Transfer Function
	MyTrakSlotTransType* tmpSlotMove 	= NULL;
	MyTrakSlotTransType* slotMove 		= *executeList;

	while (slotMove != 0)
	{
		//Return FunctionBlock
		tmpSlotMove 		= slotMove->next;
		rtnRoutedAbsFc(slotMove);
		slotMove 			= tmpSlotMove;
	}
	*executeList = NULL;

	return;
}

DINT execMyTrakSerialize(MyTrakSerializeType** executeList)
{
	DINT returnValue = 0;
	
	if (*executeList == NULL) return 0;
	
	MyTrakSerializeType* preSerialMove 	= NULL;
	MyTrakSerializeType* serialMove		= *executeList;
	
	while (serialMove != 0)
	{
		//Execution
		MC_BR_RoutedMoveVel_AcpTrak(&serialMove->moveVel);
		
		//Execution Check
		if (serialMove->moveVel.PositionReached == TRUE ||
			serialMove->moveVel.CommandAborted == TRUE)
		{
			//Reconection List and Return to bank
			if (preSerialMove != NULL)
			{
				preSerialMove->next = serialMove->next;
				rtnRoutedVelFc(serialMove);
				serialMove = preSerialMove->next;
			}
			else if (preSerialMove == NULL && serialMove->next != NULL)
			{
				(*executeList) = serialMove->next;
				rtnRoutedVelFc(serialMove);
				serialMove = (*executeList);
			}
			else if (preSerialMove == NULL && serialMove->next == NULL)
			{
				(*executeList) = NULL;
				rtnRoutedVelFc(serialMove);
				serialMove = NULL;
			}
		}
		else
		{
			preSerialMove 	= serialMove;
			serialMove 		= serialMove->next;
		}
		returnValue++;
	}
	return returnValue;
}

void releaseMyTrakSerialize(MyTrakSerializeType** executeList)
{
	if (*executeList == NULL) return;
	
	//Execute Slot Transfer Function
	MyTrakSerializeType* tmpSlotMove 	= NULL;
	MyTrakSerializeType* slotMove		= *executeList;

	while (slotMove != 0)
	{
		//Return FunctionBlock
		tmpSlotMove 		= slotMove->next;
		rtnRoutedVelFc(slotMove);
		slotMove 			= tmpSlotMove;
	}
	
	*executeList = NULL;
	
	return;
}
