#include "Vysyx_22050039_top.h"
#include "verilated.h"
#include <stdio.h>
#include <assert.h>
#include <stdint.h>

#define MEM_SIZE 65536 // 64KB
#define MEM_BASE 0x80000000

VerilatedContext* contextp;
Vysyx_22050039_top* top;
char pmem[MEM_SIZE];

static unsigned int pmem_read(unsigned long pc) {
//	printf("pmem = 0x%p\n", pmem);
//	printf("pc = %lu\n", pc);	
	char *p = (char *)pmem + (pc-MEM_BASE) * 4; 
//	printf("p = 0x%p\n", p);
	return *(unsigned int *)(p);	
}

static void init_pmem() {
	char *p = (char *)pmem; 
	for(int i = 0; i < 20; i++) {
		*(unsigned int *)(p + i*4) = i+1;
	}
}

static void single_cycle() {
  top->clk = 0; top->eval();
  top->clk = 1; top->eval();
}
//
static void reset(int n) {
  top->rst = 1;
  while (n -- > 0) single_cycle();
  top->rst = 0;
}

int main(int argc, char** argv, char** env) {

	contextp = new VerilatedContext;
	contextp->commandArgs(argc, argv);
	top = new Vysyx_22050039_top{contextp};

	init_pmem();
	reset(10);

	int sim_time = 20;
	while (contextp->time() < sim_time && !contextp->gotFinish()) {
		contextp->timeInc(1);
//		printf("before pmem_read\n");
//		printf("top = 0x%p\n", top);
//		printf("pc = %lu\n", top->pc);	
		top->inst = pmem_read(top->pc);
//		printf("after pmem_read\n");
		printf("top->inst = 0x%x\n", top->inst);
		single_cycle();
	}

	delete top;
	delete contextp;

	return 0;
}

