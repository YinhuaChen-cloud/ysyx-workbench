#include <common.h>
#include "Vtop.h"
#include "verilated.h"

#ifdef CONFIG_WAVEFORM
#include "verilated_vcd_c.h"
extern VerilatedVcdC *tfp;
#endif

VerilatedContext* contextp;
Vtop* top;

#ifdef CONFIG_WAVEFORM
int first_flag = 0;
#endif

void single_cycle() {
#ifdef CONFIG_WAVEFORM
  if(!first_flag) { // 打印还没有 eval() 时的波形
    tfp->dump(contextp->time());
    first_flag = 1;
  }
#endif
//   top->clock = 0; top->eval();
// #ifdef CONFIG_WAVEFORM
//   contextp->timeInc(1); // necessary for wave gen
//   tfp->dump(contextp->time());
// #endif
//   top->clock = 1; top->eval();
// #ifdef CONFIG_WAVEFORM
//   contextp->timeInc(1); // necessary for wave gen
//   tfp->dump(contextp->time());
// #endif
}


