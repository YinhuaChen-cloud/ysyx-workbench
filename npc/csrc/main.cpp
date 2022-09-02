#include "Vtop.h"
#include "verilated.h"
#include <stdio.h>
#include <assert.h>
// for wave gen starts
#include "verilated_vcd_c.h"
// for wave gen ends

int main(int argc, char** argv, char** env) {

	// Create logs/ directory in case we have traces to put under it
	Verilated::mkdir("logs");

	VerilatedContext* contextp = new VerilatedContext;

	// for wave gen starts
	Verilated::traceEverOn(true);
	VerilatedVcdC* tfp = new VerilatedVcdC;
	// for wave gen ends
	
	contextp->commandArgs(argc, argv);
	Vtop* top = new Vtop{contextp};

	// for wave gen starts
	top->trace(tfp, 99); // Trace 99 levels of hierarchy (or see below)
	// tfp->dumpvars(1, "t"); // trace 1 level under "t"
	tfp->open("./logs/simx.vcd");	
	// for wave gen ends

	// for wave gen starts
	int sim_time = 5;
	while (contextp->time() < sim_time && !contextp->gotFinish()) {
//	while (!contextp->gotFinish()) {
		contextp->timeInc(1);
	// for wave gen ends
		int a = rand() & 1;
		int b = rand() & 1;
		top->a = a;
		top->b = b;
		top->eval();
		printf("a = %d, b = %d, f = %d\n", a, b, top->f);
		assert(top->f == a ^ b);
		// for wave gen starts
		tfp->dump(contextp->time());
		// for wave gen ends
	}
	tfp->close();

	delete top;
	delete contextp;

	return 0;
}

