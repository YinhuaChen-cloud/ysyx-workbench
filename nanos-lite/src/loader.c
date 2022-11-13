#include <proc.h>
#include <elf.h>

#ifdef __LP64__
# define Elf_Ehdr Elf64_Ehdr
# define Elf_Phdr Elf64_Phdr
#else
# define Elf_Ehdr Elf32_Ehdr
# define Elf_Phdr Elf32_Phdr
#endif

#if defined(__ISA_AM_NATIVE__)
# define EXPECT_TYPE EM_X86_64
#elif defined(__ISA_RISCV64__)
# define EXPECT_TYPE EM_RISCV  // see /usr/include/elf.h to get the right type
#else
# error Unsupported ISA
#endif

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
	extern uint8_t ramdisk_start;
//	extern uint8_t ramdisk_end;

	printf("ramdisk_start = 0x%x\n", ramdisk_start);
	Elf_Ehdr *elfheader = (Elf_Ehdr *)(&ramdisk_start); 
	printf("elfheader->e_ident = 0x%x\n", elfheader->e_ident[0]);

	assert(elfheader->e_machine == EXPECT_TYPE);	
	assert(*(uint64_t *)elfheader->e_ident == 0x00010102464c457f);	

	Elf_Phdr *program_headers = (Elf_Phdr *)((uint8_t *)elfheader + elfheader->e_phoff);

	for(Elf_Phdr *p = program_headers; p < program_headers + elfheader->e_phnum; p++){
		if(p->p_type != PT_LOAD) {
			continue;
		}
		ramdisk_read((void *)(p->p_vaddr), p->p_offset, p->p_filesz); 
		memset((uint8_t *)(p->p_vaddr) + p->p_filesz, 0, p->p_memsz - p->p_filesz ); // -- zero
	}

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
  return elfheader->e_entry; // return entry of the program
//  return (uintptr_t)(osmem + elfheader->e_entry); // return entry of the program

}

void naive_uload(PCB *pcb, const char *filename) {
//	pcb == NULL		filename == NULL
  uintptr_t entry = loader(pcb, filename);
  Log("Jump to entry = 0x%lx", entry);
  ((void(*)())entry) (); // execute from location entry
}

