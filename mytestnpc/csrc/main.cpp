#define CYHTOP ps2_keyboard
#define CYHTOPHEADER <Vps2_keyboard.h>
#define CYHTOPSTRUCT Vps2_keyboard
#include <nvboard.h>
#include CYHTOPHEADER

static TOP_NAME dut;

// 调用该文件中的nvboard_bind_all_pins(dut)函数即可完成所有信号的绑定。
void nvboard_bind_all_pins(CYHTOPSTRUCT* top);
// actually, nvboard_bind_all_pins invokes nvboard_bind_pin to complete its fucntion. You can check my words in build/auto_bind.cpp

static void single_cycle() {
  dut.clk = 0; dut.eval();
  dut.clk = 1; dut.eval();
}

static void reset(int n) {
  dut.rst = 1;
  while (n -- > 0) single_cycle();
  dut.rst = 0;
}

int main() {

//在进入verilator仿真的循环前，先对引脚进行绑定，然后对NVBoard进行初始化

  nvboard_bind_all_pins(&dut);
  nvboard_init(); // initialize NVBOARD nvboard_quit(): 退出NVBoard

  reset(10);

  while(1) {
//在verilator仿真的循环中更新NVBoard各组件的状态
    nvboard_update(); // 更新NVBoard中各组件的状态，每当电路状态发生改变时都需要调用该函数
//		dut.eval();
    single_cycle();
//		printf("dut.state_out = %d\n", dut.state_dout);
  }

//退出verilator仿真的循环后，销毁NVBoard的相关资源
	nvboard_quit();
}

