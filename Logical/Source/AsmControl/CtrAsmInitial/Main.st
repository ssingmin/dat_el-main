
PROGRAM _INIT
	
	fbCheckIn.ProcessPoint			:= ADR(ptCheckIn);
	fbCheckInStatus.ProcessPoint 	:= ADR(ptCheckIn);
	fbCheckInTrg.ProcessPoint		:= ADR(ptCheckIn);
	fbCheckInTrgInfo.ProcessPoint	:= ADR(ptCheckIn);
	
	fbCheckOutStatus.ProcessPoint	:= ADR(ptCheckOut);
	fbCheckOut.ProcessPoint			:= ADR(ptCheckOut);
	
	IF gParInitialized = FALSE THEN
		gPar.MovementPar.Initialize.Velocity := 1.0;
		gPar.MovementPar.Initialize.RoutedVelocity := 1.0;
		gPar.MovementPar.Initialize.Acceleration := 1.0;
		gPar.MovementPar.Initialize.Deceleration := 1.0;

		gPar.TargetPPM := 40;
		gPar.CountOfGroup := 1;
	END_IF
	
END_PROGRAM

PROGRAM _CYCLIC
	
	IF gSts.AsmState <> E_ASM_INITIALIZATION THEN
		initStep 						:= 0;		
		TotalShuttleCount				:= 0;
		
		fbSecGetShuttles.Enable 		:= FALSE;

		fbCheckInTrg.Enable				:= FALSE;
		fbCheckInTrgInfo.Execute		:= FALSE;
		fbCheckIn.Execute				:= FALSE;
		fbCheckInStatus.Enable			:= FALSE;
		fbCheckOut.Execute				:= FALSE;
		fbCheckOutStatus.Enable			:= FALSE;
	
		fbMoveAbs.Execute				:= FALSE;
		fbMovelVel.Execute 				:= FALSE;	
	ELSE
		CASE initStep OF
			0:
				fbCheckInStatus.Enable := TRUE;
				fbCheckIn.Execute := TRUE;
				fbCheckOut.Execute := TRUE;
				BrBuffer.Execute := TRUE;
				
				fbCheckIn.Command := mcACPTRAK_BARRIER_CLOSE;
				fbCheckOut.Command := mcACPTRAK_BARRIER_OPEN;
				
				BrBuffer.Command := mcACPTRAK_BARRIER_OPEN;
				
				IF fbCheckIn.Done = TRUE AND fbCheckOut.Done = TRUE AND fbCheckInStatus.Valid = TRUE AND BrBuffer.Done THEN
					fbCheckIn.Execute 			:= FALSE;
					fbCheckOut.Execute 			:= FALSE;
					BrBuffer.Execute 			:= FALSE;
					initStep 					:= 100;
				END_IF
			
			100:
				fbSecGetShuttles.Sector 		:= ADR(SectorTrackAll);
				fbSecGetShuttles.Enable 		:= TRUE;
				fbSecGetShuttles.AdvancedParameters.StartPosition := 0.0;
				fbSecGetShuttles.AdvancedParameters.EndPosition := 0.0;
			
				IF fbSecGetShuttles.Valid = TRUE THEN	
					TotalShuttleCount 		:= fbSecGetShuttles.TotalCount;
					initStep 				:= 210;						
				END_IF
						
			210:
				fbSecGetShuttles.Next 			:= FALSE;
						
				fbMovelVel.Sector				:= ADR(SectorTrackAll);
				fbMovelVel.Axis 				:= ADR(fbSecGetShuttles.Axis);
				
				fbMovelVel.Position				:= 12.48;
				fbMovelVel.RouteVelocity 		:= gPar.MovementPar.Initialize.RoutedVelocity;
				fbMovelVel.Velocity 			:= gPar.MovementPar.Initialize.Velocity;
				fbMovelVel.Acceleration 		:= gPar.MovementPar.Initialize.Acceleration;
				fbMovelVel.Deceleration 		:= gPar.MovementPar.Initialize.Deceleration;
				fbMovelVel.Execute 				:= TRUE;
						
				fbMovelVel.AdvancedParameters.StartDirection 		:= mcDIR_POSITIVE;
				fbMovelVel.AdvancedParameters.EndDirection 			:= mcDIR_UNDEFINED;
				fbMovelVel.AdvancedParameters.ShuttleOrientation 	:= mcDIR_UNDEFINED;
					
				IF bMoveVelActive = FALSE AND fbMovelVel.Active = TRUE THEN
					fbMovelVel.Execute 			:= FALSE;
					initStep 					:= 220;
				END_IF
			
			220:
				IF fbSecGetShuttles.RemainingCount > 0 THEN
					fbSecGetShuttles.Next 		:= TRUE;
					initStep 					:= 210;
				ELSE
					fbSecGetShuttles.Enable 	:= FALSE;
					initStep 					:= 230;				
				END_IF
				
				(* Go To Bar Code Reading *)
				(* Go To Bar Code Reading *)
				(* Go To Bar Code Reading *)
			230:
				fbCheckInTrg.Enable := TRUE;
				
				IF fbCheckInTrg.Valid = TRUE THEN
					fbCheckIn.Command							:= mcACPTRAK_BARRIER_ADD_TICKETS;
					fbCheckIn.AdvancedParameters.TicketCount 	:= TotalShuttleCount;
					fbCheckIn.Execute							:= TRUE;
										
					IF fbCheckIn.Done = TRUE THEN
						fbCheckIn.Execute 		:= FALSE;
						initStep 				:= 240;						
					END_IF
				END_IF
				
			240:
				IF fbCheckInTrg.EventCount > 0 THEN
					initStep 				:= 250;
				END_IF
				
			250:
				fbCheckInTrgInfo.Execute := TRUE;
				
				IF fbCheckInTrgInfo.Done = TRUE THEN
					initStep 				:= 260;
				END_IF
				
			260:
				fbMoveAbs.Sector		:= ADR(SectorTrackAll);
				fbMoveAbs.Axis			:= ADR(fbCheckInTrgInfo.TrgPointInfo.Axis);
				fbMoveAbs.Position		:= 7.57;//(LENGTH_OF_ARC * 1) + (LENGTH_OF_CURVE * 3) + (LENGTH_OF_STRAIGHT * 5) + 0.12;
				fbMoveAbs.Velocity 		:= gPar.MovementPar.Initialize.Velocity;
				fbMoveAbs.Acceleration 	:= gPar.MovementPar.Initialize.Acceleration;
				fbMoveAbs.Deceleration 	:= gPar.MovementPar.Initialize.Deceleration;
				fbMoveAbs.AdvancedParameters.StartDirection 	:= mcDIR_POSITIVE;
				fbMoveAbs.AdvancedParameters.EndDirection 		:= mcDIR_UNDEFINED;
				fbMoveAbs.AdvancedParameters.ShuttleOrientation := mcDIR_UNDEFINED;
				fbMoveAbs.Execute 		:= TRUE;
				
				IF fbMoveAbs.Done = TRUE THEN
					fbMoveAbs.Execute 	:= FALSE;
					initStep 			:= 270;
				END_IF

				(* Read User Data *)
			270:
				
				fbUserData.Axis := ADR(fbCheckInTrgInfo.TrgPointInfo.Axis);
				fbUserData.DataSize := SIZEOF(userData);
				fbUserData.DataAddress := ADR(userData);
				fbUserData.Mode := mcACPTRAK_USERDATA_GET;

				fbUserData.Execute := TRUE;

				IF fbUserData.Done = TRUE THEN
					fbUserData.Execute := FALSE;
					gBarCodeReader.Trigger := TRUE;
					initStep := 271;
				END_IF

				(* Read BCR *)
			271:
				//Timer Check
				IF gSim = TRUE THEN
					initStep := 272;					
				END_IF
				
				CharCount := brsstrlen(ADR(gBarCodeReader.SerialNumber));
				fbTmr(IN := TRUE, PT:= T#5s);

				IF preSerialNumber <> gBarCodeReader.SerialNumber THEN
					//ID Check
					IF CharCount = 11 THEN
						brsmemcpy(ADR(userData.SerialNumber), ADR(gBarCodeReader.SerialNumber), 11);
						brsmemset(ADR(userData.Data),0,SIZEOF(userData.Data));
						initStep := 272;
					ELSE
						gBarCodeReader.Trigger := TRUE;
					END_IF

					fbTmr(IN := FALSE);
				ELSIF fbTmr.Q = TRUE THEN
					gBarCodeReader.Trigger := TRUE;
					fbTmr(IN := FALSE);
				END_IF

				(* Write User Data *)
			272:
				fbUserData.Axis := ADR(fbCheckInTrgInfo.TrgPointInfo.Axis);
				fbUserData.DataSize := SIZEOF(userData);
				fbUserData.DataAddress := ADR(userData);
				fbUserData.Mode := mcACPTRAK_USERDATA_SET;

				fbUserData.Execute := TRUE;

				IF fbUserData.Done = TRUE THEN
					fbUserData.Execute := FALSE;
					initStep := 280;
				END_IF
				
				(* Move to Home *)
			280:
				fbMovelVel.Sector				:= ADR(SectorTrackAll);
				fbMovelVel.Axis 				:= ADR(fbCheckInTrgInfo.TrgPointInfo.Axis);
				
				fbMovelVel.Position				:= 12.48;
				fbMovelVel.RouteVelocity 		:= gPar.MovementPar.Initialize.RoutedVelocity;
				fbMovelVel.Velocity 			:= gPar.MovementPar.Initialize.Velocity;
				fbMovelVel.Acceleration 		:= gPar.MovementPar.Initialize.Acceleration;
				fbMovelVel.Deceleration 		:= gPar.MovementPar.Initialize.Deceleration;
				fbMovelVel.Execute 				:= TRUE;
						
				fbMovelVel.AdvancedParameters.StartDirection 		:= mcDIR_POSITIVE;
				fbMovelVel.AdvancedParameters.EndDirection 			:= mcDIR_UNDEFINED;
				fbMovelVel.AdvancedParameters.ShuttleOrientation 	:= mcDIR_UNDEFINED;
					
				IF bMoveVelActive = FALSE AND fbMovelVel.Active = TRUE THEN
					TotalShuttleCount 			:= TotalShuttleCount - 1;
					fbMovelVel.Execute 			:= FALSE;
					fbCheckInTrgInfo.Execute 	:= FALSE;
					
					IF TotalShuttleCount > 0 THEN
						initStep 					:= 240;
					ELSE
						initStep 					:= 300;
					END_IF
				END_IF
			
			300:
				IF fbCheckInStatus.BarrierInfo.RemainingTickets = 0 THEN
					fbCheckInTrg.Enable			:= FALSE;
					initStep 					:= 400;					
				END_IF
				
			400:
				fbSecGetShuttles.Sector 		:= ADR(SectorTrackAll);
				fbSecGetShuttles.Enable 		:= TRUE;
				fbSecGetShuttles.AdvancedParameters.StartPosition 	:= 13.14;//12.48; // Check in point
				fbSecGetShuttles.AdvancedParameters.EndPosition 	:= 0.0;
				
				IF fbSecGetShuttles.Valid = TRUE AND fbSecGetShuttles.TotalCount = 0 THEN
					fbSecGetShuttles.Enable 		:= FALSE;
					initStep 						:= 1000;
				ELSIF  fbSecGetShuttles.Valid = TRUE AND fbSecGetShuttles.TotalCount > 0 THEN
					fbSecGetShuttles.Enable 		:= FALSE;
				END_IF
			
			1000:
				fbCheckInStatus.Enable := FALSE;
				fbCheckIn.Execute := TRUE;
				fbCheckOut.Execute := TRUE;
				BrBuffer.Execute := TRUE;
				
				fbCheckIn.Command := mcACPTRAK_BARRIER_OPEN;
				fbCheckOut.Command := mcACPTRAK_BARRIER_CLOSE;
				BrBuffer.Command := mcACPTRAK_BARRIER_CLOSE;
				
				IF fbCheckIn.Done = TRUE AND fbCheckOut.Done = TRUE THEN
					fbCheckIn.Execute 			:= FALSE;
					fbCheckOut.Execute 			:= FALSE;
					fbSecGetShuttles.Enable 	:= FALSE;
					gSts.AsmState 				:= E_ASM_IDLE;
					
					FOR i := 0 TO 18 DO
						StStage[i].Interface	:= E_SLOT_IDLE;
					END_FOR;

					initStep 					:= 0;
				END_IF
			
				IF BrBuffer.Done THEN	
					BrBuffer.Execute := FALSE;
				END_IF
		END_CASE;
	END_IF

	fbSecGetShuttles();

	fbCheckInTrg();
	fbCheckInTrgInfo();
	fbCheckIn();
	fbCheckInStatus();
	fbCheckOut();
	fbCheckOutStatus();
	fbUserData();
	
	fbMoveAbs();
	bMoveVelActive 	:= fbMovelVel.Active;
	fbMovelVel();	
	
END_PROGRAM

PROGRAM _EXIT
	fbSecGetShuttles.Enable 		:= FALSE;

	fbCheckInTrg.Enable				:= FALSE;
	fbCheckInTrgInfo.Execute		:= FALSE;
	fbCheckIn.Execute				:= FALSE;
	fbCheckInStatus.Enable			:= FALSE;
	fbCheckOut.Execute				:= FALSE;
	fbCheckOutStatus.Enable			:= FALSE;
	
	fbMoveAbs.Execute				:= FALSE;
	fbMovelVel.Execute 				:= FALSE;	

	fbSecGetShuttles();

	fbCheckInTrg();
	fbCheckInTrgInfo();
	fbCheckIn();
	fbCheckInStatus();
	fbCheckOut();
	fbCheckOutStatus();
	
	fbMoveAbs();
	fbMovelVel();	
END_PROGRAM