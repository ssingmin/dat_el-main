(**)
(*Function Blocks*)

{REDUND_ERROR} FUNCTION_BLOCK MyTrak_ShInfeeder (*Buffer Handle based Productivity *) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Enable : BOOL; (*Enable/Disable*)
		ProcessPoint : REFERENCE TO McProcessPointType; (*Stop Position Process Point*)
		SetPPM : UINT; (*SettedPPM*)
		CountOfOneShot : USINT; (*Supply Shuttle Count at once*)
		Process : BOOL; (*Feeding Start/Stop*)
		Pause : BOOL; (*Puase when feeding is started*)
		Manual : BOOL; (*Manual Input when Feeding is Stopped - Positive Trigger*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Activated FunctionBlock*)
		Error : BOOL; (*Error Status - Not Implemented*)
		ErrorID : DINT; (*Function Block Status - refer to Constant*)
		ActPPM : UINT; (*Actual PPM*)
		Interval : REAL; (*Feeding Interval*)
	END_VAR
	VAR
		Internal : MyTrak_ShInfeeder_Internal_type;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION_BLOCK MyTrak_Buffer (*Buffer Handing based Productivity*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Enable : BOOL; (*Activate Function Block*)
		CheckInProcessPoint : REFERENCE TO McProcessPointType; (*Check In Process Point*)
		CheckOutProcessPoint : REFERENCE TO McProcessPointType; (*Check Out Process Point*)
		TargetStage : UDINT; (*Reference of Target Stage(MyTrakSlotType array)*)
		TargetSlotCount : USINT; (*Count of slot in target stage*)
		Process : BOOL; (*Process Start And Stop*)
		Feeding : BOOL; (*Holding Process*)
		Manual : BOOL; (*Manual Feeding*)
		SetPPM : UINT; (*Set PPM*)
		CountOfOneShot : USINT; (*Feeding Shuttle Count of One Time*)
		MaximumShuttleCount : USINT; (*Maximum Handle Shuttle Count*)
		Velocity : REAL; (*Velocity from Buffer to 'Target Stage'*)
		Acceleration : REAL; (*Acceleration from Buffer to 'Target Stage'*)
		Deceleration : REAL; (*Deceleration from Buffer to 'Target Stage'*)
		AdvancedParameters : McAcpTrakAdvRouteParType; (*Advanced Parameter*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Activate Status*)
		Error : BOOL; (*Error Status*)
		ErrorID : DINT; (*Error ID*)
		CountOfShuttle : USINT; (*Total Shuttle by Handled By this FunctionBlock*)
		CountOfBuffer : USINT; (*Shuttle Count in Buffer*)
		CountOfSupplied : UDINT; (*Shuttle Count in Buffer*)
		NextSlotNo : INT; (*Next Slot Number*)
		Interval : REAL; (*Feeding Interval*)
	END_VAR
	VAR
		Internal : MyTrak_Buffer_Internal_type;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION_BLOCK MyTrak_ServeStage (*Move shuttles  from source process point to stage*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Enable : BOOL; (*Activate Function Block*)
		SourceProcessPoint : REFERENCE TO McProcessPointType; (*Reference of Process Point that shuttle getting*)
		TargetStage : UDINT; (*Reference of Target Stage(MyTrakSlotType array)*)
		TargetSlotCount : USINT; (*Count of slot in target stage*)
		MaximumShuttleCount : USINT; (*Maximum Handle Shuttle Count*)
		MinimumShuttleCount : USINT; (*Minimum Shuttle Handle Count at one time*)
		Velocity : REAL; (*Velocity from 'Source Stage' to 'Target Stage'.*)
		Acceleration : REAL; (*Acceleration from Source Process Point*)
		Deceleration : REAL; (*Deceleration from Source Process Point *)
		AdvancedParameters : McAcpTrakAdvRouteParType; (*Advanced Parameter*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Activate Status*)
		Error : BOOL; (*Error Status*)
		ErrorID : DINT; (*Error ID*)
		CountOfShuttle : INT; (*Count of Shuttles*)
		NextSlotNo : INT; (*Next Placed Slot*)
	END_VAR
	VAR
		Internal : MyTrak_ServeStage_Internal_type;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION_BLOCK MyTrak_TransStage (*Move shuttles from source stage to target stage *) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Enable : BOOL; (*Activate Function Block*)
		SourceStage : {REDUND_UNREPLICABLE} ARRAY[0..9] OF UDINT; (*Reference of Source Stage(Reference of 'MyTrakSlotType' array)*)
		SourceSlotCount : {REDUND_UNREPLICABLE} ARRAY[0..9] OF USINT; (*Source Stage Slot Count*)
		TargetStage : {REDUND_UNREPLICABLE} UDINT; (*Reference of Target Stage(Reference of 'MyTrakSlotType' array)*)
		TargetSlotCount : USINT; (*Target Stage Slot Count*)
		MaximumShuttleCount : USINT; (*Maximum Shuttle Count between 'End of Source Slot' to 'End of Target Slot')*)
		Process : BOOL; (*Transfer Start / Stop*)
		Manual : BOOL; (*Manual Feeding One Shuttle(By Positive Edge)*)
		Velocity : REAL; (*Velocity from 'Source Stage' to 'Target Stage'.*)
		Acceleration : REAL; (*Acceleration from 'Source Stage' to 'Target Stage'.*)
		Deceleration : REAL; (*Deceleration from 'Source Stage' to 'Target Stage'*)
		AdvancedParameters : McAcpTrakAdvRouteParType; (*Advanced Parameter for Make Routing - Refer *)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Activate Status*)
		Error : BOOL; (*Error Status*)
		ErrorID : DINT; (*Error ID*)
		CountOfShuttle : INT; (*Count of Shuttles*)
		NextSlotNo : INT; (*Next Placed Slot*)
	END_VAR
	VAR
		Internal : MyTrak_TransStage_Internal_type;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION_BLOCK MyTrak_Serialize (*Move shuttles from source stage to target sector*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Enable : BOOL; (*Activate Function Block*)
		SourceStage : ARRAY[0..9] OF UDINT; (*Reference of Source Stage(Reference of MyTrakSlotType array)*)
		SourceSlotCount : ARRAY[0..9] OF USINT; (*Source Array Count*)
		TargetSector : REFERENCE TO McSectorType; (*Reference of Target Sector(Reference of McSectorType)*)
		TargetPosition : LREAL; (*Target Sector Position*)
		Process : BOOL; (*Serialize Start / Stop*)
		Manual : BOOL; (*Manual Feeding One Shuttle(By Positive Edge)*)
		RoutedVelocity : REAL; (*Routed Velocity from Stage to Target Position*)
		Velocity : REAL; (*Velocty from Target Position Of Sector*)
		Acceleration : REAL; (*Acceleration*)
		Deceleration : REAL; (*Deceleration*)
		AdvancedParameters : McAcpTrakAdvRouteParType; (*Advanced Parameter for moving*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Activate Status*)
		Error : BOOL; (*Error Status*)
		ErrorID : DINT; (*Error ID or Status ID*)
		CountOfShuttle : INT; (*Count of shuttle by handled by this FunctionBlock*)
	END_VAR
	VAR
		Internal : MyTrak_Serialize_Internal_type;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION_BLOCK MyTrak_UntilStop (*Not Implemented*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		SourceSector : REFERENCE TO McSectorType;
		SourceStart : LREAL;
		SourceEnd : LREAL;
		Execute : REAL;
		TargetSector : REFERENCE TO McSectorType;
		TargetPosition : REAL;
		RoutedVelocity : REAL;
		Velocity : REAL;
		Acceleration : REAL;
		Deceleration : REAL;
		AdvancedParameters : McAcpTrakAdvRouteParType;
	END_VAR
	VAR_OUTPUT
		Active : BOOL;
		Error : BOOL;
		ErrorID : DINT;
		Done : BOOL;
		CountOfShuttle : INT;
	END_VAR
	VAR
		Internal : MyTrak_UntilStop_Internal_type;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION_BLOCK MyTrak_TicketArea (*Keep shuttles count between two process point*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Enable : BOOL; (*Activating Function Block*)
		InPoint : REFERENCE TO McProcessPointType; (*Start Point*)
		OutPoint : REFERENCE TO McProcessPointType; (*End Point*)
		MaximumShuttleCount : USINT; (*Keeping Shuttle Count*)
		InitShuttleCount : USINT; (*Initial Shuttle Count(It means shuttle count of prcess In to Process Out before activatiing*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Activate Status*)
		Error : BOOL; (*Error Status*)
		ErrorID : DINT; (*Status ID*)
		Processing : BOOL;
		Passed : BOOL;
		ShuttleCount : USINT;
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MyTrak_TicketArea_Internal_type;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION_BLOCK MyTrak_ChangeVel (*Change Shuttle Velocity at Specific Process Point*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Enable : BOOL; (*Enable*)
		ProcessPoint : REFERENCE TO McProcessPointType;
		Velocity : REAL; (*Changing Velocity*)
		Acceleration : REAL; (*Changing Acceleration*)
		Deceleration : {REDUND_UNREPLICABLE} REAL; (*Chagneing Deceleration*)
		Direction : {REDUND_UNREPLICABLE} McDirectionEnum; (*Changing Direction*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Enable Status*)
		Error : BOOL; (*Error Existing*)
		ErrorID : DINT; (*Error ID*)
	END_VAR
	VAR
		Internal : MyTrak_ChangeVel_Internal_type; (*Internal Variable*)
	END_VAR
END_FUNCTION_BLOCK
(**)
(*Functions*)

{REDUND_ERROR} FUNCTION GetProcessReady : BOOL (*All Stage Process Ready Status*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Stage : UDINT;
		SlotCount : USINT;
	END_VAR
END_FUNCTION

{REDUND_ERROR} FUNCTION GetProcessing : BOOL (*All Stage Processing Status*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Stage : UDINT;
		SlotCount : USINT;
	END_VAR
END_FUNCTION

{REDUND_ERROR} FUNCTION GetStageStatus : E_SLOT_IF_STATE (*All Stage Process Ready Status*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Stage : UDINT;
		SlotCount : USINT;
	END_VAR
END_FUNCTION

{REDUND_ERROR} FUNCTION InitializeFcBank : BOOL (*Initialize Maximum Movement FunctionBlock Count*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		shuttleCount : UINT;
	END_VAR
END_FUNCTION

{REDUND_ERROR} FUNCTION Random : BOOL (*Get RandomValue in Boolean*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Percent : REAL; (*Percent of return 'TRUE'*)
	END_VAR
END_FUNCTION
