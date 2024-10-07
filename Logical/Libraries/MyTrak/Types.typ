(**)
(*Enumeration*)

TYPE
	E_SLOT_IF_STATE : 
		(
		E_SLOT_UNKNOWN := 0,
		E_SLOT_MANUAL := 1,
		E_SLOT_IDLE := 2,
		E_SLOT_PROCESS_READY := 3,
		E_SLOT_PROCESSING := 4,
		E_SLOT_TAKEOUT_READY := 5
		) := E_SLOT_UNKNOWN;
END_TYPE

(**)
(*Structure*)

TYPE
	MyTrakSlotType : 	STRUCT  (*Slot of Stage.*)
		Enable : BOOL;
		Sector : UDINT;
		Position : LREAL;
		Interface : E_SLOT_IF_STATE;
		Shuttle : McAxisType;
		NextStage : UDINT;
	END_STRUCT;
	MyTrakSlotTransType : 	STRUCT  (*Function Block for transfer Shuttle from Prestage to Nextstage*)
		moveAbs : MC_BR_RoutedMoveAbs_AcpTrak;
		axis : McAxisType;
		targetSlot : REFERENCE TO MyTrakSlotType;
		next : REFERENCE TO MyTrakSlotTransType;
	END_STRUCT;
	MyTrakSerializeType : 	STRUCT  (*Function Block for transfer Shuttle from Prestage to Nextstage*)
		moveVel : MC_BR_RoutedMoveVel_AcpTrak;
		axis : McAxisType;
		sourceSlot : REFERENCE TO MyTrakSlotType;
		next : REFERENCE TO MyTrakSerializeType;
	END_STRUCT;
END_TYPE

(**)
(*Internal Structrue for FunctionBlock*)

TYPE
	MyTrak_ServeStage_Internal_type : 	STRUCT 
		slotMoveFc : REFERENCE TO MyTrakSlotTransType;
		fbTrgInfo : MC_BR_TrgPointGetInfo_AcpTrak;
		fbTrgEnable : MC_BR_TrgPointEnable_AcpTrak;
	END_STRUCT;
	MyTrak_TransStage_Internal_type : 	STRUCT 
		slotMoveFc : REFERENCE TO MyTrakSlotTransType;
		manualCmd : R_TRIG;
	END_STRUCT;
	MyTrak_Serialize_Internal_type : 	STRUCT 
		serialMoveFc : REFERENCE TO MyTrakSerializeType;
		manualCmd : R_TRIG;
	END_STRUCT;
	MyTrak_TicketArea_Internal_type : 	STRUCT 
		step : USINT;
		init : BOOL;
		fbInEnable : MC_BR_TrgPointEnable_AcpTrak;
		fbInGetInfo : MC_BR_TrgPointGetInfo_AcpTrak;
		fbBarrierReadInfo : MC_BR_BarrierReadInfo_AcpTrak;
		fbBarrier : MC_BR_BarrierCommand_AcpTrak;
		fbOutEnable : MC_BR_TrgPointEnable_AcpTrak;
		fbOutGetInfo : MC_BR_TrgPointGetInfo_AcpTrak;
	END_STRUCT;
	MyTrak_ChangeVel_Internal_type : 	STRUCT 
		step : DINT;
		preActive : BOOL;
		ElasticMoveVel : MC_BR_ElasticMoveVel_AcpTrak;
		TrgEnable : MC_BR_TrgPointEnable_AcpTrak;
		TrgGetInfo : MC_BR_TrgPointGetInfo_AcpTrak;
	END_STRUCT;
	MyTrak_ShInfeeder_Internal_type : 	STRUCT 
		BarCmd : MC_BR_BarrierCommand_AcpTrak;
		BarReadInfo : MC_BR_BarrierReadInfo_AcpTrak;
		Tmr : TON;
		manualCmd : R_TRIG;
	END_STRUCT;
	MyTrak_Buffer_Internal_type : 	STRUCT 
		slotMoveFc : REFERENCE TO MyTrakSlotTransType;
		CheckInPointEnable : MC_BR_TrgPointEnable_AcpTrak;
		GetCheckInShuttleInfo : MC_BR_TrgPointGetInfo_AcpTrak;
		GetShuttleInfo : MC_BR_ShReadInfo_AcpTrak;
		CheckOutBarrier : MC_BR_BarrierCommand_AcpTrak;
		Tmr : TON;
		manualCmd : R_TRIG;
		outReqCount : USINT;
	END_STRUCT;
	MyTrak_UntilStop_Internal_type : 	STRUCT 
		serialMoveFc : REFERENCE TO MyTrakSerializeType;
		getShuttle : MC_BR_SecGetShuttleSel_AcpTrak;
	END_STRUCT;
END_TYPE
