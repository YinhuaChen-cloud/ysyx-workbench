#include "reg.h"
#include "common.h"

uint64_t *cpu_gpr = NULL;
uint32_t *pc = NULL;

riscv64_CPU_state cpu = {};

extern "C" void set_gpr_ptr(const svOpenArrayHandle r) {
  cpu_gpr = (uint64_t *)(((VerilatedDpiOpenVar*)r)->datap());
}

extern "C" void set_pc(const svOpenArrayHandle a) {
  pc = (uint32_t *)(((VerilatedDpiOpenVar*)a)->datap());
//	printf("In set_pc, *pc = %lx\n", *pc);
}

void sv_regs_to_c() {
	for(int i = 0; i < GPR_NR; i++) {
		cpu.gpr[i] = cpu_gpr[i];
	}
	cpu.pc = *pc;
//	printf("%s\t0x%lx\t%ld\n", "pc", cpu.pc, cpu.pc);
}

const char *regs[] = {
  "$0", "ra", "sp", "gp", "tp", "t0", "t1", "t2",
  "s0", "s1", "a0", "a1", "a2", "a3", "a4", "a5",
  "a6", "a7", "s2", "s3", "s4", "s5", "s6", "s7",
  "s8", "s9", "s10", "s11", "t3", "t4", "t5", "t6"
};

// 输出RTL中通用寄存器的值
void isa_reg_display() {
  // format:  $(reg_name)\t$(hex_val)\t$(decimal_val)
  for(int i = 0; i < sizeof(regs)/sizeof(char *); i++) {
    printf("%s\t0x%lx\t%ld\n", regs[i], cpu.gpr[i], cpu.gpr[i]);
  }
  printf("%s\t0x%lx\t%ld\n", "pc", cpu.pc, cpu.pc);
}

word_t isa_reg_str2val(const char *s, bool *success) {
  for(int i = 0; i < sizeof(regs)/sizeof(char *); i++) {
    if(strcmp(regs[i], s) == 0) {
      return cpu.gpr[i];
    }
  }
  if(strcmp("pc", s) == 0) {
    return cpu.pc;
  }
  *success = false;
  return 0;
}

