#include <common.h>
#include "syscall.h"

//#define GPR1 gpr[17] // a7
//#define GPR2 gpr[0]
//#define GPR3 gpr[0]
//#define GPR4 gpr[0]
//#define GPRx gpr[0]

//事实上, 我们也可以在Nanos-lite中实现一个简单的strace: Nanos-lite可以得到系统调用的所有信息, 
//包括名字, 参数和返回值. 这也是为什么我们选择在Nanos-lite中实现strace: 系统调用是携带高层的
//程序语义的, 但NEMU中只能看到底层的状态机.

#define STRACE
#define STRACE_Log(format, ...) \
  printf("\33[1;35mstrace: " format "\33[0m\n", \
      ## __VA_ARGS__)

void do_syscall(Context *c) {
  uintptr_t a[4];
  a[0] = c->GPR1;
  a[1] = c->GPR2;
  a[2] = c->GPR3;
  a[3] = c->GPR4;

#ifdef STRACE
  switch (a[0]) {
		case SYS_yield: 
			break;
		case SYS_exit: 
			break;
		case SYS_write:
			STRACE_Log("SYS_write args:");
			break;
    default: panic("Unhandled syscall ID = %d", a[0]);
	}
#endif

  switch (a[0]) {
		case SYS_yield: 
			break;
		case SYS_exit: 
			halt(c->GPR2);
			break;
		case SYS_write:
			STRACE_Log("SYS_yield args[a0:0x%lx, a1:0x%lx, a2:0x%lx] ret[a0:0x%lx]", a[1], a[2], a[3], c->GPR2);
			assert(a[1] == 1 || a[1] == 2);
			int count;
			char *p = (char *)a[2];
			for(count = 0; count < a[3] && *p != '\0'; count++) {
				putch(*p);
				p++;
			}
			c->GPR2 = p - (char *)a[2];
			break;
    default: panic("Unhandled syscall ID = %d", a[0]);
  }
}
