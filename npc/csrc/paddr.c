#include "paddr.h"
#include "debug.h"

uint8_t *pmem = NULL;

/* convert the guest physical address in the guest program to host virtual address in NEMU */
uint8_t* cpu_to_sim(paddr_t paddr) { 
	printf("paddr = 0x%lx\n", paddr);
	Assert(paddr >= CONFIG_MBASE && paddr < CONFIG_MBASE + CONFIG_MSIZE, \
			"[%s:%d] In %s, out of mem bound, paddr = 0x%lx", __FILENAME__, __LINE__, __FUNCTION__, paddr);
	return pmem + paddr - CONFIG_MBASE; 
}

extern "C" void pmem_read(long long raddr, long long *rdata) {
  // 总是读取地址为`raddr & ~0x7ull`的8字节返回给`rdata`
	*rdata = *(long long *)cpu_to_sim(raddr);
}

//extern "C" void pmem_write(long long waddr, long long wdata, char wmask) {
//  // 总是往地址为`waddr & ~0x7ull`的8字节按写掩码`wmask`写入`wdata`
//  // `wmask`中每比特表示`wdata`中1个字节的掩码,
//  // 如`wmask = 0x3`代表只写入最低2个字节, 内存中的其它字节保持不变
//}
