#include <unistd.h>
#include <stdio.h>
#include <fixedptc.h>
#include <assert.h>

//#define fixedpt_tofloat(T) ((float) ((T)*((float)(1)/(float)(1L << FIXEDPT_FBITS))))
//#define fixedpt_toint(F) ((F) >> FIXEDPT_FBITS)

int main() {

	fixedpt A = fixedpt_rconst(1.2);
	fixedpt B = fixedpt_rconst(2.6);

//
//static inline fixedpt fixedpt_floor(fixedpt A) {
//	return A & ~0xff; // TODO: there might be a bug
//}
//
//static inline fixedpt fixedpt_ceil(fixedpt A) {
//	return (A + 0xff) & ~0xff;
//}

//static inline fixedpt fixedpt_muli(fixedpt A, int B) {
	assert(fixedpt_muli(A, 2) == fixedpt_rconst(2.4));
  printf("fixedpt_muli pass\n");

//static inline fixedpt fixedpt_divi(fixedpt A, int B) {
	assert(fixedpt_abs(fixedpt_sub(fixedpt_divi(A, 2), fixedpt_rconst(0.6))) < fixedpt_rconst(0.1));
  printf("fixedpt_divi pass\n");

//static inline fixedpt fixedpt_mul(fixedpt A, fixedpt B) {
	assert(fixedpt_abs(fixedpt_sub(fixedpt_mul(A, B), fixedpt_rconst(3.12))) < fixedpt_rconst(0.1));
  printf("fixedpt_mul pass\n");

//static inline fixedpt fixedpt_div(fixedpt A, fixedpt B) {
	assert(fixedpt_abs(fixedpt_sub(fixedpt_div(A, B), fixedpt_rconst(0.461538461538))) < fixedpt_rconst(0.1));
  printf("fixedpt_div pass\n");

//static inline fixedpt fixedpt_abs(fixedpt A) {
	assert(fixedpt_abs(fixedpt_rconst(-5.5)) == fixedpt_rconst(5.5));
  printf("fixedpt_abs pass\n");

  printf("All tests pass!!!\n");

  return 0;
}

//	printf("left = 0x%x, right = 0x%x\n", fixedpt_div(A, B), fixedpt_rconst(0.461538461538));
//	printf("sub result = 0x%x\n", fixedpt_sub(fixedpt_divi(A, 2), fixedpt_rconst(0.6)));
//	printf("abs = 0x%x\n", fixedpt_abs(fixedpt_sub(fixedpt_divi(A, 2), fixedpt_rconst(0.6))));
//	printf("0.1 = 0x%x\n", fixedpt_rconst(0.1));
//	if(fixedpt_abs(fixedpt_sub(fixedpt_divi(A, 2), fixedpt_rconst(0.6))) < fixedpt_rconst(0.1))
//		printf("yes less\n");
//	else
//		printf("no greater\n");

