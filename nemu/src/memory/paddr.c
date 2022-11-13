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

#include <memory/host.h>
#include <memory/paddr.h>
#include <device/mmio.h>
#include <isa.h>

#if   defined(CONFIG_PMEM_MALLOC)
static uint8_t *pmem = NULL;
#else // CONFIG_PMEM_GARRAY
static uint8_t pmem[CONFIG_MSIZE] PG_ALIGN = {};
#endif

#ifdef CONFIG_MTRACE
// format: cpu.pc, instrction code(4 bytes), disasm, accessed mem  
char mtrace_buf[MTBUF_LEN];
int pmtrace;
char *mtrace_buf_p;
extern FILE *mtrace_fp;
extern uint32_t text_size;
#endif

uint8_t* guest_to_host(paddr_t paddr) { return pmem + paddr - CONFIG_MBASE; }
paddr_t host_to_guest(uint8_t *haddr) { return haddr - pmem + CONFIG_MBASE; }

static word_t pmem_read(paddr_t addr, int len) {
  word_t ret = host_read(guest_to_host(addr), len);
  return ret;
}

static void pmem_write(paddr_t addr, int len, word_t data) {
  host_write(guest_to_host(addr), len, data);
}

static void out_of_bound(paddr_t addr) {
  panic("address = " FMT_PADDR " is out of bound of pmem [" FMT_PADDR ", " FMT_PADDR "] at pc = " FMT_WORD,
      addr, (paddr_t)CONFIG_MBASE, (paddr_t)CONFIG_MBASE + CONFIG_MSIZE - 1, cpu.pc);
}

void init_mem() {
#if   defined(CONFIG_PMEM_MALLOC)
  pmem = malloc(CONFIG_MSIZE);
  assert(pmem);
#endif
#ifdef CONFIG_MEM_RANDOM
  uint32_t *p = (uint32_t *)pmem;
  int i;
  for (i = 0; i < (int) (CONFIG_MSIZE / sizeof(p[0])); i ++) {
    p[i] = rand();
  }
#endif
  Log("physical memory area [" FMT_PADDR ", " FMT_PADDR "]",
      (paddr_t)CONFIG_MBASE, (paddr_t)CONFIG_MBASE + CONFIG_MSIZE - 1);
}

#define TEXT_SIZE 0x20c

word_t paddr_read(paddr_t addr, int len) {
#ifdef CONFIG_MTRACE
	if(in_pmem(addr) && addr >= CONFIG_MTRACE_START && addr <= CONFIG_MTRACE_END && addr >= CONFIG_MBASE + TEXT_SIZE) {
//		$pc: R/W addr (len) data	
		int retval = sprintf(mtrace_buf, "pc: 0x%lx\t%5s\taddr: 0x%x\tlen: %d\n", cpu.pc, "Read", addr, len);
		fwrite(mtrace_buf, retval, 1, mtrace_fp);
		fflush(mtrace_fp);
	}
#endif
  if (likely(in_pmem(addr))) return pmem_read(addr, len);
  IFDEF(CONFIG_DEVICE, return mmio_read(addr, len));
  out_of_bound(addr);
  return 0;
}

void paddr_write(paddr_t addr, int len, word_t data) {
//#ifdef CONFIG_MTRACE
//	if(cpu.pc != addr && addr >= CONFIG_MTRACE_START && addr <= CONFIG_MTRACE_END){
//		//printf("CONFIG_MTRACE_START = 0x%x, CONFIG_MTRACE_END = 0x%x\n", CONFIG_MTRACE_START, CONFIG_MTRACE_END);
//		pmtrace = (pmtrace + 1) % MTBUF_NUM;
//		
//		mtrace_buf_p = mtrace_buf[pmtrace];
//		mtrace_buf_p += snprintf(mtrace_buf_p, sizeof(mtrace_buf[pmtrace]), "W addr:0x%x len:%d data:0x%8lx pc:0x%8lx ", addr, len, data, cpu.pc); // 4 spaces
//		// added by yinhua for temporary debug -- start
//		*mtrace_buf_p = '\n';	
//		*(mtrace_buf_p+1) = '\0';	
//		if(!mtrace_fp)		 
//			mtrace_fp = fopen(mtrace_file, "w");
//		fwrite(mtrace_buf[pmtrace], mtrace_buf_p-mtrace_buf[pmtrace]+1, 1, mtrace_fp);
//		fflush(mtrace_fp);
//		// added by yinhua for temporary debug -- end
//		isldst = true;
//	}
//#endif
  if (likely(in_pmem(addr))) { pmem_write(addr, len, data); return; }
  IFDEF(CONFIG_DEVICE, mmio_write(addr, len, data); return);
  out_of_bound(addr);
}

