
PROGRAM _INIT
	elasticAbsMove.Velocity 		:= 0.5;
	elasticAbsMove.Acceleration 	:= 1.0;
	elasticAbsMove.Deceleration 	:= 1.0;
	
	
END_PROGRAM

PROGRAM _CYCLIC
	r_trgExecute(CLK := execute);
	r_trgApply(CLK := apply);
	
	CASE step OF
		0:	(*Manual IDLE*)
			IF selectedStage <> E_STAGE_NONE THEN
				IF selectedStage = E_STAGE_STAGE1 AND StStage[0].Shuttle.controlif <> 0 THEN
					elasticAbsMove.Axis 	:= ADR(StStage[0].Shuttle);
					position				:= (gPar.ProcessPosition.Stage[0]);
					position_max			:= POS_STAGE1_MAX;
					position_min			:= POS_STAGE1_MIN;
				ELSIF selectedStage = E_STAGE_STAGE2	AND StStage[1].Shuttle.controlif <> 0 THEN
					elasticAbsMove.Axis 	:= ADR(StStage[1].Shuttle);
					position				:= (gPar.ProcessPosition.Stage[1]);
					position_max			:= POS_STAGE2_MAX;
					position_min			:= POS_STAGE2_MAX;
				ELSIF selectedStage = E_STAGE_STAGE3	AND StStage[2].Shuttle.controlif <> 0 THEN
					elasticAbsMove.Axis 	:= ADR(StStage[2].Shuttle);
					position				:= (gPar.ProcessPosition.Stage[2]);
					position_max			:= POS_STAGE3_MAX;
					position_min			:= POS_STAGE3_MAX;
				ELSIF selectedStage = E_STAGE_STAGE4	AND StStage[3].Shuttle.controlif <> 0 THEN
					elasticAbsMove.Axis 	:= ADR(StStage[3].Shuttle);
					position				:= (gPar.ProcessPosition.Stage[3]);
					position_max			:= POS_STAGE4_MAX;
					position_min			:= POS_STAGE4_MAX;
				ELSIF selectedStage = E_STAGE_STAGE5	AND StStage[4].Shuttle.controlif <> 0 THEN
					elasticAbsMove.Axis 	:= ADR(StStage[4].Shuttle);
					position				:= (gPar.ProcessPosition.Stage[4]);
					position_max			:= POS_STAGE5_MAX;
					position_min			:= POS_STAGE5_MAX;
				ELSIF selectedStage = E_STAGE_STAGE6	AND StStage[5].Shuttle.controlif <> 0 THEN
					elasticAbsMove.Axis 	:= ADR(StStage[5].Shuttle);
					position				:= (gPar.ProcessPosition.Stage[5]);
					position_max			:= POS_STAGE6_MAX;
					position_min			:= POS_STAGE6_MAX;
				ELSIF selectedStage = E_STAGE_STAGE7	AND StStage[6].Shuttle.controlif <> 0 THEN
					elasticAbsMove.Axis 	:= ADR(StStage[6].Shuttle);
					position				:= (gPar.ProcessPosition.Stage[6]);
					position_max			:= POS_STAGE7_MAX;
					position_min			:= POS_STAGE7_MAX;
				ELSIF selectedStage = E_STAGE_STAGE8	AND StStage[7].Shuttle.controlif <> 0 THEN
					elasticAbsMove.Axis 	:= ADR(StStage[7].Shuttle);
					position				:= (gPar.ProcessPosition.Stage[7]);
					position_max			:= POS_STAGE8_MAX;
					position_min			:= POS_STAGE8_MAX;
				ELSIF selectedStage = E_STAGE_STAGE9	AND StStage[8].Shuttle.controlif <> 0 THEN
					elasticAbsMove.Axis 	:= ADR(StStage[8].Shuttle);
					position				:= (gPar.ProcessPosition.Stage[8]);
					position_max			:= POS_STAGE9_MAX;
					position_min			:= POS_STAGE9_MAX;
				ELSIF selectedStage = E_STAGE_STAGE10	AND StStage[9].Shuttle.controlif <> 0 THEN
					elasticAbsMove.Axis 	:= ADR(StStage[9].Shuttle);
					position				:= (gPar.ProcessPosition.Stage[9]);
					position_max			:= POS_STAGE10_MAX;
					position_min			:= POS_STAGE10_MAX;
				ELSIF selectedStage = E_STAGE_STAGE11	AND StStage[10].Shuttle.controlif <> 0 THEN
					elasticAbsMove.Axis 	:= ADR(StStage[10].Shuttle);
					position				:= (gPar.ProcessPosition.Stage[10]);
					position_max			:= POS_STAGE11_MAX;
					position_min			:= POS_STAGE11_MAX;
				ELSIF selectedStage = E_STAGE_STAGE12	AND StStage[11].Shuttle.controlif <> 0 THEN
					elasticAbsMove.Axis 	:= ADR(StStage[11].Shuttle);
					position				:= (gPar.ProcessPosition.Stage[11]);
					position_max			:= POS_STAGE12_MAX;
					position_min			:= POS_STAGE12_MAX;
				ELSIF selectedStage = E_STAGE_STAGE13	AND StStage[12].Shuttle.controlif <> 0 THEN
					elasticAbsMove.Axis 	:= ADR(StStage[12].Shuttle);
					position				:= (gPar.ProcessPosition.Stage[12]);
					position_max			:= POS_STAGE13_MAX;
					position_min			:= POS_STAGE13_MAX;
				ELSIF selectedStage = E_STAGE_STAGE14	AND StStage[13].Shuttle.controlif <> 0 THEN
					elasticAbsMove.Axis 	:= ADR(StStage[13].Shuttle);
					position				:= (gPar.ProcessPosition.Stage[13]);
					position_max			:= POS_STAGE14_MAX;
					position_min			:= POS_STAGE14_MAX;
				ELSIF selectedStage = E_STAGE_STAGE15	AND StStage[14].Shuttle.controlif <> 0 THEN
					elasticAbsMove.Axis 	:= ADR(StStage[14].Shuttle);
					position				:= (gPar.ProcessPosition.Stage[14]);
					position_max			:= POS_STAGE15_MAX;
					position_min			:= POS_STAGE15_MAX;
				ELSIF selectedStage = E_STAGE_STAGE16	AND StStage[15].Shuttle.controlif <> 0 THEN
					elasticAbsMove.Axis 	:= ADR(StStage[15].Shuttle);
					position				:= (gPar.ProcessPosition.Stage[15]);
					position_max			:= POS_STAGE16_MAX;
					position_min			:= POS_STAGE16_MAX;
				ELSIF selectedStage = E_STAGE_STAGE17	AND StStage[16].Shuttle.controlif <> 0 THEN
					elasticAbsMove.Axis 	:= ADR(StStage[16].Shuttle);
					position				:= (gPar.ProcessPosition.Stage[16]);
					position_max			:= POS_STAGE17_MAX;
					position_min			:= POS_STAGE17_MAX;
				ELSIF selectedStage = E_STAGE_STAGE18	AND StStage[17].Shuttle.controlif <> 0 THEN
					elasticAbsMove.Axis 	:= ADR(StStage[17].Shuttle);
					position				:= (gPar.ProcessPosition.Stage[17]);
					position_max			:= POS_STAGE18_MAX;
					position_min			:= POS_STAGE18_MAX;
				ELSIF selectedStage = E_STAGE_STAGE19	AND StStage[18].Shuttle.controlif <> 0 THEN
					elasticAbsMove.Axis 	:= ADR(StStage[18].Shuttle);
					position				:= (gPar.ProcessPosition.Stage[18]);
					position_max			:= POS_STAGE19_MAX;
					position_min			:= POS_STAGE19_MAX;
				END_IF
				
				openDialog				:= TRUE;
				step 					:= 100;
			END_IF
			
		100: (*Manual RUN*)
			IF r_trgExecute.Q = TRUE THEN
				elasticAbsMove.Position := position;
				elasticAbsMove.Execute	:= TRUE;
				step 					:= 110;
			ELSIF r_trgApply.Q = TRUE THEN
				IF selectedStage = E_STAGE_STAGE1 THEN
					gPar.ProcessPosition.Stage[0] := position;
				ELSIF selectedStage = E_STAGE_STAGE2 THEN
					gPar.ProcessPosition.Stage[1] := position;
				ELSIF selectedStage = E_STAGE_STAGE3 THEN
					gPar.ProcessPosition.Stage[2] := position;
				ELSIF selectedStage = E_STAGE_STAGE4 THEN
					gPar.ProcessPosition.Stage[3] := position;
				ELSIF selectedStage = E_STAGE_STAGE5 THEN
					gPar.ProcessPosition.Stage[4] := position;
				ELSIF selectedStage = E_STAGE_STAGE6 THEN
					gPar.ProcessPosition.Stage[5] := position;
				ELSIF selectedStage = E_STAGE_STAGE7 THEN
					gPar.ProcessPosition.Stage[6] := position;
				ELSIF selectedStage = E_STAGE_STAGE8 THEN
					gPar.ProcessPosition.Stage[7] := position;
				ELSIF selectedStage = E_STAGE_STAGE9 THEN
					gPar.ProcessPosition.Stage[8] := position;
				ELSIF selectedStage = E_STAGE_STAGE10 THEN
					gPar.ProcessPosition.Stage[9] := position;
				ELSIF selectedStage = E_STAGE_STAGE11 THEN
					gPar.ProcessPosition.Stage[10] := position;
				ELSIF selectedStage = E_STAGE_STAGE12 THEN
					gPar.ProcessPosition.Stage[11] := position;
				ELSIF selectedStage = E_STAGE_STAGE13 THEN
					gPar.ProcessPosition.Stage[12] := position;
				ELSIF selectedStage = E_STAGE_STAGE14 THEN
					gPar.ProcessPosition.Stage[13] := position;
				ELSIF selectedStage = E_STAGE_STAGE15 THEN
					gPar.ProcessPosition.Stage[14] := position;
				ELSIF selectedStage = E_STAGE_STAGE16 THEN
					gPar.ProcessPosition.Stage[15] := position;
				ELSIF selectedStage = E_STAGE_STAGE17 THEN
					gPar.ProcessPosition.Stage[16] := position;
				ELSIF selectedStage = E_STAGE_STAGE18 THEN
					gPar.ProcessPosition.Stage[17] := position;
				ELSIF selectedStage = E_STAGE_STAGE19 THEN
					gPar.ProcessPosition.Stage[18] := position;
				END_IF
				
				elasticAbsMove.Axis 	:= 0;
				step 					:= 0;
				openDialog				:= FALSE;
				elasticAbsMove.Execute 	:= FALSE;				
				selectedStage 			:= E_STAGE_NONE;
			ELSIF selectedStage = E_STAGE_NONE THEN 
				elasticAbsMove.Axis 	:= 0;
				step 					:= 0;
				openDialog				:= FALSE;
				elasticAbsMove.Execute 	:= FALSE;
			END_IF
		
		110:
			IF elasticAbsMove.Done = TRUE THEN
				elasticAbsMove.Execute	:= FALSE;
				step := 100;
			ELSIF elasticAbsMove.Error = TRUE THEN
				elasticAbsMove.Execute	:= FALSE;
				step := 100;
			END_IF
		
	END_CASE;
	
	elasticAbsMove();
	
	execute 	:= FALSE;
	apply 		:= FALSE;
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

