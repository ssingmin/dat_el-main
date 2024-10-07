//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 
// Copyright B&R Industrial Automation GmbH
// Author    B&R
// Created   Feb 1, 2018
// 
// trak assembly design support task (optional)
// TC#1 => mandatory to be attached to mappMotion task class
// 
// * calculates/estimates the assembly power consumption
// * calculates/estimates the segment power losses
// * analyzes the mechanical situation (does the shuttle stay in the standard-B&R guiding rails?, ist thrust force sufficient?)
// * suitable for use in ARsim (and on real HW)
// 
// "TrakDesign" - local interface structure
// "gTrakDesignShuttleOnline" - global interface structure, not mandatory
//
// CAUTION: this task can cause high CPU load on real HW
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



PROGRAM _INIT

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// configuration

	// general parameter
	TrakDesign.AssemblyRef			:= ADR(gAsmMain);
	TrakDesign.AssemblyName			:= 'gAsmMain';
	TrakDesign.EnableCalc			:= DiagCpuIsSimulated();	//TRUE;
	TrakDesign.CmdReset				:= FALSE;
	TrakDesign.CmdSaveReport		:= FALSE;
	TrakDesign.CmdRecordToolData	:= FALSE;

	TrakDesign.ParaShuttleType		:= SA102_50N;			//SA201_100D
	TrakDesign.ParaTempAmbient		:= 25;

	//	TrakDesign.ParaMechShuttleIx	:= 1;
	TrakDesign.ParaFileDevice		:= 'SvgData';
	TrakDesign.ParaFileNameReport	:= 'TrakDesignReport.csv';
	TrakDesign.ParaFileNameToolData	:= 'TrakDesignToolData.dat';
	TrakDesign.ParaFileCsvStyle		:= 0;
	TrakDesign.ParaToolDataPrescale	:= 10;

	// shuttle payload parameter
	// carrier
	TrakDesign.Carrier.ParaMass					:= 1.2;			// [kg]
	TrakDesign.Carrier.ParaMassCenterX			:= 0.0;			// [m]
	TrakDesign.Carrier.ParaMassCenterY			:= 0.0;			// [m]
	TrakDesign.Carrier.ParaMassCenterZ			:= 0.0;			// [m]
	TrakDesign.Carrier.ParaMassInertiaZZ		:= 0.0;			// [kg m^2]	
	// product
	TrakDesign.Payload[1].ParaName				:= 'no product on carrier';
	TrakDesign.Payload[1].ParaMass				:= 0.0;			// [kg]
	TrakDesign.Payload[1].ParaMassCenterX		:= 0.0;			// [m]
	TrakDesign.Payload[1].ParaMassCenterY		:= 0.0;			// [m]
	TrakDesign.Payload[1].ParaMassCenterZ		:= 0.0;			// [m]
	TrakDesign.Payload[1].ParaMassInertiaZZ		:= 0.0;			// [kg m^2]
	// external friction/force
	TrakDesign.Payload[1].ParaExtFrictionX		:= 0.0;			// [N]
	TrakDesign.Payload[1].ParaExtFrictionVelX	:= 0.0;			// [N/(m/s)]
	TrakDesign.Payload[1].ParaExtForceX			:= 0.0;			// [N]
	TrakDesign.Payload[1].ParaExtForceY			:= 0.0;			// [N]
	TrakDesign.Payload[1].ParaExtForceZ			:= 0.0;			// [N]
	TrakDesign.Payload[1].ParaExtForceAppPointX	:= 0.0;			// [m]
	TrakDesign.Payload[1].ParaExtForceAppPointY	:= 0.0;			// [m]
	TrakDesign.Payload[1].ParaExtForceAppPointZ	:= 0.0;			// [m]
	
	FOR i:=1 TO TRAK_MAX_SHUTTLE DO
		TrakDesign.Shuttle[i].ParaPayloadIx					:= 1;
		TrakDesign.Shuttle[i].ParaAutoPayload				:= 0;
		//		TrakDesign.Shuttle[i].ParaInitialOrientationFlip	:= 1;
	END_FOR

	// electrical segment assembly
	TrakDesign.Segment[1].ParaName 	:= 'Seg_A_1';		TrakDesign.Segment[1].ParaType := TYPE_BB;		TrakDesign.Segment[1].ParaIxCable := 1;
	TrakDesign.Segment[2].ParaName 	:= 'Seg_A_2';		TrakDesign.Segment[2].ParaType := TYPE_BA;		TrakDesign.Segment[2].ParaIxCable := 1;
	TrakDesign.Segment[3].ParaName 	:= 'Seg_A_3';		TrakDesign.Segment[3].ParaType := TYPE_AA;		TrakDesign.Segment[3].ParaIxCable := 2;
	TrakDesign.Segment[4].ParaName 	:= 'Seg_A_4';		TrakDesign.Segment[4].ParaType := TYPE_AA;		TrakDesign.Segment[4].ParaIxCable := 2;
	TrakDesign.Segment[5].ParaName 	:= 'Seg_A_5';		TrakDesign.Segment[5].ParaType := TYPE_AA;		TrakDesign.Segment[5].ParaIxCable := 2;
	TrakDesign.Segment[6].ParaName 	:= 'Seg_A_6';		TrakDesign.Segment[6].ParaType := TYPE_AA;		TrakDesign.Segment[6].ParaIxCable := 2;
	TrakDesign.Segment[7].ParaName 	:= 'Seg_A_7';		TrakDesign.Segment[7].ParaType := TYPE_AA;		TrakDesign.Segment[7].ParaIxCable := 3;
	TrakDesign.Segment[8].ParaName 	:= 'Seg_A_8';		TrakDesign.Segment[8].ParaType := TYPE_AB;		TrakDesign.Segment[8].ParaIxCable := 3;
	TrakDesign.Segment[9].ParaName 	:= 'Seg_A_9';		TrakDesign.Segment[9].ParaType := TYPE_BB;		TrakDesign.Segment[9].ParaIxCable := 3;
	TrakDesign.Segment[10].ParaName := 'Seg_A_10';		TrakDesign.Segment[10].ParaType := TYPE_BA;		TrakDesign.Segment[10].ParaIxCable := 3;
	TrakDesign.Segment[11].ParaName := 'Seg_A_11';		TrakDesign.Segment[11].ParaType := TYPE_AA;		TrakDesign.Segment[11].ParaIxCable := 4;
	TrakDesign.Segment[12].ParaName := 'Seg_A_12';		TrakDesign.Segment[12].ParaType := TYPE_AA;		TrakDesign.Segment[12].ParaIxCable := 4;
	TrakDesign.Segment[13].ParaName := 'Seg_A_13';		TrakDesign.Segment[13].ParaType := TYPE_AB;		TrakDesign.Segment[13].ParaIxCable := 4;
	TrakDesign.Segment[14].ParaName := 'Seg_A_14';		TrakDesign.Segment[14].ParaType := TYPE_BB;		TrakDesign.Segment[14].ParaIxCable := 4;
	TrakDesign.Segment[15].ParaName := 'Seg_A_15';		TrakDesign.Segment[15].ParaType := TYPE_BA;		TrakDesign.Segment[15].ParaIxCable := 4;
	TrakDesign.Segment[16].ParaName := 'Seg_A_16';		TrakDesign.Segment[16].ParaType := TYPE_AA;		TrakDesign.Segment[16].ParaIxCable := 5;
	TrakDesign.Segment[17].ParaName := 'Seg_A_17';		TrakDesign.Segment[17].ParaType := TYPE_AA;		TrakDesign.Segment[17].ParaIxCable := 5;
	TrakDesign.Segment[18].ParaName := 'Seg_A_18';		TrakDesign.Segment[18].ParaType := TYPE_AA;		TrakDesign.Segment[18].ParaIxCable := 5;
	TrakDesign.Segment[19].ParaName := 'Seg_A_19';		TrakDesign.Segment[19].ParaType := TYPE_AA;		TrakDesign.Segment[19].ParaIxCable := 5;
	TrakDesign.Segment[20].ParaName := 'Seg_A_20';		TrakDesign.Segment[20].ParaType := TYPE_AA;		TrakDesign.Segment[20].ParaIxCable := 6;
	TrakDesign.Segment[21].ParaName := 'Seg_A_21';		TrakDesign.Segment[21].ParaType := TYPE_AB;		TrakDesign.Segment[21].ParaIxCable := 6;
	TrakDesign.Segment[22].ParaName := 'Seg_A_22';		TrakDesign.Segment[22].ParaType := TYPE_BB;		TrakDesign.Segment[22].ParaIxCable := 6;
	TrakDesign.Segment[23].ParaName := 'Seg_A_23';		TrakDesign.Segment[23].ParaType := TYPE_BA;		TrakDesign.Segment[22].ParaIxCable := 7;
	TrakDesign.Segment[24].ParaName := 'Seg_A_24';		TrakDesign.Segment[24].ParaType := TYPE_AA;		TrakDesign.Segment[22].ParaIxCable := 7;
	TrakDesign.Segment[25].ParaName := 'Seg_A_25';		TrakDesign.Segment[25].ParaType := TYPE_AA;		TrakDesign.Segment[22].ParaIxCable := 7;
	TrakDesign.Segment[26].ParaName := 'Seg_A_26';		TrakDesign.Segment[26].ParaType := TYPE_AB;		TrakDesign.Segment[22].ParaIxCable := 1;
	
	// power cable assembly
	TrakDesign.Cable[1].ParaLength := 10.0;						TrakDesign.Cable[1].ParaIxSupply := 1;
	TrakDesign.Cable[2].ParaLength := 10.0;						TrakDesign.Cable[2].ParaIxSupply := 2;
	TrakDesign.Cable[3].ParaLength := 10.0;						TrakDesign.Cable[3].ParaIxSupply := 3;
	TrakDesign.Cable[4].ParaLength := 10.0;						TrakDesign.Cable[4].ParaIxSupply := 4;
	TrakDesign.Cable[5].ParaLength := 5.0;						TrakDesign.Cable[5].ParaIxSupply := 5;
	TrakDesign.Cable[6].ParaLength := 5.0;						TrakDesign.Cable[6].ParaIxSupply := 6;
	TrakDesign.Cable[7].ParaLength := 5.0;						TrakDesign.Cable[6].ParaIxSupply := 7;
	// power supply assembly
	TrakDesign.Supply[1].ParaName := 'gAxis01';					TrakDesign.Supply[1].ParaType := BC032;			TrakDesign.Supply[1].ParaIxSupplyParallel := 1;
	TrakDesign.Supply[2].ParaName := 'gAxis01';					TrakDesign.Supply[2].ParaType := BC032;			TrakDesign.Supply[2].ParaIxSupplyParallel := 2;
	TrakDesign.Supply[3].ParaName := 'gAxis02';					TrakDesign.Supply[3].ParaType := BC032;			TrakDesign.Supply[3].ParaIxSupplyParallel := 3;
	TrakDesign.Supply[4].ParaName := 'gAxis02';					TrakDesign.Supply[4].ParaType := BC032;			TrakDesign.Supply[4].ParaIxSupplyParallel := 4;
	TrakDesign.Supply[5].ParaName := 'gAxis03';					TrakDesign.Supply[5].ParaType := BC032;			TrakDesign.Supply[5].ParaIxSupplyParallel := 5;
	TrakDesign.Supply[6].ParaName := 'gAxis03';					TrakDesign.Supply[6].ParaType := BC032;			TrakDesign.Supply[6].ParaIxSupplyParallel := 6;
	TrakDesign.Supply[7].ParaName := 'gAxis04';					TrakDesign.Supply[7].ParaType := BC032;			TrakDesign.Supply[7].ParaIxSupplyParallel := 7;
	
	ExpertReport := TRUE;
	CreateFileHistory := TRUE;

	Action_INIT;
	
END_PROGRAM
