#include "paddr.h"
#include "debug.h"
#include <common.h>
#include <diff.h>

#define _BSD_SOURCE
#include <sys/time.h>

extern struct timeval boot_time;

uint8_t *pmem = NULL;

#ifdef CONFIG_MTRACE
#define MTRACE_BUF_LEN 128
char *mtrace_file = NULL;
static FILE *mtrace_fp = NULL;
static char mtrace_buf[MTRACE_BUF_LEN];
#endif

/* convert the guest physical address in the guest program to host virtual address in NEMU */
uint8_t* cpu_to_sim(paddr_t paddr) { 
	Assert(paddr >= CONFIG_MBASE && paddr < CONFIG_MBASE + CONFIG_MSIZE, \
			"[%s:%d] In %s, out of mem bound, paddr = 0x%lx", __FILENAME__, __LINE__, __FUNCTION__, paddr);
	return (uint8_t *)((uint64_t)pmem + paddr - CONFIG_MBASE); 
}

void init_mtrace() {
#ifdef CONFIG_MTRACE
	assert(mtrace_file);
  mtrace_fp = fopen(mtrace_file, "w");
	assert(mtrace_fp);
#endif
}

void close_mtrace() {
#ifdef CONFIG_MTRACE
	assert(mtrace_fp);
	fclose(mtrace_fp);
	mtrace_fp = NULL;
#endif
}

extern "C" void pmem_read(long long raddr, long long *rdata) {
//	if(raddr >= CONFIG_RTC_ADDR && raddr < CONFIG_RTC_ADDR + 8) {
//		difftest_skip_ref();
//
//		struct timeval now;
//		gettimeofday(&now, NULL);
//		long seconds = now.tv_sec - boot_time.tv_sec;
//		*rdata = seconds * 1000000;	
//
//		if(raddr == CONFIG_RTC_ADDR) {
//			*rdata &= 0xffffffff;
//		}
//		else if(raddr == CONFIG_RTC_ADDR + 4) {
//			*rdata >>= 32;
//		}
//		return;
//	}
  // 总是读取地址为`raddr & ~0x7ull`的8字节返回给`rdata`
	*rdata = *(long long *)cpu_to_sim(raddr & ~0x7ull);
	// mtrace -> NOTE: we need to judge whether raddr is a inst or a data -> human assistance
	// filterout inst reading -> human assistance	
//	#define TEXT_SIZE 0x26c	
//	if(raddr < CONFIG_MBASE + TEXT_SIZE)
//		return;
//	snprintf(mtrace_buf, MTRACE_BUF_LEN, "pc:0x%8lx %5s addr:0x%8llx data:0x%8llx\n", cpu.pc, "Read", raddr, *rdata); 
//	fwrite(mtrace_buf, strlen(mtrace_buf), 1, mtrace_fp);
//	fflush(mtrace_fp);
}

extern "C" void pmem_write(long long waddr, long long wdata, char wmask) {
//	// peripheral
//	if(waddr == CONFIG_SERIAL_PORT) {
//		printf("%c", (char)(wdata & 0xff));
//		difftest_skip_ref();
//		return;
//	}
  // 总是往地址为`waddr & ~0x7ull`的8字节按写掩码`wmask`写入`wdata`
  // `wmask`中每比特表示`wdata`中1个字节的掩码,
  // 如`wmask = 0x3`代表只写入最低2个字节, 内存中的其它字节保持不变
	uint64_t mymask = 1;	
	uint64_t offest = waddr & 0x7ull;
	switch(wmask) {
		case 0x1: mymask = 0xff; break;
		case 0x3: mymask = 0xffff; break;
		case 0xf: mymask = 0xffffffff; break;
		case -1: mymask = -1; break;
		default: panic("In %s, Unsupported wmask argument", __FUNCTION__); break;
	}
	Assert(mymask != 1, "mymask == 1");	
	*(uint64_t *)(cpu_to_sim(waddr & ~0x7ull) + offest) &= ~mymask;
	*(uint64_t *)(cpu_to_sim(waddr & ~0x7ull) + offest) |= wdata & mymask;

	printf("omg this is pmem_write!\n");
#ifdef CONFIG_MTRACE
	snprintf(mtrace_buf, MTRACE_BUF_LEN, "pc:0x%8lx %5s addr:0x%8llx data:0x%8llx mymask:0x%8lx\n", cpu.pc, "Write", waddr, wdata, mymask); 
	fwrite(mtrace_buf, strlen(mtrace_buf), 1, mtrace_fp);
	fflush(mtrace_fp);
#endif
}

word_t paddr_read(paddr_t addr, int len) {
	long long rdata;
	pmem_read(addr, &rdata);
  switch (len) {
    case 1: return (uint8_t)rdata;
    case 2: return (uint16_t)rdata;
    case 4: return (uint32_t)rdata;
    case 8: return (uint64_t)rdata;
    default: Assert(0, "Unsupported len = %d", len);
  }
}

word_t vaddr_read(vaddr_t addr, int len) {
  return paddr_read(addr, len);
}

