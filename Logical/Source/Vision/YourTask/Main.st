// -----------------------------------------------------------------------------------------------------------
// Use this task to add your own code
// -----------------------------------------------------------------------------------------------------------	

// -----------------------------------------------------------------------------------------------------------
// Initialization
// -----------------------------------------------------------------------------------------------------------	
PROGRAM _INIT
	// -----------------------------------------------------------------------------------------------------------
	// Delay startup for mappVision
	startupDelay.IN := 1;
	startupDelay.PT := 200;
	REPEAT
		startupDelay();
		UNTIL startupDelay.Q 
	END_REPEAT;
	
	// -----------------------------------------------------------------------------------------------------------
	// Vision sensor configuration
	// -----------------------------------------------------------------------------------------------------------
	gVisionSensor.CFG.VisionFunction		:= enumCoderReader;			// Used to run specific code for this vision function
	gVisionSensor.CFG.PowerlinkNode			:= 1;						// Powerlink node number
	gVisionSensor.CFG.DataStructure			:= ADR(gCodeReader);		// Global structures that holds all data related to this function
	gVisionSensor.CFG.ComponentLink			:= gCameraCodeReading;		// Vision component name defined under mappVision in the configuration view
	gVisionSensor.CFG.ResolutionWidth_X		:= 1280;
	gVisionSensor.CFG.ResolutionHeight_Y	:= 1024;
	
	cmdLoadRecipeAfterBoot	:= TRUE;
	
	gParVision.Cam.MaxItemCnt := 1;
	gParVision.Cam.FlashColor := 1;
	gParVision.Cam.FlashSegment := 15;
	
	gBarCodeReader.Enable	:= TRUE;
	
END_PROGRAM

// -----------------------------------------------------------------------------------------------------------
// Cyclic part
// -----------------------------------------------------------------------------------------------------------	
PROGRAM _CYCLIC
		
	// -----------------------------------------------------------------------------------------------------------	
	// Transfer data when loading a recipe
	IF cmdLoadRecipeAfterBoot THEN
		cmdLoadRecipeAfterBoot := FALSE;
		
		gVisionSensor.FCT.ApplicationName	:= gParVision.Cam.ApplicationName;
		gVisionSensor.DAT.Exposure			:= gParVision.Cam.Exposure;
		gVisionSensor.DAT.FlashColor		:= gParVision.Cam.FlashColor;
		gVisionSensor.DAT.FlashSegment		:= gParVision.Cam.FlashSegment;
		gVisionSensor.DAT.Focus				:= gParVision.Cam.Focus;
		gVisionSensor.DAT.Gain				:= gParVision.Cam.Gain;
		gVisionSensor.DAT.MaxItemCnt		:= gParVision.Cam.MaxItemCnt;
		gVisionSensor.DAT.Timeout			:= gParVision.Cam.Timeout;	
	ELSE
		gParVision.Cam.ApplicationName		:= gVisionSensor.FCT.ApplicationName;
		gParVision.Cam.Exposure				:= gVisionSensor.DAT.Exposure;
		gParVision.Cam.FlashColor			:= gVisionSensor.DAT.FlashColor;
		gParVision.Cam.FlashSegment			:= gVisionSensor.DAT.FlashSegment;
		gParVision.Cam.Focus				:= gVisionSensor.DAT.Focus;
		gParVision.Cam.Gain					:= gVisionSensor.DAT.Gain;
		gParVision.Cam.MaxItemCnt			:= gVisionSensor.DAT.MaxItemCnt;
		gParVision.Cam.Timeout				:= gVisionSensor.DAT.Timeout;
	END_IF
	
	// -----------------------------------------------------------------------------------------------------------
	// Fire trigger for camera image
	// -----------------------------------------------------------------------------------------------------------
	IF((gBarCodeReader.Trigger OR EDGEPOS(gVisionSensor.DAT.Enable)) AND gVisionSensor.HW.Ready AND NOT gVisionSensor.DAT.ImageProcessingActive) THEN
		// Add default delay and fire trigger
		IF NETTIME_ENABLE THEN
			gVisionSensor.DAT.NettimeDelay := NettimeCurrent_us + NETTIME_DEFAULT_DELAY;
		END_IF
		gVisionSensor.CMD.ImageTrigger	:= TRUE;
		gBarCodeReader.Trigger			:= FALSE;
		gVisionSensor.DAT.Active		:= TRUE;
	END_IF	
	
	gVisionSensor.DAT.Enable 			:= gBarCodeReader.Enable;
	
	gBarCodeReader.TakeCount 			:= gVisionSensor.DAT.AcquisitionCompletedCnt;
	gBarCodeReader.SerialNumber			:= gCodeReader.BarcodeText[1];
END_PROGRAM