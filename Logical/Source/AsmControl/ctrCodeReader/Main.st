
PROGRAM _INIT
	(* Insert code here *)
	
	fbTrig.ProcessPoint			:= ADR(ptVision);
	fbTrigInfo.ProcessPoint		:= ADR(ptVision);
	
	ShReadInfo.Axis 	:= ADR(Axis);
	
	fbUserData.Axis	:= ADR(fbTrigInfo.TrgPointInfo);
	
	fbTrig();
	fbTrigInfo();
	fbUserData();
	ShReadInfo();
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	
	gBarCodeReader.Enable 		:= TRUE;
	
	CASE gSts.AsmState OF
		
		E_ASM_INITIALIZATION:
			
			IF NOT gSim THEN
				gInitialDone		:= FALSE;
			END_IF
			
			actCodeReader;

		E_ASM_IDLE:
			
			actCodeReader;
			
		ELSE
			actCodeReader_INIT;
			
	END_CASE
	 
	fbTrig();
	fbTrigInfo();
	fbUserData();
	ShReadInfo();
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

