(*estimate assembly power consumption and distribution*)
(*interface structure*)

TYPE
	TrakDesignType : 	STRUCT 
		AssemblyRef : REFERENCE TO McAssemblyType; (*assembly reference - ADR(gAssembly_1)*)
		AssemblyName : STRING[32]; (*assembly name - 'gAssembly_1'*)
		EnableCalc : BOOL; (*enable*)
		CmdReset : BOOL; (*command reset peak values*)
		CmdSaveReport : BOOL; (*command save report to file*)
		CmdRecordToolData : BOOL; (*command activate recording of TrakDesign-Tool data*)
		ParaShuttleType : TrakDesignShuttleTypeEnum; (*parameter shuttle type
SA100_50D......8F1SA.100.xxxxxx-1  50mm double sided magnet
SA102_50N......8F1SA.102.xxxxxx-1  50mm single sided magnet
SA201_100D....8F1SA.201.xxxxxx-1  100mm double sided magnet
SA203_100N....8F1SA.203.xxxxxx-1  100mm single sided magnet
SA104_50DS....8F1SA.104.xxxxxx-1  50mm double sided skewed magnet
SA106_50NS....8F1SA.106.xxxxxx-1  50mm single sided skewed magnet
SB308_210N....8F1SB.308.xxxxxx-1  21magnet pole single sided magnet*)
		ParaTempAmbient : REAL; (*parameter ambient air temperature [°C]*)
		ParaMechShuttleIx : UINT; (*parameter mechanical check - use shuttle index*)
		ParaFileDevice : STRING[32]; (*parameter FileDevice*)
		ParaFileNameReport : STRING[32]; (*parameter report file name - file extention .csv mandatory*)
		ParaFileNameToolData : STRING[32]; (*parameter TrakDesign-Tool data file name - file extention .dat mandatory*)
		ParaFileCsvStyle : USINT; (*parameter file csv style
0..english
1..german
2..mathlab*)
		ParaToolDataPrescale : USINT; (*parameter TrakDesign-Tool data prescaler - record TrakDesign-Tool data every x task cycles*)
		Message : STRING[256]; (*message*)
		TimeAsmPowerOn : REAL; (*monitor time elapsed since AsmPowerOn*)
		TimeShuttlesMoving : REAL; (*monitor time shuttles moving - for stabile Avg values process needs to run for >120sec*)
		TimeReset : REAL; (*monitor time elapsed since CmdReset*)
		TimeRecordToolDataActive : REAL; (*monitor time recording of TrakDesign-Tool data active*)
		NumShuttles : UINT; (*monitor number of shuttles present*)
		Carrier : TrakDesignCarrierType;
		Payload : ARRAY[1..8]OF TrakDesignPayloadType;
		Shuttle : ARRAY[1..TRAK_MAX_SHUTTLE]OF TrakDesignShuttleType;
		Segment : ARRAY[1..TRAK_MAX_SEGMENT]OF TrakDesignSegmentType;
		Cable : ARRAY[1..TRAK_MAX_POWER_CABLE]OF TrakDesignCableType;
		Supply : ARRAY[1..TRAK_MAX_POWER_SUPPLY]OF TrakDesignSupplyType;
		MainSupply : TrakDesignMainSupplyType;
		Mech : TrakDesignMechType;
	END_STRUCT;
	TrakDesignCarrierType : 	STRUCT 
		ParaMass : LREAL; (*parameter payload carrier mass [kg]*)
		ParaMassCenterX : LREAL; (*parameter payload carrier mass center of gravity offset X [m] (measured from center of shuttle, sign according to the shuttle coordinate system)*)
		ParaMassCenterY : LREAL; (*parameter payload carrier mass center of gravity offset Y [m] (measured from center of shuttle, sign according to the shuttle coordinate system)*)
		ParaMassCenterZ : LREAL; (*parameter payload carrier mass center of gravity offset Z [m] (measured from center of shuttle, sign according to the shuttle coordinate system)*)
		ParaMassInertiaZZ : LREAL; (*parameter payload carrier inertia ZZ [kgm? (with respect to the center of gravity of the carrier - set to 0.0 if unknown)*)
	END_STRUCT;
	TrakDesignPayloadType : 	STRUCT 
		ParaName : STRING[32]; (*parameter payload name (free definable name for identification of payload in report and mathlab)*)
		ParaMass : LREAL; (*parameter payload product mass [kg]*)
		ParaMassCenterX : LREAL; (*parameter payload product mass center of gravity offset X [m] (measured from center of shuttle, sign according to the shuttle coordinate system)*)
		ParaMassCenterY : LREAL; (*parameter payload product mass center of gravity offset Y [m] (measured from center of shuttle, sign according to the shuttle coordinate system)*)
		ParaMassCenterZ : LREAL; (*parameter payload product mass center of gravity offset Z [m] (measured from center of shuttle, sign according to the shuttle coordinate system)*)
		ParaMassInertiaZZ : LREAL; (*parameter payload product inertia ZZ [kgm? (with respect to the center of gravity of the payload - set to 0.0 if unknown)*)
		ParaExtFrictionX : LREAL; (*parameter external process friction [N] (sign according to the shuttle movement direction)*)
		ParaExtFrictionVelX : LREAL; (*parameter external process velocity-friction [N/(m/s)] (sign according to the shuttle movement direction)*)
		ParaExtForceX : LREAL; (*parameter external process force X [N] (sign according to the shuttle coordinate system)*)
		ParaExtForceY : LREAL; (*parameter external process force Y [N] (sign according to the shuttle coordinate system)*)
		ParaExtForceZ : LREAL; (*parameter external process force Z [N] (sign according to the shuttle coordinate system)*)
		ParaExtForceAppPointX : LREAL; (*parameter external process force application point offset X [m] (measured from center of shuttle, sign according to the shuttle coordinate system)*)
		ParaExtForceAppPointY : LREAL; (*parameter external process force application point offset Y [m] (measured from center of shuttle, sign according to the shuttle coordinate system)*)
		ParaExtForceAppPointZ : LREAL; (*parameter external process force application point offset Z [m] (measured from center of shuttle, sign according to the shuttle coordinate system)*)
	END_STRUCT;
	TrakDesignShuttleType : 	STRUCT 
		ParaPayloadIx : USINT; (*parameter payload index*)
		ParaAutoPayload : USINT; (*parameter autmatic payload selection 0..set PayloadIx explicit / 1..get payload index from ShSelCtrlParSet index*)
		ParaInitialOrientationFlip : INT; (*the initial orientation is different from the one indicated or located.[-]
  1 --> initial orientation is identical with the indicated or located one 
 -1 --> initial orientation is different with the indicated or located one *)
		ID : UINT; (*shuttle ID*)
		Vel : LREAL; (*shuttle velocity [m/s]*)
		Acc : LREAL; (*shuttle acceleration [m/s?*)
		Area : USINT; (*shuttle is in area 0..straight / 1..circular / 2..diverter*)
		Force : REAL; (*shuttle thrust force [N]*)
		Current : REAL; (*shuttle current [A]*)
		PowerCalcAct : REAL; (*monitor current shuttle power [W]*)
		PowerCalcAvg : REAL; (*monitor filtered shuttle power [W]*)
		VelStraightPeak : REAL; (*report peak shuttle velocity in straight trak area [m/s]*)
		AccStraightPeak : REAL; (*report peak shuttle acceleration in straight trak area [m/s?*)
		VelCircularPeak : REAL; (*report peak shuttle velocity in circular trak area [m/s]*)
		AccCircularPeak : REAL; (*report peak shuttle acceleration in circular trak area [m/s?*)
		VelDiverterPeak : REAL; (*report peak shuttle velocity in diverter area [m/s]*)
		AccDiverterPeak : REAL; (*report peak shuttle acceleration in diverter area [m/s?*)
		ForcePeak : REAL; (*report peak shuttle thrust Force [N]*)
		CurrentPeak : REAL; (*report peak shuttle current [A]*)
		PowerCalcActPeak : REAL; (*report peak current shuttle power [W]*)
		PowerCalcAvgPeak : REAL; (*report peak filitered shuttle power [W]*)
		CoilDisabled : USINT; (*report reduced force due to temporary disabled stator coil*)
	END_STRUCT;
	TrakDesignSegmentType : 	STRUCT 
		ParaName : STRING[32]; (*parameter segment name
name of segment reference variable of type McSegmentType connected to this segment in SystemDesigner*)
		ParaType : TrakDesignSegmentTypeEnum; (*parameter segment type
TYPE_AA
TYPE_AB
TYPE_BA
TYPE_BB*)
		ParaIxCable : USINT; (*parameter segment connected to cable index*)
		ID : UINT; (*segment ID*)
		PowerCalcAct : REAL; (*monitor current segment power [W]*)
		PowerCalcAvg : REAL; (*monitor filtered segment power [W]*)
		PowerCalcActPeak : REAL; (*report peak current segment power [W]*)
		PowerCalcAvgPeak : REAL; (*report peak filtered segment power [W]*)
		PowerCalcLoss : REAL; (*monitor current segment loss [W]*)
		PowerCalcLoad : REAL; (*monitor filtered segment Load [W]*)
		PowerCalcLossPeak : REAL; (*report peak current segment loss [W]*)
		PowerCalcLoadPeak : REAL; (*report peak filtered segment Load [W]*)
		CurrentBalancer : REAL; (*monitor balancer current [A]*)
		CurrentBalancerPeak : REAL; (*report peak balancer current [A]*)
		CoilDisabled : USINT; (*report reduced force due to temporary disabled stator coil*)
	END_STRUCT;
	TrakDesignCableType : 	STRUCT 
		ParaLength : REAL; (*parameter cable length [m]*)
		ParaIxSupply : USINT; (*parameter cable connected to PowerSupply index*)
		PowerCalcAct : REAL; (*monitor current cable power [W]*)
		PowerCalcAvg : REAL; (*monitor filtered cable power [W]*)
		PowerCalcActPeak : REAL; (*report peak cable shuttle power [W]*)
		PowerCalcAvgPeak : REAL; (*report peak cable shuttle power [W]*)
		VoltageDropAct : REAL; (*monitor voltage drop [V]*)
		VoltageDropActPeak : REAL; (*report peak voltage drop [V]*)
	END_STRUCT;
	TrakDesignSupplyType : 	STRUCT 
		ParaName : STRING[32]; (*parameter supply name
name of supply reference variable of type McAxisType connected to this BC032 in SystemDesigner*)
		ParaType : TrakDesignSupplyTypeEnum; (*parameter supply type
PS080...80PS080X3.10-01         1kW standalone power supply (ACOPOSmicro)
BC032...8B0C0320HW00.B00-1 2kW backplane power supply (ACOPOSmulti)*)
		ParaIxSupplyParallel : USINT; (*Parameter supply is parallel connected to supply index / 0..no parallel connection*)
		PowerCalcAct : REAL; (*monitor current supply power [W]*)
		PowerCalcAvg : REAL; (*monitor filtered supply power [W]*)
		PowerCalcActPeak : REAL; (*report peak current supply power [W]*)
		PowerCalcAvgPeak : REAL; (*report peak filitered supply power [W]*)
		PowerCalcRetPeak : REAL; (*report peak current return power [W]*)
		PowerMeasAct : REAL; (*monitor current supply power [W] (measured via IO)*)
		PowerMeasAvg : REAL; (*monitor filtered supply power [W] (measured via IO)*)
		PowerMeasActPeak : REAL; (*report peak current supply power [W] (measured via IO)*)
		PowerMeasAvgPeak : REAL; (*report peak filitered supply power [W] (measured via IO)*)
		PowerMeasRetPeak : REAL; (*report peak current return power [W] (measured via IO)*)
		IoPS080 : TrakDesignSupplyIoPS080Type;
		IoBC032 : TrakDesignSupplyIoBC032Type;
	END_STRUCT;
	TrakDesignSupplyIoPS080Type : 	STRUCT 
		ModuleOk : BOOL; (*PS080 IO*)
		CurrentLimitActive : BOOL; (*PS080 IO*)
		Voltage : SINT; (*PS080 IO [V]*)
		Current : INT; (*PS080 IO [0.1A]*)
		CmdClearError : BOOL; (*PS080 IO*)
		ErrorOutput : BOOL; (*PS080 IO*)
		ErrorOverload : BOOL; (*PS080 IO*)
		ErrorPhaseDetection : BOOL; (*PS080 IO*)
		ErrorOvertemperature : BOOL; (*PS080 IO*)
		ErrorOvervoltage : BOOL; (*PS080 IO*)
		ChopperActive : BOOL; (*PS080 IO*)
		ErrorChopperTemperature : BOOL; (*PS080 IO*)
		ErrorBleederTemperature : BOOL; (*PS080 IO*)
		ErrorOutput24VDC : BOOL; (*PS080 IO*)
	END_STRUCT;
	TrakDesignSupplyIoBC032Type : 	STRUCT 
		ModuleOk : BOOL; (*8B0C0320 IO module OK*)
		Iout : REAL; (*8B0C0320 IO Actual Output current [A]*)
		Uout : REAL; (*8B0C0320 IO Actual Output voltage [V]*)
		CrOk : BOOL; (*8B0C0320 IO state charging relais 1..OK*)
		StatusRunMode : USINT; (*8B0C0320 IO Operating mode 0..INIT / 1..READY / 2..ACTIVE / 3..ERROR*)
		ErrorsPacked : UDINT; (*8B0C0320 IO ErrorsPacked - Register ERROR_REG*)
		WarningsPacked : UDINT; (*8B0C0320 IO WarningsPacked - Register WARN_REG*)
	END_STRUCT;
	TrakDesignMainSupplyType : 	STRUCT 
		PowerCalcAct : REAL; (*monitor current main supply power [W]*)
		PowerCalcAvg : REAL; (*monitor filtered main supply power [W]*)
		PowerCalcActPeak : REAL; (*report peak current main supply power [W]*)
		PowerCalcAvgPeak : REAL; (*report peak filitered main supply power [W]*)
		PowerCalcRetPeak : REAL; (*report peak current main return power [W]*)
		PowerMeasAct : REAL; (*monitor current main supply power [W] (measured via IO)*)
		PowerMeasAvg : REAL; (*monitor filtered main supply power [W] (measured via IO)*)
		PowerMeasActPeak : REAL; (*report peak current main supply power [W] (measured via IO)*)
		PowerMeasAvgPeak : REAL; (*report peak filitered main supply power [W] (measured via IO)*)
		PowerMeasRetPeak : REAL; (*report peak current main return power [W] (measured via IO)*)
	END_STRUCT;
	TrakDesignMechType : 	STRUCT 
		ShuttleIx : UINT;
		ShuttleID : UINT;
		PayloadIx : USINT; (*parameter payload index*)
		ResultThrust : BOOL; (*report thrust force 0..ok / 1..force insufficient*)
		ResultMech : BOOL; (*report mechanical failure 0..ok / 1..shuttle leaving guiding rails*)
		GlobalFrame : McFrameType;
		SectorName : STRING[32];
		SectorPosition : LREAL;
		SectorVelocity : LREAL;
		SectorAcceleration : LREAL;
		SectorOrientation : McDirectionEnum;
		SegmentValid : ARRAY[0..3]OF BOOL;
		SegmentID : ARRAY[0..3]OF UINT;
		SegmentName : ARRAY[0..3]OF STRING[32];
		SegmentTyp : ARRAY[0..3]OF TrakDesignSegmentTypeEnum;
		SegmentLength : ARRAY[0..3]OF LREAL;
		SegmentPosition : ARRAY[0..3]OF LREAL;
		SegmentFieldMode : ARRAY[0..3]OF McAcpTrakFieldModeEnum;
	END_STRUCT;
END_TYPE

(*interface TrakDesign shuttle online interaction*)

TYPE
	TrakDesignOnlineFunctionJobType : 	STRUCT 
		LockNew : UDINT;
		Axis : McAxisType;
		ShuttleID : UINT;
		Cmd : USINT;
		PayloadIx : USINT;
		spare : ARRAY[0..3]OF UDINT;
		LockEnd : UDINT;
	END_STRUCT;
END_TYPE

(*TrakDesign-Tool data (diagnosis-data)*)

TYPE
	TrakDesignDiagParaType : 	STRUCT 
		VersionDataStruct : UDINT := 2;
		VersionMappMotion : ARRAY[0..9]OF USINT;
		VersionTrakDesignTask : ARRAY[0..9]OF USINT;
		CycleTime : REAL;
		Prescaler : USINT;
		ShuttleType : UINT;
		TempAmbient : REAL;
		PayloadCnt : UINT;
		Carrier : TrakDesignDiagParaCarrierType;
		Payload : ARRAY[1..8]OF TrakDesignDiagParaPayloadType;
		SegmentCnt : UINT;
		Segment : ARRAY[1..TRAK_MAX_SEGMENT]OF TrakDesignDiagParaSegmentType;
		CableCnt : UINT;
		Cable : ARRAY[1..TRAK_MAX_POWER_CABLE]OF TrakDesignDiagParaCableType;
		SupplyCnt : UINT;
		Supply : ARRAY[1..TRAK_MAX_POWER_SUPPLY]OF TrakDesignDiagParaSupplyType;
	END_STRUCT;
	TrakDesignDiagParaCarrierType : 	STRUCT 
		Mass : LREAL;
		MassCenterX : LREAL;
		MassCenterY : LREAL;
		MassCenterZ : LREAL;
		MassInertiaZZ : LREAL;
	END_STRUCT;
	TrakDesignDiagParaPayloadType : 	STRUCT 
		Name : STRING[32];
		Mass : LREAL;
		MassCenterX : LREAL;
		MassCenterY : LREAL;
		MassCenterZ : LREAL;
		MassInertiaZZ : LREAL;
		ExtFrictionX : LREAL;
		ExtFrictionVelX : LREAL;
		ExtForceX : LREAL;
		ExtForceY : LREAL;
		ExtForceZ : LREAL;
		ExtForceAppPointX : LREAL;
		ExtForceAppPointY : LREAL;
		ExtForceAppPointZ : LREAL;
	END_STRUCT;
	TrakDesignDiagParaSegmentType : 	STRUCT 
		Ix : UINT;
		ID : UINT;
		Name : STRING[32];
		Type : TrakDesignSegmentTypeEnum;
		IxCable : UINT;
	END_STRUCT;
	TrakDesignDiagParaCableType : 	STRUCT 
		Ix : UINT;
		Length : REAL;
		IxSupply : UINT;
	END_STRUCT;
	TrakDesignDiagParaSupplyType : 	STRUCT 
		Ix : UINT;
		Type : TrakDesignSupplyTypeEnum;
		IxSupplyParallel : UINT;
	END_STRUCT;
	TrakDesignDiagType : 	STRUCT 
		RecordIndex : UDINT;
		Time : REAL;
		MechShuttleIx : UINT;
		MechResultThrust : BOOL;
		MechResultMech : BOOL;
		AddData : ARRAY[0..4]OF LREAL;
		SegmentCnt : UINT;
		Segment : ARRAY[1..TRAK_MAX_SEGMENT]OF TrakDesignDiagSegmentType;
		ShuttleCnt : UINT;
		Shuttle : ARRAY[1..TRAK_MAX_SHUTTLE]OF TrakDesignDiagShuttleType;
	END_STRUCT;
	TrakDesignDiagSegmentType : 	STRUCT 
		CalcPower : REAL;
		CalcLoss : REAL;
	END_STRUCT;
	TrakDesignDiagShuttleType : 	STRUCT 
		ID : UINT;
		GlobalFrame : McFrameType;
		SectorVelocity : LREAL;
		SectorAcceleration : LREAL;
		SectorOrientation : McDirectionEnum;
		PayloadIx : UINT;
		GripperCnt : UINT;
		GripperSegValid : ARRAY[0..3]OF BOOL;
		GripperSegIx : ARRAY[0..3]OF UINT;
		GripperSegPosition : ARRAY[0..3]OF LREAL;
		GripperSegFieldMode : ARRAY[0..3]OF McAcpTrakFieldModeEnum;
	END_STRUCT;
END_TYPE

(*supply-data (ServoSoft-import-data)*)

TYPE
	TrakDesignSupplyDataType : 	STRUCT 
		Time : LREAL;
		Power : ARRAY[0..TRAK_MAX_POWER_SUPPLY]OF REAL;
	END_STRUCT;
END_TYPE

(*enum*)

TYPE
	TrakDesignShuttleTypeEnum : 
		(
		SHUTTLE_UNDEFINED := 0,
		SA100_50D := 100, (*8F1SA.100.xxxxxx-1  50mm double sided magnet*)
		SA102_50N := 102, (*8F1SA.102.xxxxxx-1  50mm single sided magnet*)
		SA201_100D := 201, (*8F1SA.201.xxxxxx-1  100mm double sided magnet*)
		SA203_100N := 203, (*8F1SA.203.xxxxxx-1  100mm single sided magnet*)
		SA104_50DS := 104, (*8F1SA.104.xxxxxx-1  50mm double sided skewed magnet*)
		SA106_50NS := 106, (*8F1SA.106.xxxxxx-1  50mm single sided skewed magnet*)
		SHUTTLE_205 := 205, (*internal*)
		SHUTTLE_207 := 207, (*internal*)
		SB308_210N := 1308, (*8F1SB.308.xxxxxx-1  21magnet pole single sided magnet*)
		SHUTTLE_9100 := 9100, (*internal*)
		SHUTTLE_65535 := 65535 (*internal*)
		);
	TrakDesignSegmentTypeEnum : 
		(
		SEGMENT_UNDEFINED := 0,
		TYPE_AA := 1, (*AA Straight segment*)
		TYPE_AB := 2, (*AB Curved segment*)
		TYPE_BA := 3, (*BA Curved segment*)
		TYPE_BB := 4 (*BB Circular arc segment*)
		);
	TrakDesignSupplyTypeEnum : 
		(
		SUPPLY_UNDEFINED := 0,
		PS080 := 1, (*80PS080X3.10-01 1kW standalone power supply (ACOPOSmicro)*)
		BC032 := 2 (*8B0C0320HW00.B00-1 2kW backplane power supply (ACOPOSmulti)*)
		);
	TrakDesignStepGetShuttleEnum : 
		(
		TRAK_DISABLED := 0,
		TRAK_WAIT,
		TRAK_GET_SHUTTLE_INIT,
		TRAK_GET_SHUTTLE,
		TRAK_GET_SHUTTLE_WAIT,
		TRAK_INIT,
		TRAK_READY,
		TRAK_ERROR
		);
END_TYPE
