(*local structures*)

TYPE
	SegCurrType : 	STRUCT 
		Coil : ARRAY[1..44]OF SegCurrCoilType;
	END_STRUCT;
	SegCurrCoilType : 	STRUCT 
		ShuttleIx : USINT;
		Prio : USINT;
		Current : REAL;
	END_STRUCT;
	DualTrakSegType : 	STRUCT 
		Ix : UINT;
		Type : TrakDesignSegmentTypeEnum;
		Len : LREAL;
		Pos : LREAL;
		DistGap : LREAL;
	END_STRUCT;
END_TYPE

(**)
(*enum*)

TYPE
	StepEnum : 
		(
		TRAK_COMMAND := 0,
		TRAK_FILE_PREPARE,
		TRAK_FILE_DELETE,
		TRAK_FILE_CREATE,
		TRAK_FILE_OPEN,
		TRAK_PREPARE_HEADER,
		TRAK_PREPARE_DATA,
		TRAK_FILE_BUFFER,
		TRAK_FILE_READ,
		TRAK_FILE_WRITE,
		TRAK_FILE_CLOSE,
		TRAK_FILE_CLOSE_2,
		TRAK_FILE_COPY_HISTORY,
		TRAK_FILE_CLOSE_ERROR,
		TRAK_MESSAGE_DELAY
		);
END_TYPE

(**)
(*datatyp fo the mechanical simulation*)

TYPE
	System_matrix_typ : 	STRUCT 
		column1 : ARRAY[0..5]OF LREAL;
		column2 : ARRAY[0..5]OF LREAL;
		column3 : ARRAY[0..5]OF LREAL;
		column4 : ARRAY[0..5]OF LREAL;
		column5 : ARRAY[0..5]OF LREAL;
		column6 : ARRAY[0..5]OF LREAL;
		column7 : ARRAY[0..5]OF LREAL;
	END_STRUCT;
	Solution_typ : 	STRUCT 
		xFj_0 : ARRAY[0..5]OF LREAL;
	END_STRUCT;
	Vec_typ : 	STRUCT 
		x : LREAL;
		y : LREAL;
		z : LREAL;
	END_STRUCT;
	Frame_orientation_typ : 	STRUCT 
		phi : LREAL;
		theta : LREAL;
		psi : LREAL;
	END_STRUCT;
	SegmentSelectionData_typ : 	STRUCT 
		SegmentPosition : LREAL;
		SegmentFieldMode : LREAL;
		SegmentLength : LREAL;
		SegmentID : UINT;
		SegmentTyp : TrakDesignSegmentTypeEnum;
	END_STRUCT;
END_TYPE
