
PROGRAM _INIT
	
	fbCheckIn.ProcessPoint			:= ADR(ptCheckIn);
	fbCheckInStatus.ProcessPoint 	:= ADR(ptCheckIn);
	fbCheckInTrg.ProcessPoint		:= ADR(ptCheckIn);
	fbCheckInTrgInfo.ProcessPoint	:= ADR(ptCheckIn);
	 
	fbCheckOutStatus.ProcessPoint	:= ADR(ptCheckOut);
	fbCheckOut.ProcessPoint			:= ADR(ptCheckOut);
	
END_PROGRAM

PROGRAM _CYCLIC
	
	IF gSts.AsmState <> E_ASM_CLEAN THEN
		initStep					:= 0;
		
		fbSecGetShuttles.Enable		:= FALSE;
		fbCheckInTrgInfo.Execute	:= FALSE;
		fbCheckIn.Execute			:= FALSE;
		fbCheckInStatus.Enable		:= FALSE;
		
		fbMoveAbs.Execute				:= FALSE;
		fbMovelVel.Execute 				:= FALSE;
		
		TotalShuttleCount				:= 0;
	ELSE
		
		CASE initStep OF
			0:
				fbCheckInStatus.Enable	:= TRUE;
				fbCheckIn.Execute 		:= TRUE;
				fbCheckOut.Execute 		:= TRUE;
				
				fbCheckIn.Command 		:= mcACPTRAK_BARRIER_OPEN;
				fbCheckOut.Command 		:= mcACPTRAK_BARRIER_OPEN;
				
				IF fbCheckIn.Done AND fbCheckInStatus.Valid THEN
					fbCheckIn.Execute 	:= FALSE;
					fbCheckOut.Execute 	:= FALSE;
					initStep			:= 10;
				END_IF
			
			10:
				fbSecGetShuttles.Sector := ADR(SectorTrackAll);
				fbSecGetShuttles.Enable := TRUE;
				fbSecGetShuttles.AdvancedParameters.StartPosition	:= 0.0;
				fbSecGetShuttles.AdvancedParameters.EndPosition		:= 0.0;
			
				IF fbSecGetShuttles.Valid = TRUE THEN	
					TotalShuttleCount 	:= fbSecGetShuttles.TotalCount;
					initStep 			:= 20;						
				END_IF

			20:
				fbSecGetShuttles.Next 			:= FALSE;
						
				fbMovelVel.Sector				:= ADR(SectorTrackAll);
				fbMovelVel.Axis 				:= ADR(fbSecGetShuttles.Axis);
				
				fbMovelVel.Position				:= 12.48;
				fbMovelVel.RouteVelocity 		:= 1.0;
				fbMovelVel.Velocity 			:= 1.0;
				fbMovelVel.Acceleration 		:= 1.0;
				fbMovelVel.Deceleration 		:= 1.0;
				fbMovelVel.Execute 				:= TRUE;
						
				fbMovelVel.AdvancedParameters.StartDirection 		:= mcDIR_POSITIVE;
				fbMovelVel.AdvancedParameters.EndDirection 			:= mcDIR_UNDEFINED;
				fbMovelVel.AdvancedParameters.ShuttleOrientation 	:= mcDIR_UNDEFINED;
			
				IF bMoveVelActive = FALSE AND fbMovelVel.Active = TRUE THEN
					fbMovelVel.Execute 			:= FALSE;
					initStep 					:= 30;
				END_IF
			
			30:
				IF fbSecGetShuttles.RemainingCount > 0 THEN
					fbSecGetShuttles.Next 		:= TRUE;
					initStep 					:= 20;
				ELSE
					fbSecGetShuttles.Enable 	:= FALSE;
			//		initStep 					:= 40;				
				END_IF
			
			40:
				IF fbCheckInStatus.BarrierInfo.RemainingTickets = 0 THEN
					initStep 					:= 50;					
				END_IF
				
			50:
				fbSecGetShuttles.Sector 		:= ADR(SectorTrackAll);
				fbSecGetShuttles.Enable 		:= TRUE;
				fbSecGetShuttles.AdvancedParameters.StartPosition 	:= 13.14;//12.48; // Check in point
				fbSecGetShuttles.AdvancedParameters.EndPosition 	:= 0.0;
				
				IF fbSecGetShuttles.Valid = TRUE AND fbSecGetShuttles.TotalCount = 0 THEN
					fbSecGetShuttles.Enable 		:= FALSE;
					initStep 						:= 60;
				ELSIF  fbSecGetShuttles.Valid = TRUE AND fbSecGetShuttles.TotalCount > 0 THEN
					fbSecGetShuttles.Enable 		:= FALSE;
				END_IF
			
			60:
				fbCheckInStatus.Enable := FALSE;
				fbCheckIn.Execute := TRUE;
				fbCheckOut.Execute := TRUE;
			
				fbCheckIn.Command := mcACPTRAK_BARRIER_OPEN;
				fbCheckOut.Command := mcACPTRAK_BARRIER_OPEN;
				
				IF fbCheckIn.Done = TRUE AND fbCheckOut.Done = TRUE THEN
					fbCheckIn.Execute 			:= FALSE;
					fbCheckOut.Execute 			:= FALSE;
					fbSecGetShuttles.Enable 	:= FALSE;
					gSts.AsmState 				:= E_ASM_IDLE;
					initStep 					:= 0;
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
//	fbUserData();
	
	fbMoveAbs();
	bMoveVelActive 	:= fbMovelVel.Active;
	fbMovelVel();	
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

