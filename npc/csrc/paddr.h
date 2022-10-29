#ifndef __PADDR_H__
#define __PADDR_H__

#include "common.h"
#include <stdlib.h>

extern uint8_t *pmem; 

uint8_t* guest_to_host(paddr_t paddr); 

static inline void init_pmem() {
	pmem = (uint8_t *)malloc(CONFIG_MSIZE);
}

static inline uint32_t pmem_read(uint64_t pc) {
//	printf("pmem = 0x%p\n", pmem);
//	printf("pc = %lu\n", pc);	
	uint8_t *p = pmem + (pc-CONFIG_MBASE); 
//	printf("p = 0x%p\n", p);
	return *(uint32_t *)(p);	
}

#endif

