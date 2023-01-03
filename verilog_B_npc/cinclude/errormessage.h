#ifndef __ERRORMESSAGE_H__
#define __ERRORMESSAGE_H__

#include "common.h"
#include "utils.h"
#include "paddr.h"

#define FMT_WORD "0x%016lx"
#define FMT_PADDR "0x%016lx"

void set_npc_state(int state, vaddr_t pc, int halt_ret);

__attribute__((noinline))
void invalid_inst(uint64_t thispc);

void printTrap();

#endif
