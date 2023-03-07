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
// #ifdef CONFIG_WAVEFORM
//   if(!first_flag) { // 打印还没有 eval() 时的波形
//     tfp->dump(contextp->time()); // 此时还没有调用过 context->timeInc()， 这里是在时间 0 画上一个边
//     first_flag = 1; // 默认时间0时，clock = 1
//   }
// #endif
// 产生一个时钟下沿，然后计算这个下沿的信号变化(猜测：组合信号不受影响，时序信号也不受影响（因为我没有negedge)
  top->clock = 0; top->eval(); // 表示在时间 0, clock = 0, 然后用eval()计算各个信号的值(估计此时只能计算组合电路)    在第二次执行时，这里就表示下降沿了
#ifdef CONFIG_WAVEFORM
  tfp->dump(contextp->time()); // 把时间 0 的信号电平画下来
  contextp->timeInc(1); // 时间前进1
#endif
  // void dealWithExit();
  // dealWithExit();
  top->clock = 1; top->eval(); // 在时间 +1 时， clock = 1，这是一个上升沿。调用 eval() 计算各个信号的值 （更新上升沿的时序逻辑，以及会受到响应影响的组合逻辑）
#ifdef CONFIG_WAVEFORM
  tfp->dump(contextp->time()); // 画出这个时间的信号电平
  contextp->timeInc(1); // 时间前进1
#endif
}


