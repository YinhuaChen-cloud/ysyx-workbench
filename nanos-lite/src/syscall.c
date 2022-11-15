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
		case SYS_yield: 
			printf("syscall yield handled\n"); 
			break;
		case SYS_exit: 
			printf("syscall exit handled\n"); 
			printf("a0 = 0x%lx\n", c->GPR2); 
			halt(c->GPR2);
			break;
		case SYS_write:
			printf("syscall write handled\n");
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
