
TYPE
	Com_Equip_Side_type : 	STRUCT 
		Interlock : BOOL;
		Ready : BOOL;
		Done : BOOL;
		Data : ARRAY[0..8]OF UINT; (*UINT[0..8]*)
		Data2 : ARRAY[0..19]OF UINT;
	END_STRUCT;
	Com_Trak_Side_type : 	STRUCT 
		ShuttleArrived : BOOL;
		Data : ARRAY[0..8]OF UINT;
		ShuttleID : REFERENCE TO STRING[11];
		Data2 : ARRAY[0..19]OF UINT;
	END_STRUCT;
	Interface_Process : 	STRUCT 
		Equipment : Com_Equip_Side_type;
		Trak : Com_Trak_Side_type;
	END_STRUCT;
	Interface_Process_1Sh : 	STRUCT 
		Equipment : Com_Equip_Side_1Sh_type;
		Trak : Com_Trak_Side_1Sh_type;
	END_STRUCT;
	Com_Equip_Side_1Sh_type : 	STRUCT 
		Interlock : BOOL;
		Ready : BOOL;
		Busy : BOOL; (*Delete After Modify All*)
		Done : BOOL;
		Data : ARRAY[0..8]OF UINT; (*UINT[0..8]*)
		Data2 : ARRAY[0..19]OF UINT;
	END_STRUCT;
	Com_Trak_Side_1Sh_type : 	STRUCT 
		ProcessReq : BOOL; (*Delete After Modify All*)
		ProcessDone : BOOL; (*Delete After Modify All*)
		ShuttleArrived : BOOL;
		Data : ARRAY[0..8]OF UINT; (*UINT[0..8]*)
		Data2 : ARRAY[0..19]OF UINT;
		ShuttleID : REFERENCE TO STRING[11];
	END_STRUCT;
END_TYPE
