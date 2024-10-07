(*-----------------------------------------------------------------------------------------------------------------------------------------*)
(*General vision structures*)

TYPE
	typVisionMain : 	STRUCT 
		CMD : typVisionCommand;
		CFG : typVisionConfig;
		DAT : typVisionData;
		FCT : typVisionFunction;
		DIA : typVisionDiag;
		OPT : typVisionOptics;
		HW : typVisionHW;
	END_STRUCT;
	typVisionCommand : 	STRUCT 
		ImageTrigger : BOOL;
		ImageTriggerReset : BOOL;
		AutoSetupStartStop : BOOL;
		VaSwitchApplication : BOOL;
		SaveDiagData : BOOL;
		ReadCameraInfo : BOOL;
	END_STRUCT;
	typVisionConfig : 	STRUCT 
		VisionFunction : enumVisionFunction;
		PowerlinkNode : USINT;
		DataStructure : UDINT;
		ComponentLink : ViComponentType;
		ResolutionWidth_X : UINT; (*Nr of sensor pixels in x direction (width). Is always bigger than height*)
		ResolutionHeight_Y : UINT; (*Nr of sensor pixels in y direction (height). Is always smaller than width*)
	END_STRUCT;
	typVisionFunction : 	STRUCT 
		ApplicationName : STRING[40];
		Status : DINT;
	END_STRUCT;
	typVisionDiag : 	STRUCT 
		DiagName : STRING[80] := 'diag.tgz';
		Status : DINT;
	END_STRUCT;
	typVisionData : 	STRUCT 
		Enable : BOOL := FALSE;
		MaxItemCnt : USINT := 1;
		NettimeDelay : DINT;
		Timeout : UINT := 500;
		Gain : USINT := 1;
		Focus : UINT := 15951;
		Exposure : UDINT := 11;
		FlashColor : USINT := 1;
		FlashSegment : USINT := 15;
		LedColor : USINT;
		IRFilter : BOOL;
		OffsetROIX : DINT;
		OffsetROIY : DINT;
		OffsetROIRotationCenterX : DINT;
		OffsetROIRotationCenterY : DINT;
		OffsetROIOrientation : INT;
		ChromaticLock : BOOL;
		Alignment : USINT;
		AutoSetupGain : USINT;
		AutoSetupFocus : UINT;
		AutoSetupExposure : UDINT;
		AcquisitionAcceptedCnt : USINT;
		AcquisitionCompletedCnt : USINT;
		AcquisitionFailedCnt : USINT;
		LightWarningCnt : USINT;
		ImageProcessingError : UINT;
		ImageProcessingActive : BOOL;
		ImageNettime : DINT;
		ProcessingTimeCamera : UINT;
		ProcessingTimeFunction : UINT;
		ResultCnt : USINT;
		CockpitIsActive : BOOL;
		Status : UDINT;
		StatusText : STRING[30];
		Active : BOOL;
	END_STRUCT;
	typVisionHW : 	STRUCT 
		Connected : BOOL;
		Ready : BOOL;
		DigitalInput01 : BOOL;
		DigitalOutput01 : BOOL;
		DigitalOutputStatus01 : BOOL;
		DigitalOutput02 : BOOL;
		DigitalOutputStatus02 : BOOL;
		SerialNumber : UDINT;
		ID : UDINT;
		Variant : UDINT;
		Firmware : UDINT;
		Undervoltage : BOOL;
		Temperature : SINT;
	END_STRUCT;
	typVisionOptics : 	STRUCT 
		OrderNr : STRING[40];
		Binning : BOOL;
		ResolutionX : INT;
		ResolutionY : INT;
		Lens : USINT;
		Sensor : USINT;
		ValidDistance : BOOL;
		Distance_mm : LREAL;
		DistanceLens_mm : LREAL;
		HyperFocalDistance_mm : LREAL;
		PixelSize_um : LREAL;
		PixelSizeBinning_um : LREAL;
		FocalLength_mm : LREAL;
		MinObjectDist_mm : LREAL;
		MaxObjectDist_mm : LREAL;
		Aperture : LREAL;
		CircleOfConfusion_mm : LREAL;
		DepthOfFieldNearPos_mm : LREAL;
		DepthOfFieldFarPos_mm : LREAL;
		DepthOfField_mm : LREAL;
		FieldOfView_X_mm : LREAL;
		FieldOfView_Y_mm : LREAL;
		Resolution_mmPerPx : LREAL;
	END_STRUCT;
	enumVisionFunction : 
		(
		enumFunctionNone,
		enumBlob,
		enumCoderReader,
		enumMatch,
		enumMeasurement,
		enumOCR,
		enumPixelCounter
		);
END_TYPE

(*-----------------------------------------------------------------------------------------------------------------------------------------*)
(*Vision specific structures*)

TYPE
	typCodeReaderMain : 	STRUCT  (*Code reader structures*)
		CodeType : USINT := 50;
		GradingEnable : BOOL;
		RobustnessEnable : BOOL;
		ParameterMode : USINT := 0;
		ParameterOptimization : USINT;
		BarcodeText : ARRAY[1..MAX_NUM_RESULTS]OF STRING[100];
		BarcodeType : ARRAY[1..MAX_NUM_RESULTS]OF USINT;
		PositionX : ARRAY[1..MAX_NUM_RESULTS]OF DINT;
		PositionY : ARRAY[1..MAX_NUM_RESULTS]OF DINT;
		Orientation : ARRAY[1..MAX_NUM_RESULTS]OF INT;
		Grading : ARRAY[1..MAX_NUM_RESULTS]OF SINT;
		EnhancedGrading : ARRAY[1..23]OF USINT;
	END_STRUCT;
END_TYPE

(*------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*)
(*Structure that contains the recipe variables*)

TYPE
	recVariable : 	STRUCT 
		Cam : recVariableCam;
	END_STRUCT;
	recVariableCam : 	STRUCT 
		ApplicationName : STRING[40];
		MaxItemCnt : USINT; (*Default 1*)
		Timeout : UINT; (*Default 200*)
		Gain : USINT;
		Focus : UINT;
		Exposure : UDINT;
		FlashColor : USINT; (*Default is 1*)
		FlashSegment : USINT; (*Default is 15*)
	END_STRUCT;
END_TYPE

(*------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*)
(*Structure that contains the recipe variables*)

TYPE
	VisionInterface_typ : 	STRUCT 
		Enable : BOOL;
		Trigger : BOOL;
		TakeCount : USINT;
		SerialNumber : STRING[100];
	END_STRUCT;
END_TYPE
