#include <am.h>
#include <nemu.h>

// 阅读abstract-machine/am/src/platform/nemu/trm.c中的代码, 你会发现只需要实现很少的API就可以支撑起程序在TRM上运行了:

//     Area heap结构用于指示堆区的起始和末尾
//     void putch(char ch)用于输出一个字符
//     void halt(int code)用于结束程序的运行
//     void _trm_init()用于进行TRM相关的初始化工作

// 堆区是给程序自由使用的一段内存区间, 为程序提供动态分配内存的功能. TRM的API只提供堆区的起始和末尾, 而堆区的分配和管理需要程序自行维护. 当然, 程序也可以不使用堆区, 例如dummy. 
// 把putch()作为TRM的API是一个很有趣的考虑, 我们在不久的将来再讨论它, 目前我们暂不打算运行需要调用putch()的程序.

// 最后来看看halt(). halt()里面调用了nemu_trap()宏 (在abstract-machine/am/src/platform/nemu/include/nemu.h中定义), 这个宏展开之后是一条内联汇编语句, 
// 内联汇编语句允许我们在C代码中嵌入汇编语句, 显然, 这个宏的定义是和ISA相关的. 同时, 这条指令和我们常见的汇编指令不一样(例如movl $1, %eax), 它是直接通过指令的二进制编码给出的. 
// 如果你查看nemu/src/isa/$ISA/instr/decode.c, 你会发现这条指令正是那条特殊的nemu_trap! 这其实也说明了为什么要通过编码来给出这条指令, 如果你使用以下方式来给出指令, 
// 汇编器将会报错:

// asm volatile("nemu_trap");

// 因为这条特殊的指令是我们人为添加的, 标准的汇编器并不能识别它, objdump的反汇编结果也无法按照我们的想法将其反汇编为nemu_trap. nemu_trap()宏还会把一个标识结束的结束码移动到通用寄存器中,
//  这样, 这段汇编代码的功能就和nemu/src/isa/$ISA/instr/special.h 中的执行辅助函数def_EHelper(nemu_trap)对应起来了: 通用寄存器中的值将会作为参数传给rtl_hostcall, rtl_hostcall
//  将会根据传入的id(此处为HOSTCALL_EXIT)来调用set_nemu_state(), 将halt()中的结束码设置到NEMU的monitor中, monitor将会根据结束码来报告程序结束的原因. 此外, 
//  volatile是C语言的一个关键字, 如果你想了解关于volatile的更多信息, 请查阅相关资料.

extern char _heap_start;
int main(const char *args);

Area heap = RANGE(&_heap_start, PMEM_END);
#ifndef MAINARGS
#define MAINARGS ""
#endif
static const char mainargs[] = MAINARGS;

void putch(char ch) {
  outb(SERIAL_PORT, ch);
}

void halt(int code) {
  nemu_trap(code);

  // should not reach here
  while (1);
}

void _trm_init() {
  int ret = main(mainargs);
  halt(ret);
}
