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

#define ECALL_FROM_M 0xb

//SR[mepc] <- PC
//SR[mcause] <- 一个描述失败原因的号码
//PC <- SR[mtvec]
word_t isa_raise_intr(word_t NO, vaddr_t epc) {
  /* TODO: Trigger an interrupt/exception with ``NO''.
   * Then return the address of the interrupt/exception vector.
   */
	cpu.mepc = epc;	
	switch(NO) {
		case EVENT_YIELD: cpu.mcause = ECALL_FROM_M; // TODO: in the future we should add privilege distinguish
		default: assert(0);
	}
	
//	printf("NO = %ld, epc = 0x%lx\n", NO, epc);
  return cpu.mtvec;
}

word_t isa_query_intr() {
  return INTR_EMPTY;
}
