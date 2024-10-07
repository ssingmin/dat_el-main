(**)

TYPE
	E_ASM_STATUS : 
		(
		E_ASM_UNKNOWN := 0,
		E_ASM_OFF := 1,
		E_ASM_ON := 2,
		E_ASM_IDLE := 3,
		E_ASM_PROCESS := 4,
		E_ASM_ERRORSTOP := 5,
		E_ASM_MANUAL := 6,
		E_ASM_POWER_ON := 10,
		E_ASM_POWER_OFF := 20,
		E_ASM_INITIALIZATION := 30,
		E_ASM_RECOVERY := 31,
		E_ASM_RESET := 40,
		E_ASM_STOPPING := 50,
		E_ASM_EMS := 60,
		E_ASM_CLEAN := 70
		);
	E_PROCESS_STATUS : 
		(
		E_PROCESS_None,
		E_PROCESS_Stage1,
		E_PROCESS_Stage2,
		E_PROCESS_Stage3,
		E_PROCESS_Stage4,
		E_PROCESS_Stage5,
		E_PROCESS_Stage6,
		E_PROCESS_Stage7,
		E_PROCESS_Stage8,
		E_PROCESS_Stage9,
		E_PROCESS_Stage10,
		E_PROCESS_Stage11,
		E_PROCESS_Stage12,
		E_PROCESS_Stage13,
		E_PROCESS_Stage14,
		E_PROCESS_Stage15,
		E_PROCESS_Stage16,
		E_PROCESS_Stage17,
		E_PROCESS_Stage18,
		E_PROCESS_Stage19
		);
END_TYPE

(**)

TYPE
	ShuttleUserData_typ : 	STRUCT 
		SerialNumber : STRING[19]; (*Shuttle Number*)
		ProcessStatus : E_PROCESS_STATUS;
		Data : ARRAY[0..19]OF UINT;
	END_STRUCT;
END_TYPE

(**)

TYPE
	Command_type : 	STRUCT 
		PowerOn : BOOL;
		PowerOff : BOOL;
		Initialize : BOOL;
		EMS : BOOL;
		Start : BOOL;
		Stop : BOOL;
		Reset : BOOL;
		ErrorReset : BOOL;
		Clean : BOOL;
	END_STRUCT;
	Parameter_type : 	STRUCT 
		MovementPar : MovementParameter_type;
		PositionOffset : PosOffsetParameter_type;
		ProcessPosition : PositionParameter_type;
		TargetPPM : UINT := 30;
		CountOfGroup : USINT := 6;
	END_STRUCT;
	Status_type : 	STRUCT 
		AsmState : E_ASM_STATUS;
	END_STRUCT;
END_TYPE

(**)

TYPE
	MovementParameter_type : 	STRUCT 
		Initialize : SerializeParType;
		Stage1 : ServeStageParType;
		Stage2 : TransferStageParType;
		Stage3 : TransferStageParType;
		Stage4 : TransferStageParType;
		Stage5 : TransferStageParType;
		Stage6 : TransferStageParType;
		Stage7 : TransferStageParType;
		Stage8 : TransferStageParType;
		Stage9 : TransferStageParType;
		Stage10 : TransferStageParType;
		Stage11 : TransferStageParType;
		Stage12 : TransferStageParType;
		Stage13 : TransferStageParType;
		Stage14 : TransferStageParType;
		Stage15 : TransferStageParType;
		Stage16 : TransferStageParType;
		Stage17 : TransferStageParType;
		Stage18 : TransferStageParType;
		Stage19 : TransferStageParType;
		Return : SerializeParType;
	END_STRUCT;
	PositionParameter_type : 	STRUCT 
		Stage : ARRAY[0..18]OF LREAL;
	END_STRUCT;
	PosOffsetParameter_type : 	STRUCT 
		Stage : ARRAY[0..18]OF LREAL;
	END_STRUCT;
END_TYPE

(**)

TYPE
	ServeStageParType : 	STRUCT 
		Velocity : REAL;
		Acceleration : REAL;
		Deceleration : REAL;
		MaxController : USINT;
	END_STRUCT;
	TransferStageParType : 	STRUCT 
		Velocity : REAL;
		Acceleration : REAL;
		Deceleration : REAL;
		MaxController : USINT;
	END_STRUCT;
	SerializeParType : 	STRUCT 
		RoutedVelocity : REAL;
		Velocity : REAL;
		Acceleration : REAL;
		Deceleration : REAL;
	END_STRUCT;
END_TYPE

(**)
