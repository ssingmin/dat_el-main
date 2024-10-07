(********************************************************************
 * COPYRIGHT -- Bernecker + Rainer
 ********************************************************************
 * Program: MbApp
 * File: MbApp.st
 * Author: Bernecker + Rainer
 * Created: October 22, 2009
 ********************************************************************
 * Implementation of program MbApp
 ********************************************************************)

PROGRAM _INIT

	(* init values *)
	mb_station 			:= 'IF2.ST40';					(* path to modbus station *)
	register_address	:= 16#2400;						(* register address on modbus station *)
	register_value		:= 2#1010101010101010;			(* register value to write *)
	coil_address		:= 16#0;						(* coils address on modbus station *)
	fub_status			:= 0;							(* status of function blocks *)
	mb_exception		:= 0;							(* modbus exception *)
	
	instruction			:= mbMFC_WRITE_SINGLE_REGISTER;	(* start instruction *)

END_PROGRAM


PROGRAM _CYCLIC

	(* WORKING STATE MACHINE *)
	CASE (instruction) OF
	
		mbMFC_WRITE_SINGLE_REGISTER:
			mbWriteSingleRegister_0.enable 			:= 1;
			mbWriteSingleRegister_0.pStation 		:= ADR(mb_station);
			mbWriteSingleRegister_0.startAddress 	:= register_address;
			mbWriteSingleRegister_0.value 			:= register_value;
			mbWriteSingleRegister_0();										(* call function block *)
			IF (mbWriteSingleRegister_0.status <> ERR_FUB_BUSY) THEN
   				fub_status 			:= mbWriteSingleRegister_0.status;
				check_status 		:= TRUE;			(* flag to check status *)
				instruction_ready 	:= TRUE;			(* flag marks instruction "ready" *)
			END_IF
			
		mbMFC_READ_COILS:
			mbReadCoils_0.enable := 1;
			mbReadCoils_0.pStation := ADR(mb_station);
   			mbReadCoils_0.startAddress := coil_address;
			mbReadCoils_0.nrCoils := 16;
			mbReadCoils_0.pData := ADR(coil_values);
   			mbReadCoils_0.dataSize := SIZEOF(coil_values);
			mbReadCoils_0();												(* call function block *)
   			IF (mbReadCoils_0.status <> ERR_FUB_BUSY) THEN
   				fub_status 			:= mbReadCoils_0.status;
				check_status 		:= TRUE;			(* flag to check status *)
				instruction_ready 	:= TRUE;			(* flag marks instruction "ready" *)
			END_IF			

		
	END_CASE
	
	
	
	(* ERROR HANDLING *)
	IF (check_status) THEN
 	
		CASE fub_status OF
  			
			ERR_OK:
				(* no error *)
			
			mbERR_EXCEPTION:
				(* modbus station response sent a modbus exception *)
				mbGetLastException_0.enable := 1;
				mbGetLastException_0.pStation := ADR(mb_station);
				mbGetLastException_0();										(* call function block *)
				mb_exception := mbGetLastException_0.mbExcp;			
				
			ELSE
   				(* other error handling *)			
				
		END_CASE		
	
		(* stop checking *)
		check_status := FALSE;
	END_IF	



	(* STATE MACHINE CONTROL *)
	IF (instruction_ready AND fub_status = ERR_OK) THEN
 	
		CASE (instruction) OF
	
			mbMFC_WRITE_SINGLE_REGISTER:
				instruction 		:= mbMFC_READ_COILS;
				instruction_ready 	:= FALSE;
				
			mbMFC_READ_COILS:
				instruction 		:= mbMFC_WRITE_SINGLE_REGISTER;
				instruction_ready 	:= FALSE;
				
		END_CASE
	
	END_IF	


END_PROGRAM
