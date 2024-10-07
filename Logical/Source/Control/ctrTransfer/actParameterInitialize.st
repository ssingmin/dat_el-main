
ACTION actParameterInitialize: 
	IF gParInitialized = FALSE THEN
		// Position Parameter Intialize
		gPar.ProcessPosition.Stage[0]						:= POS_STAGE1;
		gPar.ProcessPosition.Stage[1]						:= POS_STAGE2;
		gPar.ProcessPosition.Stage[2]						:= POS_STAGE3;
		gPar.ProcessPosition.Stage[3]						:= POS_STAGE4;
		gPar.ProcessPosition.Stage[4]						:= POS_STAGE5;
		gPar.ProcessPosition.Stage[5]						:= POS_STAGE6;
		gPar.ProcessPosition.Stage[6]						:= POS_STAGE7;
		gPar.ProcessPosition.Stage[7]						:= POS_STAGE8;
		gPar.ProcessPosition.Stage[8]						:= POS_STAGE9;
		gPar.ProcessPosition.Stage[9]						:= POS_STAGE10;
		gPar.ProcessPosition.Stage[10]						:= POS_STAGE11;
		gPar.ProcessPosition.Stage[11]						:= POS_STAGE12;
		gPar.ProcessPosition.Stage[12]						:= POS_STAGE13;
		gPar.ProcessPosition.Stage[13]						:= POS_STAGE14;
		gPar.ProcessPosition.Stage[14]						:= POS_STAGE15;
		gPar.ProcessPosition.Stage[15]						:= POS_STAGE16;
		gPar.ProcessPosition.Stage[16]						:= POS_STAGE17;
		gPar.ProcessPosition.Stage[17]						:= POS_STAGE18;
		gPar.ProcessPosition.Stage[18]						:= POS_STAGE19;

		// Velocity Parameter Intialize
		gPar.MovementPar.Stage1.Velocity					:= 2.0;
		gPar.MovementPar.Stage1.Acceleration				:= 3.5;
		gPar.MovementPar.Stage1.Deceleration				:= 3.5;
		gPar.MovementPar.Stage1.MaxController				:= 1;
		
		gPar.MovementPar.Stage2.Velocity					:= 2.0;
		gPar.MovementPar.Stage2.Acceleration				:= 3.5;
		gPar.MovementPar.Stage2.Deceleration				:= 3.5;
		gPar.MovementPar.Stage2.MaxController				:= 1;
		
		gPar.MovementPar.Stage3.Velocity					:= 2.0;
		gPar.MovementPar.Stage3.Acceleration				:= 3.5;
		gPar.MovementPar.Stage3.Deceleration				:= 3.5;
		gPar.MovementPar.Stage3.MaxController				:= 1;
		
		gPar.MovementPar.Stage4.Velocity					:= 2.0;
		gPar.MovementPar.Stage4.Acceleration				:= 3.5;
		gPar.MovementPar.Stage4.Deceleration				:= 3.5;
		gPar.MovementPar.Stage4.MaxController				:= 1;
		
		gPar.MovementPar.Stage5.Velocity					:= 2.0;
		gPar.MovementPar.Stage5.Acceleration				:= 3.5;
		gPar.MovementPar.Stage5.Deceleration				:= 3.5;
		gPar.MovementPar.Stage5.MaxController				:= 1;
		
		gPar.MovementPar.Stage6.Velocity					:= 2.0;
		gPar.MovementPar.Stage6.Acceleration				:= 3.5;
		gPar.MovementPar.Stage6.Deceleration				:= 3.5;
		gPar.MovementPar.Stage6.MaxController				:= 1;
		
		gPar.MovementPar.Stage7.Velocity					:= 2.0;
		gPar.MovementPar.Stage7.Acceleration				:= 3.5;
		gPar.MovementPar.Stage7.Deceleration				:= 3.5;
		gPar.MovementPar.Stage7.MaxController				:= 1;
		
		gPar.MovementPar.Stage8.Velocity					:= 2.0;
		gPar.MovementPar.Stage8.Acceleration				:= 3.5;
		gPar.MovementPar.Stage8.Deceleration				:= 3.5;
		gPar.MovementPar.Stage8.MaxController				:= 1;
		
		gPar.MovementPar.Stage9.Velocity					:= 2.0;
		gPar.MovementPar.Stage9.Acceleration				:= 3.5;
		gPar.MovementPar.Stage9.Deceleration				:= 3.5;
		gPar.MovementPar.Stage9.MaxController				:= 1;
		// Maint
		gPar.MovementPar.Stage10.Velocity					:= 2.0;
		gPar.MovementPar.Stage10.Acceleration				:= 4.0;
		gPar.MovementPar.Stage10.Deceleration				:= 4.0;
		gPar.MovementPar.Stage10.MaxController				:= 3;
		
		gPar.MovementPar.Stage11.Velocity					:= 2.0;
		gPar.MovementPar.Stage11.Acceleration				:= 4.0;
		gPar.MovementPar.Stage11.Deceleration				:= 4.0;
		gPar.MovementPar.Stage11.MaxController				:= 1;
		
		gPar.MovementPar.Stage12.Velocity					:= 2.0;
		gPar.MovementPar.Stage12.Acceleration				:= 3.5;
		gPar.MovementPar.Stage12.Deceleration				:= 3.5;
		gPar.MovementPar.Stage12.MaxController				:= 1;
		
		gPar.MovementPar.Stage13.Velocity					:= 2.0;
		gPar.MovementPar.Stage13.Acceleration				:= 3.5;
		gPar.MovementPar.Stage13.Deceleration				:= 3.5;
		gPar.MovementPar.Stage13.MaxController				:= 1;
		
		gPar.MovementPar.Stage14.Velocity					:= 2.0;
		gPar.MovementPar.Stage14.Acceleration				:= 3.5;
		gPar.MovementPar.Stage14.Deceleration				:= 3.5;
		gPar.MovementPar.Stage14.MaxController				:= 2;
		
		gPar.MovementPar.Stage15.Velocity					:= 2.0;
		gPar.MovementPar.Stage15.Acceleration				:= 3.5;
		gPar.MovementPar.Stage15.Deceleration				:= 3.5;
		gPar.MovementPar.Stage15.MaxController				:= 1;
		
		gPar.MovementPar.Stage16.Velocity					:= 2.0;
		gPar.MovementPar.Stage16.Acceleration				:= 3.5;
		gPar.MovementPar.Stage16.Deceleration				:= 3.5;
		gPar.MovementPar.Stage16.MaxController				:= 1;
		
		gPar.MovementPar.Stage17.Velocity					:= 2.0;
		gPar.MovementPar.Stage17.Acceleration				:= 3.0;
		gPar.MovementPar.Stage17.Deceleration				:= 3.0;
		gPar.MovementPar.Stage17.MaxController				:= 1;
		
		gPar.MovementPar.Stage18.Velocity					:= 2.0;
		gPar.MovementPar.Stage18.Acceleration				:= 3.0;
		gPar.MovementPar.Stage18.Deceleration				:= 3.0;
		gPar.MovementPar.Stage18.MaxController				:= 2;
		
		gPar.MovementPar.Stage19.Velocity					:= 2.0;
		gPar.MovementPar.Stage19.Acceleration				:= 3.0;
		gPar.MovementPar.Stage19.Deceleration				:= 3.0;
		gPar.MovementPar.Stage19.MaxController				:= 1;
		
		gPar.MovementPar.Return.Velocity					:= 2.0;
		gPar.MovementPar.Return.RoutedVelocity				:= 2.0;
		gPar.MovementPar.Return.Acceleration				:= 3.5;
		gPar.MovementPar.Return.Deceleration				:= 3.5;
		
		gPar.TargetPPM 										:= 40;
		gPar.CountOfGroup 									:= 1;
		
		gParVision.Cam.MaxItemCnt	:= 1;
		gParVision.Cam.Timeout		:= 5000;
		gParVision.Cam.Gain			:= 1;
		gParVision.Cam.Focus		:= 20715;
		gParVision.Cam.Exposure		:= 14;
//		gParInitialized 									:= TRUE;
	END_IF
END_ACTION
