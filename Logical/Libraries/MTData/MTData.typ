
TYPE
	MTDataStdDeviationInternalType : 	STRUCT  (*Internal variables of function block MTDataStdDeviation.*)
		CycleTime : REAL; (*Task cycle time. Unit: [s].*)
		Mean : LREAL; (*Sum of input values.*)
		Mean2 : LREAL; (*Sum of the square of the input values.*)
		NumberOfValues : UDINT; (*Number of values for output calculation.*)
		EnableOld : BOOL; (*Data for internal use.*)
		ResetOld : BOOL; (*Data for internal use.*)
		Hold : BOOL; (*As long as Hold = TRUE, the output is holding the actual value.*)
	END_STRUCT;
	MTDataVarianceInternalType : 	STRUCT  (*Internal variables of function block MTDataVariance.*)
		CycleTime : REAL; (*Task cycle time. Unit: [s].*)
		Mean : LREAL; (*Sum of input values.*)
		Mean2 : LREAL; (*Sum of the square of the input values.*)
		NumberOfValues : UDINT; (*Number of values for output calculation.*)
		EnableOld : BOOL; (*Data for internal use.*)
		ResetOld : BOOL; (*Data for internal use.*)
		Hold : BOOL; (*As long as Hold = TRUE, the output is holding the actual value.*)
	END_STRUCT;
	MTDataRMSInternalType : 	STRUCT  (*Internal variables of function block MTDataRMS.*)
		CycleTime : REAL; (*Task cycle time. Unit: [s].*)
		Mean2 : LREAL; (*Sum of the square of the input values.*)
		NumberOfValues : UDINT; (*Number of values for output calculation.*)
		EnableOld : BOOL; (*Data for internal use.*)
		ResetOld : BOOL; (*Data for internal use.*)
		Hold : BOOL; (*As long as Hold = TRUE, the output is holding the actual value.*)
	END_STRUCT;
	MTDataMeanInternalType : 	STRUCT  (*Internal variables of function block MTDataMean.*)
		CycleTime : REAL; (*Task cycle time. Unit: [s].*)
		Mean : LREAL; (*Sum of input values.*)
		NumberOfValues : UDINT; (*Number of values for output calculation.*)
		EnableOld : BOOL; (*Data for internal use.*)
		ResetOld : BOOL; (*Data for internal use.*)
		Hold : BOOL; (*As long as Hold = TRUE, the output is holding the actual value.*)
	END_STRUCT;
	MTDataMinMaxInternalType : 	STRUCT  (*Internal variables of function block MTDataMinMax.*)
		CycleTime : REAL; (*Task cycle time. Unit: [s].*)
		NumberOfValues : UDINT; (*Number of values for output calculation.*)
		EnableOld : BOOL; (*Data for internal use.*)
		ResetOld : BOOL; (*Data for internal use.*)
		Hold : BOOL; (*As long as Hold = TRUE, the output is holding the actual values.*)
	END_STRUCT;
	MTDataStatisticsInternalType : 	STRUCT  (*Internal variables of function block MTDataStatistics.*)
		CycleTime : REAL; (*Task cycle time. Unit: [s].*)
		ParametersValid : BOOL; (*Data for internal use.*)
		NumberOfValues : UDINT; (*Number of values for output calculation.*)
		Buffer : UDINT; (*Size of window.*)
		BufferMax : UDINT; (*Size of memory allocation in number of elements.*)
		NumberMax : UDINT; (*Number of saved elements.*)
		Number0 : UDINT; (*Data for internal use.*)
		Mean : LREAL; (*Sum of input values.*)
		Mean2 : LREAL; (*Sum of the square of the input values.*)
		Change : BOOL; (*Data for internal use.*)
		InOld : REAL; (*Data for internal use.*)
		BufferOld : UDINT; (*Data for internal use.*)
		ResetOld : BOOL; (*Data for internal use.*)
		EnableOld : BOOL; (*Data for internal use.*)
		UpdateOld : BOOL; (*Data for internal use.*)
		FirstTime : BOOL; (*Data for internal use.*)
		MemStatus : UINT; (*Data for internal use.*)
		BufferCntMax : UDINT; (*Data for internal use.*)
		pBuffer : REFERENCE TO REAL; (*Data for internal use.*)
	END_STRUCT;
END_TYPE
