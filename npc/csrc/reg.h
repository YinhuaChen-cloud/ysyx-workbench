#ifndef __REG_H__
#define __REG_H__

#include "verilated_dpi.h"

#define GPR_NR 32

extern uint64_t *cpu_gpr;
extern "C" void set_gpr_ptr(const svOpenArrayHandle r);
void dump_gpr();
extern const char *regs[GPR_NR];
void isa_reg_display();

#endif
