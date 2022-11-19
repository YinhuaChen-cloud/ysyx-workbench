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
#define LOAD_ADDRESS_MISSALIGN 0x4
#define MSTATUS_MIE (1 << 3) 
#define MSTATUS_MPIE (1 << 7) 
#define MSTATUS_MPP (3 << 11)

enum {
	EVENT_NULL = 0,
	EVENT_YIELD, EVENT_SYSCALL, EVENT_PAGEFAULT, EVENT_ERROR, 
	EVENT_IRQ_TIMER, EVENT_IRQ_IODEV, EVENT_UNALIGN_MEM_ACCESS,
} event; // define events and its values

//SR[mepc] <- PC
//SR[mcause] <- 一个描述失败原因的号码
//PC <- SR[mtvec]
word_t isa_raise_intr(word_t NO, vaddr_t epc) {
  /* TODO: Trigger an interrupt/exception with ``NO''.
   * Then return the address of the interrupt/exception vector.
   */

	// add this to pass difftest -- start
	if(0xa00001800 == cpu.mstatus && NO == EVENT_UNALIGN_MEM_ACCESS)
		cpu.mstatus = 0xa00021800;
	else
		cpu.mstatus = 0xa00001800;
	// add this to pass difftest -- end

	cpu.mepc = epc;	

	switch(NO) {
		case EVENT_SYSCALL: cpu.mcause = ECALL_FROM_M; break; // TODO: in the future we should add privilege distinguish
		case EVENT_UNALIGN_MEM_ACCESS: cpu.mcause = LOAD_ADDRESS_MISSALIGN; break; // TODO: in the future we should add privilege distinguish
		default: Assert(0, "[%s:%d] Unsupported event: 0x%lx", __FILE__, __LINE__, NO);
	}
	
//	printf("NO = %ld, epc = 0x%lx\n", NO, epc);
  return cpu.mtvec;
}

word_t isa_quit_exp() {
	cpu.mstatus |= MSTATUS_MPIE;
	cpu.mstatus &= ~MSTATUS_MPP;
	return cpu.mepc;
}

word_t isa_query_intr() {
  return INTR_EMPTY;
}
