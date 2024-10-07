
#include <bur/plctypes.h>
#ifdef __cplusplus
	extern "C"
	{
#endif
	#include "MyTrak.h"
	#include "stdlib.h"
#ifdef __cplusplus
	};
#endif

#define FALSE 0
#define TRUE 1

plcbit Random(float Percent)
{
 	unsigned int test = rand();
	double result;
	
	result = (double)test/(double)4294967295.0 * (double)100.0;
	
	return result < (double)Percent ? TRUE : FALSE;	
}
