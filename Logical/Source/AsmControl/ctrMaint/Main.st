
PROGRAM _INIT
	fbAsmGetShuttle.Assembly 	:= ADR(gAsmMain);
	
	fbRoutedMoveAbs.Sector := ADR(SectorTrackAll);
	
	fbGetUserData.Axis			:= ADR(fbAsmGetShuttle.Axis);
	fbReadShuttleInfo.Axis 		:= ADR(fbAsmGetShuttle.Axis);
	fbStop.Axis					:= ADR(fbAsmGetShuttle.Axis);
	fbRoutedMoveAbs.Axis 		:= ADR(fbAsmGetShuttle.Axis);
	
	fbGetUserData.DataAddress	:= ADR(UserData);
	fbGetUserData.DataSize		:= SIZEOF(UserData);
END_PROGRAM

PROGRAM _CYCLIC
	IF fbAsmGetShuttle.Error = TRUE THEN
		MaintShuttleControlEnable 	:= FALSE;
		Step 						:= E_MAINT_DIABLE;
	END_IF
	
	cmdStop(CLK := Stop); 
	cmdNextSh(CLK := NextShuttle);
	cmdMoveAbs(CLK := MoveAbsolute);
	
	IF cmdStop.Q = TRUE THEN
		fbStop.Execute := TRUE;
	END_IF
	
	CASE Step OF
		E_MAINT_DIABLE:
			IF gSts.AsmState = E_ASM_ON AND MaintShuttleControlEnable = TRUE THEN
				fbAsmGetShuttle.Enable 	:= TRUE;
				
				IF fbAsmGetShuttle.Valid = TRUE THEN
					CurrentShuttleIndex := fbAsmGetShuttle.RemainingCount + 1;
					Step 				:= E_MAINT_LINK_CURRENT_SH;
				END_IF
			ELSE
				fbAsmGetShuttle.Enable 	:= FALSE;
			END_IF
			
		E_MAINT_LINK_CURRENT_SH:
			fbReadShuttleInfo.Enable 		:= TRUE;
			fbGetUserData.Execute 			:= TRUE;

			fbAsmGetShuttle.Next 			:= FALSE;

			IF fbGetUserData.Done = TRUE AND fbReadShuttleInfo.Valid = TRUE THEN
				fbGetUserData.Execute		:= FALSE;
				Step 						:= E_MAINT_SELECTED_SHUTTLE;
			END_IF
			
		E_MAINT_SELECTED_SHUTTLE:
			IF cmdNextSh.Q = TRUE THEN
				fbReadShuttleInfo.Enable 		:= FALSE;
				
				IF fbAsmGetShuttle.RemainingCount > 0 THEN
					fbAsmGetShuttle.Next 	:= TRUE;
					Step 					:= E_MAINT_LINK_CURRENT_SH;
				ELSE
					fbAsmGetShuttle.Enable := FALSE;					
					Step 					:= E_MAINT_DIABLE;
				END_IF
			ELSIF cmdMoveAbs.Q = TRUE THEN
				Step 						:= E_MAINT_RUN_ABS;
			END_IF
		
		E_MAINT_RUN_ABS:
			fbRoutedMoveAbs.Execute 	:= TRUE;
			
			IF fbRoutedMoveAbs.Done = TRUE OR fbRoutedMoveAbs.CommandAborted = TRUE OR fbRoutedMoveAbs.Error = TRUE THEN
				Step 						:= E_MAINT_SELECTED_SHUTTLE;
				fbRoutedMoveAbs.Execute 	:= FALSE;
				
			END_IF
	END_CASE
	
	IF fbStop.Error = TRUE OR fbStop.Done = TRUE THEN
		fbStop.Execute := FALSE;
	END_IF
	
	MoveAbsolute				:= FALSE;
	Stop						:= FALSE;
	
	fbStop;
	fbGetUserData;
	fbRoutedMoveAbs;
	fbAsmGetShuttle;
	fbReadShuttleInfo;
END_PROGRAM

