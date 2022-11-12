#include <proc.h>
#include <elf.h>

#ifdef __LP64__
# define Elf_Ehdr Elf64_Ehdr
# define Elf_Phdr Elf64_Phdr
#else
# define Elf_Ehdr Elf32_Ehdr
# define Elf_Phdr Elf32_Phdr
#endif

#define MEM_SIZE
#define CONFIG_OS_MSIZE 0x2000000
static uint8_t osmem[CONFIG_OS_MSIZE];

static uintptr_t loader(PCB *pcb, const char *filename) {
//	let's do this easy and stupid first
//	pcb = NULL,		filename = NULL
//	其中的pcb参数目前暂不使用, 可以忽略, 而因为ramdisk中目前只有一个文件, filename参数也可以忽略.
//	1. read program from ramdisk -- invoke ramdisk_read()
//	2. load program into mem -- the same as above
//	3. execute the program -- return the entry
	extern size_t ramdisk_read(void *buf, size_t offset, size_t len);
	extern uint8_t ramdisk_start;
	extern uint8_t ramdisk_end;
	printf("in loader, before reading ramdisk\n");
	for(uint16_t *x = (uint16_t *)&ramdisk_start; (uint8_t *)x < &ramdisk_end; x++) {
		for(int i = 0; i < 8; i++) {
			printf("%h ", *x);
		}
		printf("\n");
	}
	printf("in loader, after reading ramdisk\n");
//	ramdisk_read(osmem, 0x1000, 0x24d8);
  return (uintptr_t)osmem; // return entry of the program
}

void naive_uload(PCB *pcb, const char *filename) {
//	pcb == NULL		filename == NULL
  uintptr_t entry = loader(pcb, filename);
  Log("Jump to entry = %p", entry);
  ((void(*)())entry) (); // execute from location entry
}

