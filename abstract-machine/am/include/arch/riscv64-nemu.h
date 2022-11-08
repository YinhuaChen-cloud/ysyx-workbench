#ifndef ARCH_H__
#define ARCH_H__

//对于上下文, 我们只能将描述上下文的结构体类型名统一成Context, 至于其中的具体内容, 
//就无法进一步进行抽象了. 这主要是因为不同架构之间上下文信息的差异过大, 
//比如mips32有32个通用寄存器, 就从这一点来看, mips32和x86的Context注定是无法抽象成完
//全统一的结构的. 所以在AM中, Context的具体成员也是由不同的架构自己定义的, 比如x86-nemu的
//Context结构体在abstract-machine/am/include/arch/x86-nemu.h中定义. 因此, 在操
//作系统中对Context成员的直接引用, 都属于架构相关的行为, 会损坏操作系统的可移植性. 不过大
//多数情况下, 操作系统并不需要单独访问Context结构中的成员. CTE也提供了一些的接口, 来让
//操作系统在必要的时候访问它们, 从而保证操作系统的相关代码与架构无关.

//const char *regs[] = {
//  "$0", "ra", "sp", "gp", "tp", "t0", "t1", "t2",
//  "s0", "s1", "a0", "a1", "a2", "a3", "a4", "a5",
//  "a6", "a7", "s2", "s3", "s4", "s5", "s6", "s7",
//  "s8", "s9", "s10", "s11", "t3", "t4", "t5", "t6"
//};

struct Context {
  // TODO: fix the order of these members to match trap.S
	// the reason of 30: $0 no need to store, sp is not stored
	uintptr_t gpr[32]; // NOTE: no order need among gprs, restoring process will do it self
  uintptr_t mcause, mstatus, mepc;
  void *pdir;
};

#define GPR1 gpr[17] // a7
#define GPR2 gpr[0]
#define GPR3 gpr[0]
#define GPR4 gpr[0]
#define GPRx gpr[0]
#endif
