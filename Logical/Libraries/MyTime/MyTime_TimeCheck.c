
#include <bur/plctypes.h>
#ifdef __cplusplus
	extern "C"
	{
#endif
	#include "MyTime.h"
#ifdef __cplusplus
	};
#endif

#define FALSE 0
#define TRUE 1

void MyTime_TimeCheck(struct MyTime_TimeCheck* inst)
{
	/* Get time */
	RTC_gettime(&inst->Internal.rtcTime);
	
	/* Calculate the cycle time */
	if(inst->Internal.rtcTime.year == 0)
	{
		/* Store the last time */
		inst->Internal.last_cycle_start = inst->Internal.rtcTime;
	}else{
		/* Clear the last cycle information */
		brsmemset(&inst->Internal.lastCycle,0,sizeof(inst->Internal.lastCycle));
		/* Create local counting variables */
		unsigned int SecCnt = 0;  
		unsigned int MinCnt = 0;
		unsigned int HrCnt = 0;
		unsigned int DayCnt = 0;
		unsigned int MonCnt = 0;
		unsigned int YrCnt = 0;
			
		/* Start with microseconds */
		inst->Internal.lastCycle.microsec = inst->Internal.rtcTime.microsec;
		/* Miliseconds calculation */
		if(inst->Internal.rtcTime.millisec < inst->Internal.last_cycle_start.millisec){
			inst->Internal.lastCycle.millisec = ((inst->Internal.rtcTime.millisec+1000)-inst->Internal.last_cycle_start.millisec);
			SecCnt = 1;
		}else{
			inst->Internal.lastCycle.millisec = (inst->Internal.rtcTime.millisec-inst->Internal.last_cycle_start.millisec);
		}
		// Second calculation
		if(inst->Internal.rtcTime.second < inst->Internal.last_cycle_start.second){
			inst->Internal.lastCycle.second = ((inst->Internal.rtcTime.second+60)-inst->Internal.last_cycle_start.second)-SecCnt;
			MinCnt = 1;
		}else{
			inst->Internal.lastCycle.second = (inst->Internal.rtcTime.second-inst->Internal.last_cycle_start.second)-SecCnt;
		}	
		// Minute calculation
		if(inst->Internal.rtcTime.minute < inst->Internal.last_cycle_start.minute){
			inst->Internal.lastCycle.minute = ((inst->Internal.rtcTime.minute+60)-inst->Internal.last_cycle_start.minute)-MinCnt;
			HrCnt = 1;
		}else{
			inst->Internal.lastCycle.minute = (inst->Internal.rtcTime.minute-inst->Internal.last_cycle_start.minute)-MinCnt;
		}
		// Hour calculation
		if(inst->Internal.rtcTime.hour < inst->Internal.last_cycle_start.hour){
			inst->Internal.lastCycle.hour = ((inst->Internal.rtcTime.hour+24)-inst->Internal.last_cycle_start.hour)-HrCnt;
			DayCnt = 1;
		}else{
			inst->Internal.lastCycle.hour = (inst->Internal.rtcTime.hour-inst->Internal.last_cycle_start.hour) -HrCnt;
		}
		// Day calculation
		if(inst->Internal.rtcTime.day < inst->Internal.last_cycle_start.day){
			inst->Internal.lastCycle.day = ((inst->Internal.rtcTime.day+30)-inst->Internal.last_cycle_start.day)-DayCnt;
			MonCnt = 1;
		}else{
			inst->Internal.lastCycle.day = (inst->Internal.rtcTime.day-inst->Internal.last_cycle_start.day)-DayCnt;
		}
		// Month calculation
		if(inst->Internal.rtcTime.month < inst->Internal.last_cycle_start.month){
			inst->Internal.lastCycle.month = ((inst->Internal.rtcTime.month+12)-inst->Internal.last_cycle_start.month)-MonCnt;
			YrCnt = 1;
		}else{
			inst->Internal.lastCycle.month = (inst->Internal.rtcTime.month-inst->Internal.last_cycle_start.month)-MonCnt;
		}
		// Year calculation
		if(inst->Internal.rtcTime.year < inst->Internal.last_cycle_start.year){
			inst->Internal.lastCycle.year = ((inst->Internal.rtcTime.year)-inst->Internal.last_cycle_start.year)-YrCnt;
		}else{
			inst->Internal.lastCycle.year = (inst->Internal.rtcTime.year-inst->Internal.last_cycle_start.year)-YrCnt;
		}
		
		if(inst->Internal.maxCycle.year < inst->Internal.lastCycle.year &&
			inst->Internal.maxCycle.month < inst->Internal.lastCycle.month &&
			inst->Internal.maxCycle.day < inst->Internal.lastCycle.day &&
			inst->Internal.maxCycle.hour < inst->Internal.lastCycle.hour &&
			inst->Internal.maxCycle.minute  < inst->Internal.lastCycle.minute &&
			inst->Internal.maxCycle.second < inst->Internal.lastCycle.second &&
		inst->Internal.maxCycle.millisec < inst->Internal.lastCycle.millisec){
						
			inst->Internal.maxCycle = inst->Internal.lastCycle;
		}					

		if(inst->Internal.lastCycle.minute == 0){
			if(inst->Internal.lastCycle.second == 0){
				inst->Time = 0.001 * inst->Internal.lastCycle.millisec;
			
				//	Internal.tmpString := UINT_TO_STRING(Internal.lastCycle.millisec);
				//	brsstrcat(ADR(Internal.tmpString), ADR('ms'));
			}else{
		
				//Internal.tmpString := USINT_TO_STRING(Internal.lastCycle.second);
				//brsstrcat(ADR(Internal.tmpString), ADR('s '));
				//Internal.timeTemp := UINT_TO_STRING(Internal.lastCycle.millisec);
				//	brsstrcat(ADR(Internal.tmpString), ADR(Internal.timeTemp));
				//brsstrcat(ADR(Internal.tmpString), ADR('ms'));
				inst->Time = 0.001 * inst->Internal.lastCycle.millisec;
				inst->Time = inst->Time + 1 * inst->Internal.lastCycle.second;
			}
		}
		inst->Internal.last_cycle_start = inst->Internal.rtcTime;	
		
	}
}
