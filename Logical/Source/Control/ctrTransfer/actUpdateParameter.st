
ACTION actUpdateParamter: 
	
	// Stage pararmeter setting
	FOR i := 0 TO 18 DO
		StStage[i].Enable	:= TRUE;
	END_FOR;
	
	StStage[0].Position			:= POS_STAGE1 + gPar.PositionOffset.Stage[0];
	StStage[1].Position			:= POS_STAGE2 + gPar.PositionOffset.Stage[1];
	StStage[2].Position			:= POS_STAGE3 + gPar.PositionOffset.Stage[2];
	StStage[3].Position			:= POS_STAGE4 + gPar.PositionOffset.Stage[3];
	StStage[4].Position			:= POS_STAGE5 + gPar.PositionOffset.Stage[4];
	StStage[5].Position			:= POS_STAGE6 + gPar.PositionOffset.Stage[5];
	StStage[6].Position			:= POS_STAGE7 + gPar.PositionOffset.Stage[6];
	StStage[7].Position			:= POS_STAGE8 + gPar.PositionOffset.Stage[7];
	StStage[8].Position			:= POS_STAGE9 + gPar.PositionOffset.Stage[8];
	StStage[9].Position			:= POS_STAGE10 + gPar.PositionOffset.Stage[9];
	StStage[10].Position		:= POS_STAGE11 + gPar.PositionOffset.Stage[10];
	StStage[11].Position		:= POS_STAGE12 + gPar.PositionOffset.Stage[11];
	StStage[12].Position		:= POS_STAGE13 + gPar.PositionOffset.Stage[12];
	StStage[13].Position		:= POS_STAGE14 + gPar.PositionOffset.Stage[13];
	StStage[14].Position		:= POS_STAGE15 + gPar.PositionOffset.Stage[14];
	StStage[15].Position		:= POS_STAGE16 + gPar.PositionOffset.Stage[15];
	StStage[16].Position		:= POS_STAGE17 + gPar.PositionOffset.Stage[16];
	StStage[17].Position		:= POS_STAGE18 + gPar.PositionOffset.Stage[17];
	StStage[18].Position		:= POS_STAGE19 + gPar.PositionOffset.Stage[18];	
	
	// Movement pararmeter setting
	
	fbStage1.SetPPM										:= gPar.TargetPPM;
	fbStage1.CountOfOneShot								:= gPar.CountOfGroup;
	fbStage1.Velocity									:= gPar.MovementPar.Stage1.Velocity;
	fbStage1.Acceleration								:= gPar.MovementPar.Stage1.Acceleration;
	fbStage1.Deceleration								:= gPar.MovementPar.Stage1.Deceleration;
	fbStage1.AdvancedParameters.StartDirection 			:= mcDIR_POSITIVE;
	fbStage1.AdvancedParameters.EndDirection 			:= mcDIR_UNDEFINED;
	fbStage1.AdvancedParameters.ShuttleOrientation 		:= mcDIR_UNDEFINED;
	fbStage1.MaximumShuttleCount						:= gPar.MovementPar.Stage1.MaxController;

	fbStage2.Velocity									:= gPar.MovementPar.Stage2.Velocity;
	fbStage2.Acceleration								:= gPar.MovementPar.Stage2.Acceleration;
	fbStage2.Deceleration								:= gPar.MovementPar.Stage2.Deceleration;
	fbStage2.AdvancedParameters.StartDirection 			:= mcDIR_POSITIVE;
	fbStage2.AdvancedParameters.EndDirection 			:= mcDIR_UNDEFINED;
	fbStage2.AdvancedParameters.ShuttleOrientation 		:= mcDIR_UNDEFINED;
	fbStage2.MaximumShuttleCount						:= gPar.MovementPar.Stage2.MaxController;
	
	fbStage3.Velocity									:= gPar.MovementPar.Stage3.Velocity;
	fbStage3.Acceleration								:= gPar.MovementPar.Stage3.Acceleration;
	fbStage3.Deceleration								:= gPar.MovementPar.Stage3.Deceleration;
	fbStage3.AdvancedParameters.StartDirection 			:= mcDIR_POSITIVE;
	fbStage3.AdvancedParameters.EndDirection 			:= mcDIR_UNDEFINED;
	fbStage3.AdvancedParameters.ShuttleOrientation 		:= mcDIR_UNDEFINED;
	fbStage3.MaximumShuttleCount						:= gPar.MovementPar.Stage3.MaxController;
	
	fbStage4.Velocity									:= gPar.MovementPar.Stage4.Velocity;
	fbStage4.Acceleration								:= gPar.MovementPar.Stage4.Acceleration;
	fbStage4.Deceleration								:= gPar.MovementPar.Stage4.Deceleration;
	fbStage4.AdvancedParameters.StartDirection 			:= mcDIR_POSITIVE;
	fbStage4.AdvancedParameters.EndDirection 			:= mcDIR_UNDEFINED;
	fbStage4.AdvancedParameters.ShuttleOrientation 		:= mcDIR_UNDEFINED;
	fbStage4.MaximumShuttleCount						:= gPar.MovementPar.Stage4.MaxController;
	
	fbStage5.Velocity									:= gPar.MovementPar.Stage5.Velocity;
	fbStage5.Acceleration								:= gPar.MovementPar.Stage5.Acceleration;
	fbStage5.Deceleration								:= gPar.MovementPar.Stage5.Deceleration;
	fbStage5.AdvancedParameters.StartDirection 			:= mcDIR_POSITIVE;
	fbStage5.AdvancedParameters.EndDirection 			:= mcDIR_UNDEFINED;
	fbStage5.AdvancedParameters.ShuttleOrientation 		:= mcDIR_UNDEFINED;
	fbStage5.MaximumShuttleCount						:= gPar.MovementPar.Stage5.MaxController;
	
	fbStage6.Velocity									:= gPar.MovementPar.Stage6.Velocity;
	fbStage6.Acceleration								:= gPar.MovementPar.Stage6.Acceleration;
	fbStage6.Deceleration								:= gPar.MovementPar.Stage6.Deceleration;
	fbStage6.AdvancedParameters.StartDirection 			:= mcDIR_POSITIVE;
	fbStage6.AdvancedParameters.EndDirection 			:= mcDIR_UNDEFINED;
	fbStage6.AdvancedParameters.ShuttleOrientation 		:= mcDIR_UNDEFINED;
	fbStage6.MaximumShuttleCount						:= gPar.MovementPar.Stage6.MaxController;
	
	fbStage7.Velocity									:= gPar.MovementPar.Stage7.Velocity;
	fbStage7.Acceleration								:= gPar.MovementPar.Stage7.Acceleration;
	fbStage7.Deceleration								:= gPar.MovementPar.Stage7.Deceleration;
	fbStage7.AdvancedParameters.StartDirection 			:= mcDIR_POSITIVE;
	fbStage7.AdvancedParameters.EndDirection 			:= mcDIR_UNDEFINED;
	fbStage7.AdvancedParameters.ShuttleOrientation 		:= mcDIR_UNDEFINED;
	fbStage7.MaximumShuttleCount						:= gPar.MovementPar.Stage7.MaxController;
	
	fbStage8.Velocity									:= gPar.MovementPar.Stage8.Velocity;
	fbStage8.Acceleration								:= gPar.MovementPar.Stage8.Acceleration;
	fbStage8.Deceleration								:= gPar.MovementPar.Stage8.Deceleration;
	fbStage8.AdvancedParameters.StartDirection 			:= mcDIR_POSITIVE;
	fbStage8.AdvancedParameters.EndDirection 			:= mcDIR_UNDEFINED;
	fbStage8.AdvancedParameters.ShuttleOrientation 		:= mcDIR_UNDEFINED;
	fbStage8.MaximumShuttleCount						:= gPar.MovementPar.Stage8.MaxController;
	
	fbStage9.Velocity									:= gPar.MovementPar.Stage9.Velocity;
	fbStage9.Acceleration								:= gPar.MovementPar.Stage9.Acceleration;
	fbStage9.Deceleration								:= gPar.MovementPar.Stage9.Deceleration;
	fbStage9.AdvancedParameters.StartDirection 			:= mcDIR_POSITIVE;
	fbStage9.AdvancedParameters.EndDirection 			:= mcDIR_UNDEFINED;
	fbStage9.AdvancedParameters.ShuttleOrientation 		:= mcDIR_UNDEFINED;
	fbStage9.MaximumShuttleCount						:= gPar.MovementPar.Stage9.MaxController;
	
	fbStage10.Velocity									:= gPar.MovementPar.Stage10.Velocity;
	fbStage10.Acceleration								:= gPar.MovementPar.Stage10.Acceleration;
	fbStage10.Deceleration								:= gPar.MovementPar.Stage10.Deceleration;
	fbStage10.AdvancedParameters.StartDirection 		:= mcDIR_POSITIVE;
	fbStage10.AdvancedParameters.EndDirection 			:= mcDIR_UNDEFINED;
	fbStage10.AdvancedParameters.ShuttleOrientation 	:= mcDIR_UNDEFINED;
	fbStage10.MaximumShuttleCount						:= gPar.MovementPar.Stage10.MaxController;
	
	fbStage11.Velocity									:= gPar.MovementPar.Stage11.Velocity;
	fbStage11.Acceleration								:= gPar.MovementPar.Stage11.Acceleration;
	fbStage11.Deceleration								:= gPar.MovementPar.Stage11.Deceleration;
	fbStage11.AdvancedParameters.StartDirection 		:= mcDIR_POSITIVE;
	fbStage11.AdvancedParameters.EndDirection 			:= mcDIR_UNDEFINED;
	fbStage11.AdvancedParameters.ShuttleOrientation 	:= mcDIR_UNDEFINED;
	fbStage11.MaximumShuttleCount						:= gPar.MovementPar.Stage11.MaxController;
	
	fbStage12.Velocity									:= gPar.MovementPar.Stage12.Velocity;
	fbStage12.Acceleration								:= gPar.MovementPar.Stage12.Acceleration;
	fbStage12.Deceleration								:= gPar.MovementPar.Stage12.Deceleration;
	fbStage12.AdvancedParameters.StartDirection 		:= mcDIR_POSITIVE;
	fbStage12.AdvancedParameters.EndDirection 			:= mcDIR_UNDEFINED;
	fbStage12.AdvancedParameters.ShuttleOrientation 	:= mcDIR_UNDEFINED;
	fbStage12.MaximumShuttleCount						:= gPar.MovementPar.Stage12.MaxController;
	
	fbStage13.Velocity									:= gPar.MovementPar.Stage13.Velocity;
	fbStage13.Acceleration								:= gPar.MovementPar.Stage13.Acceleration;
	fbStage13.Deceleration								:= gPar.MovementPar.Stage13.Deceleration;
	fbStage13.AdvancedParameters.StartDirection 		:= mcDIR_POSITIVE;
	fbStage13.AdvancedParameters.EndDirection 			:= mcDIR_UNDEFINED;
	fbStage13.AdvancedParameters.ShuttleOrientation 	:= mcDIR_UNDEFINED;
	fbStage13.MaximumShuttleCount						:= gPar.MovementPar.Stage13.MaxController;
	
	fbStage14.Velocity									:= gPar.MovementPar.Stage14.Velocity;
	fbStage14.Acceleration								:= gPar.MovementPar.Stage14.Acceleration;
	fbStage14.Deceleration								:= gPar.MovementPar.Stage14.Deceleration;
	fbStage14.AdvancedParameters.StartDirection 		:= mcDIR_POSITIVE;
	fbStage14.AdvancedParameters.EndDirection 			:= mcDIR_UNDEFINED;
	fbStage14.AdvancedParameters.ShuttleOrientation 	:= mcDIR_UNDEFINED;
	fbStage14.MaximumShuttleCount						:= gPar.MovementPar.Stage14.MaxController;
	
	fbStage15.Velocity									:= gPar.MovementPar.Stage15.Velocity;
	fbStage15.Acceleration								:= gPar.MovementPar.Stage15.Acceleration;
	fbStage15.Deceleration								:= gPar.MovementPar.Stage15.Deceleration;
	fbStage15.AdvancedParameters.StartDirection 		:= mcDIR_POSITIVE;
	fbStage15.AdvancedParameters.EndDirection 			:= mcDIR_UNDEFINED;
	fbStage15.AdvancedParameters.ShuttleOrientation 	:= mcDIR_UNDEFINED;
	fbStage15.MaximumShuttleCount						:= gPar.MovementPar.Stage15.MaxController;
	
	fbStage16.Velocity									:= gPar.MovementPar.Stage16.Velocity;
	fbStage16.Acceleration								:= gPar.MovementPar.Stage16.Acceleration;
	fbStage16.Deceleration								:= gPar.MovementPar.Stage16.Deceleration;
	fbStage16.AdvancedParameters.StartDirection 		:= mcDIR_POSITIVE;
	fbStage16.AdvancedParameters.EndDirection 			:= mcDIR_UNDEFINED;
	fbStage16.AdvancedParameters.ShuttleOrientation 	:= mcDIR_UNDEFINED;
	fbStage16.MaximumShuttleCount						:= gPar.MovementPar.Stage16.MaxController;
	
	fbStage17.Velocity									:= gPar.MovementPar.Stage17.Velocity;
	fbStage17.Acceleration								:= gPar.MovementPar.Stage17.Acceleration;
	fbStage17.Deceleration								:= gPar.MovementPar.Stage17.Deceleration;
	fbStage17.AdvancedParameters.StartDirection 		:= mcDIR_POSITIVE;
	fbStage17.AdvancedParameters.EndDirection 			:= mcDIR_UNDEFINED;
	fbStage17.AdvancedParameters.ShuttleOrientation 	:= mcDIR_UNDEFINED;
	fbStage17.MaximumShuttleCount						:= gPar.MovementPar.Stage17.MaxController;
	
	fbStage18.Velocity									:= gPar.MovementPar.Stage18.Velocity;
	fbStage18.Acceleration								:= gPar.MovementPar.Stage18.Acceleration;
	fbStage18.Deceleration								:= gPar.MovementPar.Stage18.Deceleration;
	fbStage18.AdvancedParameters.StartDirection 		:= mcDIR_POSITIVE;
	fbStage18.AdvancedParameters.EndDirection 			:= mcDIR_UNDEFINED;
	fbStage18.AdvancedParameters.ShuttleOrientation 	:= mcDIR_UNDEFINED;
	fbStage18.MaximumShuttleCount						:= gPar.MovementPar.Stage18.MaxController;

	fbStage19.Velocity									:= gPar.MovementPar.Stage19.Velocity;
	fbStage19.Acceleration								:= gPar.MovementPar.Stage19.Acceleration;
	fbStage19.Deceleration								:= gPar.MovementPar.Stage19.Deceleration;
	fbStage19.AdvancedParameters.StartDirection 		:= mcDIR_POSITIVE;
	fbStage19.AdvancedParameters.EndDirection 			:= mcDIR_UNDEFINED;
	fbStage19.AdvancedParameters.ShuttleOrientation 	:= mcDIR_UNDEFINED;
	fbStage19.MaximumShuttleCount						:= gPar.MovementPar.Stage19.MaxController;
		
	fbReturn.RoutedVelocity								:= gPar.MovementPar.Return.RoutedVelocity;
	fbReturn.Velocity									:= gPar.MovementPar.Return.Velocity;
	fbReturn.Acceleration								:= gPar.MovementPar.Return.Acceleration;
	fbReturn.Deceleration								:= gPar.MovementPar.Return.Deceleration;
	fbReturn.AdvancedParameters.StartDirection 			:= mcDIR_POSITIVE;
	fbReturn.AdvancedParameters.EndDirection 			:= mcDIR_UNDEFINED;
	fbReturn.AdvancedParameters.ShuttleOrientation		:= mcDIR_UNDEFINED;
	
END_ACTION
