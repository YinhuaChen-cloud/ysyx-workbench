#ifndef __INTSTACKFORC_H
#define __INTSTACKFORC_H

#ifdef __cplusplus
#define EXTERNC extern "C"
#else
#define EXTERNC
#endif

//interface 
EXTERNC void *createIntStack();
EXTERNC void pushIntStack(void *stack, int x);
EXTERNC void popIntStack(void *stack);
EXTERNC int intStackTop(void *stack);
EXTERNC bool isIntStackEmpty(void *stack);
EXTERNC void deleteIntStack(void *stack);


#undef EXTERNC

#endif