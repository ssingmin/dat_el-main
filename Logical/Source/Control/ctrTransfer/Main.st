
PROGRAM _INIT
	
	gSim	:= DiagCpuIsSimulated();
	
	StStage[0].Sector		:= ADR(SectorCurve1);
	StStage[1].Sector		:= ADR(SectorTrackA_2);
	StStage[2].Sector		:= ADR(SectorTrackA_2);
	StStage[3].Sector		:= ADR(SectorTrackA_2);
	StStage[4].Sector		:= ADR(SectorTrackA_2);
	StStage[5].Sector		:= ADR(SectorTrackA_2);
	StStage[6].Sector		:= ADR(SectorTrackA_2);
	StStage[7].Sector		:= ADR(SectorTrackA_2);
	StStage[8].Sector		:= ADR(SectorTrackA_2);
	StStage[9].Sector		:= ADR(SectorTrackA_3);
	StStage[10].Sector		:= ADR(SectorCurve3);
	StStage[11].Sector		:= ADR(SectorTrackA_4);
	StStage[12].Sector		:= ADR(SectorTrackA_4);
	StStage[13].Sector		:= ADR(SectorTrackA_4);
	StStage[14].Sector		:= ADR(SectorTrackA_4);
	StStage[15].Sector		:= ADR(SectorTrackA_4);
	StStage[16].Sector		:= ADR(SectorCurve4);
	StStage[17].Sector		:= ADR(SectorCurve4);
	StStage[18].Sector		:= ADR(SectorTrackA_1);
	
	/////////////////////////////////////////////////////////////////////////////////////
	// Can supply 
	fbStage1.CheckInProcessPoint		:= ADR(ptCheckIn);
	fbStage1.CheckOutProcessPoint		:= ADR(ptCheckOut);
	fbStage1.TargetStage				:= ADR(StStage[0]);
	fbStage1.TargetSlotCount			:= COUNT_OF_SLOT;
	// TC insert
	fbStage2.SourceStage[0]				:= ADR(StStage[0]);
	fbStage2.SourceSlotCount[0]			:= COUNT_OF_SLOT;
	fbStage2.TargetStage				:= ADR(StStage[1]);
	fbStage2.TargetSlotCount			:= COUNT_OF_SLOT;
	// TC push
	fbStage3.SourceStage[0]				:= ADR(StStage[1]);
	fbStage3.SourceSlotCount[0]			:= COUNT_OF_SLOT;
	fbStage3.TargetStage				:= ADR(StStage[2]);
	fbStage3.TargetSlotCount			:= COUNT_OF_SLOT;
	// TC vision
	fbStage4.SourceStage[0]				:= ADR(StStage[2]);
	fbStage4.SourceSlotCount[0]			:= COUNT_OF_SLOT;
	fbStage4.TargetStage				:= ADR(StStage[3]);
	fbStage4.TargetSlotCount			:= COUNT_OF_SLOT;
	// TC NG re-insert
	fbStage5.SourceStage[0]				:= ADR(StStage[3]);
	fbStage5.SourceSlotCount[0]			:= COUNT_OF_SLOT;
	fbStage5.TargetStage				:= ADR(StStage[4]);
	fbStage5.TargetSlotCount			:= COUNT_OF_SLOT;
	// BCR vision
	fbStage6.SourceStage[0]				:= ADR(StStage[4]);
	fbStage6.SourceSlotCount[0]			:= COUNT_OF_SLOT;
	fbStage6.TargetStage				:= ADR(StStage[5]);
	fbStage6.TargetSlotCount			:= COUNT_OF_SLOT;
	// CCR 1
	fbStage7.SourceStage[0]				:= ADR(StStage[5]);
	fbStage7.SourceSlotCount[0]			:= COUNT_OF_SLOT;
	fbStage7.TargetStage				:= ADR(StStage[6]);
	fbStage7.TargetSlotCount			:= COUNT_OF_SLOT;
	// CCR 1 vision
	fbStage8.SourceStage[0]				:= ADR(StStage[6]);
	fbStage8.SourceSlotCount[0]			:= COUNT_OF_SLOT;
	fbStage8.TargetStage				:= ADR(StStage[7]);
	fbStage8.TargetSlotCount			:= COUNT_OF_SLOT;
	// CCR 2
	fbStage9.SourceStage[0]				:= ADR(StStage[7]);
	fbStage9.SourceSlotCount[0]			:= COUNT_OF_SLOT;
	fbStage9.TargetStage				:= ADR(StStage[8]);
	fbStage9.TargetSlotCount			:= COUNT_OF_SLOT;
	// Maint
	fbStage10.SourceStage[0]			:= ADR(StStage[8]);
	fbStage10.SourceSlotCount[0]		:= COUNT_OF_SLOT;
	fbStage10.TargetStage				:= ADR(StStage[9]);
	fbStage10.TargetSlotCount			:= COUNT_OF_SLOT;
	// CCR 2 vision
	fbStage11.SourceStage[0]			:= ADR(StStage[9]);
	fbStage11.SourceSlotCount[0]		:= COUNT_OF_SLOT;
	fbStage11.TargetStage				:= ADR(StStage[10]);
	fbStage11.TargetSlotCount			:= COUNT_OF_SLOT;
	// CCR 3
	fbStage12.SourceStage[0]			:= ADR(StStage[10]);
	fbStage12.SourceSlotCount[0]		:= COUNT_OF_SLOT;
	fbStage12.TargetStage				:= ADR(StStage[11]);
	fbStage12.TargetSlotCount			:= COUNT_OF_SLOT;
	// CCR 3 vision
	fbStage13.SourceStage[0]			:= ADR(StStage[11]);
	fbStage13.SourceSlotCount[0]		:= COUNT_OF_SLOT;
	fbStage13.TargetStage				:= ADR(StStage[12]);
	fbStage13.TargetSlotCount			:= COUNT_OF_SLOT;
	// CSZ
	fbStage14.SourceStage[0]			:= ADR(StStage[12]);
	fbStage14.SourceSlotCount[0]		:= COUNT_OF_SLOT;
	fbStage14.TargetStage				:= ADR(StStage[13]);
	fbStage14.TargetSlotCount			:= COUNT_OF_SLOT;
	// 3D done position
	fbStage15.SourceStage[0]			:= ADR(StStage[13]);
	fbStage15.SourceSlotCount[0]		:= COUNT_OF_SLOT;
	fbStage15.TargetStage				:= ADR(StStage[14]);
	fbStage15.TargetSlotCount			:= COUNT_OF_SLOT;
	// Diameter inspection
	fbStage16.SourceStage[0]			:= ADR(StStage[14]);
	fbStage16.SourceSlotCount[0]		:= COUNT_OF_SLOT;
	fbStage16.TargetStage				:= ADR(StStage[15]);
	fbStage16.TargetSlotCount			:= COUNT_OF_SLOT;
	// NG out
	fbStage17.SourceStage[0]			:= ADR(StStage[15]);
	fbStage17.SourceSlotCount[0]		:= COUNT_OF_SLOT;
	fbStage17.TargetStage				:= ADR(StStage[16]);
	fbStage17.TargetSlotCount			:= COUNT_OF_SLOT;
	// Unloading
	fbStage18.SourceStage[0]			:= ADR(StStage[16]);
	fbStage18.SourceSlotCount[0]		:= COUNT_OF_SLOT;
	fbStage18.TargetStage				:= ADR(StStage[17]);
	fbStage18.TargetSlotCount			:= COUNT_OF_SLOT;
	// Clean
	fbStage19.SourceStage[0]			:= ADR(StStage[17]);
	fbStage19.SourceSlotCount[0]		:= COUNT_OF_SLOT;
	fbStage19.TargetStage				:= ADR(StStage[18]);
	fbStage19.TargetSlotCount			:= COUNT_OF_SLOT;
	// Return
	fbReturn.SourceStage[0]				:= ADR(StStage[18]);
	fbReturn.SourceSlotCount[0]			:= COUNT_OF_SLOT;
	fbReturn.TargetSector				:= ADR(SectorTrackAll);
	fbReturn.TargetPosition				:= 12.5;
	/////////////////////////////////////////////////////////////////////////////////////
	InitializeFcBank(30);
	
	actParameterInitialize;
	
	/////////////////////////////////////////////////////////////////////////////////////
	// Buffer
	/////////////////////////////////////////////////////////////////////////////////////

	//Wait buffer for CSZ
	fbCSZWait.InPoint				:= ADR(ptCSZIn);
	fbCSZWait.OutPoint				:= ADR(ptCSZOut);
	fbCSZWait.MaximumShuttleCount	:= 1;
	//fbCSZWait.InitShuttleCount		:= 1;
	
	//Wait for unloading
	fbUnloadingWait.InPoint				:= ADR(ptUnloadingIn);
	fbUnloadingWait.OutPoint			:= ADR(ptUnloadingOut);
	fbUnloadingWait.MaximumShuttleCount	:= 1;
	fbUnloadingWait.InitShuttleCount	:= 1;
	
END_PROGRAM

PROGRAM _CYCLIC
	
	actUpdateParamter;

	CASE gSts.AsmState OF
		E_ASM_INITIALIZATION:
			//For Initialize Slot Status.
			FOR i := 0 TO 18 DO
				StStage[i].Interface	:= E_SLOT_UNKNOWN;
			END_FOR;
			
		E_ASM_MANUAL:
			
			fbStage1(Enable := TRUE, Process := FALSE, Feeding := FALSE);
			fbStage2(Enable := TRUE, Process := FALSE);
			fbStage3(Enable := TRUE, Process := FALSE);
			fbStage4(Enable := TRUE, Process := FALSE);
			fbStage5(Enable := TRUE, Process := FALSE);
			fbStage6(Enable := TRUE, Process := FALSE);
			fbStage7(Enable := TRUE, Process := FALSE);
			fbStage8(Enable := TRUE, Process := FALSE);
			fbStage9(Enable := TRUE, Process := FALSE);
			fbStage10(Enable := TRUE, Process := FALSE);
			fbStage11(Enable := TRUE, Process := FALSE);
			fbStage12(Enable := TRUE, Process := FALSE);
			fbStage13(Enable := TRUE, Process := FALSE);
			fbStage14(Enable := TRUE, Process := FALSE);
			fbStage15(Enable := TRUE, Process := FALSE);
			fbStage16(Enable := TRUE, Process := FALSE);
			fbStage17(Enable := TRUE, Process := FALSE);
			fbStage18(Enable := TRUE, Process := FALSE);
			fbStage19(Enable := TRUE, Process := FALSE);
			fbReturn(Enable := TRUE, Process := FALSE);
			fbCSZWait(Enable := FALSE);
			fbUnloadingWait(Enable := FALSE);
			
			FOR i := 0 TO 18 DO
				StStage[i].Interface	:= E_SLOT_MANUAL;
				
				IF i < 18 THEN
					StStage[i].NextStage	:= ADR(StStage[i + 1]);
				ELSIF i = 18 THEN
					StStage[18].NextStage	:= ADR(StStage[0]);
				END_IF
			END_FOR;
			
		E_ASM_IDLE:
			
			fbStage1(Enable := TRUE, Process := TRUE, Feeding := FALSE);
			fbStage2(Enable := TRUE, Process := TRUE);
			fbStage3(Enable := TRUE, Process := TRUE);
			fbStage4(Enable := TRUE, Process := TRUE);
			fbStage5(Enable := TRUE, Process := TRUE);
			fbStage6(Enable := TRUE, Process := TRUE);
			fbStage7(Enable := TRUE, Process := TRUE);
			fbStage8(Enable := TRUE, Process := TRUE);
			fbStage9(Enable := TRUE, Process := TRUE);
			fbStage10(Enable := TRUE, Process := TRUE);
			fbStage11(Enable := TRUE, Process := TRUE);
			fbStage12(Enable := TRUE, Process := TRUE);
			fbStage13(Enable := TRUE, Process := TRUE);
			fbStage14(Enable := TRUE, Process := TRUE);
			fbStage15(Enable := TRUE, Process := TRUE);
			fbStage16(Enable := TRUE, Process := TRUE);
			fbStage17(Enable := TRUE, Process := TRUE);
			fbStage18(Enable := TRUE, Process := TRUE);
			fbStage19(Enable := TRUE, Process := TRUE);
			fbReturn(Enable := TRUE, Process := TRUE);
			fbCSZWait(Enable := TRUE);
			fbUnloadingWait(Enable := TRUE);
			
		E_ASM_PROCESS:
			
			fbStage1(Enable := TRUE, Process := TRUE, Feeding := TRUE);
			fbStage2(Enable := TRUE, Process := TRUE);
			fbStage3(Enable := TRUE, Process := TRUE);
			fbStage4(Enable := TRUE, Process := TRUE);
			fbStage5(Enable := TRUE, Process := TRUE);
			fbStage6(Enable := TRUE, Process := TRUE);
			fbStage7(Enable := TRUE, Process := TRUE);
			fbStage8(Enable := TRUE, Process := TRUE);
			fbStage9(Enable := TRUE, Process := TRUE);
			fbStage10(Enable := TRUE, Process := TRUE);
			fbStage11(Enable := TRUE, Process := TRUE);
			fbStage12(Enable := TRUE, Process := TRUE);
			fbStage13(Enable := TRUE, Process := TRUE);
			fbStage14(Enable := TRUE, Process := TRUE);
			fbStage15(Enable := TRUE, Process := TRUE);
			fbStage16(Enable := TRUE, Process := TRUE);
			fbStage17(Enable := TRUE, Process := TRUE);
			fbStage18(Enable := TRUE, Process := TRUE);
			fbStage19(Enable := TRUE, Process := TRUE);
			fbReturn(Enable := TRUE, Process := TRUE);
			fbCSZWait(Enable := TRUE);
			fbUnloadingWait(Enable := TRUE);
			
		E_ASM_STOPPING:
		
			fbStage1(Enable := TRUE, Process := TRUE, Feeding := FALSE);
			fbStage2(Enable := TRUE, Process := TRUE);
			fbStage3(Enable := TRUE, Process := TRUE);
			fbStage4(Enable := TRUE, Process := TRUE);
			fbStage5(Enable := TRUE, Process := TRUE);
			fbStage6(Enable := TRUE, Process := TRUE);
			fbStage7(Enable := TRUE, Process := TRUE);
			fbStage8(Enable := TRUE, Process := TRUE);
			fbStage9(Enable := TRUE, Process := TRUE);
			fbStage10(Enable := TRUE, Process := TRUE);
			fbStage11(Enable := TRUE, Process := TRUE);
			fbStage12(Enable := TRUE, Process := TRUE);
			fbStage13(Enable := TRUE, Process := TRUE);
			fbStage14(Enable := TRUE, Process := TRUE);
			fbStage15(Enable := TRUE, Process := TRUE);
			fbStage16(Enable := TRUE, Process := TRUE);
			fbStage17(Enable := TRUE, Process := TRUE);
			fbStage18(Enable := TRUE, Process := TRUE);
			fbStage19(Enable := TRUE, Process := TRUE);
			fbReturn(Enable := TRUE, Process := TRUE);
			fbCSZWait(Enable := TRUE);
			fbUnloadingWait(Enable := TRUE);
			
			IF fbStage1.ErrorID = MyTrakIdle AND
				fbStage2.ErrorID = MyTrakIdle AND
				fbStage3.ErrorID = MyTrakIdle AND
				fbStage4.ErrorID = MyTrakIdle AND
				fbStage5.ErrorID = MyTrakIdle AND
				fbStage6.ErrorID = MyTrakIdle AND
				fbStage7.ErrorID = MyTrakIdle AND
				fbStage8.ErrorID = MyTrakIdle AND
				fbStage9.ErrorID = MyTrakIdle AND
				fbStage10.ErrorID = MyTrakIdle AND
				fbStage11.ErrorID = MyTrakIdle AND
				fbStage12.ErrorID = MyTrakIdle AND
				fbStage13.ErrorID = MyTrakIdle AND
				fbStage14.ErrorID = MyTrakIdle AND
				fbStage15.ErrorID = MyTrakIdle AND
				fbStage16.ErrorID = MyTrakIdle AND
				fbStage17.ErrorID = MyTrakIdle AND
				fbStage18.ErrorID = MyTrakIdle AND
				fbStage19.ErrorID = MyTrakIdle AND
				
				StStage[0].Interface = E_SLOT_IDLE AND
				StStage[1].Interface = E_SLOT_IDLE AND
				StStage[2].Interface = E_SLOT_IDLE AND
				StStage[3].Interface = E_SLOT_IDLE AND
				StStage[4].Interface = E_SLOT_IDLE AND
				StStage[5].Interface = E_SLOT_IDLE AND
				StStage[6].Interface = E_SLOT_IDLE AND
				StStage[7].Interface = E_SLOT_IDLE AND
				StStage[8].Interface = E_SLOT_IDLE AND
				StStage[9].Interface = E_SLOT_IDLE AND
				StStage[10].Interface = E_SLOT_IDLE AND
				StStage[11].Interface = E_SLOT_IDLE AND
				StStage[12].Interface = E_SLOT_IDLE AND
				StStage[13].Interface = E_SLOT_IDLE AND
				StStage[14].Interface = E_SLOT_IDLE AND
				StStage[15].Interface = E_SLOT_IDLE AND
				StStage[16].Interface = E_SLOT_IDLE AND
				StStage[17].Interface = E_SLOT_IDLE AND
				StStage[18].Interface = E_SLOT_IDLE	THEN
			//	gSts.AsmState	:= E_ASM_IDLE;
			END_IF
			
		ELSE
			fbStage1(Enable := FALSE, Process := FALSE, Feeding := FALSE);
			fbStage2(Enable := FALSE, Process := FALSE);
			fbStage3(Enable := FALSE, Process := FALSE);
			fbStage4(Enable := FALSE, Process := FALSE);
			fbStage5(Enable := FALSE, Process := FALSE);
			fbStage6(Enable := FALSE, Process := FALSE);
			fbStage7(Enable := FALSE, Process := FALSE);
			fbStage8(Enable := FALSE, Process := FALSE);
			fbStage9(Enable := FALSE, Process := FALSE);
			fbStage10(Enable := FALSE, Process := FALSE);
			fbStage11(Enable := FALSE, Process := FALSE);
			fbStage12(Enable := FALSE, Process := FALSE);
			fbStage13(Enable := FALSE, Process := FALSE);
			fbStage14(Enable := FALSE, Process := FALSE);
			fbStage15(Enable := FALSE, Process := FALSE);
			fbStage16(Enable := FALSE, Process := FALSE);
			fbStage17(Enable := FALSE, Process := FALSE);
			fbStage18(Enable := FALSE, Process := FALSE);
			fbStage19(Enable := FALSE, Process := FALSE);
			fbReturn(Enable := FALSE, Process := FALSE);
			fbCSZWait(Enable := FALSE);
			fbUnloadingWait(Enable := FALSE);
			
	END_CASE;
	 
	readShuttleInfo.Axis	:= ADR(StStage[0].Shuttle);
	readShuttleInfo();
	
END_PROGRAM

PROGRAM _EXIT
	
	fbStage1.Enable		:= FALSE;
	fbStage2.Enable		:= FALSE;
	fbStage3.Enable		:= FALSE;
	fbStage4.Enable		:= FALSE;
	fbStage5.Enable		:= FALSE;
	fbStage6.Enable		:= FALSE;
	fbStage7.Enable		:= FALSE;
	fbStage8.Enable		:= FALSE;
	fbStage9.Enable		:= FALSE;
	fbStage10.Enable	:= FALSE;
	fbStage11.Enable	:= FALSE;
	fbStage12.Enable	:= FALSE;
	fbStage13.Enable	:= FALSE;
	fbStage14.Enable	:= FALSE;
	fbStage15.Enable	:= FALSE;
	fbStage16.Enable	:= FALSE;
	fbStage17.Enable	:= FALSE;
	fbStage18.Enable	:= FALSE;
	fbStage19.Enable	:= FALSE;
	fbCSZWait.Enable	:= FALSE;
	
END_PROGRAM

