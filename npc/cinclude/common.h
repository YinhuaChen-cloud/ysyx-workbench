#ifndef __COMMON_H__
#define __COMMON_H__

#include "conf.h"
#include <stdint.h>
#include <stdio.h>
#include <assert.h>
#include <string.h>
#include <stdlib.h>

#define RESET_VECTOR (CONFIG_MBASE + CONFIG_PC_RESET_OFFSET)
#define __FILENAME__ (strrchr(__FILE__, '/') ? strrchr(__FILE__, '/') + 1 : __FILE__)
#define ARRLEN(arr) (int)(sizeof(arr) / sizeof(arr[0]))

typedef uint64_t paddr_t;
typedef uint64_t word_t;
typedef word_t vaddr_t;

typedef struct {
  word_t gpr[32];
  vaddr_t pc;
} riscv64_CPU_state;

extern riscv64_CPU_state cpu;

#endif
