
ACTION actCommandCheck: 
	IF gLocal = TRUE THEN
		cmdPowerOn(CLK := gCmd.PowerOn);
		cmdPowerOff(CLK := gCmd.PowerOff);
		cmdInit(CLK := gCmd.Initialize);
		cmdEMS(CLK := gCmd.EMS);
		cmdStart(CLK := gCmd.Start);
		cmdStop(CLK := gCmd.Stop);
	ELSE
		cmdPowerOn(CLK := gCmdRemote.PowerOn);
		cmdPowerOff(CLK := gCmdRemote.PowerOff);
		cmdInit(CLK := gCmdRemote.Initialize);
		cmdEMS(CLK := gCmdRemote.EMS);
		cmdStart(CLK := gCmdRemote.Start);
		cmdStop(CLK := gCmdRemote.Stop);
	END_IF
	
	cmdReset(CLK := gCmd.Reset OR gCmdRemote.Reset);
	
	gCmd.PowerOn 			:= FALSE;
	gCmd.PowerOff 			:= FALSE;
	gCmd.Initialize 		:= FALSE;
	gCmd.EMS 				:= FALSE;
	gCmd.Start 				:= FALSE;
	gCmd.Stop 				:= FALSE;
	gCmd.Reset 				:= FALSE;
	
	gCmdRemote.PowerOn 		:= FALSE;
	gCmdRemote.PowerOff 	:= FALSE;
	gCmdRemote.Initialize 	:= FALSE;
	gCmdRemote.EMS 			:= FALSE;
	gCmdRemote.Start 		:= FALSE;
	gCmdRemote.Stop 		:= FALSE;
	gCmdRemote.Reset 		:= FALSE;
END_ACTION

ACTION actPowerOn: 
	IF fbAsmReadStatus.AssemblyDisabled = TRUE AND NOT(fbAsmPowerOn.Error OR NOT(fbAsmPowerOn.ErrorID = 0)) THEN
		fbAsmPowerOn.Execute 		:= TRUE;
		ShuttleCount				:= 0;
	ELSIF fbAsmReadStatus.AssemblyReady = TRUE THEN
		fbAsmPowerOn.Execute 		:= FALSE;
		
		IF fbAsmGetShuttle.Valid = FALSE THEN
			fbAsmGetShuttle.Enable := TRUE;
		ELSE
			fbAsmGetShuttle.Next 	:= FALSE;
			
			fbUserData.Axis 		:= ADR(fbAsmGetShuttle.Axis);
			fbUserData.Mode 		:= mcACPTRAK_USERDATA_SET;
			fbUserData.Execute 		:= TRUE;
			fbUserData.DataAddress	:= ADR(UserData);
			fbUserData.DataSize		:= SIZEOF(UserData);
			
			StrShuttleCount 		:= USINT_TO_STRING(ShuttleCount);
			
			IF ShuttleCount < 10 THEN
				UserData.SerialNumber		:= 'UNDEFINED0';
				UserData.SerialNumber		:= CONCAT(UserData.SerialNumber, StrShuttleCount);
			ELSIF ShuttleCount < 100 THEN
				UserData.SerialNumber		:= 'UNDEFINED';
				UserData.SerialNumber		:= CONCAT(UserData.SerialNumber, StrShuttleCount);
			END_IF
			
			IF fbUserData.Done = TRUE THEN
				ShuttleCount 		:= ShuttleCount + 1;
				fbUserData.Execute 	:= FALSE;
				
				IF fbAsmGetShuttle.RemainingCount = 0 THEN
					fbAsmGetShuttle.Enable 	:= FALSE;
					gSts.AsmState 			:= E_ASM_ON;
				ELSE
					fbAsmGetShuttle.Next 	:= TRUE;
				END_IF
			END_IF
		END_IF
	END_IF
	
	IF fbAsmPowerOn.Error OR NOT(fbAsmPowerOn.ErrorID = 0) THEN
		fbAsmPowerOn.Execute	:= FALSE;
		gSts.AsmState			:= E_ASM_ERRORSTOP;
	END_IF
	
END_ACTION

ACTION actPowerOff: 
	fbAsmPowerOff.Execute := TRUE;
			
	IF fbAsmPowerOff.Done = TRUE THEN
		fbAsmPowerOff.Execute := FALSE;
		gSts.AsmState := E_ASM_OFF;
	ELSIF fbAsmPowerOff.Error = TRUE THEN
		fbAsmPowerOff.Execute := FALSE;
		gSts.AsmState := E_ASM_ERRORSTOP;
	END_IF
END_ACTION

ACTION actEMS:
	fbAsmStop.Execute := TRUE;
			
	IF fbAsmStop.Busy = TRUE THEN
		fbAsmStop.Execute := FALSE;
		gSts.AsmState := E_ASM_ON;
	ELSIF fbAsmStop.Error = TRUE THEN
		fbAsmStop.Execute := FALSE;
	END_IF
END_ACTION

ACTION actErrorReset:
	fbAsmReset.Execute := TRUE;
			
	IF fbAsmReset.Done = TRUE THEN
		fbAsmReset.Execute := FALSE;
		gSts.AsmState := E_ASM_OFF;
	ELSIF fbAsmReset.Error = TRUE THEN
		fbAsmReset.Execute := FALSE;
		gSts.AsmState := E_ASM_ERRORSTOP;
	END_IF

END_ACTION
