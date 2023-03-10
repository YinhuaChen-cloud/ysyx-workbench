/***************************************************************************************
* Copyright (c) 2014-2022 Zihao Yu, Nanjing University
*
* NEMU is licensed under Mulan PSL v2.
* You can use this software according to the terms and conditions of the Mulan PSL v2.
* You may obtain a copy of Mulan PSL v2 at:
*          http://license.coscl.org.cn/MulanPSL2
*
* THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
* EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
* MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
*
* See the Mulan PSL v2 for more details.
***************************************************************************************/

#include <isa.h>
#include "local-include/reg.h"

const char *regs[] = {
  "$0", "ra", "sp", "gp", "tp", "t0", "t1", "t2",
  "s0", "s1", "a0", "a1", "a2", "a3", "a4", "a5",
  "a6", "a7", "s2", "s3", "s4", "s5", "s6", "s7",
  "s8", "s9", "s10", "s11", "t3", "t4", "t5", "t6"
};

#ifdef CONFIG_DIFFTEST
void ref_isa_reg_display(CPU_state *ref) {
	printf("-----------------The ref regs value is as follows: -------------\n");
  for(int i = 0; i < sizeof(regs)/sizeof(char *); i++) {
    printf("%s\t0x%lx\t%ld\n", regs[i], ref->gpr[i], ref->gpr[i]);
  }
  printf("%s\t0x%lx\t%ld\n", "pc", ref->pc, ref->pc);
}
#endif

// assume each name in the string array regs[] matches gpr number, not checked yet
void isa_reg_display() {
  // format:  $(reg_name)\t$(hex_val)\t$(decimal_val)
  for(int i = 0; i < sizeof(regs)/sizeof(char *); i++) {
    printf("%s\t0x%lx\t%ld\n", regs[i], cpu.gpr[i], cpu.gpr[i]);
  }
	printf("%s\t0x%lx\t%ld\n", "mcause", cpu.mcause, cpu.mcause);
	printf("%s\t0x%lx\t%ld\n", "mstatus", cpu.mstatus, cpu.mstatus);
	printf("%s\t0x%lx\t%ld\n", "mepc", cpu.mepc, cpu.mepc);
	printf("%s\t0x%lx\t%ld\n", "mtvec", cpu.mtvec, cpu.mtvec);
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
