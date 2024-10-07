
PROGRAM _INIT
	
	MpAxis[AXIS_MAIN].MpLink		:= ADR(gAxisMain);
	MpAxis[AXIS_MAIN].Parameters	:= ADR(MpAxisPar[AXIS_MAIN]);
	MpAxis[AXIS_MAIN].Enable		:= TRUE;
	
	MpAxis[AXIS01].MpLink			:= ADR(gAxis01);
	MpAxis[AXIS01].Parameters		:= ADR(MpAxisPar[AXIS01]);
	MpAxis[AXIS01].Enable			:= TRUE;
	
	MpAxis[AXIS02].MpLink			:= ADR(gAxis02);
	MpAxis[AXIS02].Parameters		:= ADR(MpAxisPar[AXIS02]);
	MpAxis[AXIS02].Enable			:= TRUE;
	
	MpAxis[AXIS03].MpLink			:= ADR(gAxis03);
	MpAxis[AXIS03].Parameters		:= ADR(MpAxisPar[AXIS03]);
	MpAxis[AXIS03].Enable			:= TRUE;
	
	MpAxis[AXIS04].MpLink			:= ADR(gAxis04);
	MpAxis[AXIS04].Parameters		:= ADR(MpAxisPar[AXIS04]);
	MpAxis[AXIS04].Enable			:= TRUE;
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	FOR i := 0 TO AXIS04 DO
		MpAxis[i]();
	END_FOR;
	
	IF MpAxis[AXIS_MAIN].Info.ReadyToPowerOn THEN
		MpAxis[AXIS_MAIN].Power	:= TRUE;
	END_IF
	
END_PROGRAM

PROGRAM _EXIT
	
	FOR i := 0 TO AXIS04 DO
		MpAxis[i].Enable	:= FALSE;
	END_FOR;
	 
END_PROGRAM

