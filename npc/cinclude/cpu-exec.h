#ifndef __CPUEXEC_H__
#define __CPUEXEC_H__
#include "Vtop.h"
#include "verilated.h"

void single_cycle();

extern VerilatedContext* contextp;
extern Vtop* top;

#endif
