PROGRAM _INIT
	currentProcess							:= E_PROCESS_Stage10;
	fbUserData.Axis							:= ADR(StStage[9].Shuttle);
	nextSlot 								:= ADR(StStage[10]);
	
	fbShuttleOutCheck.ProcessPoint			:= ADR(ptStage10);
	
	targetSlot ACCESS ADR(StStage[9]);
	shuttleID ACCESS ADR(interface.Trak.Data[0]);
	
	auditTag  := "10";
	
END_PROGRAM

PROGRAM _CYCLIC
	IF gSim = TRUE THEN
		bBlockReadOnceAck := bBlockReadOnce;
		bBlockSendOnceAck := bBlockSendOnce;
		bBlockSendShuttleIDAck := bBlockSendShuttleID;

		IF interface.Trak.ShuttleArrived = TRUE THEN
			interface.Equipment.Ready 		:= FALSE;
			
			tmr.IN 							:= TRUE;
			tmr.PT 							:= T#1s;
		END_IF
		
		IF tmr.Q = TRUE THEN
			interface.Equipment.Done 		:= TRUE;
		END_IF

		IF interface.Trak.ShuttleArrived = FALSE THEN
			tmr.IN							:= FALSE;
			interface.Equipment.Ready 		:= TRUE;
			interface.Equipment.Done 		:= FALSE;
		END_IF
		
		tmr();
	END_IF
	
	IF targetSlot.Interface = E_SLOT_UNKNOWN THEN
		step 				:= 0;
	END_IF

	CASE step OF
		0:	(* Modbus Interface Initialize and Shuttle Check *)
			bBlockSendShuttleID					:= FALSE;
			bBlockSendOnce						:= FALSE;
			bBlockReadOnce						:= FALSE;
			
			//interface.Trak.ShuttleArrived		:= FALSE;

			IF targetSlot.Shuttle.controlif <> 0 AND bBlockSendOnceAck = FALSE AND bBlockReadOnceAck = FALSE AND bBlockSendShuttleIDAck = FALSE THEN
				step 							:= 10;
			END_IF
			
		10:	(* Read Shuttle Data from userData *)
			fbUserData.DataAddress 				:= ADR(userData);
			fbUserData.DataSize 				:= SIZEOF(userData);
			fbUserData.Mode						:= mcACPTRAK_USERDATA_GET;
			fbUserData.Execute 					:= TRUE;
			
			IF fbUserData.Done = TRUE THEN
				//End to Read Data fron user Data
				fbUserData.Execute 				:= FALSE;
				
				//Copy User Data to Modbus IO
				brsmemcpy(ADR(interface.Trak.Data[0]),ADR(userData.SerialNumber), 11); 
				brsmemcpy(ADR(interface.Trak.Data2[0]),ADR(userData.Data[0]), SIZEOF(userData.Data)); 
				
				ParString := STRING_TO_WSTRING(userData.SerialNumber);
				MpAuditCustomEvent(gAuditTrak, auditTag, "userData.SerialNumber", ParString);
				ParString := UINT_TO_WSTRING(userData.Data[0]);
				MpAuditCustomEvent(gAuditTrak, auditTag, "userData.Data[0]", ParString);
				
				//Start to Write userdata to Modbus
				bBlockSendOnce					:= TRUE;
				bBlockSendShuttleID				:= TRUE;
				step 							:= 11;
			END_IF
			
		11: (* Check End of write to Modbus *)
			IF bBlockSendOnceAck AND bBlockSendShuttleIDAck THEN
				bBlockSendOnce					:= FALSE;
				bBlockSendShuttleID				:= FALSE;
				step							:= 20;
			END_IF
			
		20: (* Check Process Ready *)
			IF targetSlot.Interface = E_SLOT_PROCESS_READY THEN

				MpAuditCustomEvent(gAuditTrak, auditTag, "targetSlot.Interface", "E_SLOT_PROCESS_READY");
				
				step 							:= 30;
			ELSIF targetSlot.Shuttle.controlif = 0 THEN
				step 							:= 0;
			END_IF
			
		30:	(* Check Assemble Status and Slot Status *)
			IF (gSts.AsmState = E_ASM_PROCESS OR gSts.AsmState = E_ASM_IDLE)
				AND targetSlot.Interface = E_SLOT_PROCESS_READY THEN
				interface.Trak.ShuttleArrived	:= TRUE;
				fbShuttleOutCheck.Enable		:= TRUE;

				ParString := BOOL_TO_WSTRING(interface.Trak.ShuttleArrived);
				MpAuditCustomEvent(gAuditTrak, auditTag, "ShuttleArrived", ParString);
				step 							:= 100;
			END_IF
		
		100: (* Wait Proess End and Next Stage Ready *)
			IF interface.Equipment.Done = TRUE AND NextReady THEN
				//Start to Read Data from PLC
				ParString := BOOL_TO_WSTRING(interface.Equipment.Done);
				MpAuditCustomEvent(gAuditTrak, auditTag, "interface.Equipment.Done", ParString);
				bBlockReadOnce					:= TRUE;
				step 							:= 101;
			END_IF
			
		101:
			IF bBlockReadOnceAck = TRUE THEN
				// Save Current Process Status
				userData.ProcessStatus			:= currentProcess;
				
				// Read process data from PLC
				brsmemcpy(ADR(userData.Data[0]), ADR(interface.Equipment.Data2[0]), SIZEOF(interface.Equipment.Data2)); 

				brsmemcpy(ADR(ParStringTmp), ADR(userData.Data), SIZEOF(userData.Data));
				ParString := STRING_TO_WSTRING(ParStringTmp);
				MpAuditCustomEvent(gAuditTrak, auditTag, "userData.Data[0]", ParString);
				
				// End to Read Data from PLC
				bBlockReadOnce					:= FALSE;
				step := 110;
			END_IF
			
		110: 	//Write User Data
			fbUserData.DataAddress 				:= ADR(userData);
			fbUserData.DataSize 				:= SIZE_OF_USERDATA;
			fbUserData.Mode						:= mcACPTRAK_USERDATA_SET;
			fbUserData.Execute 					:= TRUE;
			
			IF fbUserData.Done = TRUE THEN
				fbUserData.Execute 				:= FALSE;
				//	interface.Trak.ShuttleArrived 	:= FALSE;
				targetSlot.Interface 			:= E_SLOT_TAKEOUT_READY;
				targetSlot.NextStage			:= nextSlot;

				MpAuditCustomEvent(gAuditTrak, auditTag, "targetSlot.Interface", "E_SLOT_TAKEOUT_READY");
				ParString := UDINT_TO_WSTRING(targetSlot.NextStage);
				MpAuditCustomEvent(gAuditTrak, auditTag, "targetSlot.NextStage", ParString);
				step 							:= 120;
			END_IF
				
		120: 	//Done Check	
			IF interface.Equipment.Done = FALSE THEN
				ParString := BOOL_TO_WSTRING(interface.Equipment.Done);
				MpAuditCustomEvent(gAuditTrak, auditTag, "interface.Equipment.Done", ParString);
				step 						:= 0;
			END_IF
	END_CASE;
	
	IF fbShuttleOutCheck.EventCount > 0 THEN
		interface.Trak.ShuttleArrived	:= FALSE;
		fbShuttleOutCheck.Enable		:= FALSE;
		ParString := UINT_TO_WSTRING(fbShuttleOutCheck.EventCount);
		MpAuditCustomEvent(gAuditTrak, auditTag, "fbShuttleOutCheck.EventCount", ParString);
	END_IF
	
	IF targetSlot.Shuttle.controlif = 0 AND shuttleID <> '' THEN
		brsmemset(ADR(interface.Trak.Data[0]),0,11);
	END_IF
	
	fbUserData();
	fbShuttleOutCheck();
	Timer();
	Timer2();
	
END_PROGRAM
