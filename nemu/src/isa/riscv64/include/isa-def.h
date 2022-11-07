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

#ifndef __ISA_RISCV64_H__
#define __ISA_RISCV64_H__

#include <common.h>

#define CSR_BASE 0x300
enum {
	MSTATUS = 0,
	MISA,
	MEDELEG,
	MIDELEG,
	MIE,
	MTVEC,
	MCOUNTEREN,
	MNONE
//	MSTATUSH error: 0x310
}; // define events and its values

typedef struct {
  word_t gpr[32];
  vaddr_t pc;
	uint64_t csr[MNONE];
} riscv64_CPU_state;

// decode
typedef struct {
  union {
    uint32_t val;
  } inst;
} riscv64_ISADecodeInfo;

#define isa_mmu_check(vaddr, len, type) (MMU_DIRECT)

#endif
