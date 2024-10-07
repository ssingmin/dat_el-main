

PROGRAM _INIT
	fbPowerOff.Assembly := ADR(gAsmMain);
	fbPowerOn.Assembly := ADR(gAsmMain);	
	fbAddShuttle.Sector := ADR(SectorTrackAll);
	
	FOR loop := 1 TO COUNT_OF_SIM_SHUTTLE BY 1 DO
		shuttlePosition[loop] :=  6.6 + (COUNT_OF_SIM_SHUTTLE * GAP_BETWEEN_OF_SHUTTLE) + ((loop - 1) * GAP_BETWEEN_OF_SHUTTLE);
	END_FOR;
	
	loop := 1;
END_PROGRAM

PROGRAM _CYCLIC
	CASE step OF
		SIM_POWER_ON:
			fbPowerOn.Execute 		:= TRUE;
			
			IF fbPowerOn.Done = TRUE THEN
				fbPowerOn.Execute 	:= FALSE;
				step 				:= SIM_ADD_SHUTTLE;
			END_IF
			
			fbPowerOn();
			
		SIM_ADD_SHUTTLE:
			fbAddShuttle.Position 	:= shuttlePosition[loop];
			fbAddShuttle.Execute 	:= TRUE;
			
			IF fbAddShuttle.Done = TRUE THEN
				fbAddShuttle.Execute:= FALSE;
				
				IF loop < COUNT_OF_SIM_SHUTTLE THEN
					loop			:= loop + 1;
				ELSE
					step 			:= SIM_POWER_OFF;
				END_IF
			END_IF
			
			fbAddShuttle();

			
		SIM_POWER_OFF:
			fbPowerOff.Execute 		:= TRUE;
			
			IF fbPowerOff.Done = TRUE THEN
				fbPowerOff.Execute 	:= FALSE;
				step 				:= SIM_INIT_END;
			END_IF
			
			fbPowerOff();
		
		300:
			
	END_CASE;
END_PROGRAM


