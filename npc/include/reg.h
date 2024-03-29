#ifndef __REG_H__
#define __REG_H__

#include "verilated_dpi.h"
#include <common.h>

#define GPR_NR 32

extern uint64_t *cpu_gpr;
extern uint64_t difftest_pc;
extern uint64_t *difftest_valid;

extern "C" void set_gpr_ptr(const svOpenArrayHandle r);
extern const char *regs[GPR_NR];

extern "C" void set_pc(const svOpenArrayHandle a);

// 输出cpu中寄存器的值
void isa_reg_display(riscv64_CPU_state *cpu);

void sv_regs_to_c();

word_t isa_reg_str2val(const char *s, bool *success);

#endif
