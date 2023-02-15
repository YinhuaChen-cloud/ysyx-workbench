#include <proc.h>
#include <elf.h>
#include <fs.h>

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

//// yinhua add this -- start
//#define RAM_READ_BUF_LEN 0x2000000
//static uint8_t osmem[RAM_READ_BUF_LEN];
//
////static inline uint8_t  inb(uintptr_t addr) { return *(volatile uint8_t  *)addr; }
////static inline uint16_t inw(uintptr_t addr) { return *(volatile uint16_t *)addr; }
////static inline uint32_t inl(uintptr_t addr) { return *(volatile uint32_t *)addr; }
//
////static inline void outb(uintptr_t addr, uint8_t  data) { *(volatile uint8_t  *)addr = data; }
////static inline void outw(uintptr_t addr, uint16_t data) { *(volatile uint16_t *)addr = data; }
////static inline void outl(uintptr_t addr, uint32_t data) { *(volatile uint32_t *)addr = data; }
////static inline void outb(uintptr_t addr, uint8_t  data) { osmem[addr] = data; }
////static inline void outw(uintptr_t addr, uint16_t data) { osmem[addr] = data; }
////static inline void outl(uintptr_t addr, uint32_t data) { osmem[addr] = data; }
//// yinhua add this -- end

static uintptr_t loader(PCB *pcb, const char *filename) {
////	1. read program from ramdisk -- invoke ramdisk_read()
////	2. load program into mem -- the same as above
////	3. execute the program -- return the entry
//	printf("in loader, before reading ramdisk, filename = %s\n", filename);
//
//	int fd = fs_open(filename, 0, 0);
//
//	Elf_Ehdr elfheader_entity;
//	Elf_Ehdr *elfheader = &elfheader_entity; 
//
//	fs_read(fd, (void *)elfheader, sizeof(Elf_Ehdr));
//
//	assert(elfheader->e_machine == EXPECT_TYPE);	
//	assert(*(uint64_t *)elfheader->e_ident == 0x00010102464c457f);	
//
//	Elf_Phdr program_headers_entity;
//	Elf_Phdr *program_headers = &program_headers_entity;
//	fs_lseek(fd, elfheader->e_phoff, SEEK_SET);
//	fs_read(fd, (void *)program_headers, sizeof(Elf_Phdr));
//
//	for(int i = 1; i < elfheader->e_phnum; i++){
//		if(program_headers->p_type != PT_LOAD) {
//			fs_lseek(fd, elfheader->e_phoff + i*elfheader->e_phentsize, SEEK_SET);
//			fs_read(fd, (void *)program_headers, sizeof(Elf_Phdr));
//			continue;
//		}
//
//		fs_lseek(fd, program_headers->p_offset, SEEK_SET);
//		fs_read(fd, (void *)(program_headers->p_vaddr), program_headers->p_filesz);
//		memset((uint8_t *)(program_headers->p_vaddr) + program_headers->p_filesz, 0, program_headers->p_memsz - program_headers->p_filesz ); // -- zero
//
//		fs_lseek(fd, elfheader->e_phoff + i*elfheader->e_phentsize, SEEK_SET);
//		fs_read(fd, (void *)program_headers, sizeof(Elf_Phdr));
//	}
//
//	printf("in loader, after reading ramdisk, filename = %s\n", filename);
//
//	fs_close(fd);
//  return elfheader->e_entry; // return entry of the program
	return 0;

}

void naive_uload(PCB *pcb, const char *filename) {
//	pcb == NULL		filename == NULL
  uintptr_t entry = loader(pcb, filename);
  Log("Jump to entry = 0x%lx", entry);
  ((void(*)())entry) (); // execute from location entry
}

