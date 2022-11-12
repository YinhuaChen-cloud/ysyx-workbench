#include <proc.h>
#include <elf.h>

#ifdef __LP64__
# define Elf_Ehdr Elf64_Ehdr
# define Elf_Phdr Elf64_Phdr
#else
# define Elf_Ehdr Elf32_Ehdr
# define Elf_Phdr Elf32_Phdr
#endif

//#if defined(__ISA_AM_NATIVE__)
//# define EXPECT_TYPE EM_X86_64
//#elif defined(__ISA_RISCV64__)
//# define EXPECT_TYPE ...  // see /usr/include/elf.h to get the right type
//...
//#else
//# error Unsupported ISA
//#endif

// yinhua add this -- start
//#define RAM_READ_BUF_LEN 0x8000000
//static uint8_t osmem[RAM_READ_BUF_LEN];

//static inline uint8_t  inb(uintptr_t addr) { return *(volatile uint8_t  *)addr; }
//static inline uint16_t inw(uintptr_t addr) { return *(volatile uint16_t *)addr; }
//static inline uint32_t inl(uintptr_t addr) { return *(volatile uint32_t *)addr; }

//static inline void outb(uintptr_t addr, uint8_t  data) { *(volatile uint8_t  *)addr = data; }
//static inline void outw(uintptr_t addr, uint16_t data) { *(volatile uint16_t *)addr = data; }
//static inline void outl(uintptr_t addr, uint32_t data) { *(volatile uint32_t *)addr = data; }
//static inline void outb(uintptr_t addr, uint8_t  data) { osmem[addr] = data; }
//static inline void outw(uintptr_t addr, uint16_t data) { osmem[addr] = data; }
//static inline void outl(uintptr_t addr, uint32_t data) { osmem[addr] = data; }
// yinhua add this -- end

static uintptr_t loader(PCB *pcb, const char *filename) {
//	1. read program from ramdisk -- invoke ramdisk_read()
//	2. load program into mem -- the same as above
//	3. execute the program -- return the entry
	printf("in loader, before reading ramdisk\n");

	extern size_t ramdisk_read(void *buf, size_t offset, size_t len);
	printf("b\n");
//	extern uint8_t ramdisk_start;
//	extern uint8_t ramdisk_end;

	printf("a\n");
//	Elf64_Ehdr *elfheader = (Elf64_Ehdr *)(&ramdisk_start); 
	printf("c\n");
//	printf("machine = %d\n", elfheader->e_machine);
	printf("machine = %d\n", 1);
	printf("machine\n");
//	assert(*(uint64_t *)elfheader->e_ident == 0x00010102464c457f);	
//	Elf64_Phdr *program_headers = (Elf64_Phdr *)((uint8_t *)elfheader + elfheader->e_phoff);
//
//	for(Elf64_Phdr *p = program_headers; p < program_headers + elfheader->e_phnum; p++){
//		if(p->p_type != PT_LOAD) 
//			continue;
//		ramdisk_read(osmem + p->p_vaddr, p->p_offset, p->p_filesz); 
//		memset(osmem + p->p_vaddr + p->p_filesz, 0, p->p_memsz - p->p_filesz ); // -- zero
//	}

//	// loader -- start
//	// loader -- end

//	// loader -- start
//	printf("in loader, before reading ramdisk\n");
//	uint32_t *osmem_pointer = (uint32_t *)0x83000000;
//	ramdisk_read(osmem, 0, 0x4c38); // 1
//	for(uint32_t *x = (uint32_t *)osmem; (uint8_t *)x < osmem + 0x4c38; x++, osmem_pointer++) {
//		outl((uintptr_t)osmem_pointer, *x);
////		printf("0x%x\t0x%x\n", osmem_pointer, *x);
//	}
//	ramdisk_read(osmem, 0x4c38, 0xfe8); // 2
//	uint32_t *x = (uint32_t *)osmem;
//	for(; (uint8_t *)x < osmem + 0xfe8; x++, osmem_pointer++) {
//		outl((uintptr_t)osmem_pointer, *x);
////		printf("0x%x\t0x%x\n", osmem_pointer, *x);
//	}
//	for(; (uint8_t *)x < osmem + 0x1038; x++, osmem_pointer++) {
//		outl((uintptr_t)osmem_pointer, 0);
////		printf("0x%x\t0x%x\n", osmem_pointer, *x);
//	}
//	printf("in loader, after reading ramdisk\n");
//	// loader -- end
	printf("in loader, after reading ramdisk\n");
  return 0x83000430; // return entry of the program
//  return (uintptr_t)(osmem + elfheader->e_entry); // return entry of the program

}

void naive_uload(PCB *pcb, const char *filename) {
//	pcb == NULL		filename == NULL
  uintptr_t entry = loader(pcb, filename);
  Log("Jump to entry = 0x%lx", entry);
  ((void(*)())entry) (); // execute from location entry
}

