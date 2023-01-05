#ifndef __PADDR_H__
#define __PADDR_H__

#include "common.h"
#include <stdlib.h>

extern uint8_t *pmem; 

extern char *mtrace_file;

uint8_t* cpu_to_sim(paddr_t paddr); 

static inline void init_pmem() {
	pmem = (uint8_t *)malloc(CONFIG_MSIZE);
}

//static inline uint32_t pmem_read(uint64_t pc) {
//	uint8_t *p = pmem + (pc-CONFIG_MBASE); 
//	return *(uint32_t *)(p);	
//}

void init_mtrace();

void close_mtrace();

extern "C" void pmem_read(long long raddr, long long *rdata);

extern "C" void pmem_write(long long waddr, long long wdata, char wmask);

word_t paddr_read(paddr_t addr, int len);

word_t vaddr_read(vaddr_t addr, int len);

#endif

