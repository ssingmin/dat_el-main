
PROGRAM _INIT
	fbAsmPowerOff.Assembly 		:= ADR(gAsmMain);
	fbAsmPowerOn.Assembly 		:= ADR(gAsmMain);	
	fbAsmReset.Assembly 		:= ADR(gAsmMain);
	fbAsmStop.Assembly 			:= ADR(gAsmMain);
	fbAsmReadStatus.Assembly 	:= ADR(gAsmMain);
	fbAsmReadErrorInfo.Assembly := ADR(gAsmMain);
	fbAsmReadInfo.Assembly 		:= ADR(gAsmMain);
	fbAsmGetShuttle.Assembly	:= ADR(gAsmMain);
END_PROGRAM

PROGRAM _CYCLIC
	
	// PC running hours
	RunningTime	:= DINT_TO_UDINT(OperatingHours);
	SystemTime	:= UDINT_TO_UINT(RunningTime / 1000000);
	
	IF gLocal THEN
		cmdPowerOn(CLK := gCmd.PowerOn);
		cmdPowerOff(CLK := gCmd.PowerOff);
		cmdInit(CLK := gCmd.Initialize);
		cmdEMS(CLK := gCmd.EMS);
		cmdStart(CLK := gCmd.Start);
		cmdStop(CLK := gCmd.Stop);
		cmdReset(CLK := gCmd.Reset);
		cmdClean(CLK := gCmd.Clean);
	ELSE
		cmdPowerOn(CLK := gCmdRemote.PowerOn);
		cmdPowerOff(CLK := gCmdRemote.PowerOff);
		cmdInit(CLK := gCmdRemote.Initialize);
		cmdEMS(CLK := gCmdRemote.EMS);
		cmdStart(CLK := gCmdRemote.Start);
		cmdStop(CLK := gCmdRemote.Stop);
		cmdReset(CLK := gCmdRemote.Reset);
		cmdClean(CLK := gCmdRemote.Clean);
	END_IF
	
	fbAsmReadStatus(Enable := TRUE);
			
	// Power on/off signal
	IF fbAsmReadInfo.AssemblyInfo.PowerOn THEN
		gStsPowerOn		:= TRUE;
		gStsPowerOff	:= FALSE;
	ELSIF NOT(fbAsmReadInfo.AssemblyInfo.PowerOn) THEN
		gStsPowerOn		:= FALSE;
		gStsPowerOff	:= TRUE;
	END_IF
	
	// Reset 
	IF gCmdRemote.Reset THEN
		gCmd.Reset	:= TRUE;
	ELSIF NOT(gCmdRemote.Reset) THEN
		gCmd.Reset	:= FALSE;
	END_IF
	
	// EMS
	IF gCmd.EMS OR gCmdRemote.EMS THEN
		gSts.AsmState	:= E_ASM_EMS;
	END_IF
	
	IF fbAsmReadStatus.AssemblyErrorStop = TRUE AND
		(gSts.AsmState <> E_ASM_ERRORSTOP AND
		gSts.AsmState <> E_ASM_RESET) THEN
		gSts.AsmState := E_ASM_ERRORSTOP;
	END_IF
	
	CASE gSts.AsmState OF
		E_ASM_UNKNOWN:
			
			gStsInitialize	:= FALSE;
			gStsEMS			:= FALSE;
			gStsProcess		:= FALSE;
			gStsStopping	:= FALSE;
			gStsIdle		:= FALSE;
			gStsManual		:= FALSE;
			gStsAsmOn		:= FALSE;
			gStsAsmOff		:= FALSE;
			gStsErrorStop	:= FALSE;
			
			IF fbAsmReadInfo.AssemblyInfo.ReadyForPowerOn = TRUE THEN
				gSts.AsmState := E_ASM_OFF;
			END_IF
			
		E_ASM_OFF:
			
			gStsInitialize	:= FALSE;
			gStsEMS			:= FALSE;
			gStsProcess		:= FALSE;
			gStsStopping	:= FALSE;
			gStsIdle		:= FALSE;
			gStsManual		:= FALSE;
			gStsAsmOn		:= FALSE;
			gStsAsmOff		:= TRUE;
			gStsErrorStop	:= FALSE;
			
			IF fbAsmReadInfo.AssemblyInfo.ReadyForPowerOn = FALSE THEN
				gSts.AsmState := E_ASM_UNKNOWN;
			ELSIF cmdPowerOn.Q = TRUE THEN
				gSts.AsmState := E_ASM_POWER_ON;
			END_IF
			
		E_ASM_ON:
			
			gStsInitialize	:= FALSE;
			gStsEMS			:= FALSE;
			gStsProcess		:= FALSE;
			gStsStopping	:= FALSE;
			gStsIdle		:= FALSE;
			gStsManual		:= FALSE;
			gStsAsmOn		:= TRUE;
			gStsAsmOff		:= FALSE;
			gStsErrorStop	:= FALSE;
			
			IF cmdPowerOff.Q = TRUE THEN
				gSts.AsmState := E_ASM_POWER_OFF;
			ELSIF cmdInit.Q = TRUE THEN
				gSts.AsmState := E_ASM_INITIALIZATION;
			ELSIF NOT(fbAsmReadInfo.AssemblyInfo.PowerOn) THEN
				gSts.AsmState := E_ASM_OFF;
			ELSIF cmdClean.Q THEN
				gSts.AsmState := E_ASM_CLEAN;
			END_IF
			
		E_ASM_ERRORSTOP:
			
			gStsInitialize	:= FALSE;
			gStsEMS			:= FALSE;
			gStsProcess		:= FALSE;
			gStsStopping	:= FALSE;
			gStsIdle		:= FALSE;
			gStsManual		:= FALSE;
			gStsAsmOn		:= FALSE;
			gStsAsmOff		:= FALSE;
			gStsErrorStop	:= TRUE;
			
			IF cmdPowerOff.Q = TRUE THEN
				gSts.AsmState := E_ASM_POWER_OFF;
			ELSIF cmdReset.Q = TRUE THEN
				gSts.AsmState := E_ASM_RESET;
			END_IF

		E_ASM_IDLE:
			
			gStsInitialize	:= FALSE;
			gStsEMS			:= FALSE;
			gStsProcess		:= FALSE;
			gStsStopping	:= FALSE;
			gStsIdle		:= TRUE;
			gStsManual		:= FALSE;
			gStsAsmOn		:= FALSE;
			gStsAsmOff		:= FALSE;
			gStsErrorStop	:= FALSE;
			
			IF gManual = TRUE THEN
				gSts.AsmState := E_ASM_MANUAL;
			ELSIF cmdEMS.Q = TRUE THEN
				gSts.AsmState := E_ASM_EMS;
			ELSIF cmdStart.Q = TRUE THEN
				gSts.AsmState := E_ASM_PROCESS;
			ELSIF cmdPowerOff.Q = TRUE THEN
				gSts.AsmState := E_ASM_POWER_OFF;
			END_IF
		
		E_ASM_MANUAL:
			
			gStsInitialize	:= FALSE;
			gStsEMS			:= FALSE;
			gStsProcess		:= FALSE;
			gStsStopping	:= FALSE;
			gStsIdle		:= FALSE;
			gStsManual		:= TRUE;
			gStsAsmOn		:= FALSE;
			gStsAsmOff		:= FALSE;
			gStsErrorStop	:= FALSE;
			
			IF gManual = FALSE THEN
				gSts.AsmState := E_ASM_EMS;
			END_IF
			
		E_ASM_PROCESS:
			
			gStsInitialize	:= FALSE;
			gStsEMS			:= FALSE;
			gStsProcess		:= TRUE;
			gStsStopping	:= FALSE;
			gStsIdle		:= FALSE;
			gStsManual		:= FALSE;
			gStsAsmOn		:= FALSE;
			gStsAsmOff		:= FALSE;
			gStsErrorStop	:= FALSE;
			
			IF cmdEMS.Q = TRUE THEN
				gSts.AsmState := E_ASM_EMS;
			ELSIF cmdStop.Q = TRUE THEN
				gSts.AsmState := E_ASM_STOPPING;
			END_IF
			
		E_ASM_POWER_ON:
			
			gStsInitialize	:= FALSE;
			gStsEMS			:= FALSE;
			gStsProcess		:= FALSE;
			gStsStopping	:= FALSE;
			gStsIdle		:= FALSE;
			gStsManual		:= FALSE;
			gStsAsmOn		:= FALSE;
			gStsAsmOff		:= FALSE;
			gStsErrorStop	:= FALSE;
			
			actPowerOn;
			
		E_ASM_POWER_OFF:
			
			gStsInitialize	:= FALSE;
			gStsEMS			:= FALSE;
			gStsProcess		:= FALSE;
			gStsStopping	:= FALSE;
			gStsIdle		:= FALSE;
			gStsManual		:= FALSE;
			gStsAsmOn		:= FALSE;
			gStsAsmOff		:= FALSE;
			gStsErrorStop	:= FALSE;
			
			actPowerOff;
			
		E_ASM_RESET:
			
			gStsInitialize	:= FALSE;
			gStsEMS			:= FALSE;
			gStsProcess		:= FALSE;
			gStsStopping	:= FALSE;
			gStsIdle		:= FALSE;
			gStsManual		:= FALSE;
			gStsAsmOn		:= FALSE;
			gStsAsmOff		:= FALSE;
			gStsErrorStop	:= FALSE;
			
			actErrorReset;
		
		E_ASM_EMS:
			
			gStsInitialize	:= FALSE;
			gStsEMS			:= TRUE;
			gStsProcess		:= FALSE;
			gStsStopping	:= FALSE;
			gStsIdle		:= FALSE;
			gStsManual		:= FALSE;
			gStsAsmOn		:= FALSE;
			gStsAsmOff		:= FALSE;
			gStsErrorStop	:= FALSE;
			
			actEMS;
		
		E_ASM_INITIALIZATION:
			
			gStsInitialize	:= TRUE;
			gStsEMS			:= FALSE;
			gStsProcess		:= FALSE;
			gStsStopping	:= FALSE;
			gStsIdle		:= FALSE;
			gStsManual		:= FALSE;
			gStsAsmOn		:= FALSE;
			gStsAsmOff		:= FALSE;
			gStsErrorStop	:= FALSE;
			//Customeizing
			
		E_ASM_RECOVERY:
			//Customeizing

		E_ASM_STOPPING:
			
			gStsInitialize	:= FALSE;
			gStsEMS			:= FALSE;
			gStsProcess		:= FALSE;
			gStsStopping	:= TRUE;
			gStsReset		:= FALSE;
			gStsIdle		:= FALSE;
			gStsManual		:= FALSE;
			gStsAsmOn		:= FALSE;
			gStsAsmOff		:= FALSE;
			gStsErrorStop	:= FALSE;
		
			IF cmdStart.Q THEN
				gSts.AsmState	:= E_ASM_PROCESS;
			END_IF
		
		E_ASM_CLEAN:
		
			gStsInitialize	:= FALSE;
			gStsEMS			:= FALSE;
			gStsProcess		:= FALSE;
			gStsStopping	:= FALSE;
			gStsIdle		:= FALSE;
			gStsManual		:= FALSE;
			gStsAsmOn		:= FALSE;
			gStsAsmOff		:= FALSE;
			gStsErrorStop	:= FALSE;
	END_CASE;
		
	fbAsmReadStatus(Enable := TRUE);
	fbAsmReadErrorInfo();
	fbAsmReadInfo(Enable := TRUE);
	
	fbAsmPowerOn();
	fbAsmPowerOff();
	fbAsmReset();
	fbAsmStop();
	fbAsmGetShuttle();
	fbUserData();
	
	gCmd.PowerOn 	:= FALSE;
	gCmd.PowerOff 	:= FALSE;
	gCmd.Initialize := FALSE;
	gCmd.EMS 		:= FALSE;
	gCmd.Start 		:= FALSE;
	gCmd.Stop 		:= FALSE;
	gCmd.Clean		:= FALSE;
	
	gCmdRemote.PowerOn 		:= FALSE;
	gCmdRemote.PowerOff 	:= FALSE;
	gCmdRemote.Initialize 	:= FALSE;
	gCmdRemote.EMS 			:= FALSE;
	gCmdRemote.Start 		:= FALSE;
	gCmdRemote.Stop 		:= FALSE;
	gCmdRemote.Reset 		:= FALSE;
	gCmdRemote.Clean		:= FALSE;
	
END_PROGRAM
