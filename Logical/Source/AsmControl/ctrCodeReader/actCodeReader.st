
ACTION actCodeReader:
	
	IF gSim THEN
		
		gInitialDone := TRUE;
		
	END_IF
	
	IF NOT gInitialDone THEN
	
	CASE CodeStep OF
		
		CODE_WAIT:

			IF gShuttleTotalCount > checkSHCount THEN
				
					fbTrig.Enable				:= TRUE;
					
				IF fbTrig.Valid THEN
		
					CodeStep				:= CODE_CHECK_TRIG;
			
				END_IF
				
			ELSE
				
				gInitialDone				:= TRUE;
				fbTrig.Enable				:= FALSE;
//				gBarCodeReader.Enable 		:= FALSE;
				
			END_IF
			
		CODE_CHECK_TRIG:
			
			IF fbTrig.EventCount > 0 THEN
				
				checkSHCount := checkSHCount + 1;
				
				fbTrigInfo.Execute := TRUE;
				
				fbUserData.DataAddress 			:= ADR(userData);
				fbUserData.DataSize 			:= SIZE_OF_USERDATA;
				fbUserData.Mode					:= mcACPTRAK_USERDATA_GET;
				fbUserData.Execute 				:= TRUE;
				
				CodeStep						:= CODE_GET_SH;
				
			END_IF
			
		CODE_GET_SH:
			
			IF fbTrigInfo.Done = TRUE AND fbUserData.Done = TRUE THEN
				
				Axis	:= fbTrigInfo.TrgPointInfo.Axis;
				fbUserData.Execute 				:= FALSE;

				CodeStep 				:= CODE_MOVE_TO_READER;
				
			END_IF
			
		CODE_MOVE_TO_READER:
			
			fbMovelAbs.Sector				:= ADR(SectorTrackAll);
			fbMovelAbs.Axis 				:= ADR(Axis);
						
			fbMovelAbs.Velocity				:= gPar.MovementPar.Initialize.Velocity;
			fbMovelAbs.Acceleration 		:= gPar.MovementPar.Initialize.Acceleration;
			fbMovelAbs.Deceleration 		:= gPar.MovementPar.Initialize.Deceleration;
			fbMovelAbs.Position				:= POS_VISION;
				
			fbMovelAbs.Execute 				:= TRUE;
				
			fbMovelAbs.AdvancedParameters.StartDirection 		:= mcDIR_UNDEFINED;
			fbMovelAbs.AdvancedParameters.EndDirection 			:= mcDIR_POSITIVE;
				
			fbMovelAbs.AdvancedParameters.ShuttleOrientation 	:= mcDIR_UNDEFINED;
			fbMovelAbs.AdvancedParameters.PosRelativeTo 		:= mcACPTRAK_SEC_START;
					
			IF fbMovelAbs.Done THEN
				
				fbMovelAbs.Execute 			:= FALSE;
				
				CodeStep					:= CODE_READER_CHECK;
				
			END_IF
			
		CODE_READER_CHECK:
			
			IF gVisionSensor.DAT.StatusText = 'Ready' AND NOT gVisionSensor.DAT.ImageProcessingActive THEN
				
				gBarCodeReader.Trigger		:= TRUE;
				checkTakeCount				:= gBarCodeReader.TakeCount;
				CodeStep					:= CODE_CHECK_TAKE_COUNT;
				
			END_IF
			
		CODE_CHECK_TAKE_COUNT:
			
			IF gVisionSensor.DAT.ImageProcessingActive AND checkTakeCount <> gBarCodeReader.TakeCount THEN // gVisionSensor.DAT.StatusText <> 'Ready' AND checkTakeCount <> gBarCodeReader.TakeCount THEN //bNextStep1 THEN
				
				gBarCodeReader.Trigger		:= FALSE;
				
				CodeStep					:= CODE_ID_DEFINE;
				
			END_IF
			
		CODE_ID_DEFINE:
			
			IF NOT gVisionSensor.DAT.ImageProcessingActive THEN // bNextStep2 THEN // 

//				fbUserData.Axis 		:= ADR(Axis);
				fbUserData.Mode 		:= mcACPTRAK_USERDATA_SET;
				fbUserData.Execute 		:= TRUE;
				fbUserData.DataAddress	:= ADR(userData);
				fbUserData.DataSize		:= SIZEOF(userData);
			
//				StrShuttleCount 		:= USINT_TO_STRING(checkSHCount);
//				
//				IF checkSHCount < 10 THEN
//					userData.SerialNumber		:= 'FA99999900';
//					userData.SerialNumber		:= CONCAT(userData.SerialNumber, StrShuttleCount);
//					
//				ELSIF checkSHCount < 100 THEN
//					userData.SerialNumber		:= 'FA9999990';
//					userData.SerialNumber		:= CONCAT(userData.SerialNumber, StrShuttleCount);
//				END_IF
				
//				brsmemcpy(ADR(userData.SerialNumber), ADR(StrTempShuttleID), 11);// ADR(gBarCodeReader.SerialNumber), 11);
					
				userData.SerialNumber := gBarCodeReader.SerialNumber;
				
				IF fbUserData.Done = TRUE THEN // AND bNextStep3 THEN
					
					fbUserData.Execute 	:= FALSE;
					CodeStep					:= CODE_RELEASE_SH;
			
				END_IF
				
			END_IF
				
		CODE_RELEASE_SH:
			
			fbMovelVel.Sector				:= ADR(SectorTrackAll);
			fbMovelVel.Axis 				:= ADR(Axis);
					
			fbMovelVel.RouteVelocity 		:= gPar.MovementPar.Initialize.RoutedVelocity;
			fbMovelVel.Velocity 			:= gPar.MovementPar.Initialize.Velocity;
			fbMovelVel.Acceleration 		:= gPar.MovementPar.Initialize.Acceleration;
			fbMovelVel.Deceleration 		:= gPar.MovementPar.Initialize.Deceleration;
			
			fbMovelVel.Execute 				:= TRUE;

			fbMovelVel.AdvancedParameters.StartDirection 		:= mcDIR_UNDEFINED;
			fbMovelVel.AdvancedParameters.EndDirection 			:= mcDIR_POSITIVE;
			
			fbMovelVel.AdvancedParameters.ShuttleOrientation 	:= mcDIR_UNDEFINED;
			fbMovelVel.AdvancedParameters.PosRelativeTo 		:= mcACPTRAK_SEC_START;
				
			CodeStep 					:= CODE_NORMAL_END;
			
//			IF fbMovelVel.Active THEN
//				
//				fbMovelVel.Execute 			:= FALSE;
//				fbUserData.Execute			:= FALSE;
//				fbTrigInfo.Execute			:= FALSE;
//
//			END_IF
			
		CODE_NORMAL_END:
			
			fbTrigInfo.Execute			:= FALSE;
			fbUserData.Execute			:= FALSE;
			fbMovelVel.Execute 			:= FALSE;
		
			CodeStep 					:= CODE_WAIT;
		
		END_CASE
		
	END_IF
		
	fbTrig();
	fbTrigInfo();
	fbUserData();
	fbMovelAbs();
	fbMovelVel();
	ShReadInfo();
	
	bMoveVelActive 	:= fbMovelVel.Active;
	
END_ACTION

ACTION actCodeReader_INIT:
	
	CodeStep 			:= CODE_WAIT;
	
//	gBarCodeReader.Enable 		:= FALSE;
//	gBarCodeReader.Trigger		:= FALSE;
	
	checkSHCount		:= 0;
	
	fbTrig.Enable		:= FALSE;
	fbTrigInfo.Execute	:= FALSE;
	fbUserData.Execute	:= FALSE;
	fbMovelAbs.Execute	:= FALSE;
	fbMovelVel.Execute	:= FALSE;

END_ACTION
				
/////////////////////////////////////////////////////////////////////////////////////////////////////////				
				
//				
//		INIT_BARRIERSETTING:(* Process Point Setting *)
//			countShuttle					:= 0;
//			gShuttleTotalCount				:= 0;
//				
//			fbCheckInStatus.Enable 			:= TRUE;
//				
//			fbCheckIn.Command 				:= mcACPTRAK_BARRIER_CLOSE;
//			fbCheckIn.Execute 				:= TRUE;
//				
//			fbCheckOut.Command 				:= mcACPTRAK_BARRIER_OPEN;
//			fbCheckOut.Execute 				:= TRUE;
//
//			IF fbCheckIn.Done = TRUE AND fbCheckOut.Done = TRUE	AND fbCheckInStatus.Valid = TRUE THEN
//				fbCheckIn.Execute 			:= FALSE;
//				fbCheckOut.Execute 			:= FALSE;
//				
//				fbAsmGetShuttle.Assembly 		:= ADR(gAsmMain);
//				fbAsmGetShuttle.Enable 			:= TRUE;
//				
//				IF fbAsmGetShuttle.Valid = TRUE THEN
//					gShuttleTotalCount			:= fbAsmGetShuttle.TotalCount;
//					initStep 					:= INIT_SHUTTLE_CHECK;	
//				END_IF
//			END_IF
//			
//		INIT_SHUTTLE_CHECK:
//			IF fbAsmGetShuttle.TotalCount > countShuttle THEN
//				readShuttleInfo.Axis  		:= ADR(fbAsmGetShuttle.Axis);
//				readShuttleInfo.Enable 		:= TRUE;
//					
//				IF readShuttleInfo.Valid = TRUE THEN
//					countShuttle			:= countShuttle + 1;
//					fbAsmGetShuttle.Next	:= FALSE;
//					initStep 				:= INIT_MOVE;	
//				END_IF
//			ELSE
//				fbAsmGetShuttle.Enable 		:= FALSE;
//				readShuttleInfo.Enable 		:= FALSE;
//				initStep 					:= INIT_ADD_TICKET;					
//			END_IF
//			
//		INIT_MOVE:
//			IF readShuttleInfo.ShuttleInfo.CurrentValues.Velocity = 0 THEN
//				fbMovelVel.Sector				:= ADR(SecMain);
//				fbMovelVel.Axis 				:= ADR(fbAsmGetShuttle.Axis);
//						
//				fbMovelVel.RouteVelocity 		:= gPar.MovementPar.Initialize.RoutedVelocity;
//				fbMovelVel.Velocity 			:= gPar.MovementPar.Initialize.Velocity;
//				fbMovelVel.Acceleration 		:= gPar.MovementPar.Initialize.Acceleration;
//				fbMovelVel.Deceleration 		:= gPar.MovementPar.Initialize.Deceleration;
//				fbMovelVel.Execute 				:= TRUE;
//
//				fbMovelVel.AdvancedParameters.StartDirection 		:= mcDIR_UNDEFINED;
//				fbMovelVel.AdvancedParameters.EndDirection 			:= mcDIR_POSITIVE;
//				
//				fbMovelVel.AdvancedParameters.ShuttleOrientation 	:= mcDIR_UNDEFINED;
//				fbMovelVel.AdvancedParameters.PosRelativeTo 		:= mcACPTRAK_SEC_START;
//					
//				IF bMoveVelActive = FALSE AND fbMovelVel.Active = TRUE THEN
//					fbMovelVel.Execute 			:= FALSE;
//					readShuttleInfo.Enable 		:= FALSE;
//					fbAsmGetShuttle.Next		:= TRUE;
//					initStep 					:= INIT_SHUTTLE_CHECK;
//				END_IF
//			END_IF
//			
//		INIT_ADD_TICKET:
//			fbCheckIn.AdvancedParameters.TicketCount 	:= gShuttleTotalCount;
//			fbCheckIn.Command							:= mcACPTRAK_BARRIER_ADD_TICKETS;
//			fbCheckIn.Execute 							:= TRUE;
//				
//			IF fbCheckIn.Done = TRUE THEN
//				fbCheckIn.Execute						:= FALSE;
//				initStep 								:= INIT_START_ID_IDENTIFICATION;
//			END_IF
//
//				
//		INIT_START_ID_IDENTIFICATION:
//			IF fbCheckInStatus.BarrierInfo.RemainingTickets = 0 THEN
//				initStep 								:= INIT_CHECK_END;
//			END_IF
//				
//		INIT_CHECK_END:
//			fbSecGetShuttles.Sector := ADR(SecMain);
//			fbSecGetShuttles.Enable := TRUE;
//			fbSecGetShuttles.AdvancedParameters.StartPosition 	:= 1.2;
//			fbSecGetShuttles.AdvancedParameters.EndPosition 	:= 2.4;
//				
//			IF fbSecGetShuttles.Valid = TRUE THEN
//				IF fbSecGetShuttles.TotalCount = 0 THEN
//					fbSecGetShuttles.Enable 			:= FALSE;
//					initStep 							:= INIT_NORMAL_END;
//				ELSE
//					fbSecGetShuttles.Enable := FALSE;						
//				END_IF
//			END_IF
//				
//		INIT_NORMAL_END:
//			fbCheckInStatus.Enable := FALSE;
//			fbCheckIn.Execute := TRUE;
//			fbCheckOut.Execute := TRUE;
//			
//			fbCheckIn.Command := mcACPTRAK_BARRIER_OPEN;
//			fbCheckOut.Command := mcACPTRAK_BARRIER_OPEN;
//				
//			IF fbCheckIn.Done = TRUE AND fbCheckOut.Done = TRUE THEN
//				gSts.AsmState 					:= E_ASM_IDLE;
//			END_IF
//	END_CASE;
//	
//	fbCheckInStatus();
//	fbCheckIn();
//	fbCheckOut();
//
//	fbAsmGetShuttle();
//	readShuttleInfo();
//	
//	fbSecGetShuttles();
//	
//	bMoveVelActive 	:= fbMovelVel.Active;
//	
//END_ACTION
//
//ACTION actInitialize_INIT:
//	CodeStep 						:= CODE_WAIT;	
//	fbAsmGetShuttle.Enable 			:= FALSE;
//	fbSecGetShuttles.Enable 		:= FALSE;
//	fbCheckInStatus.Enable			:= FALSE;
//	fbCheckIn.Execute 				:= FALSE;
//	fbCheckOut.Execute 				:= FALSE;
//	fbMovelVel.Execute				:= FALSE;
//END_ACTION
