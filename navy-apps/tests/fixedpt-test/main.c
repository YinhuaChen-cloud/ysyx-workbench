#include <unistd.h>
#include <stdio.h>
#include <fixedptc.h>
#include <assert.h>

//#define fixedpt_tofloat(T) ((float) ((T)*((float)(1)/(float)(1L << FIXEDPT_FBITS))))
//#define fixedpt_toint(F) ((F) >> FIXEDPT_FBITS)

int main() {

	fixedpt A = fixedpt_rconst(1.2);
	fixedpt B = fixedpt_rconst(2.6);


///* Divides two fixedpt numbers, returns the result. */
//static inline fixedpt fixedpt_div(fixedpt A, fixedpt B) {
////	A = a * 2^8		B = b * 2^8       R = (a / b) * 2^8  = (A/B) * 2^8
//	return (A / B) * FIXEDPT_ONE;
//}
//
//static inline fixedpt fixedpt_abs(fixedpt A) {
////	A = a * 2^8
//	return A >= 0 ? A : -A;
//}
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
//static inline fixedpt fixedpt_divi(fixedpt A, int B) {
	printf("left = 0x%x, right = 0x%x\n", fixedpt_divi(A, 2), fixedpt_rconst(0.6));
	printf("sub result = 0x%x\n", fixedpt_sub(fixedpt_divi(A, 2), fixedpt_rconst(0.6)));
	printf("0.1 = 0x%x\n", fixedpt_rconst(0.1));
	assert(fixedpt_abs(fixedpt_divi(A, 2) - fixedpt_rconst(0.6)) < fixedpt_rconst(0.1));
//static inline fixedpt fixedpt_mul(fixedpt A, fixedpt B) {
	assert(fixedpt_mul(A, B) == fixedpt_rconst(3.12));


  printf("PASS!!!\n");

  return 0;
}

