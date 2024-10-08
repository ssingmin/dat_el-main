
PROGRAM _INIT
	fbAudit.MpLink := ADR(gAuditTrak);
	fbAudit.Enable := TRUE;
	fbAudit.DeviceName := ADR('Log');
	 
END_PROGRAM

PROGRAM _CYCLIC
	fbAudit();
	
	IF (fbAudit.Export) AND (fbAudit.CommandDone) THEN
		fbAudit.Export := FALSE;
	END_IF
END_PROGRAM

PROGRAM _EXIT
	fbAudit(Enable := FALSE);
	 
END_PROGRAM

