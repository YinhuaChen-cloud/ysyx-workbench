# make ISA=native run

LD = $(CXX)

### Run an application with $(ISA)=native

env:
	$(MAKE) -C $(NAVY_HOME)/libs/libos ISA=native

run: app env
	@echo "In run target"
	@echo "APP = $(APP)"   # /home/chenyinhua/sda3/ysyx-workbench/navy-apps/tests/bmp-test/build/bmp-test-native
	@echo "mainargs = $(mainargs)"
	@LD_PRELOAD=$(NAVY_HOME)/libs/libos/build/native.so $(APP) $(mainargs)
#	LD_PRELOAD=/home/chenyinhua/sda3/ysyx-workbench/navy-apps/libs/libos/build/native.so ./build/bmp-test-native   we can use this command to execute program

gdb: app env
	@LD_PRELOAD=$(NAVY_HOME)/libs/libos/build/native.so gdb --args $(APP) $(mainargs)

.PHONY: env run gdb

# If you set LD_PRELOAD to the path of a shared object, that file will be loaded before any other library (including the C runtime, libc.so).
# LD_PRELOAD 是 Linux 系统中的一个环境变量，它可以影响程序的运行时的链接（Runtime linker），它允许你定义在程序运行前优先加载的动态链接库。
