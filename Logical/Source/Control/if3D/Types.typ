
TYPE
	STEP_3DSensor : 
		(
		STEP_WAIT := 0,
		STEP_IDLE := 1,
		STEP_GETSH := 2,
		STEP_PRERUN := 3,
		STEP_END := 4
		);
	TimingMeasurement_type : 	STRUCT 
		NextShuttle : MyTime_TimeCheck;
		ProcessingTime : MyTime_TimeCheck;
		MovementTime : MyTime_TimeCheck;
	END_STRUCT;
END_TYPE
