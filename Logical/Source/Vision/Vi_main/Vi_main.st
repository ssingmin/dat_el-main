// --------------------------------------------------------------------------------------------------------------------
// General vision task. This is a support task for the mappVision. The following functions are implemneted
// - Translate some values in text messages
// - Reset camera trigger when inspection is finsihed
// - Load vision application
// - Save diagnostic data
// Version 2.x (Check revision history for details)
// --------------------------------------------------------------------------------------------------------------------
PROGRAM _INIT
	gVisionSensor;
	gCodeReader;
END_PROGRAM

// -----------------------------------------------------------------------------------------------------------
// Cyclic part
// -----------------------------------------------------------------------------------------------------------	
PROGRAM _CYCLIC
	// -----------------------------------------------------------------------------------------------------------
	// Translate camera status in readable text
	// -----------------------------------------------------------------------------------------------------------
	IF gVisionSensor.DAT.Status = 0 THEN // Display only a single 0
		gVisionSensor.DAT.StatusText := 'Ready';
	ELSIF gVisionSensor.DAT.Status = 16#00000001 THEN
		gVisionSensor.DAT.StatusText := 'Image acquisition';
	ELSIF gVisionSensor.DAT.Status = 16#00000002 THEN
		gVisionSensor.DAT.StatusText := 'Waiting trigger';
	ELSIF gVisionSensor.DAT.Status = 16#00000010 THEN
		gVisionSensor.DAT.StatusText := 'Searching settings';
	ELSIF gVisionSensor.DAT.Status = 16#00000080 THEN
		gVisionSensor.DAT.StatusText := 'Setting focus';
	ELSIF gVisionSensor.DAT.Status = 16#00000090 THEN
		gVisionSensor.DAT.StatusText := 'Searching settings';
	ELSIF gVisionSensor.DAT.Status = 16#00000800 THEN
		gVisionSensor.DAT.StatusText := 'Cam CPU not ready';
	ELSIF gVisionSensor.DAT.Status = 16#00001000 THEN
		gVisionSensor.DAT.StatusText := 'Cam sensor not ready';
	ELSIF gVisionSensor.DAT.Status = 16#01000000 OR gVisionSensor.DAT.Status = 16#02000000 OR gVisionSensor.DAT.Status = 16#03000000 THEN
		gVisionSensor.DAT.StatusText := 'OS check/update';
	ELSIF gVisionSensor.DAT.Status = 16#80000000 THEN
		gVisionSensor.DAT.StatusText := 'Vision cockpit active';
	ELSE 
		// Display the status in hex format 0x02000800
		gVisionSensor.DAT.StatusText := '';
		FOR i := 0 TO 28 BY 4 DO
			gVisionSensor.DAT.StatusText := CONCAT(MID(HexTab, 1, LIMIT(1, UDINT_TO_INT((SHR(gVisionSensor.DAT.Status, i) AND 16#0000000F) + 1), 16)), gVisionSensor.DAT.StatusText);
		END_FOR
		gVisionSensor.DAT.StatusText := CONCAT('0x', gVisionSensor.DAT.StatusText);
	END_IF
	
	// -----------------------------------------------------------------------------------------------------------
	// Check if vision cockpit is open
	// -----------------------------------------------------------------------------------------------------------
	gVisionSensor.DAT.CockpitIsActive := (gVisionSensor.DAT.Status AND 16#8000_0000) > 0;
		
	// -----------------------------------------------------------------------------------------------------------
	// Auto setup handling
	// -----------------------------------------------------------------------------------------------------------
	IF(gVisionSensor.CMD.AutoSetupStartStop AND gVisionSensor.DAT.Status <> 0) THEN
		AutoSetupRunning := TRUE;
	ELSIF NOT gVisionSensor.CMD.AutoSetupStartStop THEN
		AutoSetupRunning := FALSE;
	END_IF
	IF(gVisionSensor.CMD.AutoSetupStartStop AND gVisionSensor.DAT.Status = 0 AND AutoSetupRunning) THEN // Setup successfully finished
		gVisionSensor.DAT.Gain					:= gVisionSensor.DAT.AutoSetupGain;
		gVisionSensor.DAT.Focus					:= gVisionSensor.DAT.AutoSetupFocus;
		gVisionSensor.DAT.Exposure				:= gVisionSensor.DAT.AutoSetupExposure;
		gVisionSensor.CMD.AutoSetupStartStop	:= FALSE;
		AutoSetupRunning						:= FALSE;
		TON_DelayAfterAutoSetup.IN				:= TRUE;
	END_IF
	TON_DelayAfterAutoSetup(PT := T#50ms);
	IF TON_DelayAfterAutoSetup.Q THEN // After the camera tells it is ready, we need to wait still at least ca 20ms, otherwise it does not accept the trigger
		TON_DelayAfterAutoSetup.IN := FALSE;
		IF gVisionSensor.HW.Ready AND NOT gVisionSensor.DAT.ImageProcessingActive THEN
			IF NETTIME_ENABLE THEN
				gVisionSensor.DAT.NettimeDelay := NettimeCurrent_us + NETTIME_DEFAULT_DELAY;
			END_IF
			gVisionSensor.CMD.ImageTrigger	:= TRUE;
			gVisionSensor.DAT.Active		:= TRUE;
		END_IF
	END_IF
		
	// -----------------------------------------------------------------------------------------------------------
	// Reset image trigger, reload web page and store image when process is finished
	// -----------------------------------------------------------------------------------------------------------
	IF ((gVisionSensor.DAT.AcquisitionCompletedCnt <> AcquisitionCompletedCntOld OR gVisionSensor.DAT.AcquisitionFailedCnt <> AcquisitionFailedCntOld) AND NOT gVisionSensor.DAT.ImageProcessingActive AND gVisionSensor.HW.Ready) THEN
		AcquisitionCompletedCntOld		:= gVisionSensor.DAT.AcquisitionCompletedCnt;
		AcquisitionFailedCntOld			:= gVisionSensor.DAT.AcquisitionFailedCnt;
		gVisionSensor.CMD.ImageTrigger	:= FALSE;
		gVisionSensor.DAT.Active		:= FALSE;
	END_IF

	// -----------------------------------------------------------------------------------------------------------
	// Reset trigger when timed out
	// -----------------------------------------------------------------------------------------------------------
	IF gVisionSensor.CMD.ImageTrigger THEN
		TriggerTimeoutSensor.IN := TRUE;
		TriggerTimeoutSensor.PT := REAL_TO_TIME(gVisionSensor.DAT.Timeout * 1.25);
		IF TriggerTimeoutSensor.Q THEN
			gVisionSensor.CMD.ImageTrigger			:= FALSE;
			gVisionSensor.CMD.ImageTriggerReset		:= TRUE;
			gVisionSensor.DAT.Active				:= FALSE;
		END_IF
	ELSE
		TriggerTimeoutSensor.IN := FALSE;
		gVisionSensor.CMD.ImageTriggerReset := FALSE;
	END_IF
	TriggerTimeoutSensor();

	// -----------------------------------------------------------------------------------------------------------
	// Load vision application
	// -----------------------------------------------------------------------------------------------------------
	IF (gVisionSensor.CMD.VaSwitchApplication) THEN
		ViBaseLoadApplication_01.MpLink	:= ADR(gVisionSensor.CFG.ComponentLink);
		ViBaseLoadApplication_01.Name	:= ADR(gVisionSensor.FCT.ApplicationName);
		gVisionSensor.FCT.Status := ERR_FUB_BUSY;
		
		// -----------------------------------------------------------------------------------------------------------
		// OK
		IF (ViBaseLoadApplication_01.Done) THEN
			gVisionSensor.FCT.Status := ERR_OK;
			gVisionSensor.CMD.VaSwitchApplication := FALSE;
			// -----------------------------------------------------------------------------------------------------------
			// Error
		ELSIF (NOT ViBaseLoadApplication_01.Busy AND ViBaseLoadApplication_01.Error) THEN
			gVisionSensor.FCT.Status := ViBaseLoadApplication_01.StatusID;
			gVisionSensor.CMD.VaSwitchApplication := FALSE;
		END_IF		
	END_IF
	ViBaseLoadApplication_01.Execute := gVisionSensor.CMD.VaSwitchApplication;
	ViBaseLoadApplication_01();
	// Dont proceed until loading is finished
	IF (gVisionSensor.CMD.VaSwitchApplication) THEN
		RETURN;
	END_IF
	
	// -----------------------------------------------------------------------------------------------------------
	// Save diagnostic data
	// -----------------------------------------------------------------------------------------------------------
	IF (gVisionSensor.CMD.SaveDiagData) THEN
		// Delete old file first
		FDelete.enable := gVisionSensor.CMD.SaveDiagData AND NOT ViBaseSaveDiagData_01.Execute;
		FDelete.pDevice := ADR(DEVICE_NAME);
		FDelete.pName := ADR(gVisionSensor.DIA.DiagName);
		IF (FDelete.status <> ERR_FUB_BUSY) THEN
			ViBaseSaveDiagData_01.Execute := TRUE;
		END_IF
		// Upload diagnostic information
		ViBaseSaveDiagData_01.MpLink := ADR(gVisionSensor.CFG.ComponentLink);
		ViBaseSaveDiagData_01.DeviceName := ADR(DEVICE_NAME);
		ViBaseSaveDiagData_01.FileName := ADR(gVisionSensor.DIA.DiagName);
		gVisionSensor.DIA.Status := ERR_FUB_BUSY;
		
		// -----------------------------------------------------------------------------------------------------------
		// OK
		IF (ViBaseSaveDiagData_01.Done) THEN
			gVisionSensor.DIA.Status := ERR_OK;
			ViBaseSaveDiagData_01.Execute := FALSE;
			gVisionSensor.CMD.SaveDiagData := FALSE;
			// -----------------------------------------------------------------------------------------------------------
			// Error
		ELSIF (NOT ViBaseSaveDiagData_01.Busy AND ViBaseSaveDiagData_01.Error) THEN
			gVisionSensor.DIA.Status := ViBaseSaveDiagData_01.StatusID;
			ViBaseSaveDiagData_01.Execute := FALSE;
			gVisionSensor.CMD.SaveDiagData := FALSE;
		END_IF
	END_IF
	ViBaseSaveDiagData_01();
	FDelete();
	// Dont proceed until loading is finished
	IF (gVisionSensor.CMD.SaveDiagData) THEN
		RETURN;
	END_IF
	
	// -----------------------------------------------------------------------------------------------------------
	// Read camera info
	// -----------------------------------------------------------------------------------------------------------
	CASE OpticsReadStep[idSensor] OF 
		// -----------------------------------------------------------------------------------------------------------
		// Wait
		0: 
			IF gVisionSensor.CMD.ReadCameraInfo THEN
				gVisionSensor.OPT.OrderNr	:= '';
				Index := 0;
				OpticsReadStep[idSensor]	:= 1;
			END_IF
			// -----------------------------------------------------------------------------------------------------------
			// Create DiagInformation
		1: 
			DiagCreateInfo_0.enable			:= TRUE;
			DiagCreateInfo_0.infoKind		:= asdiagPLUGGED;
			DiagCreateInfo_0();
			IF DiagCreateInfo_0.status = 0 THEN
				OpticsReadStep[idSensor] := 2;
			ELSIF DiagCreateInfo_0.status <> ERR_FUB_BUSY THEN
				OpticsReadStep[idSensor] := 90;
			END_IF
			// -----------------------------------------------------------------------------------------------------------
			// Read HW-ID and compare with selected camera
		2: 
			DiagGetNumInfo_0.enable			:= TRUE;
			DiagGetNumInfo_0.ident			:= DiagCreateInfo_0.ident;
			DiagGetNumInfo_0.index			:= Index;
			DiagGetNumInfo_0.infoCode		:= asdiagPLUGGED_MODNO;
			DiagGetNumInfo_0();
			IF DiagGetNumInfo_0.status = 0 THEN
				//IF DiagGetNumInfo_0.value = gVisionSensor[visSelectedSensor].HW.ID THEN
				IF DiagGetNumInfo_0.value = gVisionSensor.HW.ID THEN
					OpticsReadStep[idSensor] := 3;
				ELSE
					Index := Index + 1;
					IF Index >= DiagCreateInfo_0.nrEntries THEN
						OpticsReadStep[idSensor] := 91;
					END_IF
				END_IF
			ELSIF DiagGetNumInfo_0.status <> ERR_FUB_BUSY THEN
				OpticsReadStep[idSensor] := 92;
			END_IF
			// -----------------------------------------------------------------------------------------------------------
			// Read ordernumber
		3: 
			DiagGetStrInfo_0.enable			:= TRUE;
			DiagGetStrInfo_0.ident			:= DiagCreateInfo_0.ident;
			DiagGetStrInfo_0.index			:= Index;
			DiagGetStrInfo_0.infoCode		:= asdiagPLUGGED_MODULE;
			DiagGetStrInfo_0.pBuffer		:= ADR(gVisionSensor.OPT.OrderNr);
			DiagGetStrInfo_0.bufferLen		:= SIZEOF(gVisionSensor.OPT.OrderNr) - 1;
			DiagGetStrInfo_0();
			IF DiagGetStrInfo_0.status = 0 THEN
				OpticsReadStep[idSensor] := 10;
			ELSIF DiagGetStrInfo_0.status <> ERR_FUB_BUSY THEN
				OpticsReadStep[idSensor] := 93;
			END_IF
			// -----------------------------------------------------------------------------------------------------------
			// Release info function block
		10:
			DiagDisposeInfo_0.enable		:= TRUE;
			DiagDisposeInfo_0.ident			:= DiagCreateInfo_0.ident;
			DiagDisposeInfo_0();
			IF DiagDisposeInfo_0.status = 0 THEN
				OpticsReadStep[idSensor] := 20;
			ELSIF DiagDisposeInfo_0.status <> ERR_FUB_BUSY THEN
				OpticsReadStep[idSensor] := 94;
			END_IF
			// -----------------------------------------------------------------------------------------------------------
			// Get the info to the actual camara
		20: 
			IF brsstrlen(ADR(gVisionSensor.OPT.OrderNr)) = 18 THEN
				pChar ACCESS ADR(gVisionSensor.OPT.OrderNr) + 8; 	// Letter for Sensor
				CASE pChar OF
					16#31:  gVisionSensor.OPT.Sensor := SENSOR_1_3_MP; // ASCII '1'
					16#32:  gVisionSensor.OPT.Sensor := SENSOR_1_3_MP; // ASCII '2'
					16#34:  gVisionSensor.OPT.Sensor := SENSOR_3_5_MP; // ASCII '4'
					16#35:  gVisionSensor.OPT.Sensor := SENSOR_5_3_MP; // ASCII '5'
					ELSE
						OpticsReadStep[idSensor] := 95;
				END_CASE
				pChar ACCESS ADR(gVisionSensor.OPT.OrderNr) + 10; // first letter for optics (0 or M)
				CASE pChar OF
					16#30:  gVisionSensor.OPT.Lens := LENS_4_6; // ASCII '0'
					16#4D:  gVisionSensor.OPT.Lens := LENS_12_0_MACRO; // ASCII 'M'
					ELSE
						OpticsReadStep[idSensor] := 96;
				END_CASE
				pChar ACCESS ADR(gVisionSensor.OPT.OrderNr) + 11; // second letter for optics
				CASE pChar OF
					16#30:  gVisionSensor.OPT.Lens := LENS_4_6; // ASCII '0' // no optics
					16#32:  gVisionSensor.OPT.Lens := LENS_4_6; // ASCII '2'
					16#33:  gVisionSensor.OPT.Lens := LENS_6_0; // ASCII '3'
					16#34:  gVisionSensor.OPT.Lens := LENS_8_0; // ASCII '4'
					16#35: // ASCII '5'
					IF gVisionSensor.OPT.Lens = LENS_12_0_MACRO THEN
						// do noting, already selected
					ELSE
						gVisionSensor.OPT.Lens := LENS_12_0;
					END_IF
					16#36:  gVisionSensor.OPT.Lens := LENS_16_0; // ASCII '6'
					16#37:  gVisionSensor.OPT.Lens := LENS_25_0; // ASCII '7'
					ELSE
						OpticsReadStep[idSensor] := 97;
				END_CASE
				gVisionSensor.OPT.Distance_mm := gVisionSensor.DAT.Focus/100;
				gVisionSensor.CMD.ReadCameraInfo := FALSE;
				OpticsReadStep[idSensor] := 0;
			ELSE
				OpticsReadStep[idSensor] := 98;
			END_IF
		90..99: // auto reset errors
			gVisionSensor.CMD.ReadCameraInfo := FALSE;
			OpticsReadStep[idSensor] := 0;
	END_CASE

	// -----------------------------------------------------------------------------------------------------------
	// Set sensor parameter
	CASE gVisionSensor.OPT.Sensor OF
		SENSOR_1_3_MP:
			gVisionSensor.OPT.PixelSize_um		:= 4.8;
			gVisionSensor.OPT.ResolutionX		:= 1280;
			gVisionSensor.OPT.ResolutionY		:= 1024;
		SENSOR_3_5_MP:
			gVisionSensor.OPT.PixelSize_um		:= 3.2;
			gVisionSensor.OPT.ResolutionX		:= 2112;
			gVisionSensor.OPT.ResolutionY		:= 1664;
		SENSOR_5_3_MP:
			gVisionSensor.OPT.PixelSize_um		:= 3.2;
			gVisionSensor.OPT.ResolutionX		:= 2592;
			gVisionSensor.OPT.ResolutionY		:= 2048;
	END_CASE
	
	// -----------------------------------------------------------------------------------------------------------
	// Set lens parameter
	CASE gVisionSensor.OPT.Lens OF
		LENS_4_6:
			gVisionSensor.OPT.FocalLength_mm	:= 4.6;
			gVisionSensor.OPT.MinObjectDist_mm	:= 25;
			gVisionSensor.OPT.MaxObjectDist_mm	:= 65550;
			gVisionSensor.OPT.Aperture			:= 3.5;
		LENS_6_0:
			gVisionSensor.OPT.FocalLength_mm	:= 6.0;
			gVisionSensor.OPT.MinObjectDist_mm	:= 50;
			gVisionSensor.OPT.MaxObjectDist_mm	:= 65550;
			gVisionSensor.OPT.Aperture			:= 3.5;
		LENS_8_0:
			gVisionSensor.OPT.FocalLength_mm	:= 8.0;
			gVisionSensor.OPT.MinObjectDist_mm	:= 50;
			gVisionSensor.OPT.MaxObjectDist_mm	:= 65500;
			gVisionSensor.OPT.Aperture			:= 3.5;
		LENS_12_0:
			gVisionSensor.OPT.FocalLength_mm	:= 12.0;
			gVisionSensor.OPT.MinObjectDist_mm	:= 75;
			gVisionSensor.OPT.MaxObjectDist_mm	:= 5000;
			gVisionSensor.OPT.Aperture			:= 4.0;
		LENS_16_0:
			gVisionSensor.OPT.FocalLength_mm	:= 16.0;
			gVisionSensor.OPT.MinObjectDist_mm	:= 100;
			gVisionSensor.OPT.MaxObjectDist_mm	:= 1500;
			gVisionSensor.OPT.Aperture			:= 4.0;
		LENS_25_0:
			gVisionSensor.OPT.FocalLength_mm	:= 25.0;
			gVisionSensor.OPT.MinObjectDist_mm	:= 250;
			gVisionSensor.OPT.MaxObjectDist_mm	:= 1500;
			gVisionSensor.OPT.Aperture			:= 4.0;
		LENS_12_0_MACRO:
			gVisionSensor.OPT.FocalLength_mm	:= 12.0;
			gVisionSensor.OPT.MinObjectDist_mm	:= 35;
			gVisionSensor.OPT.MaxObjectDist_mm	:= 65;
			gVisionSensor.OPT.Aperture			:= 4.0;
	END_CASE
	gVisionSensor.OPT.ValidDistance := gVisionSensor.OPT.Distance_mm >= gVisionSensor.OPT.MinObjectDist_mm AND gVisionSensor.OPT.Distance_mm <= gVisionSensor.OPT.MaxObjectDist_mm;
	IF gVisionSensor.OPT.ValidDistance THEN
		gVisionSensor.OPT.DistanceLens_mm				:= gVisionSensor.OPT.Distance_mm + DISTANCE_FRONTGLASS_LENS_MM; // The lens is 15mm behind the front glass
		IF gVisionSensor.OPT.Binning THEN
			gVisionSensor.OPT.PixelSizeBinning_um		:= gVisionSensor.OPT.PixelSize_um * 2;
		ELSE
			gVisionSensor.OPT.PixelSizeBinning_um		:= gVisionSensor.OPT.PixelSize_um * 1;
		END_IF
		gVisionSensor.OPT.CircleOfConfusion_mm			:= gVisionSensor.OPT.PixelSizeBinning_um * 1 * SQRT(2.0) / 1000.0;
		gVisionSensor.OPT.HyperFocalDistance_mm			:= (gVisionSensor.OPT.FocalLength_mm * gVisionSensor.OPT.FocalLength_mm) / (gVisionSensor.OPT.Aperture * gVisionSensor.OPT.CircleOfConfusion_mm) + gVisionSensor.OPT.FocalLength_mm;
		gVisionSensor.OPT.DepthOfFieldNearPos_mm		:= gVisionSensor.OPT.DistanceLens_mm * (gVisionSensor.OPT.HyperFocalDistance_mm - gVisionSensor.OPT.FocalLength_mm) / (gVisionSensor.OPT.HyperFocalDistance_mm + gVisionSensor.OPT.DistanceLens_mm - 2 * gVisionSensor.OPT.FocalLength_mm) - DISTANCE_FRONTGLASS_LENS_MM;
		IF gVisionSensor.OPT.DistanceLens_mm < gVisionSensor.OPT.HyperFocalDistance_mm THEN
			gVisionSensor.OPT.DepthOfFieldFarPos_mm	:= gVisionSensor.OPT.DistanceLens_mm * (gVisionSensor.OPT.HyperFocalDistance_mm - gVisionSensor.OPT.FocalLength_mm) / (gVisionSensor.OPT.HyperFocalDistance_mm - gVisionSensor.OPT.DistanceLens_mm) - DISTANCE_FRONTGLASS_LENS_MM;
			gVisionSensor.OPT.DepthOfField_mm			:= gVisionSensor.OPT.DepthOfFieldFarPos_mm - gVisionSensor.OPT.DepthOfFieldNearPos_mm;
		ELSE
			gVisionSensor.OPT.DepthOfFieldFarPos_mm		:= -1; // Means "infinite"
			gVisionSensor.OPT.DepthOfField_mm			:= -1; // Means "infinite"
		END_IF
		gVisionSensor.OPT.FieldOfView_X_mm			:= gVisionSensor.OPT.PixelSizeBinning_um / 1000 * gVisionSensor.OPT.ResolutionX *(gVisionSensor.OPT.DistanceLens_mm / gVisionSensor.OPT.FocalLength_mm - 1.0);
		gVisionSensor.OPT.FieldOfView_Y_mm			:= gVisionSensor.OPT.PixelSizeBinning_um / 1000 * gVisionSensor.OPT.ResolutionY *(gVisionSensor.OPT.DistanceLens_mm / gVisionSensor.OPT.FocalLength_mm - 1.0);
		gVisionSensor.OPT.Resolution_mmPerPx		:= gVisionSensor.OPT.FieldOfView_X_mm / gVisionSensor.OPT.ResolutionX;
	ELSE
		gVisionSensor.OPT.PixelSizeBinning_um		:= 0;
		gVisionSensor.OPT.DistanceLens_mm			:= 0;
		gVisionSensor.OPT.CircleOfConfusion_mm		:= 0;
		gVisionSensor.OPT.HyperFocalDistance_mm		:= 0;
		gVisionSensor.OPT.DepthOfFieldNearPos_mm	:= 0;
		gVisionSensor.OPT.DepthOfFieldFarPos_mm		:= 0;
		gVisionSensor.OPT.DepthOfField_mm			:= 0;
		gVisionSensor.OPT.FieldOfView_X_mm			:= 0;
		gVisionSensor.OPT.FieldOfView_Y_mm			:= 0;
		gVisionSensor.OPT.Resolution_mmPerPx		:= 0;
	END_IF
	

END_PROGRAM
