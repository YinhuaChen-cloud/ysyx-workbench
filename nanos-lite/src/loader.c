#include <proc.h>
#include <elf.h>

#ifdef __LP64__
# define Elf_Ehdr Elf64_Ehdr
# define Elf_Phdr Elf64_Phdr
#else
# define Elf_Ehdr Elf32_Ehdr
# define Elf_Phdr Elf32_Phdr
#endif

// yinhua add this -- start
#define RAM_READ_BUF_LEN 0x5000
static uint8_t osmem[RAM_READ_BUF_LEN];

static inline uint8_t  inb(uintptr_t addr) { return *(volatile uint8_t  *)addr; }
static inline uint16_t inw(uintptr_t addr) { return *(volatile uint16_t *)addr; }
static inline uint32_t inl(uintptr_t addr) { return *(volatile uint32_t *)addr; }

static inline void outb(uintptr_t addr, uint8_t  data) { *(volatile uint8_t  *)addr = data; }
static inline void outw(uintptr_t addr, uint16_t data) { *(volatile uint16_t *)addr = data; }
static inline void outl(uintptr_t addr, uint32_t data) { *(volatile uint32_t *)addr = data; }
static inline void outl64(uintptr_t addr, uint64_t data) { *(volatile uint64_t *)addr = data; }
// yinhua add this -- end

static uintptr_t loader(PCB *pcb, const char *filename) {
//	let's do this easy and stupid first
//	pcb = NULL,		filename = NULL
//	其中的pcb参数目前暂不使用, 可以忽略, 而因为ramdisk中目前只有一个文件, filename参数也可以忽略.
//	1. read program from ramdisk -- invoke ramdisk_read()
//	2. load program into mem -- the same as above
//	3. execute the program -- return the entry
	extern size_t ramdisk_read(void *buf, size_t offset, size_t len);
	uint64_t *osmem_pointer = (uint64_t *)0x83000000;
	printf("in loader, before reading ramdisk\n");
	ramdisk_read(osmem, 0, 0x4c38); // 1
	for(uint64_t *x = (uint64_t *)osmem; (uint8_t *)x < osmem + 0x4c38; x++, osmem_pointer++) {
		outl64((uintptr_t)osmem_pointer, *x);
	}
	ramdisk_read(osmem, 0x4c38, 0xfe8); // 2
	for(uint64_t *x = (uint64_t *)osmem; (uint8_t *)x < osmem + 0xfe8; x++, osmem_pointer++) {
		outl64((uintptr_t)osmem_pointer, *x);
	}
	printf("in loader, after reading ramdisk\n");
//	ramdisk_read(osmem, 0x1000, 0x24d8);
  return 0x83000430; // return entry of the program
}

void naive_uload(PCB *pcb, const char *filename) {
//	pcb == NULL		filename == NULL
  uintptr_t entry = loader(pcb, filename);
  Log("Jump to entry = %p", entry);
  ((void(*)())entry) (); // execute from location entry
}

