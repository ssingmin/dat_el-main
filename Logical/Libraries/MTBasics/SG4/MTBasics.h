/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _MTBASICS_
#define _MTBASICS_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#include <sys_lib.h>
#include <brsystem.h>
#include <MTTypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
/* Constants */
#ifdef _REPLACE_CONST
 #define mtBCD_INF_TUNING_ABORTED_BY_USER 1089471511
 #define mtBCD_INF_TIME_CONSTANT2_ZERO 1089471510
 #define mtBCD_INF_TIME_CONSTANT1_ZERO 1089471509
 #define mtGNR_WRN_MEM_ALLOC_FAILED (-2131755006)
 #define mtGNR_WRN_OTHER_FB_USES_SYSREF (-2131755007)
 #define mtBCD_WRN_SAMPLING_INVALID (-2131753937)
 #define mtBCD_WRN_RANGE_INVALID (-2131753938)
 #define mtBCD_WRN_STEP_HEIGHT_INVALID (-2131753939)
 #define mtBCD_WRN_TUNING_TIME_INVALID (-2131753940)
 #define mtBCD_WRN_SETTLING_TIME_INVALID (-2131753941)
 #define mtBCD_WRN_PERIOD_LOW (-2131753944)
 #define mtBCD_WRN_MIN_PULSE_LOW (-2131753945)
 #define mtBCD_WRN_MIN_PULSE_HIGH (-2131753946)
 #define mtBCD_WRN_TIME_CONSTANTS_INVALID (-2131753947)
 #define mtBCD_WRN_FILTER_TIME_LOW (-2131753948)
 #define mtBCD_WRN_FILTER_TIME_NEGATIV (-2131753949)
 #define mtBCD_WRN_DERIVATIVE_TIME_NEG (-2131753950)
 #define mtBCD_WRN_INTEGRATION_TIME (-2131753951)
 #define mtBCD_WRN_GAIN_NEGATIV (-2131753952)
 #define mtBCD_WRN_GAIN_ZERO (-2131753953)
 #define mtBCD_WRN_MIN_PAUSE_LOW (-2131753954)
 #define mtBCD_WRN_PULSE_WIDTH_LOW (-2131753955)
 #define mtBCD_WRN_MAX_NEG_SLEW_RATE_NEG (-2131753956)
 #define mtBCD_WRN_MAX_POS_SLEW_RATE_NEG (-2131753957)
 #define mtBCD_WRN_OUTPUT_LIMIT_INVALID (-2131753958)
 #define mtBCD_WRN_OUT_VALUE_NOT_DEFINED (-2131753959)
 #define mtBCD_WRN_THRESHOLD_INVALID (-2131753960)
 #define mtBCD_WRN_THRESHOLD_NOT_DEFINED (-2131753961)
 #define mtBCD_WRN_TIME_CONSTANT2_INVALID (-2131753962)
 #define mtBCD_WRN_TIME_CONSTANT1_INVALID (-2131753963)
 #define mtGNR_ERR_SAMPLE_TIME_INVALID (-1058013180)
 #define mtGNR_ERR_MEM_ALLOC_FAILED (-1058013181)
 #define mtBCD_ERR_TUNING_INVALID (-1058012113)
 #define mtBCD_ERR_RANGE_INVALID (-1058012114)
 #define mtBCD_ERR_ACT_VALUE_NOT_STABLE (-1058012115)
 #define mtBCD_ERR_TUNING_TIME_INVALID (-1058012116)
 #define mtBCD_ERR_SETTLING_TIME_INVALID (-1058012117)
 #define mtBCD_ERR_SAMPLING_INVALID (-1058012118)
 #define mtBCD_ERR_DELAY_TIME_HIGH (-1058012119)
 #define mtBCD_ERR_DELAY_TIME_NEGATIV (-1058012120)
 #define mtBCD_ERR_FILTER_TIME_NEGATIV (-1058012126)
 #define mtBCD_ERR_PERIOD_LOW (-1058012122)
 #define mtBCD_ERR_MIN_PULSE_LOW (-1058012123)
 #define mtBCD_ERR_MIN_PULSE_HIGH (-1058012124)
 #define mtBCD_ERR_TIME_CONSTANTS_INVALID (-1058012125)
 #define mtBCD_ERR_DERIVATIVE_TIME_NEG (-1058012127)
 #define mtBCD_ERR_INTEGRATION_TIME (-1058012128)
 #define mtBCD_ERR_GAIN_NEGATIV (-1058012129)
 #define mtBCD_ERR_MIN_PAUSE_LOW (-1058012130)
 #define mtBCD_ERR_PULSE_WIDTH_LOW (-1058012131)
 #define mtBCD_ERR_MAX_NEG_SLEW_RATE_NEG (-1058012132)
 #define mtBCD_ERR_MAX_POS_SLEW_RATE_NEG (-1058012133)
 #define mtBCD_ERR_OUTPUT_LIMIT_INVALID (-1058012134)
 #define mtBCD_ERR_OUT_VALUE_NOT_DEFINED (-1058012135)
 #define mtBCD_ERR_THRESHOLD_INVALID (-1058012136)
 #define mtBCD_ERR_THRESHOLD_NOT_DEFINED (-1058012137)
 #define mtBCD_ERR_TIME_CONSTANT2_INVALID (-1058012138)
 #define mtBCD_ERR_TIME_CONSTANT1_INVALID (-1058012139)
#else
 #ifndef _GLOBAL_CONST
   #define _GLOBAL_CONST _WEAK const
 #endif
 _GLOBAL_CONST signed long mtBCD_INF_TUNING_ABORTED_BY_USER;
 _GLOBAL_CONST signed long mtBCD_INF_TIME_CONSTANT2_ZERO;
 _GLOBAL_CONST signed long mtBCD_INF_TIME_CONSTANT1_ZERO;
 _GLOBAL_CONST signed long mtGNR_WRN_MEM_ALLOC_FAILED;
 _GLOBAL_CONST signed long mtGNR_WRN_OTHER_FB_USES_SYSREF;
 _GLOBAL_CONST signed long mtBCD_WRN_SAMPLING_INVALID;
 _GLOBAL_CONST signed long mtBCD_WRN_RANGE_INVALID;
 _GLOBAL_CONST signed long mtBCD_WRN_STEP_HEIGHT_INVALID;
 _GLOBAL_CONST signed long mtBCD_WRN_TUNING_TIME_INVALID;
 _GLOBAL_CONST signed long mtBCD_WRN_SETTLING_TIME_INVALID;
 _GLOBAL_CONST signed long mtBCD_WRN_PERIOD_LOW;
 _GLOBAL_CONST signed long mtBCD_WRN_MIN_PULSE_LOW;
 _GLOBAL_CONST signed long mtBCD_WRN_MIN_PULSE_HIGH;
 _GLOBAL_CONST signed long mtBCD_WRN_TIME_CONSTANTS_INVALID;
 _GLOBAL_CONST signed long mtBCD_WRN_FILTER_TIME_LOW;
 _GLOBAL_CONST signed long mtBCD_WRN_FILTER_TIME_NEGATIV;
 _GLOBAL_CONST signed long mtBCD_WRN_DERIVATIVE_TIME_NEG;
 _GLOBAL_CONST signed long mtBCD_WRN_INTEGRATION_TIME;
 _GLOBAL_CONST signed long mtBCD_WRN_GAIN_NEGATIV;
 _GLOBAL_CONST signed long mtBCD_WRN_GAIN_ZERO;
 _GLOBAL_CONST signed long mtBCD_WRN_MIN_PAUSE_LOW;
 _GLOBAL_CONST signed long mtBCD_WRN_PULSE_WIDTH_LOW;
 _GLOBAL_CONST signed long mtBCD_WRN_MAX_NEG_SLEW_RATE_NEG;
 _GLOBAL_CONST signed long mtBCD_WRN_MAX_POS_SLEW_RATE_NEG;
 _GLOBAL_CONST signed long mtBCD_WRN_OUTPUT_LIMIT_INVALID;
 _GLOBAL_CONST signed long mtBCD_WRN_OUT_VALUE_NOT_DEFINED;
 _GLOBAL_CONST signed long mtBCD_WRN_THRESHOLD_INVALID;
 _GLOBAL_CONST signed long mtBCD_WRN_THRESHOLD_NOT_DEFINED;
 _GLOBAL_CONST signed long mtBCD_WRN_TIME_CONSTANT2_INVALID;
 _GLOBAL_CONST signed long mtBCD_WRN_TIME_CONSTANT1_INVALID;
 _GLOBAL_CONST signed long mtGNR_ERR_SAMPLE_TIME_INVALID;
 _GLOBAL_CONST signed long mtGNR_ERR_MEM_ALLOC_FAILED;
 _GLOBAL_CONST signed long mtBCD_ERR_TUNING_INVALID;
 _GLOBAL_CONST signed long mtBCD_ERR_RANGE_INVALID;
 _GLOBAL_CONST signed long mtBCD_ERR_ACT_VALUE_NOT_STABLE;
 _GLOBAL_CONST signed long mtBCD_ERR_TUNING_TIME_INVALID;
 _GLOBAL_CONST signed long mtBCD_ERR_SETTLING_TIME_INVALID;
 _GLOBAL_CONST signed long mtBCD_ERR_SAMPLING_INVALID;
 _GLOBAL_CONST signed long mtBCD_ERR_DELAY_TIME_HIGH;
 _GLOBAL_CONST signed long mtBCD_ERR_DELAY_TIME_NEGATIV;
 _GLOBAL_CONST signed long mtBCD_ERR_FILTER_TIME_NEGATIV;
 _GLOBAL_CONST signed long mtBCD_ERR_PERIOD_LOW;
 _GLOBAL_CONST signed long mtBCD_ERR_MIN_PULSE_LOW;
 _GLOBAL_CONST signed long mtBCD_ERR_MIN_PULSE_HIGH;
 _GLOBAL_CONST signed long mtBCD_ERR_TIME_CONSTANTS_INVALID;
 _GLOBAL_CONST signed long mtBCD_ERR_DERIVATIVE_TIME_NEG;
 _GLOBAL_CONST signed long mtBCD_ERR_INTEGRATION_TIME;
 _GLOBAL_CONST signed long mtBCD_ERR_GAIN_NEGATIV;
 _GLOBAL_CONST signed long mtBCD_ERR_MIN_PAUSE_LOW;
 _GLOBAL_CONST signed long mtBCD_ERR_PULSE_WIDTH_LOW;
 _GLOBAL_CONST signed long mtBCD_ERR_MAX_NEG_SLEW_RATE_NEG;
 _GLOBAL_CONST signed long mtBCD_ERR_MAX_POS_SLEW_RATE_NEG;
 _GLOBAL_CONST signed long mtBCD_ERR_OUTPUT_LIMIT_INVALID;
 _GLOBAL_CONST signed long mtBCD_ERR_OUT_VALUE_NOT_DEFINED;
 _GLOBAL_CONST signed long mtBCD_ERR_THRESHOLD_INVALID;
 _GLOBAL_CONST signed long mtBCD_ERR_THRESHOLD_NOT_DEFINED;
 _GLOBAL_CONST signed long mtBCD_ERR_TIME_CONSTANT2_INVALID;
 _GLOBAL_CONST signed long mtBCD_ERR_TIME_CONSTANT1_INVALID;
#endif




/* Datatypes and datatypes of function blocks */
typedef enum MTBasicsPIDIntegrationEnum
{	mtBASICS_INTEGRATION_FREE = 0,
	mtBASICS_HOLD_INTEGRATION_POS = 1,
	mtBASICS_HOLD_INTEGRATION_NEG = -1
} MTBasicsPIDIntegrationEnum;

typedef enum MTBasicsPWMModeEnum
{	mtPULSE_BEGINNING = 0,
	mtPULSE_MIDDLE = 1
} MTBasicsPWMModeEnum;

typedef enum MTBasicsStepTuningStateEnum
{	mtBASICS_STATE_READY = 1,
	mtBASICS_STATE_SETTLING = 2,
	mtBASICS_STATE_STEP = 3,
	mtBASICS_STATE_CALCULATE_PID = 4
} MTBasicsStepTuningStateEnum;

typedef struct MTBasicsPIDInternalType
{	float CycleTime;
	plcbit ParametersValid;
	struct MTPIDParametersType PIDParameters;
	float MinOut;
	float MaxOut;
	plcbit Invert;
	float ControlError;
	float ControlErrorOld;
	float Out;
	plcbit HoldIntegration;
	float IntegrationPartPresetValue;
	plcbit SetIntegrationPart;
	plcbit SetIntegrationPartOld;
	signed long PID_StatusID;
	plcbit UpdateOld;
	plcbit EnableOld;
	plcbit EnableDone;
	plcbit DisabledBusy;
	unsigned long CounterOld;
	plcbit SysRefParaNew;
	struct MTTransferFcnType SystemReference;
} MTBasicsPIDInternalType;

typedef struct MTBasicsLevelCtrlParType
{	float OutputValue1;
	float OutputValue2;
	float OutputValue3;
	float ThresholdLevel1;
	float ThresholdLevel2;
	float ThresholdLevel3;
	float ThresholdLevel4;
} MTBasicsLevelCtrlParType;

typedef struct MTBasicsStepTuningBufElemType
{	unsigned long TimeIndex;
	double In;
	double IntIn;
	double IntTimeIn;
	double IntTime2In;
	double Int2In;
	double Int3In;
	double TSum;
	double dTSum;
	double d2TSum;
	double dyACD;
	double d2yACD;
	double d3yACD;
	double DiffIn;
	double Diff2In;
} MTBasicsStepTuningBufElemType;

typedef struct MTBasicsOscTuningInternalType
{	float CycleTime;
	plcbit ParametersValid;
	unsigned char State;
	float CriticalGain;
	float OscillationPeriod;
	unsigned char NumberOfOscillations;
	unsigned char NumberOfPhases;
	float MaxRelayOut;
	float MinRelayOut;
	float SetValue;
	float AverageOutValue;
	float MaxActValueTime[4];
	float MinActValueTime[4];
	float MaxActValue[4];
	float MinActValue[4];
	float TuningTime;
	float StartingActValue;
	float ControlError;
	float ActValueAverageAmplitude;
	float AverageActValue;
	float AverageMaxActValue;
	float AverageMinActValue;
	float AmplitudeRatio;
	float DeltaOut;
	signed char EffectiveDirection;
	plcbit StartOld;
	float MinOscillationAmplitude;
	float MinOut;
	float MaxOut;
	float TemporaryQuality;
	float TemporaryDerivativeTime;
	float TemporaryIntegrationTime;
	float TemporaryGain;
	plcbit Update;
	plcbit UpdateOld;
	plcbit EnableOld;
	float AverageOutValueSum;
	double AverageTime;
} MTBasicsOscTuningInternalType;

typedef struct MTBasicsStepTuningInternalType
{	float CycleTime;
	plcbit ParametersValid;
	float MinActValue;
	float MaxActValue;
	float MaxTuningTime;
	float StepHeight;
	enum MTBasicsStepTuningStateEnum State;
	float TuningTime;
	float Area;
	float StartActValue;
	float SumTime;
	float PlantGain;
	float LQError;
	float LQOutput[2];
	float LQParameterVector[3];
	float ActValueOld;
	float SystemSettlingTime;
	unsigned short SettlingIndex;
	unsigned short NumberOfSettlingValues;
	float NoiseDeadBand;
	plcbit StartOld;
	plcbit UpdateOld;
	plcbit EnableOld;
	float Slope;
} MTBasicsStepTuningInternalType;

typedef struct MTBasicsLevelCtrlInternalType
{	float CycleTime;
	plcbit ParametersValid;
	struct MTBasicsLevelCtrlParType Parameter;
	unsigned char State;
	plcbit UpdateOld;
	plcbit EnableOld;
} MTBasicsLevelCtrlInternalType;

typedef struct MTBasicsPT1InternalType
{	float CycleTime;
	plcbit ParametersValid;
	float Gain;
	float TimeConstant;
	double Numerator[2];
	double Denominator[2];
	double BVector[2];
	double AVector[2];
	double XVector[2];
	float OutPresetValue;
	double PresetCoefficients;
	plcbit PresetOK;
	plcbit SetOutOld;
	plcbit UpdateOld;
	plcbit EnableOld;
	plcbit EnableDone;
	plcbit DisabledBusy;
	unsigned long CounterOld;
	plcbit SysRefParaNew;
	struct MTTransferFcnType SystemReference;
} MTBasicsPT1InternalType;

typedef struct MTBasicsPT2InternalType
{	float CycleTime;
	plcbit ParametersValid;
	float Gain;
	float TimeConstant1;
	float TimeConstant2;
	double Numerator[3];
	double Denominator[3];
	double BVector[3];
	double AVector[3];
	double XVector[2];
	float OutPresetValue;
	double PresetCoefficients;
	plcbit PresetOK;
	plcbit SetOutOld;
	plcbit UpdateOld;
	plcbit EnableOld;
	plcbit EnableDone;
	plcbit DisabledBusy;
	unsigned long CounterOld;
	plcbit SysRefParaNew;
	struct MTTransferFcnType SystemReference;
} MTBasicsPT2InternalType;

typedef struct MTBasicsDT1InternalType
{	float CycleTime;
	plcbit ParametersValid;
	float Gain;
	float TimeConstant;
	double Numerator[2];
	double Denominator[2];
	double BVector[2];
	double AVector[2];
	double XVector[2];
	plcbit PresetOK;
	double PresetCoefficients;
	float InOld;
	plcbit UpdateOld;
	plcbit EnableOld;
	plcbit EnableDone;
	plcbit DisabledBusy;
	unsigned long CounterOld;
	plcbit SysRefParaNew;
	struct MTTransferFcnType SystemReference;
} MTBasicsDT1InternalType;

typedef struct MTBasicsDT2InternalType
{	float CycleTime;
	plcbit ParametersValid;
	float Gain;
	float TimeConstant1;
	float TimeConstant2;
	double Numerator[3];
	double Denominator[3];
	double BVector[3];
	double AVector[3];
	double XVector[2];
	plcbit PresetOK;
	double PresetCoefficients;
	float InOld;
	plcbit UpdateOld;
	plcbit EnableOld;
	plcbit EnableDone;
	plcbit DisabledBusy;
	unsigned long CounterOld;
	plcbit SysRefParaNew;
	struct MTTransferFcnType SystemReference;
} MTBasicsDT2InternalType;

typedef struct MTBasicsIntegratorInternalType
{	float CycleTime;
	plcbit ParametersValid;
	float Gain;
	double BVector[2];
	double AVector[2];
	double XVector;
	float OutPresetValue;
	plcbit SetOutOld;
	plcbit UpdateOld;
	plcbit EnableOld;
	plcbit EnableDone;
	plcbit DisabledBusy;
	unsigned long CounterOld;
	plcbit SysRefParaNew;
	struct MTTransferFcnType SystemReference;
} MTBasicsIntegratorInternalType;

typedef struct MTBasicsTimeDelayFcnParaType
{	unsigned long DelayCounter;
	unsigned long ActBufferIndex;
	unsigned long ActBufferElements;
	unsigned long OldBufferElements;
	float DelayTimeAct;
	float* BufferPointer;
} MTBasicsTimeDelayFcnParaType;

typedef struct MTBasicsTimeDelayInternalType
{	float CycleTime;
	float DelayTime;
	plcbit ParametersValid;
	float InitialValue;
	plcbit EnableOld;
	struct MTBasicsTimeDelayFcnParaType TimeDelayFcnPara;
} MTBasicsTimeDelayInternalType;

typedef struct MTBasicsLimiterInternalType
{	float CycleTime;
	plcbit ParametersValid;
	float MaxOut;
	float MinOut;
	float MaxPosSlewRate;
	float MaxNegSlewRate;
	float Out;
	float OutOld;
	float UpperOutLimit;
	float LowerOutLimit;
	plcbit SetOutOld;
	plcbit UpdateOld;
	plcbit EnableOld;
} MTBasicsLimiterInternalType;

typedef struct MTBasicsPWMInternalType
{	float CycleTime;
	plcbit ParametersValid;
	unsigned char Mode;
	float MinPulseWidth;
	float Period;
	float In;
	float OnTime;
	float OffTime;
	float PeriodCounter;
	float OnTimeCounter;
	plcbit UpdateOld;
	plcbit EnableOld;
} MTBasicsPWMInternalType;

typedef struct MTBasicsPFMInternalType
{	float CycleTime;
	plcbit ParametersValid;
	float In;
	float PulseWidth;
	float MinPause;
	float Area;
	float AreaC;
	float OffTime;
	float OnTime;
	plcbit Update;
	plcbit UpdateOld;
	plcbit EnableOld;
} MTBasicsPFMInternalType;

typedef struct MTBasicsPID
{
	/* VAR_INPUT (analog) */
	struct MTPIDParametersType PIDParameters;
	float MinOut;
	float MaxOut;
	float SetValue;
	float ActValue;
	float IntegrationPartPresetValue;
	float TrackingValue;
	enum MTBasicsPIDIntegrationEnum HoldIntegration;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float Out;
	float ControlError;
	float ProportionalPart;
	float IntegrationPart;
	float DerivativePart;
	enum MTBasicsPIDIntegrationEnum IntegrationStatus;
	unsigned long SystemReference;
	/* VAR (analog) */
	struct MTBasicsPIDInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Invert;
	plcbit Update;
	plcbit SetIntegrationPart;
	plcbit HoldOut;
	plcbit EnableTracking;
	/* VAR_OUTPUT (digital) */
	plcbit Busy;
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit TrackingActive;
} MTBasicsPID_typ;

typedef struct MTBasicsOscillationTuning
{
	/* VAR_INPUT (analog) */
	float SetValue;
	float MinOut;
	float MaxOut;
	float ActValue;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float Out;
	float Quality;
	struct MTPIDParametersType PIDParameters;
	/* VAR (analog) */
	struct MTBasicsOscTuningInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Invert;
	plcbit Update;
	plcbit Start;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit TuningActive;
	plcbit TuningDone;
} MTBasicsOscillationTuning_typ;

typedef struct MTBasicsStepTuning
{
	/* VAR_INPUT (analog) */
	float SystemSettlingTime;
	float MaxTuningTime;
	float MinActValue;
	float MaxActValue;
	float ActValue;
	float StepHeight;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float Out;
	struct MTPIDParametersType PIDParameters;
	float Quality;
	enum MTBasicsStepTuningStateEnum TuningState;
	/* VAR (analog) */
	struct MTBasicsStepTuningInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	plcbit Start;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit TuningActive;
	plcbit TuningDone;
} MTBasicsStepTuning_typ;

typedef struct MTBasicsLevelController
{
	/* VAR_INPUT (analog) */
	struct MTBasicsLevelCtrlParType Parameter;
	float In;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float Out;
	/* VAR (analog) */
	struct MTBasicsLevelCtrlInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MTBasicsLevelController_typ;

typedef struct MTBasicsPT1
{
	/* VAR_INPUT (analog) */
	float Gain;
	float TimeConstant;
	float In;
	float OutPresetValue;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float Out;
	unsigned long SystemReference;
	/* VAR (analog) */
	struct MTBasicsPT1InternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	plcbit SetOut;
	/* VAR_OUTPUT (digital) */
	plcbit Busy;
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MTBasicsPT1_typ;

typedef struct MTBasicsPT2
{
	/* VAR_INPUT (analog) */
	float Gain;
	float TimeConstant1;
	float TimeConstant2;
	float In;
	float OutPresetValue;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float Out;
	unsigned long SystemReference;
	/* VAR (analog) */
	struct MTBasicsPT2InternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	plcbit SetOut;
	/* VAR_OUTPUT (digital) */
	plcbit Busy;
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MTBasicsPT2_typ;

typedef struct MTBasicsDT1
{
	/* VAR_INPUT (analog) */
	float Gain;
	float TimeConstant;
	float In;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float Out;
	unsigned long SystemReference;
	/* VAR (analog) */
	struct MTBasicsDT1InternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	/* VAR_OUTPUT (digital) */
	plcbit Busy;
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MTBasicsDT1_typ;

typedef struct MTBasicsDT2
{
	/* VAR_INPUT (analog) */
	float Gain;
	float TimeConstant1;
	float TimeConstant2;
	float In;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float Out;
	unsigned long SystemReference;
	/* VAR (analog) */
	struct MTBasicsDT2InternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	/* VAR_OUTPUT (digital) */
	plcbit Busy;
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MTBasicsDT2_typ;

typedef struct MTBasicsIntegrator
{
	/* VAR_INPUT (analog) */
	float Gain;
	float In;
	float OutPresetValue;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float Out;
	unsigned long SystemReference;
	/* VAR (analog) */
	struct MTBasicsIntegratorInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	plcbit SetOut;
	plcbit HoldOut;
	/* VAR_OUTPUT (digital) */
	plcbit Busy;
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MTBasicsIntegrator_typ;

typedef struct MTBasicsTimeDelay
{
	/* VAR_INPUT (analog) */
	float DelayTime;
	float In;
	float InitialValue;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float Out;
	/* VAR (analog) */
	struct MTBasicsTimeDelayInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
} MTBasicsTimeDelay_typ;

typedef struct MTBasicsLimiter
{
	/* VAR_INPUT (analog) */
	float MinOut;
	float MaxOut;
	float MaxPosSlewRate;
	float MaxNegSlewRate;
	float In;
	float OutPresetValue;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	float Out;
	/* VAR (analog) */
	struct MTBasicsLimiterInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	plcbit SetOut;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
} MTBasicsLimiter_typ;

typedef struct MTBasicsPWM
{
	/* VAR_INPUT (analog) */
	enum MTBasicsPWMModeEnum Mode;
	float MinPulseWidth;
	float Period;
	float DutyCycle;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	/* VAR (analog) */
	struct MTBasicsPWMInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit Out;
} MTBasicsPWM_typ;

typedef struct MTBasicsPFM
{
	/* VAR_INPUT (analog) */
	float PulseWidth;
	float MinPause;
	float DutyCycle;
	/* VAR_OUTPUT (analog) */
	signed long StatusID;
	/* VAR (analog) */
	struct MTBasicsPFMInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Update;
	/* VAR_OUTPUT (digital) */
	plcbit Active;
	plcbit Error;
	plcbit UpdateDone;
	plcbit Out;
} MTBasicsPFM_typ;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC void MTBasicsPID(struct MTBasicsPID* inst);
_BUR_PUBLIC void MTBasicsOscillationTuning(struct MTBasicsOscillationTuning* inst);
_BUR_PUBLIC void MTBasicsStepTuning(struct MTBasicsStepTuning* inst);
_BUR_PUBLIC void MTBasicsLevelController(struct MTBasicsLevelController* inst);
_BUR_PUBLIC void MTBasicsPT1(struct MTBasicsPT1* inst);
_BUR_PUBLIC void MTBasicsPT2(struct MTBasicsPT2* inst);
_BUR_PUBLIC void MTBasicsDT1(struct MTBasicsDT1* inst);
_BUR_PUBLIC void MTBasicsDT2(struct MTBasicsDT2* inst);
_BUR_PUBLIC void MTBasicsIntegrator(struct MTBasicsIntegrator* inst);
_BUR_PUBLIC void MTBasicsTimeDelay(struct MTBasicsTimeDelay* inst);
_BUR_PUBLIC void MTBasicsLimiter(struct MTBasicsLimiter* inst);
_BUR_PUBLIC void MTBasicsPWM(struct MTBasicsPWM* inst);
_BUR_PUBLIC void MTBasicsPFM(struct MTBasicsPFM* inst);


#ifdef __cplusplus
};
#endif
#endif /* _MTBASICS_ */

