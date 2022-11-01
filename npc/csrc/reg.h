#ifndef __REG_H__
#define __REG_H__

#include "verilated_dpi.h"

#define GPR_NR 32

extern uint64_t *cpu_gpr;
extern uint64_t *pc;

extern "C" void set_gpr_ptr(const svOpenArrayHandle r);
extern const char *regs[GPR_NR];

extern "C" void set_pc(const svLogicVecVal* a);

// 输出RTL中通用寄存器的值
void isa_reg_display();

void sv_regs_to_c();

#endif
