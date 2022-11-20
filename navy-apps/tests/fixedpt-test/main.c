#include <unistd.h>
#include <stdio.h>
#include "fixedptc.h"

//#define fixedpt_tofloat(T) ((float) ((T)*((float)(1)/(float)(1L << FIXEDPT_FBITS))))
//#define fixedpt_toint(F) ((F) >> FIXEDPT_FBITS)

int main() {

	fixedpt A = fixedpt_rconst(1.2);
	fixedpt B = fixedpt_rconst(2.6);

	float result = fixedpt_tofloat(fixedpt_muli(A, 2));
	printf("result = %f\n", result);
//#define FIXEDPT_PI	fixedpt_rconst(3.14159265358979323846)

  printf("PASS!!!\n");

  return 0;
}

