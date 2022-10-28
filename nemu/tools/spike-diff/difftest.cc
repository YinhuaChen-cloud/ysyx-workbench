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

#include "sim.h"
#include "../../include/common.h"
#include <difftest-def.h>

#ifdef CONFIG_ISA_riscv32
#undef DEFAULT_ISA
#define DEFAULT_ISA "RV32IM"
#endif

static std::vector<std::pair<reg_t, abstract_device_t*>> difftest_plugin_devices;
static std::vector<std::string> difftest_htif_args;
static std::vector<std::pair<reg_t, mem_t*>> difftest_mem(
    1, std::make_pair(reg_t(DRAM_BASE), new mem_t(CONFIG_MSIZE)));
static std::vector<int> difftest_hartids;
static debug_module_config_t difftest_dm_config = {
  .progbufsize = 2,
  .max_bus_master_bits = 0,
  .require_authentication = false,
  .abstract_rti = 0,
  .support_hasel = true,
  .support_abstract_csr_access = true,
  .support_haltgroups = true,
  .support_impebreak = true
};

struct diff_context_t {
  word_t gpr[32];
  word_t pc;
};

static sim_t* s = NULL;
static processor_t *p = NULL;
static state_t *state = NULL;

void sim_t::diff_init(int port) {
//  processor_t this class represents one processor in a RISC-V machine.
//  static processor_t *p = NULL;
  p = get_core("0"); // get NO.0 processor
//  architectural state of a RISC-V hart,		including all regs
//	static state_t *state = NULL;
  state = p->get_state();
}

void sim_t::diff_step(uint64_t n) {
  step(n);
}

void sim_t::diff_get_regs(void* diff_context) {
  struct diff_context_t* ctx = (struct diff_context_t*)diff_context;
  for (int i = 0; i < NXPR; i++) {
    ctx->gpr[i] = state->XPR[i];
  }
  ctx->pc = state->pc;
}

void sim_t::diff_set_regs(void* diff_context) {
  struct diff_context_t* ctx = (struct diff_context_t*)diff_context;
  for (int i = 0; i < NXPR; i++) {
    state->XPR.write(i, (sword_t)ctx->gpr[i]);
  }
  state->pc = ctx->pc;
}

void sim_t::diff_memcpy(reg_t dest, void* src, size_t n) {
  mmu_t* mmu = p->get_mmu();
  for (size_t i = 0; i < n; i++) {
    mmu->store_uint8(dest+i, *((uint8_t*)src+i));
  }
}

extern "C" {

// RESET_VECTOR: The addr where the first inst is 
// guest_to_host: (paddr) { return pmem + paddr - CONFIG_MBASE; }
// img_size: the bytes size of the bin read by nemu
// DIFFTEST_TO_REF: true
// RESET_VECTOR (CONFIG_MBASE->0x80000000 + CONFIG_PC_RESET_OFFSET->0x0)
// ref_difftest_memcpy(RESET_VECTOR, guest_to_host(RESET_VECTOR), img_size, DIFFTEST_TO_REF);
void difftest_memcpy(paddr_t addr, void *buf, size_t n, bool direction) {
  if (direction == DIFFTEST_TO_REF) {
    s->diff_memcpy(addr, buf, n);
  } else {
    assert(0);
  }
}

void difftest_regcpy(void* dut, bool direction) {
  if (direction == DIFFTEST_TO_REF) {
    s->diff_set_regs(dut);
  } else {
    s->diff_get_regs(dut);
  }
}

void difftest_exec(uint64_t n) {
  s->diff_step(n);
}

void difftest_init(int port) {
  difftest_htif_args.push_back(""); // difftest_htif_args is just a string_vector
	// new a class sim_t
  s = new sim_t(DEFAULT_ISA, DEFAULT_PRIV, DEFAULT_VARCH, 1, false, false,
      0, 0, NULL, reg_t(-1), difftest_mem, difftest_plugin_devices, difftest_htif_args,
      std::move(difftest_hartids), difftest_dm_config, nullptr, false, NULL, true);
	// invoke sim_t's method "diff_init"
  s->diff_init(port); // the port seems no any function
}

void difftest_raise_intr(uint64_t NO) {
  trap_t t(NO);
  p->take_trap_public(t, state->pc);
}

}
