#include <common.h>
#include "Vtop.h"
#include "verilated.h"

VerilatedContext* contextp;
Vtop* top;

void single_cycle() {
//	printf("In single_cycle, clock = 0\n");
  top->clock = 0; top->eval();
//	printf("In single_cycle, clock = 1\n");
  top->clock = 1; top->eval();
}

