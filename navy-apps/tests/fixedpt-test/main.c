#include <unistd.h>
#include <stdio.h>
#include <fixedptc.h>
#include <assert.h>

//#define fixedpt_tofloat(T) ((float) ((T)*((float)(1)/(float)(1L << FIXEDPT_FBITS))))
//#define fixedpt_toint(F) ((F) >> FIXEDPT_FBITS)

int main() {

	fixedpt A = fixedpt_rconst(1.2);
	fixedpt B = fixedpt_rconst(2.6);

//static inline fixedpt fixedpt_muli(fixedpt A, int B) {
	assert(fixedpt_muli(A, 2) == fixedpt_rconst(2.4));
//#define FIXEDPT_PI	fixedpt_rconst(3.14159265358979323846)

  printf("PASS!!!\n");

  return 0;
}

