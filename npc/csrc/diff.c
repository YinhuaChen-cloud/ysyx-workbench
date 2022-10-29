#include <dlfcn.h>
#include <stdio.h>
#include <assert.h>
#include <stdint.h>
#include "common.h"
#include "paddr.h"
#include "diff.h"

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
	printf("cyh-ha 1\n");
  ref_difftest_init(1234);
	printf("cyh-ha 2\n");
	printf("RESET_VECTOR = 0x%x\n", RESET_VECTOR);
	printf("guest_to_host = 0x%p\n", guest_to_host(RESET_VECTOR));
	ref_difftest_memcpy(RESET_VECTOR, guest_to_host(RESET_VECTOR), img_size, DIFFTEST_TO_REF);
	printf("cyh-ha 3\n");
  ref_difftest_regcpy(&cpu, DIFFTEST_TO_REF);
	printf("cyh-ha 4\n");
}

