#include "Vtop.h"
#include "verilated.h"
#include "svdpi.h"
//#include "Vtop__Dpi.h"
#include <getopt.h>

#define _BSD_SOURCE
#include <sys/time.h>

VerilatedContext* contextp;
Vtop* top;

#include "verilated_dpi.h"
uint64_t *pc = NULL;

extern "C" void set_pc(const svOpenArrayHandle a) {
  pc = (uint64_t *)(((VerilatedDpiOpenVar*)a)->datap());
//	printf("In set_pc, *pc = %lx\n", *pc);
}

static void single_cycle() {
  top->clock = 0; top->eval();
  top->clock = 1; top->eval();
}

static void reset(int n) {
  top->reset = 1;
  while (n -- > 0) single_cycle();
  top->reset = 0;
}

int main(int argc, char** argv, char** env) {

	contextp = new VerilatedContext;
	contextp->commandArgs(argc, argv);
	top = new Vtop{contextp};

	reset(10);

	while (!contextp->gotFinish()) {
		printf("io_pc = 0x%lx\n", top->io_pc);
		contextp->timeInc(1);
		single_cycle();
	}

	delete top;
	delete contextp;

}

