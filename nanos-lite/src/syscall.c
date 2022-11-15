#include <common.h>
#include "syscall.h"

//#define GPR1 gpr[17] // a7
//#define GPR2 gpr[0]
//#define GPR3 gpr[0]
//#define GPR4 gpr[0]
//#define GPRx gpr[0]

void do_syscall(Context *c) {
  uintptr_t a[4];
  a[0] = c->GPR1;
  a[1] = c->GPR2;
  a[2] = c->GPR3;
  a[3] = c->GPR4;

  switch (a[0]) {
		case SYS_yield: printf("sysyield my god\n");
    default: panic("Unhandled syscall ID = %d", a[0]);
  }
}
