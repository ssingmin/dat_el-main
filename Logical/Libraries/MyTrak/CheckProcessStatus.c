
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

plcbit GetTakeOutReady(unsigned long Stage, unsigned char CountofSlots)
{
	int 				loop;
	MyTrakSlotType* 	slot;

	for (loop = 0; loop < CountofSlots; loop++)
	{
		slot = (MyTrakSlotType*)(Stage + sizeof(MyTrakSlotType) * loop);

		
		
		if (slot->Interface != E_SLOT_MANUAL && slot->Interface != E_SLOT_TAKEOUT_READY)
			return FALSE;
	}
	return TRUE;	
}

plcbit GetProcessReady(unsigned long Stage, unsigned char CountofSlots)
{
	int 				loop;
	MyTrakSlotType* 	slot;

	for (loop = 0; loop < CountofSlots; loop++)
	{
		slot = (MyTrakSlotType*)(Stage + sizeof(MyTrakSlotType) * loop);

		if (slot->Interface != E_SLOT_MANUAL && slot->Interface != E_SLOT_PROCESS_READY)
			return FALSE;
	}
	return TRUE;	
}

plcbit GetProcessing(unsigned long Stage, unsigned char CountofSlots)
{
	int 				loop;
	MyTrakSlotType* 	slot;

	for (loop = 0; loop < CountofSlots; loop++)
	{
		slot = (MyTrakSlotType*)(Stage + sizeof(MyTrakSlotType) * loop);

		if (slot->Interface != E_SLOT_MANUAL && slot->Interface != E_SLOT_PROCESSING)
			return FALSE;
	}
	return TRUE;	
}

E_SLOT_IF_STATE GetStageStatus(unsigned long Stage, unsigned char CountofSlots)
{
	int 				loop;
	MyTrakSlotType* 	slot;
	MyTrakSlotType* 	preslot;	

	for (loop = 1; loop < CountofSlots; loop++)
	{
		slot = (MyTrakSlotType*)(Stage + sizeof(MyTrakSlotType) * loop);
		preslot = (MyTrakSlotType*)(Stage + sizeof(MyTrakSlotType) * (loop - 1));

		if (slot->Interface != preslot->Interface)
			return E_SLOT_UNKNOWN;
	}
	return preslot->Interface;	
}
