#include <common.h>
#include "Vtop.h"
#include "verilated.h"

#ifdef CONFIG_WAVEFORM
#include "verilated_vcd_c.h"
extern VerilatedVcdC *tfp;
#endif

VerilatedContext* contextp;
Vtop* top;

// 注意：这种产生波形的方式，对于 clock 变化, 调用 eval()， dump， timeInc 的顺序是有要求的
// 有时候，你可能会发现，在时钟上升沿被触发的 invalid，在波形图中看不到，因为波形图最后是在时钟下降沿结束的
// 这里的原因是，你在 dump 之前调用了 eval，而下一个时钟上升沿，invalid触发，在eval的时候程序就结束了，没来得及调用 dump 把波形图画出来

void single_cycle() {

  top->clock = 0; top->eval(); // 表示在时间 0, clock = 0, 然后用eval()计算各个信号的值(估计此时只能计算组合电路)    在第二次执行时，这里就表示下降沿了

#ifdef CONFIG_WAVEFORM
  tfp->dump(contextp->time()); // 把时间 0 的信号电平画下来
  contextp->timeInc(1); // 时间前进1
#endif

  top->clock = 1; top->eval(); // 在时间 +1 时， clock = 1，这是一个上升沿。调用 eval() 计算各个信号的值 （更新上升沿的时序逻辑，以及会受到响应影响的组合逻辑）

#ifdef CONFIG_WAVEFORM
  tfp->dump(contextp->time()); // 画出这个时间的信号电平
  contextp->timeInc(1); // 时间前进1
#endif

}





