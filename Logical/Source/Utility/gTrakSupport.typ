(*interface TrakDesign shuttle online interaction*)

TYPE
	TrakDesignShuttleOnlineType : 	STRUCT 
		CmdSetPayloadIx : BOOL; (*command to set a payload index for a shuttle*)
		CmdAddShuttle : BOOL; (*command indicating that a shuttle has been added to the trak*)
		CmdDeleteShuttle : BOOL; (*command indicating that a shuttle has been deleted from the trak*)
		CmdRecordToolData : BOOL; (*command activate recording of TrakDesign-Tool data*)
		ParaPayloadIx : USINT; (*parameter to select a payload with this index for a shuttle*)
		ParaShuttleID : UINT; (*parameter for identification of a shuttle using its ID
can be used for CmdSetPayloadIx and CmdDeleteShuttle*)
		ParaShuttleAxis : McAxisType; (*parameter for identification of a shuttle using its Axis (McAxisType)
can be used for CmdSetPayloadIx and CmdDeleteShuttle
mandatory for CmdAddShuttle*)
		Done : BOOL; (*status command done
flag is set for one cycle only*)
		TimeRecordToolDataActive : REAL; (*monitor time recording of TrakDesign-Tool data active*)
	END_STRUCT;
END_TYPE

(*internal: process-ParID read/write*)

TYPE
	TrakSegParIDProcessDataType : 	STRUCT 
		Num : USINT; (*number of ParID's in this list to read/write at once*)
		Fub : ARRAY[0..19]OF McAcpTrakSegProcessParIDType; (*ParID list for FUB MC_BR_SegProcessParID_AcpTrak*)
		VarREAL : ARRAY[0..19]OF REAL; (*temporary REAL variable*)
		VarDINT : ARRAY[0..19]OF DINT; (*temporary DINT variable*)
	END_STRUCT;
END_TYPE
