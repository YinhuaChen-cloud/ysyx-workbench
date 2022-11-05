#include <common.h>
#include "Vysyx_22050039_top.h"
#include "verilated.h"

VerilatedContext* contextp;
Vysyx_22050039_top* top;

void single_cycle() {
	printf("In single_cycle, clk = 0\n");
  top->clk = 0; top->eval();
	printf("In single_cycle, clk = 1\n");
  top->clk = 1; top->eval();
}

