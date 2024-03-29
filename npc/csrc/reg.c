#include "reg.h"
#include "common.h"

uint64_t *cpu_gpr = NULL;
uint64_t difftest_pc;
uint64_t *difftest_valid = NULL;

riscv64_CPU_state cpu = {};

extern "C" void set_gpr_ptr(const svOpenArrayHandle r) {
  cpu_gpr = (uint64_t *)(((VerilatedDpiOpenVar*)r)->datap());
}

extern "C" void transfer_pc(long long pc) {
  difftest_pc = pc;
}

// TODO: 也许有只暴露 1 bit 的方法？（要求能够实时暴露）
// 用来告诉difftest环境，pc和regs什么时候有效
extern "C" void set_valid(const svOpenArrayHandle a) {
  difftest_valid = (uint64_t *)(((VerilatedDpiOpenVar*)a)->datap());
}

void sv_regs_to_c() {
	for(int i = 0; i < GPR_NR; i++) {
		cpu.gpr[i] = cpu_gpr[i];
	}
	cpu.pc = difftest_pc;
	// printf("%s\t0x%lx\t%ld\n", "pc", cpu.pc, pc[]);
	// printf("%s\t0x%lx\t%ld\n", "pc", cpu.pc, cpu.pc);
	// printf("%s\t0x%lx\t0x%lx\n", "pc", cpu.pc, pc[0]);
	// printf("%s\t0x%lx\t0x%lx\n", "pc", cpu.pc, *pc);
}

const char *regs[] = {
  "$0", "ra", "sp", "gp", "tp", "t0", "t1", "t2",
  "s0", "s1", "a0", "a1", "a2", "a3", "a4", "a5",
  "a6", "a7", "s2", "s3", "s4", "s5", "s6", "s7",
  "s8", "s9", "s10", "s11", "t3", "t4", "t5", "t6"
};

// 输出RTL中通用寄存器的值
void isa_reg_display(riscv64_CPU_state *cpu) {
  // format:  $(reg_name)\t$(hex_val)\t$(decimal_val)
  for(int i = 0; i < sizeof(regs)/sizeof(char *); i++) {
    printf("%s\t0x%lx\t%ld\n", regs[i], cpu->gpr[i], cpu->gpr[i]);
  }
  printf("%s\t0x%lx\t%ld\n", "pc", cpu->pc, cpu->pc);
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

