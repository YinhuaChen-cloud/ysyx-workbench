#include <common.h>
#include "syscall.h"
#include <fs.h>

//#define GPR1 gpr[17] // a7
//#define GPR2 gpr[0]
//#define GPR3 gpr[0]
//#define GPR4 gpr[0]
//#define GPRx gpr[0]

//事实上, 我们也可以在Nanos-lite中实现一个简单的strace: Nanos-lite可以得到系统调用的所有信息, 
//包括名字, 参数和返回值. 这也是为什么我们选择在Nanos-lite中实现strace: 系统调用是携带高层的
//程序语义的, 但NEMU中只能看到底层的状态机.

//#define STRACE
#define STRACE_Log(format, ...) \
  printf("\33[0;33mstrace: " format "\33[0m\n", \
      ## __VA_ARGS__)

#define	_TIME_T_ long
typedef	_TIME_T_	time_t;
typedef	long		__suseconds_t;	/* microseconds (signed) */
typedef	__suseconds_t	suseconds_t;
struct timeval {
	time_t		tv_sec;		/* seconds */
	suseconds_t	tv_usec;	/* and microseconds */
};

void do_syscall(Context *c) {
  uintptr_t a[4];
  a[0] = c->GPR1;
  a[1] = c->GPR2;
  a[2] = c->GPR3;
  a[3] = c->GPR4;


  switch (a[0]) {
		case SYS_yield: 
			break;
		case SYS_exit: 
#ifdef STRACE
			STRACE_Log("SYS_exit args[a0:0x%lx, a1:0x%lx, a2:0x%lx] ret[a0:0x%lx]", a[1], a[2], a[3], c->GPR2);
#endif
			halt(c->GPR2);
			break;
		case SYS_open:
			c->GPR2 = fs_open((const char *)a[1], a[2], a[3]);
			break;
		case SYS_read:
			c->GPR2 = fs_read(a[1], (void *)a[2], a[3]);
			break;
		case SYS_write:
			c->GPR2 = fs_write(a[1], (void *)a[2], a[3]);	
			break;
		case SYS_close:
			c->GPR2 = fs_close(a[1]);
			break;
		case SYS_lseek:
			c->GPR2 = fs_lseek(a[1], a[2], a[3]);
			break;
		case SYS_brk:
			c->GPR2 = 0;
			break;
		case SYS_gettimeofday: 
			{
				uint64_t us = io_read(AM_TIMER_UPTIME).us;
				((struct timeval *)a[1])->tv_sec = us / 1000000;
				((struct timeval *)a[1])->tv_usec = us % 1000000; 
				c->GPR2 = 0;
			}
			break;
    default: panic("Unhandled syscall ID = 1%d1", a[0]);
  }

#ifdef STRACE
  switch (a[0]) {
		case SYS_yield: 
			STRACE_Log("SYS_yield args[a0:0x%lx, a1:0x%lx, a2:0x%lx] ret[a0:0x%lx]", a[1], a[2], a[3], c->GPR2);
			break;
		case SYS_exit: 
			// up there
			break;
		case SYS_open:
			STRACE_Log("SYS_open args[a0:0x%lx, a1:0x%lx, a2:0x%lx] ret[a0:0x%lx]", a[1], a[2], a[3], c->GPR2);
			break;
		case SYS_read:
			STRACE_Log("SYS_read args[a0:0x%lx, a1:0x%lx, a2:0x%lx] ret[a0:0x%lx]", a[1], a[2], a[3], c->GPR2);
			break;
		case SYS_write:
			STRACE_Log("SYS_write args[a0:0x%lx, a1:0x%lx, a2:0x%lx] ret[a0:0x%lx]", a[1], a[2], a[3], c->GPR2);
			break;
		case SYS_close:
			STRACE_Log("SYS_close args[a0:0x%lx, a1:0x%lx, a2:0x%lx] ret[a0:0x%lx]", a[1], a[2], a[3], c->GPR2);
			break;
		case SYS_lseek:
			STRACE_Log("SYS_lseek args[a0:0x%lx, a1:0x%lx, a2:0x%lx] ret[a0:0x%lx]", a[1], a[2], a[3], c->GPR2);
			break;
		case SYS_brk:
			STRACE_Log("SYS_brk args[a0:0x%lx, a1:0x%lx, a2:0x%lx] ret[a0:0x%lx]", a[1], a[2], a[3], c->GPR2);
			break;
		case SYS_gettimeofday:
			STRACE_Log("SYS_gettimeofday args[a0:0x%lx, a1:0x%lx, a2:0x%lx] ret[a0:0x%lx]", a[1], a[2], a[3], c->GPR2);
			break;
    default: panic("Unhandled syscall ID = %d", a[0]);
	}
#endif
}
