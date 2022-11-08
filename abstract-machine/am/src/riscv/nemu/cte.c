#include <am.h>
#include <riscv/riscv.h>
#include <klib.h>

static Context* (*user_handler)(Event, Context*) = NULL;

const char *regs[] = {
  "$0", "ra", "sp", "gp", "tp", "t0", "t1", "t2",
  "s0", "s1", "a0", "a1", "a2", "a3", "a4", "a5",
  "a6", "a7", "s2", "s3", "s4", "s5", "s6", "s7",
  "s8", "s9", "s10", "s11", "t3", "t4", "t5", "t6"
};
//$0, sp, 
//    800005e4:   00113423                sd      ra,8(sp)
//    800005e8:   00313c23                sd      gp,24(sp)
//    800005ec:   02413023                sd      tp,32(sp)
//    800005f0:   02513423                sd      t0,40(sp)
//    800005f4:   02613823                sd      t1,48(sp)
//    800005f8:   02713c23                sd      t2,56(sp)
//    800005fc:   04813023                sd      s0,64(sp)
//    80000600:   04913423                sd      s1,72(sp)
//    80000604:   04a13823                sd      a0,80(sp)
//    80000608:   04b13c23                sd      a1,88(sp)
//    8000060c:   06c13023                sd      a2,96(sp)
//    80000610:   06d13423                sd      a3,104(sp)
//    80000614:   06e13823                sd      a4,112(sp)
//    80000618:   06f13c23                sd      a5,120(sp)
//    8000061c:   09013023                sd      a6,128(sp)
//    80000620:   09113423                sd      a7,136(sp)
//    80000624:   09213823                sd      s2,144(sp)
//    80000628:   09313c23                sd      s3,152(sp)
//    8000062c:   0b413023                sd      s4,160(sp)
//    80000630:   0b513423                sd      s5,168(sp)
//    80000634:   0b613823                sd      s6,176(sp)
//    80000638:   0b713c23                sd      s7,184(sp)
//    8000063c:   0d813023                sd      s8,192(sp)
//    80000640:   0d913423                sd      s9,200(sp)
//    80000644:   0da13823                sd      s10,208(sp)
//    80000648:   0db13c23                sd      s11,216(sp)
//    8000064c:   0fc13023                sd      t3,224(sp)
//    80000650:   0fd13423                sd      t4,232(sp)
//    80000654:   0fe13823                sd      t5,240(sp)
//    80000658:   0ff13c23                sd      t6,248(sp)
//    8000065c:   342022f3                csrr    t0,mcause
//    80000660:   30002373                csrr    t1,mstatus
//    80000664:   341023f3                csrr    t2,mepc
//    80000668:   10513023                sd      t0,256(sp)
//    8000066c:   10613423                sd      t1,264(sp)
//    80000670:   10713823                sd      t2,272(sp)

Context* __am_irq_handle(Context *c) {
	printf("in __am_irq_handle start\n");
	printf("size of uintptr_t = %d\n", sizeof(uintptr_t));
  for(int i = 0; i < sizeof(regs)/sizeof(char *); i++) {
    printf("i = %d\n", i);
    printf("%s\t0x%lx\t%d\n", regs[i], c->gpr[i], c->gpr[i]);
  }
	printf("%s\t0x%lx\t%d\n", "mcause", c->mcause, c->mcause);
	printf("%s\t0x%lx\t%d\n", "mcause", c->mstatus, c->mstatus);
	printf("%s\t0x%lx\t%d\n", "mepc", c->mepc, c->mepc);
	printf("in __am_irq_handle end\n");
  if (user_handler) {
    Event ev = {0};
    switch (c->mcause) {
      default: ev.event = EVENT_ERROR; break;
    }

    c = user_handler(ev, c);
    assert(c != NULL);
  }

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
