#ifndef __CPUEXEC_H__
#define __CPUEXEC_H__
#include "verilated.h"
#include "emu.h"

void cpu_exec(uint32_t n);
void single_cycle();

extern VerilatedContext* contextp;
extern Vtop* top;

#endif
