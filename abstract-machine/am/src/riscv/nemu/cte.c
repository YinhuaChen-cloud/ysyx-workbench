#include <am.h>
#include <riscv/riscv.h>
#include <klib.h>

#define ECALL_FROM_M 0xb

static Context* (*user_handler)(Event, Context*) = NULL;

//const char *regs[] = {
//  "$0", "ra", "sp", "gp", "tp", "t0", "t1", "t2",
//  "s0", "s1", "a0", "a1", "a2", "a3", "a4", "a5",
//  "a6", "a7", "s2", "s3", "s4", "s5", "s6", "s7",
//  "s8", "s9", "s10", "s11", "t3", "t4", "t5", "t6"
//};

Context* __am_irq_handle(Context *c) {
//	printf("in __am_irq_handle start\n");
//	printf("size of uintptr_t = %ld\n", sizeof(uintptr_t));
//  for(int i = 0; i < sizeof(regs)/sizeof(char *); i++) {
//    printf("%s\t0x%lx\t%ld\n", regs[i], c->gpr[i], c->gpr[i]);
//  }
//	printf("%s\t0x%lx\t%ld\n", "mcause", c->mcause, c->mcause);
//	printf("%s\t0x%lx\t%ld\n", "mstatus", c->mstatus, c->mstatus);
//	printf("%s\t0x%lx\t%ld\n", "mepc", c->mepc, c->mepc);
//	printf("in __am_irq_handle end\n");
  if (user_handler) {
    Event ev = {0};
    switch (c->mcause) {
			case ECALL_FROM_M: ev.event = EVENT_YIELD; c->mepc += 4; break;
      default: ev.event = EVENT_ERROR; break;
    }

    c = user_handler(ev, c);
    assert(c != NULL);
  }

//	Values are returned from functions in integer registers a0 and a1 and floating-point registers fa0 and fa1. 
//		Floating-point values are returned in floating-point registers only if they are primitives or members of a struct consisting of only one or two floating-point values.
  return c;
}

extern void __am_asm_trap(void);

//bool cte_init(Context* (*handler)(Event ev, Context *ctx))用于进行CTE相关的初始化操作. 其中它还接受一个来自操作系统的事件处理回调函数的指针, 当发生事件时, CTE将会把事件和相关的上下文作为参数, 来调用这个回调函数, 交由操作系统进行后续处理.
//cte_init()函数会做两件事情, 第一件就是设置异常入口地址:
//cte_init()函数做的第二件事是注册一个事件处理回调函数, 这个回调函数由Nanos-lite提供
//TODO: set exception entry here
bool cte_init(Context*(*handler)(Event, Context*)) {
  // initialize exception entry
  asm volatile("csrw mtvec, %0" : : "r"(__am_asm_trap));
//	csrrw x0, csr, rs

  // register event handler
  user_handler = handler;

  return true;
}

Context *kcontext(Area kstack, void (*entry)(void *), void *arg) {
  return NULL;
}

//void yield()用于进行自陷操作, 会触发一个编号为EVENT_YIELD事件. 不同的ISA会使用不同的自陷指令来触发自陷操作, 具体实现请RTFSC.
void yield() {
  asm volatile("li a7, -1; ecall");
}

bool ienabled() {
  return false;
}

void iset(bool enable) {
}
