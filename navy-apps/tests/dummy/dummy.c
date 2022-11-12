#include <stdint.h>

#ifdef __ISA_NATIVE__
#error can not support ISA=native // NOTE: learn how to use compiler's error
#endif

#define SYS_yield 1
extern int _syscall_(int, uintptr_t, uintptr_t, uintptr_t);

int main() {
  return _syscall_(SYS_yield, 0, 0, 0);
}

//为了避免和Nanos-lite的内容产生冲突, 我们约定目前用户程序需要被链接到0x83000000(riscv32)附近, Navy已经设置好了相应的选项(见navy-apps/scripts/$ISA.mk中的LDFLAGS变量). 为了编译dummy, 在navy-apps/tests/dummy/目录下执行
