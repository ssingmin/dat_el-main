
TYPE
	MTFilterMovingAvgInternalType : 	STRUCT  (*Internal variables of function block MTFilterMovingAverage.*)
		Ts : REAL; (*Data for internal use.*)
		ParameterValid : BOOL; (*Data for internal use.*)
		NumOfElmements : UINT; (*Number of elements of calculating output.*)
		Sum : LREAL; (*Data for internal use.*)
		pBuffer : UDINT; (*Data for internal use.*)
		CntAct : UINT; (*Data for internal use.*)
		CntOld : UINT; (*Data for internal use.*)
		WindowLength : UINT; (*Data for internal use.*)
		BufferLength : UINT; (*Length of window.*)
		BufferFull : BOOL; (*Data for internal use.*)
		MemAllocated : BOOL; (*Data for internal use.*)
		Update : BOOL; (*Data for internal use.*)
		UpdateOld : BOOL; (*Data for internal use.*)
		EnableOld : BOOL; (*Data for internal use.*)
		statusTMP : UINT; (*Data for internal use.*)
	END_STRUCT;
	MTFilterTypeEnum : 
		( (*Filtertype.*)
		mtBESSEL := 0, (*Bessel Filter.*)
		mtBUTTERWORTH := 1 (*Butterworth Filter.*)
		);
	MTFilterLowPassInternalType : 	STRUCT  (*Internal variables of function block MTFilterLowPass.*)
		Ts : REAL; (*Task cycle time. Unit: [s].*)
		SamplingFrequency : LREAL; (*Sampling frequency. Unit: [Hz].*)
		ParameterValid : BOOL; (*Data for internal use.*)
		AngularFrequency : LREAL; (*Data for internal use.*)
		Num : ARRAY[0..5]OF LREAL; (*Data for internal use.*)
		Den : ARRAY[0..5]OF LREAL; (*Data for internal use.*)
		BVector : ARRAY[0..5]OF LREAL; (*Data for internal use.*)
		AVector : ARRAY[0..5]OF LREAL; (*Data for internal use.*)
		XVector : ARRAY[0..4]OF LREAL; (*Data for internal use.*)
		TypeOld : USINT; (*Data for internal use.*)
		OrderOld : USINT; (*Data for internal use.*)
		CutOffFrequencyOld : REAL; (*Data for internal use.*)
		UpdateOld : BOOL; (*Data for internal use.*)
		EnableOld : BOOL; (*Data for internal use.*)
		EnableDone : BOOL; (*Data for internal use.*)
		DisabledBusy : BOOL; (*Data for internal use.*)
		CounterOld : UDINT; (*Data for internal use.*)
		SysRefParaNew : BOOL; (*Data for internal use.*)
		SystemReference : MTTransferFcnType; (*Data for internal use.*)
	END_STRUCT;
	MTFilterHighPassInternalType : 	STRUCT  (*Internal variables of function block MTFilterHighPass.*)
		Ts : REAL; (*Task cycle time. Unit: [s].*)
		SamplingFrequency : LREAL; (*Sampling frequency. Unit: [Hz].*)
		ParameterValid : BOOL; (*Data for internal use.*)
		AngularFrequency : LREAL; (*Frequency in radians*)
		Num : ARRAY[0..5]OF LREAL; (*Data for internal use.*)
		Den : ARRAY[0..5]OF LREAL; (*Data for internal use.*)
		BVector : ARRAY[0..5]OF LREAL; (*Data for internal use.*)
		AVector : ARRAY[0..5]OF LREAL; (*Data for internal use.*)
		XVector : ARRAY[0..4]OF LREAL; (*Data for internal use.*)
		TypeOld : USINT; (*Data for internal use.*)
		OrderOld : USINT; (*Data for internal use.*)
		CutOffFrequencyOld : REAL; (*Data for internal use.*)
		UpdateOld : BOOL; (*Data for internal use.*)
		EnableOld : BOOL; (*Data for internal use.*)
		EnableDone : BOOL; (*Data for internal use.*)
		DisabledBusy : BOOL; (*Data for internal use.*)
		CounterOld : UDINT; (*Data for internal use.*)
		SysRefParaNew : BOOL; (*Data for internal use.*)
		SystemReference : MTTransferFcnType; (*Data for internal use.*)
	END_STRUCT;
	MTFilterBandPassInternalType : 	STRUCT  (*Internal variables of function block MTFilterBandPass.*)
		Ts : REAL; (*Task cycle time. Unit: [s].*)
		SamplingFrequency : LREAL; (*Sampling frequency. Unit: [Hz].*)
		ParameterValid : BOOL; (*Data for internal use.*)
		AngularFrequency : LREAL; (*Frequency in radians*)
		BandwidthRad : LREAL; (*Frequency in radians*)
		Num : ARRAY[0..5]OF LREAL; (*Data for internal use.*)
		Den : ARRAY[0..5]OF LREAL; (*Data for internal use.*)
		BVector : ARRAY[0..5]OF LREAL; (*Data for internal use.*)
		AVector : ARRAY[0..5]OF LREAL; (*Data for internal use.*)
		XVector : ARRAY[0..4]OF LREAL; (*Data for internal use.*)
		TypeOld : USINT; (*Data for internal use.*)
		OrderOld : USINT; (*Data for internal use.*)
		CenterFrequencyOld : REAL; (*Data for internal use.*)
		BandwidthOld : REAL; (*Data for internal use.*)
		UpdateOld : BOOL; (*Data for internal use.*)
		EnableOld : BOOL; (*Data for internal use.*)
		EnableDone : BOOL; (*Data for internal use.*)
		DisabledBusy : BOOL; (*Data for internal use.*)
		CounterOld : UDINT; (*Data for internal use.*)
		SysRefParaNew : BOOL; (*Data for internal use.*)
		SystemReference : MTTransferFcnType; (*Data for internal use.*)
	END_STRUCT;
	MTFilterBandStopInternalType : 	STRUCT  (*Internal variables of function block MTFilterBandStop.*)
		Ts : REAL; (*Task cycle time. Unit: [s].*)
		SamplingFrequency : LREAL; (*Sampling frequency. Unit: [Hz].*)
		ParameterValid : BOOL; (*Data for internal use.*)
		AngularFrequency : LREAL; (*Data for internal use.*)
		BandwidthRad : LREAL; (*Frequency in radians*)
		Num : ARRAY[0..5]OF LREAL; (*Data for internal use.*)
		Den : ARRAY[0..5]OF LREAL; (*Data for internal use.*)
		BVector : ARRAY[0..5]OF LREAL; (*Data for internal use.*)
		AVector : ARRAY[0..5]OF LREAL; (*Data for internal use.*)
		XVector : ARRAY[0..4]OF LREAL; (*Data for internal use.*)
		TypeOld : USINT; (*Data for internal use.*)
		OrderOld : USINT; (*Data for internal use.*)
		CenterFrequencyOld : REAL; (*Data for internal use.*)
		BandwidthOld : REAL; (*Data for internal use.*)
		UpdateOld : BOOL; (*Data for internal use.*)
		EnableOld : BOOL; (*Data for internal use.*)
		EnableDone : BOOL; (*Data for internal use.*)
		DisabledBusy : BOOL; (*Data for internal use.*)
		CounterOld : UDINT; (*Data for internal use.*)
		SysRefParaNew : BOOL; (*Data for internal use.*)
		SystemReference : MTTransferFcnType; (*Data for internal use.*)
	END_STRUCT;
	MTFilterNotchInternalType : 	STRUCT  (*Internal variables of function block MTFilterNotch.*)
		Ts : REAL; (*Task cycle time. Unit: [s].*)
		SamplingFrequency : LREAL; (*Sampling frequency. Unit: [Hz].*)
		ParametersValid : BOOL; (*Data for internal use.*)
		UpperFrequency : REAL; (*Data for internal use.*)
		LowerFrequency : REAL; (*Data for internal use.*)
		BandwidthAct : REAL; (*Data for internal use.*)
		DampingConstant : REAL; (*Data for internal use.*)
		FilterTimeConstant : REAL; (*Data for internal use.*)
		Num : ARRAY[0..2]OF LREAL; (*Data for internal use.*)
		Den : ARRAY[0..2]OF LREAL; (*Data for internal use.*)
		BVector : ARRAY[0..2]OF LREAL; (*Data for internal use.*)
		AVector : ARRAY[0..2]OF LREAL; (*Data for internal use.*)
		XVector : ARRAY[0..1]OF LREAL; (*Data for internal use.*)
		TypeOld : USINT; (*Data for internal use.*)
		OrderOld : USINT; (*Data for internal use.*)
		CutOffFrequencyOld : REAL; (*Data for internal use.*)
		UpdateOld : BOOL; (*Data for internal use.*)
		EnableOld : BOOL; (*Data for internal use.*)
		EnableDone : BOOL; (*Data for internal use.*)
		DisabledBusy : BOOL; (*Data for internal use.*)
		SysRefParaNew : BOOL; (*Data for internal use.*)
		CounterOld : UDINT; (*Data for internal use.*)
		SystemReference : MTTransferFcnType; (*Data for internal use.*)
	END_STRUCT;
	MTFilterBiQuadInternalType : 	STRUCT  (*Internal variables of function block MTFilterBiQuad.*)
		Ts : REAL; (*Task cycle time. Unit: [s].*)
		SamplingFrequency : LREAL; (*Sampling frequency. Unit: [Hz]*)
		ParameterValid : BOOL; (*Data for internal use.*)
		Num : ARRAY[0..2]OF LREAL; (*Data for internal use.*)
		Den : ARRAY[0..2]OF LREAL; (*Data for internal use.*)
		BVector : ARRAY[0..2]OF LREAL; (*Data for internal use.*)
		AVector : ARRAY[0..2]OF LREAL; (*Data for internal use.*)
		XVector : ARRAY[0..1]OF LREAL; (*Data for internal use.*)
		FrequencyNumeratorOld : REAL; (*Data for internal use.*)
		DampingRatioNumeratorOld : REAL; (*Data for internal use.*)
		FrequencyDenominatorOld : REAL; (*Data for internal use.*)
		DampingRatioDenominatorOld : REAL; (*Data for internal use.*)
		FrequencyNumeratorRad : LREAL; (*Data for internal use.*)
		FrequencyDenominatorRad : LREAL; (*Data for internal use.*)
		UpdateOld : BOOL; (*Data for internal use.*)
		EnableOld : BOOL; (*Data for internal use.*)
		EnableDone : BOOL; (*Data for internal use.*)
		DisabledBusy : BOOL; (*Data for internal use.*)
		SysRefParaNew : BOOL; (*Data for internal use.*)
		CounterOld : UDINT; (*Data for internal use.*)
		SystemReference : MTTransferFcnType; (*Data for internal use.*)
	END_STRUCT;
END_TYPE
