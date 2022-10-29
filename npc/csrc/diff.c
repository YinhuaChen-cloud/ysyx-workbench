#include <dlfcn.h>
#include <stdio.h>
#include <assert.h>
#include <stdint.h>
#include "common.h"
#include "paddr.h"
#include "diff.h"
#include "reg.h"
#include "errormessage.h"

void (*ref_difftest_memcpy)(paddr_t addr, void *buf, size_t n, bool direction) = NULL;
void (*ref_difftest_regcpy)(void *dut, bool direction) = NULL;
void (*ref_difftest_exec)(uint64_t n) = NULL;

void init_difftest(char *ref_so_file, long img_size, int port) {
  assert(ref_so_file != NULL);

  void *handle;
  handle = dlopen(ref_so_file, RTLD_LAZY);
  assert(handle);

  ref_difftest_memcpy = (void (*)(paddr_t, void*, size_t, bool))dlsym(handle, "difftest_memcpy");
  assert(ref_difftest_memcpy);

  ref_difftest_regcpy = (void (*)(void*, bool))dlsym(handle, "difftest_regcpy");
  assert(ref_difftest_regcpy);
//
  ref_difftest_exec = (void (*)(uint64_t))dlsym(handle, "difftest_exec");
  assert(ref_difftest_exec);
//
//  ref_difftest_raise_intr = dlsym(handle, "difftest_raise_intr");
//  assert(ref_difftest_raise_intr);
//
  void (*ref_difftest_init)(int) = (void (*)(int))dlsym(handle, "difftest_init");
  assert(ref_difftest_init);
//
  ref_difftest_init(1234);
	ref_difftest_memcpy(RESET_VECTOR, guest_to_host(RESET_VECTOR), img_size, DIFFTEST_TO_REF);
  ref_difftest_regcpy(&cpu, DIFFTEST_TO_REF);
}

static bool isa_difftest_checkregs(riscv64_CPU_state *ref_r) {
	bool theSame = true;

	for(int i = 0; i < GPR_NR; i++)	{
		if(cpu.gpr[i] != ref_r->gpr[i]) {
			theSame = false;
			printf("------- regs differs, cpu.%s = 0x%lx, ref.%s = 0x%lx -------\n", regs[i], cpu.gpr[i], regs[i], ref_r->gpr[i]);
		}
	}
	if(cpu.pc != ref_r->pc) { 
		theSame = false;
		printf("------- pc differs, cpu.pc = 0x%lx, ref.pc = 0x%lx -------\n", cpu.pc, ref_r->pc);
	} 
	
  return theSame;
}

static void checkregs(riscv64_CPU_state *ref) {
  if (!isa_difftest_checkregs(ref)) {
		printf("\nOh, isa_difftest_checkregs() fails!\n");
    npc_state.state = NPC_ABORT;
    npc_state.halt_pc = cpu.pc;
  }
}

void difftest_step() {
	riscv64_CPU_state ref_r;

  ref_difftest_exec(1);
  ref_difftest_regcpy(&ref_r, DIFFTEST_TO_DUT);

  checkregs(&ref_r);
}

