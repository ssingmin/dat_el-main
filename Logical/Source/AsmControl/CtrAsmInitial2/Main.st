
PROGRAM _INIT
//	fbBarBufferOut.ProcessPoint	:= ADR(ptHome);
//	fbBarCmd.ProcessPoint		:= ADR(ptBufferIn);
//	fbBarNG.ProcessPoint 		:= ADR(ptLimitNGArea);
	
	fbCheckIn.ProcessPoint			:= ADR(ptCheckIn);
	fbCheckInStatus.ProcessPoint 	:= ADR(ptCheckIn);
	
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
	ELSE
		CASE initStep OF
			0:(* Process Point Setting *)
				fbCheckInStatus.Enable := TRUE;
				fbCheckIn.Execute := TRUE;
				fbCheckOut.Execute := TRUE;
				fbEndLimit.Execute := TRUE;
			
				fbCheckIn.Command := mcACPTRAK_BARRIER_CLOSE;
				fbCheckOut.Command := mcACPTRAK_BARRIER_OPEN;
				
				IF fbCheckIn.Done = TRUE AND fbCheckOut.Done = TRUE AND fbCheckInStatus.Valid = TRUE THEN
					fbCheckIn.Execute 			:= FALSE;
					fbCheckOut.Execute 			:= FALSE;
					initStep 					:= 100;
				END_IF
			
			100:
				fbSecGetShuttles.Sector 		:= ADR(SectorTrackAll);
				fbSecGetShuttles.Enable 		:= TRUE;
				fbSecGetShuttles.AdvancedParameters.StartPosition := 0.0;
				fbSecGetShuttles.AdvancedParameters.EndPosition := 0.0;
			
				IF fbSecGetShuttles.Valid = TRUE THEN
					fbCheckIn.Command							:= mcACPTRAK_BARRIER_ADD_TICKETS;
					fbCheckIn.AdvancedParameters.TicketCount 	:= fbSecGetShuttles.TotalCount;
					fbCheckIn.Execute							:= TRUE;
					
					IF fbCheckIn.Done = TRUE THEN
						fbCheckIn.Execute 		:= FALSE;
						initStep 				:= 210;						
					END_IF
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
					initStep 					:= 300;				
				END_IF
			
			300:
				IF fbCheckInStatus.BarrierInfo.RemainingTickets = 0 THEN
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
			
				fbCheckIn.Command := mcACPTRAK_BARRIER_OPEN;
				fbCheckOut.Command := mcACPTRAK_BARRIER_CLOSE;
				
				IF fbCheckIn.Done = TRUE AND fbCheckOut.Done = TRUE THEN
					fbCheckIn.Execute 			:= FALSE;
					fbCheckOut.Execute 			:= FALSE;
					fbSecGetShuttles.Enable 	:= FALSE;
					gSts.AsmState 				:= E_ASM_IDLE;
					initStep 					:= 0;
				END_IF
		END_CASE;
	END_IF
	
	fbCheckIn();
	fbCheckInStatus();
	fbCheckOut();
	fbCheckOutStatus();
	
	fbSecGetShuttles();
	
	bMoveVelActive 	:= fbMovelVel.Active;
	
	fbMovelVel();
	
	//	//SecOut 		-> Start Point of SecIn
	//	//SecIn 		-> Start Point of SecIn
	//	//Sector Main 	-> Start Point of SecMain
	//	//SectorIn		-> Start Point of SecMain
	//	//Bar Code Checking
	//	
	//	CASE initStep OF
	//		0:
	//			IF gSts.AsmState = E_ASM_INITIALIZATION THEN
	//				initStep 					:= 100;
	//			END_IF
	//			
	//		100: (* Barrier Status Setting *)
	//			fbBarBufferOut.Command			:= mcACPTRAK_BARRIER_OPEN;
	//			fbBarBufferOut.Execute 			:= TRUE;
	//			
	//			fbBarCmd.Command 				:= mcACPTRAK_BARRIER_CLOSE;
	//			fbBarCmd.Execute 				:= TRUE;
	//			
	//			
	//			
	//			IF fbBarCmd.Done = TRUE AND fbBarBufferOut.Done = TRUE THEN
	//				fbBarBufferOut.Execute 		:= FALSE;
	//				fbBarCmd.Execute 			:= FALSE;
	//				initStep 					:= 101;
	//			END_IF
	//			
	//		101:
	//			fbBarNG.Command 				:= mcACPTRAK_BARRIER_CLOSE;
	//			fbBarNG.Execute 				:= TRUE;
	//			
	//			IF fbBarNG.Done = TRUE THEN
	//				fbBarNG.Execute 			:= FALSE;
	//				initStep 					:= 110;
	//			END_IF
	//			
	//			////////////////////////////////////////////////////////////////////////////////
	//		110:
	//			fbSecGetShuttles.Sector := ADR(SecOut);
	//			fbSecGetShuttles.Enable := TRUE;
	//			fbSecGetShuttles.AdvancedParameters.StartPosition := 0.0;
	//			fbSecGetShuttles.AdvancedParameters.EndPosition := 0.0;
	//			
	//			IF fbSecGetShuttles.Valid = TRUE THEN
	//				IF fbSecGetShuttles.TotalCount > 0 THEN
	//					initStep 					:= 111;
	//				ELSE
	//					fbSecGetShuttles.Enable 	:= FALSE;
	//					initStep 					:= 120;
	//				END_IF
	//			END_IF
	//			
	//		111:
	//			fbSecGetShuttles.Next 			:= FALSE;
	//			
	//			fbMovelVel.Sector				:= ADR(SecIn);
	//			fbMovelVel.Axis 				:= ADR(fbSecGetShuttles.Axis);
	//			
	//			fbMovelVel.RouteVelocity 		:= gPar.MovementPar.Initialize.RoutedVelocity;
	//			fbMovelVel.Velocity 			:= gPar.MovementPar.Initialize.Velocity;
	//			fbMovelVel.Acceleration 		:= gPar.MovementPar.Initialize.Acceleration;
	//			fbMovelVel.Deceleration 		:= gPar.MovementPar.Initialize.Deceleration;
	//			fbMovelVel.Execute 				:= TRUE;
	//			
	//			fbMovelVel.AdvancedParameters.StartDirection 		:= mcDIR_NEGATIVE;
	//			fbMovelVel.AdvancedParameters.EndDirection 			:= mcDIR_UNDEFINED;
	//			fbMovelVel.AdvancedParameters.ShuttleOrientation 	:= mcDIR_UNDEFINED;
	//		
	//			IF bMoveVelActive = FALSE AND fbMovelVel.Active = TRUE THEN
	//				fbMovelVel.Execute 			:= FALSE;
	//				initStep 					:= 112;
	//			END_IF
	//			
	//		112:
	//			IF fbSecGetShuttles.RemainingCount > 0 THEN
	//				fbSecGetShuttles.Next 		:= TRUE;
	//				initStep 					:= 111;
	//			ELSE
	//				fbSecGetShuttles.Enable 	:= FALSE;
	//				initStep 					:= 120;				
	//			END_IF
	//			////////////////////////////////////////////////////////////////////////////////
	//		120:
	//			fbSecGetShuttles.Sector := ADR(SecIn);
	//			fbSecGetShuttles.Enable := TRUE;
	//			fbSecGetShuttles.AdvancedParameters.StartPosition := 0.0;
	//			fbSecGetShuttles.AdvancedParameters.EndPosition := 2.55;
	//			
	//			IF fbSecGetShuttles.Valid = TRUE THEN
	//				IF fbSecGetShuttles.TotalCount > 0 THEN
	//					initStep 					:= 121;
	//				ELSE
	//					fbSecGetShuttles.Enable 	:= FALSE;
	//					initStep 					:= 130;
	//				END_IF
	//			END_IF
	//			
	//		121:
	//			fbSecGetShuttles.Next 			:= FALSE;
	//			
	//			fbMovelVel.Sector				:= ADR(SecIn);
	//			fbMovelVel.Axis 				:= ADR(fbSecGetShuttles.Axis);
	//			
	//			fbMovelVel.RouteVelocity 		:= gPar.MovementPar.Initialize.RoutedVelocity;
	//			fbMovelVel.Velocity 			:= gPar.MovementPar.Initialize.Velocity;
	//			fbMovelVel.Acceleration 		:= gPar.MovementPar.Initialize.Acceleration;
	//			fbMovelVel.Deceleration 		:= gPar.MovementPar.Initialize.Deceleration;
	//			fbMovelVel.Execute 				:= TRUE;
	//			
	//			fbMovelVel.AdvancedParameters.StartDirection 		:= mcDIR_POSITIVE;
	//			fbMovelVel.AdvancedParameters.EndDirection 			:= mcDIR_UNDEFINED;
	//			fbMovelVel.AdvancedParameters.ShuttleOrientation 	:= mcDIR_UNDEFINED;
	//		
	//			IF bMoveVelActive = FALSE AND fbMovelVel.Active = TRUE THEN
	//				fbMovelVel.Execute 		:= FALSE;
	//				initStep 				:= 122;
	//			END_IF
	//			
	//		122:
	//			IF fbSecGetShuttles.RemainingCount > 0 THEN
	//				fbSecGetShuttles.Next 		:= TRUE;
	//				initStep 				:= 121;
	//			ELSE
	//				fbSecGetShuttles.Enable := FALSE;
	//				initStep 				:= 130;				
	//			END_IF
	//			////////////////////////////////////////////////////////////////////////	
	//		130:
	//			fbSecGetShuttles.Sector := ADR(SecMain);
	//			fbSecGetShuttles.Enable := TRUE;
	//			fbSecGetShuttles.AdvancedParameters.StartPosition := 0.0;
	//			fbSecGetShuttles.AdvancedParameters.EndPosition := 0.0;
	//
	//			IF fbSecGetShuttles.Valid = TRUE THEN
	//				IF fbSecGetShuttles.TotalCount > 0 THEN
	//					initStep 					:= 131;
	//				ELSE
	//					fbSecGetShuttles.Enable 	:= FALSE;
	//					initStep 					:= 140;
	//				END_IF
	//			END_IF
	//			
	//		131:
	//			fbSecGetShuttles.Next 			:= FALSE;
	//			
	//			fbMovelVel.Sector				:= ADR(SecMain);
	//			fbMovelVel.Axis 				:= ADR(fbSecGetShuttles.Axis);
	//			
	//			fbMovelVel.RouteVelocity 		:= gPar.MovementPar.Initialize.RoutedVelocity;
	//			fbMovelVel.Velocity 			:= gPar.MovementPar.Initialize.Velocity;
	//			fbMovelVel.Acceleration 		:= gPar.MovementPar.Initialize.Acceleration;
	//			fbMovelVel.Deceleration 		:= gPar.MovementPar.Initialize.Deceleration;
	//			fbMovelVel.Execute 				:= TRUE;
	//			
	//			fbMovelVel.AdvancedParameters.StartDirection 		:= mcDIR_POSITIVE;
	//			fbMovelVel.AdvancedParameters.EndDirection 			:= mcDIR_UNDEFINED;
	//			fbMovelVel.AdvancedParameters.ShuttleOrientation 	:= mcDIR_UNDEFINED;
	//		
	//			IF bMoveVelActive = FALSE AND fbMovelVel.Active = TRUE THEN
	//				fbMovelVel.Execute 			:= FALSE;
	//				initStep 					:= 132;
	//			END_IF
	//			
	//		132:
	//			IF fbSecGetShuttles.RemainingCount > 0 THEN
	//				fbSecGetShuttles.Next 		:= TRUE;
	//				initStep 					:= 131;
	//			ELSE
	//				fbSecGetShuttles.Enable 	:= FALSE;
	//				initStep 					:= 140;				
	//			END_IF
	//			////////////////////////////////////////////////////////////////////////	
	//		140:
	//			fbSecGetShuttles.Sector := ADR(SecIn);
	//			fbSecGetShuttles.Enable := TRUE;
	//			fbSecGetShuttles.AdvancedParameters.StartPosition := 2.55;
	//			fbSecGetShuttles.AdvancedParameters.EndPosition := 0.0;
	//
	//			IF fbSecGetShuttles.Valid = TRUE THEN
	//				IF fbSecGetShuttles.TotalCount > 0 THEN
	//					initStep 					:= 141;
	//				ELSE
	//					fbSecGetShuttles.Enable 	:= FALSE;
	//					initStep 					:= 150;
	//				END_IF
	//			END_IF
	//			
	//		141:
	//			fbSecGetShuttles.Next 			:= FALSE;
	//			
	//			fbMovelVel.Sector				:= ADR(SecMain);
	//			fbMovelVel.Axis 				:= ADR(fbSecGetShuttles.Axis);
	//			
	//			fbMovelVel.RouteVelocity 		:= gPar.MovementPar.Initialize.RoutedVelocity;
	//			fbMovelVel.Velocity 			:= gPar.MovementPar.Initialize.Velocity;
	//			fbMovelVel.Acceleration 		:= gPar.MovementPar.Initialize.Acceleration;
	//			fbMovelVel.Deceleration 		:= gPar.MovementPar.Initialize.Deceleration;
	//			fbMovelVel.Execute 				:= TRUE;
	//			
	//			fbMovelVel.AdvancedParameters.StartDirection 		:= mcDIR_NEGATIVE;
	//			fbMovelVel.AdvancedParameters.EndDirection 			:= mcDIR_UNDEFINED;
	//			fbMovelVel.AdvancedParameters.ShuttleOrientation 	:= mcDIR_UNDEFINED;
	//		
	//			IF bMoveVelActive = FALSE AND fbMovelVel.Active = TRUE THEN
	//				fbMovelVel.Execute 			:= FALSE;
	//				initStep 					:= 142;
	//			END_IF
	//			
	//		142:
	//			IF fbSecGetShuttles.RemainingCount > 0 THEN
	//				fbSecGetShuttles.Next 		:= TRUE;
	//				initStep 					:= 141;
	//			ELSE
	//				fbSecGetShuttles.Enable 	:= FALSE;
	//				initStep 					:= 150;				
	//			END_IF
	//			////////////////////////////////////////////////////////////////////////	
	//		150:
	//			fbSecGetShuttles.Sector := ADR(SecOut);
	//			fbSecGetShuttles.Enable := TRUE;
	//			fbSecGetShuttles.AdvancedParameters.StartPosition := 0.0;
	//			fbSecGetShuttles.AdvancedParameters.EndPosition := 1.13;
	//			
	//			IF fbSecGetShuttles.Valid = TRUE THEN
	//				IF fbSecGetShuttles.TotalCount > 0 THEN
	//					fbSecGetShuttles.Enable 	:= FALSE;
	//					initStep 					:= 150;
	//				ELSE
	//					fbSecGetShuttles.Enable 	:= FALSE;
	//					initStep 					:= 160;
	//				END_IF
	//			END_IF
	//			////////////////////////////////////////////////////////////////////////	
	//		160:
	//			fbSecGetShuttles.Sector := ADR(SecIn);
	//			fbSecGetShuttles.Enable := TRUE;
	//			fbSecGetShuttles.AdvancedParameters.StartPosition := 0.0;
	//			fbSecGetShuttles.AdvancedParameters.EndPosition := 0.0;
	//
	//			IF fbSecGetShuttles.Valid = TRUE THEN
	//				IF fbSecGetShuttles.TotalCount > 0 THEN
	//					initStep 					:= 161;
	//				ELSE
	//					fbSecGetShuttles.Enable 	:= FALSE;
	//					initStep 					:= 170;
	//				END_IF
	//			END_IF
	//			
	//		161:
	//			fbSecGetShuttles.Next 			:= FALSE;
	//			
	//			fbMovelVel.Sector				:= ADR(SecMain);
	//			fbMovelVel.Axis 				:= ADR(fbSecGetShuttles.Axis);
	//			
	//			fbMovelVel.RouteVelocity 		:= gPar.MovementPar.Initialize.RoutedVelocity;
	//			fbMovelVel.Velocity 			:= gPar.MovementPar.Initialize.Velocity;
	//			fbMovelVel.Acceleration 		:= gPar.MovementPar.Initialize.Acceleration;
	//			fbMovelVel.Deceleration 		:= gPar.MovementPar.Initialize.Deceleration;
	//			fbMovelVel.Execute 				:= TRUE;
	//			
	//			fbMovelVel.AdvancedParameters.StartDirection 		:= mcDIR_NEGATIVE;
	//			fbMovelVel.AdvancedParameters.EndDirection 			:= mcDIR_POSITIVE;
	//			fbMovelVel.AdvancedParameters.ShuttleOrientation 	:= mcDIR_UNDEFINED;
	//		
	//			IF bMoveVelActive = FALSE AND fbMovelVel.Active = TRUE THEN
	//				fbMovelVel.Execute 			:= FALSE;
	//				initStep 					:= 162;
	//			END_IF
	//			
	//		162:
	//			IF fbSecGetShuttles.RemainingCount > 0 THEN
	//				fbSecGetShuttles.Next 		:= TRUE;
	//				initStep 					:= 161;
	//			ELSE
	//				fbSecGetShuttles.Enable 	:= FALSE;
	//				initStep 					:= 170;
	//			END_IF
	//			
	//		170:
	//			fbBarGetShuttle.ProcessPoint 	:= ADR(ptBufferIn);
	////			fbBarGetShuttle.Enable 			:= TRUE;
	//			fbBarGetShuttle;
	//			
	//		200:
	//			fbBarBufferOut.Command			:= mcACPTRAK_BARRIER_OPEN;
	//			fbBarBufferOut.Execute 			:= TRUE;
	//			
	//			fbBarCmd.Command 				:= mcACPTRAK_BARRIER_OPEN;
	//			fbBarCmd.Execute 				:= TRUE;
	//			
	//			IF fbBarCmd.Done = TRUE AND fbBarBufferOut.Done = TRUE THEN
	//				fbBarBufferOut.Execute 		:= FALSE;
	//				fbBarCmd.Execute 			:= FALSE;
	//				initStep 					:= 300;
	//			END_IF
	//			
	//		300:
	//			gSts.AsmState 					:= E_ASM_IDLE;
	//			initStep 						:= 0;
	//		
	//	END_CASE;
	
	//	fbBarNG();
	//	fbBarCmd();
	//	fbBarBufferOut();
	//	fbSecGetShuttles();
	//	
	//	bMoveVelActive := fbMovelVel.Active;
	//	
	//	fbMovelVel();
END_PROGRAM
