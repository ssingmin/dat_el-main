PROGRAM _INIT
	
	fbFlyStage.InPoint				:= ADR(pt3DIn);
	fbFlyStage.OutPoint				:= ADR(pt3DOut);
	fbFlyStage.MaximumShuttleCount	:= 1;
	fbFlyStage.InitShuttleCount		:= 1;
	
	fbTrig.ProcessPoint				:= ADR(pt3D);
	fbTrigInfo.ProcessPoint			:= ADR(pt3D);
	
	ShReadInfo.Axis	:= ADR(Axis);
	
	ShReadSectorPosInfo.Sector		:= ADR(SectorTrackAll);
	ShReadSectorPosInfo.Axis		:= ADR(Axis);
	
	fbUserData.Axis	:= ADR(fbTrigInfo.TrgPointInfo);
	
	shuttleID ACCESS ADR(interface.Trak.Data[0]);
	
	g3DStartPos	:= 10.52;
	g3DEndPos	:= 10.588;
	AddedTime	:= 14000; //140000
	
END_PROGRAM

PROGRAM _CYCLIC
	
	bModuleOK;
	bMovQuitFifoEmpty;
	bMovQuitFifoFull;
	bMovQuitTargetTimeVioloation;
	bMovQuitMaxFrequencyViolation;
	
	//////////////////////////////////////////////////////////////////////////////////
	// 3D scanner with DS1119 module
	//////////////////////////////////////////////////////////////////////////////////
//	MovTargetTime	:= MovTimeValid + AddedTime;
	
	IF gSts.AsmState = E_ASM_EMS OR gSts.AsmState = E_ASM_IDLE OR gSts.AsmState = E_ASM_INITIALIZATION THEN
		//	fbFlyStage.Enable	:= FALSE;
		Step				:= STEP_WAIT;
	ELSIF gSts.AsmState = E_ASM_PROCESS OR gSts.AsmState = E_ASM_MANUAL OR gSts.AsmState = E_ASM_ON THEN
		//	fbFlyStage.Enable	:= TRUE;
	END_IF
	
	CASE Step OF
		
		STEP_WAIT:
			IF fbTrigInfo.TrgPointInfo.Axis.controlif = 0 AND shuttleID <> '' THEN
				brsmemset(ADR(interface.Trak.Data[0]), 0, 11);
				userData.SerialNumber	:= '';
			END_IF
			
			interface.Trak.ShuttleArrived	:= FALSE;
			doTrigger						:= FALSE;
//			EncCnt							:= 0;
			IF gSts.AsmState = E_ASM_PROCESS OR gSts.AsmState = E_ASM_MANUAL OR gSts.AsmState = E_ASM_ON THEN
				fbTrig.Enable	:= TRUE;
				
				IF fbTrig.Valid THEN
					MovTargetPosition	:= LREAL_TO_DINT((g3DStartPos - 0.005) * 1000000);
					Step				:= STEP_IDLE;
				END_IF
			ELSE
				fbTrig.Enable	:= FALSE;
			END_IF
			
		STEP_IDLE:
			
			IF fbTrig.EventCount > 0 THEN
				fbTrigInfo.Execute	:= TRUE;
				
				fbUserData.DataAddress	:= ADR(userData);
				fbUserData.DataSize		:= SIZE_OF_USERDATA;
				fbUserData.Mode			:= mcACPTRAK_USERDATA_GET;
				fbUserData.Execute		:= TRUE;
				
				Step					:= STEP_GETSH;
			END_IF
			
		STEP_GETSH:
			IF fbTrigInfo.Done AND fbUserData.Done THEN
				interface.Trak.ShuttleArrived	:= TRUE;
				Axis							:= fbTrigInfo.TrgPointInfo.Axis;
				
				brsmemcpy(ADR(interface.Trak.Data[0]), ADR(userData.SerialNumber), 11);
			
				ShReadSectorPosInfo.Enable		:= TRUE;
				
				IF ShReadSectorPosInfo.Valid THEN
					Step			:= STEP_PRERUN;
					MovTargetTime	:= MovTimeValid + AddedTime;
				END_IF
			END_IF
			
		STEP_PRERUN:
			MovEnable			:= TRUE;
			MovTargetPosition	:= LREAL_TO_DINT((g3DStartPos - 0.005) * 1000000);
			MovTargetTime 		:= MovTargetTime + 2000;
			
			IF ShReadSectorPosInfo.Info.Position >= g3DStartPos - 0.005 THEN
				doTrigger	:= TRUE;
				Step		:= STEP_END;
			END_IF

//			IF EncCnt >= 1 THEN
//				IF ShReadSectorPosInfo.Info.Position < g3DStartPos - 0.005 THEN
//					MovTargetPosition	:= LREAL_TO_DINT((g3DStartPos - 0.005) * 1000000);
//				ELSE
//					MovTargetPosition	:= LREAL_TO_DINT((g3DStartPos - 0.005) * 1000000);
//				END_IF
//			END_IF
			//			EncCnt	:= EncCnt + 1;
//			MovEnable			:= TRUE;
//			MovTargetPosition	:= LREAL_TO_DINT(ShReadSectorPosInfo.Info.Position * 1000000);			
			//			IF ShReadSectorPosInfo.Info.Position >= g3DStartPos THEN
//				doTrigger	:= TRUE;
//				Step		:= STEP_END;
//			END_IF
			
		STEP_END:		
			MovTargetPosition	:= LREAL_TO_DINT(ShReadSectorPosInfo.Info.Position * 1000000);
			MovTargetTime 		:= MovTargetTime + 2000;

			IF ShReadSectorPosInfo.Info.Position >= g3DEndPos THEN
				ShReadSectorPosInfo.Enable		:= FALSE;
				interface.Trak.ShuttleArrived	:= FALSE;
				MovEnable						:= FALSE;
				doTrigger						:= FALSE;
				fbTrigInfo.Execute				:= FALSE;
				fbUserData.Execute				:= FALSE;
				Step							:= STEP_WAIT;
			END_IF

	END_CASE;

	
	
	// FB calls
	fbFlyStage();
	fbTrig();
	fbTrigInfo();
	fbUserData();
	ShReadSectorPosInfo();
	
END_PROGRAM
