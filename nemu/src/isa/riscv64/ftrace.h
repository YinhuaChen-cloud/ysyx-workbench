#ifndef FTRACE_H
#define FTRACE_H

#ifdef CONFIG_FTRACE

#include<elf.h>
#include<stdbool.h>

#define FTRACE_BUF_LEN 160

extern char *elf_content; // the elf content
extern FILE *ftrace_log; // used to write ftrace logs

char ftrace_buf[FTRACE_BUF_LEN];
int ftrace_indent_space;

// symtab
// symtab_size
// strtab
Elf64_Sym *symtab = NULL;
Elf64_Xword symtab_size;
char *strtab = NULL;
char *ramdisk_elf = NULL;
Elf64_Sym *ramdisk_symtab = NULL;
Elf64_Xword ramdisk_symtab_size;
char *ramdisk_strtab = NULL;

void get_symtab_strtab(){
	// get ramdisk.img elf
  FILE *fp = fopen("/home/chenyinhua/sda3/ysyx-workbench/nanos-lite/build/ramdisk.img", "rb");
	Assert(fp, "ramdisk.img does not exits");
	if(fp) {
		fseek(fp, 0, SEEK_END);
		long size = ftell(fp);

		fseek(fp, 0, SEEK_SET);
		// TODO: we need to free ramdisk_content after used it, not implemented yet
		ramdisk_elf = (char *)malloc(size);
		int ret = fread(ramdisk_elf, size, 1, fp);
		assert(ret == 1);

		fclose(fp);

		// get strtab
		Elf64_Ehdr *elfheader = (Elf64_Ehdr *)ramdisk_elf; 
		//printf("elfheader->e_shoff = %ld\n", elfheader->e_shoff);
		Elf64_Shdr *section_headers = (Elf64_Shdr *)(ramdisk_elf + elfheader->e_shoff);
		Elf64_Shdr *strtab_sh = section_headers + elfheader->e_shstrndx - 1;
		ramdisk_strtab = ramdisk_elf + strtab_sh->sh_addr + strtab_sh->sh_offset;
//		printf("ramdisk, ramdisk_strtab = %s\n", ramdisk_strtab+1); // -- checked
//		while(1);
		// get symtab	and symtab_size
		Elf64_Shdr *p = section_headers;
		for(int i = 0; i < elfheader->e_shnum; i++){
			if(p->sh_type == SHT_SYMTAB)
				break;
			p++;	
		}

		ramdisk_symtab_size = p->sh_size;
		ramdisk_symtab = (Elf64_Sym *)(ramdisk_elf + p->sh_addr + p->sh_offset);

	}
	
	// get strtab
	Elf64_Ehdr *elfheader = (Elf64_Ehdr *)elf_content; 
	//printf("elfheader->e_shoff = %ld\n", elfheader->e_shoff);
	Elf64_Shdr *section_headers = (Elf64_Shdr *)(elf_content + elfheader->e_shoff);
	Elf64_Shdr *strtab_sh = section_headers + elfheader->e_shstrndx - 1;
	strtab = elf_content + strtab_sh->sh_addr + strtab_sh->sh_offset;
	// get symtab	and symtab_size
	Elf64_Shdr *p = section_headers;
	for(int i = 0; i < elfheader->e_shnum; i++){
		if(p->sh_type == SHT_SYMTAB)
			break;
		p++;	
	}

	symtab_size = p->sh_size;
	symtab = (Elf64_Sym *)(elf_content + p->sh_addr + p->sh_offset);
}

// assume the addr must be a FUNC-type symbol in symtab
char *addrToFunc(Elf64_Addr addr){
	// search addr in nanos-lite elf 	
	Elf64_Sym *p = symtab;
	for(; (char *)p < (char *)symtab + symtab_size; p++){
		//printf("p->st_value = 0x%lx, p->st_size = %ld\n", p->st_value, p->st_size);
		if(addr >= p->st_value && addr < p->st_value + p->st_size){
			break;
		}
	}

// 	printf("catch you, addr = 0x%lx\n", addr);
//	Assert((char *)p < (char *)symtab + symtab_size, "addr = 0x%lx", addr);
	// search addr in user program elf
	if((char *)p >= (char *)symtab + symtab_size) {
//		assert(0);
		for(p = ramdisk_symtab; (char *)p < (char *)ramdisk_symtab + ramdisk_symtab_size; p++){
			if(addr == 0x83004e9c)
				printf("in ramdisk_symtab, symbol = %s\n", ramdisk_strtab + p->st_name);
			if(addr >= p->st_value && addr < p->st_value + p->st_size){
				break;
			}
		}
	}
	Assert(p != symtab, "p is just symtab");
	Assert(p != ramdisk_symtab, "p is just ramdisk_symtab");
	Assert(((char *)p < (char *)symtab + symtab_size || ((char *)p < (char *)ramdisk_symtab + ramdisk_symtab_size)), "p is out of symtab range, the current pc is 0x%lx", cpu.pc);
	Assert(ELF64_ST_TYPE(p->st_info) == STT_FUNC, "the entry we found is not FUNC");
	if((char *)p < (char *)symtab + symtab_size)
		return strtab + p->st_name;
	else
		return ramdisk_strtab + p->st_name;
}

// We assume, if and only if ddest is x1(ra), then it is call
bool isCall(word_t dest_reg){
//	//printf("dest_reg = 0x%p\n", dest_reg);
//	Assert(dest_reg, "dest_reg == NULL!");
	return dest_reg == 1;
}
// if it is jalr, and dsrc1 is x1(ra), then it is ret
bool isRet(word_t src1_reg){
//	Assert(src1_reg, "src1_reg == NULL!");
	return src1_reg == 1;	
}

#endif

#ifdef CONFIG_FTRACE
static void drawline(char *start, int ftrace_indent_space) {
	for(int i = 0; i < ftrace_indent_space; i++) {
		if(i % 2 == 0) {
			*(start + i) = '|';
		}
		else {
			*(start + i) = ' ';
		}
	}
}
#endif

static void jalr_func(Decode *s, word_t dest, word_t src1, word_t src2) {
	R(dest) = s->snpc; 
	s->dnpc = (src1 + src2)&(~1);

#ifdef CONFIG_FTRACE
	char *p = ftrace_buf;
//TODO: isFunc?   This function is to check whether the corresponding symbol type is FUNC
  uint32_t i = s->isa.inst.val;
  int rs1 = BITS(i, 19, 15);

	if(isCall(dest)){
		ftrace_indent_space += 2;
		// write into ftrace_log: pc_val [indent] call [func_name@func_addr]
		p += snprintf(p, ftrace_buf + sizeof(ftrace_buf) - p, "0x%lx", s->pc);
	  drawline(p, ftrace_indent_space);
		p += ftrace_indent_space;
		Elf64_Addr func_addr = (src1 + src2)&(~1);
		p += snprintf(p, ftrace_buf + sizeof(ftrace_buf) - p, "call [%s@0x%lx]\n", addrToFunc(func_addr), func_addr);
		fwrite(ftrace_buf, p-ftrace_buf, 1, ftrace_log);
		fflush(ftrace_log);
	} else if(isRet(rs1)){
		// write into ftrace_log: pc_val [indent] ret [func_name]
		p += snprintf(p, ftrace_buf + sizeof(ftrace_buf) - p, "0x%lx", s->pc);
	  drawline(p, ftrace_indent_space);
		p += ftrace_indent_space;
		p += snprintf(p, ftrace_buf + sizeof(ftrace_buf) - p, "ret [%s]\n", addrToFunc(s->pc)); // we are here
		fwrite(ftrace_buf, p-ftrace_buf, 1, ftrace_log);
		fflush(ftrace_log);
		ftrace_indent_space -= 2;
	} else {
		// skip, do nothing
//		//printf("wow we meet accidence\n");	
//		//printf("its cur_pc = 0x%lx\n", s->pc);
//		Assert(false, "There is a jalr which is neither call nor ret, its cur_pc = 0x%lx", s->pc);
//		TODO: we need to chage here lately
	}
#endif
}

static void jal_func(Decode *s, word_t dest, word_t src1) {
	R(dest) = s->snpc;
	s->dnpc = s->pc + src1;

#ifdef CONFIG_FTRACE
	char *p = ftrace_buf;
//TODO: isFunc?   This function is to check whether the corresponding symbol type is FUNC
	if(isCall(dest)){
		ftrace_indent_space += 2;
		// write into ftrace_log: pc_val [indent] call [func_name@func_addr]
		p += snprintf(p, ftrace_buf + sizeof(ftrace_buf) - p, "0x%lx", s->pc);
	  drawline(p, ftrace_indent_space);
		p += ftrace_indent_space;
		Elf64_Addr func_addr = s->pc + src1;
		p += snprintf(p, ftrace_buf + sizeof(ftrace_buf) - p, "call [%s@0x%lx]\n", addrToFunc(func_addr), func_addr);
		fwrite(ftrace_buf, p-ftrace_buf, 1, ftrace_log);
		fflush(ftrace_log);
	} else {
		// skip, do nothing
//		printf("s->pc = 0x%lx\n", s->pc);
//		assert(0);
	}
#endif
}

//def_EHelper(jal) {
//  rtl_li(s, ddest, s->snpc); // store pc+4 to rd
//  rtl_j(s, s->pc + id_src1->simm); // let pc + imm
//	
////	//printf("s->pc + id_src1->simm = 0x%lx\n", s->pc + id_src1->simm);
////	//printf("ddest = 0x%p\n", ddest);
//#ifdef CONFIG_FTRACE
//	char *p = ftrace_buf;
////TODO: isFunc?   This function is to check whether the corresponding symbol type is FUNC
//	if(isCall(ddest)){
//		ftrace_indent_space += 2;
//		// write into ftrace_log: pc_val [indent] call [func_name@func_addr]
//		p += snprintf(p, ftrace_buf + sizeof(ftrace_buf) - p, "0x%lx", s->pc);
//		memset(p, ' ', ftrace_indent_space); // fill logbuf with space
//		p += ftrace_indent_space;
//		Elf64_Addr func_addr = s->pc + id_src1->simm;
//		p += snprintf(p, ftrace_buf + sizeof(ftrace_buf) - p, "call [%s@0x%lx]\n", addrToFunc(func_addr), func_addr);
//		fwrite(ftrace_buf, p-ftrace_buf, 1, ftrace_log);
//	} else {
//		// skip, do nothing
////		printf("s->pc = 0x%lx\n", s->pc);
////		assert(0);
//	}
//#endif
//}

//def_EHelper(jalr) {
//  rtl_addi(s, dsrc1, dsrc1, id_src2->simm); // rs1 = rs1 + simm[11:0]
//  rtl_andi(s, dsrc1, dsrc1, ~1);   // set the least significant bit to zero
//  rtl_li(s, ddest, s->snpc); // store pc+4 to rd
//  rtl_jr(s, dsrc1); // jump to the address in rs1
//
//#ifdef CONFIG_FTRACE
//	char *p = ftrace_buf;
////TODO: isFunc?   This function is to check whether the corresponding symbol type is FUNC
//	if(isCall(ddest)){
//		ftrace_indent_space += 2;
//		// write into ftrace_log: pc_val [indent] call [func_name@func_addr]
//		p += snprintf(p, ftrace_buf + sizeof(ftrace_buf) - p, "0x%lx", s->pc);
//		memset(p, ' ', ftrace_indent_space); // fill logbuf with space
//		p += ftrace_indent_space;
//		Elf64_Addr func_addr = *dsrc1;
//		p += snprintf(p, ftrace_buf + sizeof(ftrace_buf) - p, "call [%s@0x%lx]\n", addrToFunc(func_addr), func_addr);
//		fwrite(ftrace_buf, p-ftrace_buf, 1, ftrace_log);
//	} else if(isRet(dsrc1)){
//		// write into ftrace_log: pc_val [indent] ret [func_name]
//		p += snprintf(p, ftrace_buf + sizeof(ftrace_buf) - p, "0x%lx", s->pc);
//		memset(p, ' ', ftrace_indent_space); // fill logbuf with space
//		p += ftrace_indent_space;
//		p += snprintf(p, ftrace_buf + sizeof(ftrace_buf) - p, "ret [%s]\n", addrToFunc(s->pc)); // we are here
//		fwrite(ftrace_buf, p-ftrace_buf, 1, ftrace_log);
//		ftrace_indent_space -= 2;
//	} else {
//		// skip, do nothing
////		//printf("wow we meet accidence\n");	
////		//printf("its cur_pc = 0x%lx\n", s->pc);
////		Assert(false, "There is a jalr which is neither call nor ret, its cur_pc = 0x%lx", s->pc);
////		TODO: we need to chage here lately
//	}
//#endif
//}

#endif
