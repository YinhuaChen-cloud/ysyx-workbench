#include <common.h>

void init_mm(void);
void init_device(void);
void init_ramdisk(void);
void init_irq(void);
void init_fs(void);
void init_proc(void);

int main() {
  extern const char logo[];
  printf("%s", logo);
  Log("'Hello World!' from Nanos-lite");
  Log("Build time: %s, %s", __TIME__, __DATE__);

  // 初始化内存管理
  init_mm();

  // 初始化设备
  init_device();

  // 初始化磁盘
  init_ramdisk();

#ifdef HAS_CTE
  init_irq();
#endif

  // 初始化文件系统
  init_fs();

  init_proc();

  Log("Finish initialization");

#ifdef HAS_CTE
  yield();
#endif

  panic("Should not reach here");
}
