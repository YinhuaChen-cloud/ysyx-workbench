
### *Get a more readable version of this Makefile* by `make html` (requires python-markdown)
html:
	cat Makefile | sed 's/^\([^#]\)/    \1/g' | markdown_py > Makefile.html
.PHONY: html

## 1. Basic Setup and Checks

### Default to create a bare-metal kernel image
ifeq ($(MAKECMDGOALS),)
  MAKECMDGOALS  = image
  .DEFAULT_GOAL = image
endif

### Override checks when `make clean/clean-all/html`
ifeq ($(findstring $(MAKECMDGOALS),clean|clean-all|html),)

### Print build info message
$(info # Building $(NAME)-$(MAKECMDGOALS) [$(ARCH)])

### Check: environment variable `$AM_HOME` looks sane
ifeq ($(wildcard $(AM_HOME)/am/include/am.h),)
  $(error $$AM_HOME must be an AbstractMachine repo)
endif

### Check: environment variable `$ARCH` must be in the supported list
ARCHS = $(basename $(notdir $(shell ls $(AM_HOME)/scripts/*.mk)))
ifeq ($(filter $(ARCHS), $(ARCH)), )
  $(error Expected $$ARCH in {$(ARCHS)}, Got "$(ARCH)")
endif

### Extract instruction set architecture (`ISA`) and platform from `$ARCH`. Example: `ARCH=x86_64-qemu -> ISA=x86_64; PLATFORM=qemu`
ARCH_SPLIT = $(subst -, ,$(ARCH))
ISA        = $(word 1,$(ARCH_SPLIT))
PLATFORM   = $(word 2,$(ARCH_SPLIT))

### Check if there is something to build
ifeq ($(flavor SRCS), undefined)
  $(error Nothing to build)
endif

### Checks end here
endif

## 2. General Compilation Targets

### Create the destination directory (`build/$ARCH`)
# WORK_DIR = /home/chenyinhua/sda3/ics2021/am-kernels/tests/cpu-tests
WORK_DIR  = $(shell pwd)
# DST_DIR   = $(WORK_DIR)/build/riscv64-nemu
DST_DIR   = $(WORK_DIR)/build/$(ARCH)
$(shell mkdir -p $(DST_DIR))

### Compilation targets (a binary image or archive)
IMAGE_REL = build/$(NAME)-$(ARCH)
IMAGE     = $(abspath $(IMAGE_REL))
ARCHIVE   = $(WORK_DIR)/build/$(NAME)-$(ARCH).a

### Collect the files to be linked: object files (`.o`) and libraries (`.a`)
# ============ The first situation(recursion.o) of $(OBJS) ==================
# In the file Makefile.recursion
	# NAME = recursion 
	# SRCS = tests/recursion.c 
	# LIBS += klib 
	# include ${AM_HOME}/Makefile
# From commands:
# 	ARCH = riscv64-nemu
# 	MAKECMDGOALS = run

# DST_DIR   = $(WORK_DIR)/build/riscv64-nemu
# OBJS = $(WORK_DIR)/build/riscv64-nemu/tests/recursion.o
# ============ The second situation(am) of $(OBJS) ==================
# SRCS     = src/riscv/nemu/start.S \
#            src/riscv/nemu/cte.c \
#            src/riscv/nemu/trap.S \
#            src/riscv/nemu/vme.c
#            src/platform/nemu/trm.c \
#            src/platform/nemu/ioe/ioe.c \
#            src/platform/nemu/ioe/timer.c \
#            src/platform/nemu/ioe/input.c \
#            src/platform/nemu/ioe/gpu.c \
#            src/platform/nemu/ioe/audio.c \
#            src/platform/nemu/ioe/disk.c \
#            src/platform/nemu/mpe.c
# DST_DIR   = $(AM_HOME)/am/build/riscv64-nemu
# OBJS     = $(AM_HOME)/am/build/riscv64-nemu/src/riscv/nemu/start.o
#            $(AM_HOME)/am/build/riscv64-nemu/src/riscv/nemu/cte.o \
#            $(AM_HOME)/am/build/riscv64-nemu/src/riscv/nemu/trap.o \
#            $(AM_HOME)/am/build/riscv64-nemu/src/riscv/nemu/vme.o \
#            $(AM_HOME)/am/build/riscv64-nemu/src/platform/nemu/trm.o \
#            $(AM_HOME)/am/build/riscv64-nemu/src/platform/nemu/ioe/ioe.o \
#            $(AM_HOME)/am/build/riscv64-nemu/src/platform/nemu/ioe/timer.o \
#            $(AM_HOME)/am/build/riscv64-nemu/src/platform/nemu/ioe/input.o \
#            $(AM_HOME)/am/build/riscv64-nemu/src/platform/nemu/ioe/gpu.o \
#            $(AM_HOME)/am/build/riscv64-nemu/src/platform/nemu/ioe/audio.o \
#            $(AM_HOME)/am/build/riscv64-nemu/src/platform/nemu/ioe/disk.o \
#            $(AM_HOME)/am/build/riscv64-nemu/src/platform/nemu/mpe.o
# ============ The third situation(klib) of $(OBJS) ==================
# DST_DIR   = $(AM_HOME)/klib/build/riscv64-nemu
# OBJS     = $(AM_HOME)/klib/build/riscv64-nemu/src/cpp.o
#                $(AM_HOME)/klib/build/riscv64-nemu/src/stdio.o
#                $(AM_HOME)/klib/build/riscv64-nemu/src/int64.o
#                $(AM_HOME)/klib/build/riscv64-nemu/src/string.o
#                $(AM_HOME)/klib/build/riscv64-nemu/src/stdlib.o
OBJS      = $(addprefix $(DST_DIR)/, $(addsuffix .o, $(basename $(SRCS))))
# LIBS = am klib
LIBS     := $(sort $(LIBS) am klib) # lazy evaluation ("=") causes infinite recursions

# LINKAGE = $(OBJS) $(AM_HOME)/am/build/am-native.a $(AM_HOME)/klib/build/klib-native.a 
LINKAGE   = $(OBJS) \
  $(addsuffix -$(ARCH).a, $(join \
    $(addsuffix /build/, $(addprefix $(AM_HOME)/, $(LIBS))), \
    $(LIBS) ))

## 3. General Compilation Flags

### (Cross) compilers, e.g., mips-linux-gnu-g++
AS        = $(CROSS_COMPILE)gcc
CC        = $(CROSS_COMPILE)gcc
CXX       = $(CROSS_COMPILE)g++
LD        = $(CROSS_COMPILE)ld
OBJDUMP   = $(CROSS_COMPILE)objdump
OBJCOPY   = $(CROSS_COMPILE)objcopy
READELF   = $(CROSS_COMPILE)readelf

### Compilation flags
# WORK_DIR = $(AM_HOME)/am or $(AM_HOME)/klib
# WORK_DIR = .../cpu-tests
# $(addprefix $(AM_HOME)/, $(LIBS)) = $(AM_HOME)/am $(AM_HOME)/klib
# $(addsuffix /include/, $(addprefix $(AM_HOME)/, $(LIBS))) = $(AM_HOME)/am/include  $(AM_HOME)/klib/include
INC_PATH += $(WORK_DIR)/include $(addsuffix /include/, $(addprefix $(AM_HOME)/, $(LIBS)))
# added by cyh temporary starts
INC_PATH += /home/chenyinhua/sda3/ics2021/nemu/src/monitor/sdb
# added by cyh temporary ends
INCFLAGS += $(addprefix -I, $(INC_PATH))

CFLAGS   += -O2 -MMD -Wall -Werror $(INCFLAGS) \
            -D__ISA__=\"$(ISA)\" -D__ISA_$(shell echo $(ISA) | tr a-z A-Z)__ \
            -D__ARCH__=$(ARCH) -D__ARCH_$(shell echo $(ARCH) | tr a-z A-Z | tr - _) \
            -D__PLATFORM__=$(PLATFORM) -D__PLATFORM_$(shell echo $(PLATFORM) | tr a-z A-Z | tr - _) \
            -DARCH_H=\"arch/$(ARCH).h\" \
            -fno-asynchronous-unwind-tables -fno-builtin -fno-stack-protector \
            -Wno-main -U_FORTIFY_SOURCE -ggdb -fsanitize=alignment
CXXFLAGS +=  $(CFLAGS) -ffreestanding -fno-rtti -fno-exceptions
ASFLAGS  += -MMD $(INCFLAGS)

#added by chenyinhua for NEMU-NEMU model starts
ifdef CONFIG_TARGET_AM
  CFLAGS += -DCONFIG_TARGET_AM
endif
#added by chenyinhua for NEMU-NEMU model ends

## 4. Arch-Specific Configurations

### Paste in arch-specific configurations (e.g., from `scripts/x86_64-qemu.mk`)
-include $(AM_HOME)/scripts/$(ARCH).mk

### Fall back to native gcc/binutils if there is no cross compiler
ifeq ($(wildcard $(shell which $(CC))),)
  $(info #  $(CC) not found; fall back to default gcc and binutils)
  CROSS_COMPILE :=
endif

## 5. Compilation Rules

# DST_DIR   = .../cpu-tests/build/riscv64-nemu
# DST_DIR   = .../am/build/riscv64-nemu
# DST_DIR   = .../klib/build/riscv64-nemu
### Rule (compile): a single `.c` -> `.o` (gcc)
$(DST_DIR)/%.o: %.c
	echo "In am/Makefile/DST_DIR/c, DST_DIR = $(DST_DIR)"
	echo "In am/Makefile/DST_DIR/c, CROSS_COMPILE = $(CROSS_COMPILE)"
	echo "In am/Makefile/DST_DIR/c, CFLAGS = $(CFLAGS)"
	@mkdir -p $(dir $@) && echo + CC $<
	@$(CC) -std=gnu11 $(CFLAGS) -c -o $@ $(realpath $<)

### Rule (compile): a single `.cc` -> `.o` (g++)
$(DST_DIR)/%.o: %.cc
	@mkdir -p $(dir $@) && echo + CXX $<
	echo "In am/Makefile/DST_DIR/cc, CFLAGS = $(CFLAGS)"
	@$(CXX) -std=c++17 $(CXXFLAGS) -c -o $@ $(realpath $<)

### Rule (compile): a single `.cpp` -> `.o` (g++)
$(DST_DIR)/%.o: %.cpp
	@mkdir -p $(dir $@) && echo + CXX $<
	echo "In am/Makefile/DST_DIR/cpp, CFLAGS = $(CFLAGS)"
	@$(CXX) -std=c++17 $(CXXFLAGS) -c -o $@ $(realpath $<)

### Rule (compile): a single `.S` -> `.o` (gcc, which preprocesses and calls as)
$(DST_DIR)/%.o: %.S
	@mkdir -p $(dir $@) && echo + AS $<
	echo "In am/Makefile/DST_DIR/S, CFLAGS = $(CFLAGS)"
	@$(AS) $(ASFLAGS) -c -o $@ $(realpath $<)

### Rule (recursive make): build a dependent library (am, klib, ...)
# LIBS = am klib
# am klib: %: 
$(LIBS): %:
	echo "In am/Makefile/LIBS, LIBS = $(LIBS)"
	echo "In am/Makefile/LIBS, MAKE = $(MAKE)"
	@$(MAKE) -s -C $(AM_HOME)/$* archive
	# make -s -C $(AM_HOME)/am archive
	# make -s -C $(AM_HOME)/klib archive
	# So we change to $(AM_HOME)/am/Makefile and $(AM_HOME)/klib/Makefile now
	# We are here last time

### Rule (link): objects (`*.o`) and libraries (`*.a`) -> `IMAGE.elf`, the final ELF binary to be packed into image (ld)
 
# image.elf = recursion-riscv64-nemu.elf
# We have already got recursion.o and two archives
$(IMAGE).elf: $(OBJS) am $(LIBS)
	@echo + LD "->" $(IMAGE_REL).elf
	@echo "The following is the link process of recursion-riscv64-nemu.elf"
	@echo "LD = $(LD)"
	@echo "LDFLAGS = $(LDFLAGS)"
	@echo "IMAGE = $(IMAGE)"
	@echo "LINKAGE = $(LINKAGE)"
	$(LD) $(LDFLAGS) -o $(IMAGE).elf --start-group $(LINKAGE) --end-group
# LD = riscv64-linux-gnu-ld
# LDFLAGS = -melf64lriscv
# -T /home/chenyinhua/sda3/ics2021/abstract-machine/scripts/linker.ld 
# --defsym=_pmem_start=0x80000000 --defsym=_entry_offset=0x0 
# --gc-sections 
# -e _start
# IMAGE = /home/chenyinhua/sda3/ics2021/am-kernels/tests/cpu-tests/build/recursion-riscv64-nemu
# LINKAGE = /home/chenyinhua/sda3/ics2021/am-kernels/tests/cpu-tests/build/riscv64-nemu/tests/recursion.o 
# /home/chenyinhua/sda3/ics2021/abstract-machine/am/build/am-riscv64-nemu.a 
# /home/chenyinhua/sda3/ics2021/abstract-machine/klib/build/klib-riscv64-nemu.a

# -melf64lriscv: I guess this specifies which kind of executable format we use
# -T: Use scriptfile as the linker script
# --defsym: Create a global symbol in the output file, containing the absolute address given by expression.
# --gc-sections: nable garbage collection of unused input sections.
# -e: Use entry as the explicit symbol for beginning execution of your program, rather than the default entry point.

### Rule (archive): objects (`*.o`) -> `ARCHIVE.a` (ar)
# If ARCH=riscv64-nemu, AM_SRCS can be found at ${AM_HOME}/scripts/native.mk
# AM_SRCS := native/trm.c \
#            native/ioe.c \
#            native/cte.c \
#            native/trap.S \
#            native/vme.c \
#            native/mpe.c \
#            native/platform.c \
#            native/ioe/input.c \
#            native/ioe/timer.c \
#            native/ioe/gpu.c \
#            native/ioe/audio.c \
#            native/ioe/disk.c \
# WORK_DIR = $(AM_HOME)/am or $(AM_HOME)/klib
# NAME     := am
# SRCS      = $(addprefix src/, $(AM_SRCS)) # These are ARCH-relative RE/library
# SRCS :=		 src/native/trm.c \
#            src/native/ioe.c \
#            src/native/cte.c \
#            src/native/trap.S \
#            src/native/vme.c \
#            src/native/mpe.c \
#            src/native/platform.c \
#            src/native/ioe/input.c \
#            src/native/ioe/timer.c \
#            src/native/ioe/gpu.c \
#            src/native/ioe/audio.c \
#            src/native/ioe/disk.c \
# INC_PATH += $(AM_HOME)/am/src
# include $(AM_HOME)/Makefile
# 
# NAME = klib
# SRCS = $(shell find src/ -name "*.c") # These are ARCH-independent RE/library
#    src/cpp.c
#    src/stdio.c
#    src/int64.c
#    src/string.c
#    src/stdlib.c
# include $(AM_HOME)/Makefile
# 
# AR -> build/klib-native.a
# AR -> build/am-native.a
# DST_DIR   = $(WORK_DIR)/build/$(ARCH)
# OBJS      = $(addprefix $(DST_DIR)/, $(addsuffix .o, $(basename $(SRCS))))

# ARCHIVE   = $(AM_HOME)/am/build/am-riscv64-nemu.a and $(AM_HOME)/klib/build/klib-riscv64-nemu.a
$(ARCHIVE): $(OBJS)
	@echo + AR "->" $(shell realpath $@ --relative-to .)
	@echo "In am/Makefile/ARCHIVE, DST_DIR = $(DST_DIR)"
	@echo "In am/Makefile/ARCHIVE, ARCHIVE = $(ARCHIVE), OBJS = $(OBJS)"
	@ar rcs $(ARCHIVE) $(OBJS)
	# pack ARCH-relative RE/library into am/build/am-native.a
	# pack ARCH-independent RE/library into klib/build/klib-native.a
# WORK_DIR = $(AM_HOME)/am and $(AM_HOME)/klib
	# ar rcs $(AM_HOME)/am/build/am-native.a ../cpu-tests/../recursion.o
	# ar rcs $(AM_HOME)/klib/build/klib-native.a ../cpu-tests/../recursion.o

### Rule (`#include` dependencies): paste in `.d` files generated by gcc on `-MMD

# SRCS = tests/recursion.c 
# WORK_DIR = /home/chenyinhua/sda3/ics2021/am-kernels/tests/cpu-tests
# DST_DIR   = .../cpu-tests/build/native
# -include .../cpu-tests/build/native/tests/recursion.d
# This file tells each element in $(OBJS) where their dependencies are
# What's more, it also includes all .d files of ARCH-relative RE/lib and ARCH-independent RE/lib
-include $(addprefix $(DST_DIR)/, $(addsuffix .d, $(basename $(SRCS))))

## 6. Miscellaneous

### Build order control
# @echo "added by cyh, this is another image target"
image: image-dep
# We have accessed $(AM_HOME)/am/Makefile and $(AM_HOME)/klib/Makefile already
# And we have make -C $(AM_HOME)/am -C $(AM_HOME)/klib now

# NAME     := am
# SRCS      = $(addprefix src/, $(AM_SRCS))
# INC_PATH += $(AM_HOME)/am/src

# NAME = klib
# SRCS = $(shell find src/ -name "*.c")

# WORK_DIR = $(AM_HOME)/am and $(AM_HOME)/klib
# ARCHIVE   = $(AM_HOME)/am/build/am-native.a
# and
# ARCHIVE   = $(AM_HOME)/klib/build/klib-native.a
archive: $(ARCHIVE)
	echo "In am/Makefile/archive, ARCHIVE = $(ARCHIVE)"

# WORK_DIR = /home/chenyinhua/sda3/ics2021/am-kernels/tests/cpu-tests
# OBJS = $(WORK_DIR)/build/riscv64-nemu/tests/recursion.o
# image-dep: cpu-tests/.../recursion.o  am am klib
# You need to generate $(OBJS) and $(LIBS) here
image-dep: $(OBJS) am $(LIBS)
	echo "In am/makefile/image-dep, LIBS = $(LIBS)"
	@echo \# Creating image [$(ARCH)]
.PHONY: image image-dep archive run $(LIBS)

### Clean a single project (remove `build/`)
clean:
	rm -rf Makefile.html $(WORK_DIR)/build/
.PHONY: clean

### Clean all sub-projects within depth 2 (and ignore errors)
CLEAN_ALL = $(dir $(shell find . -mindepth 2 -name Makefile))
# OBJS = $(WORK_DIR)/build/native/tests/recursion.o
clean-all: $(CLEAN_ALL) clean
$(CLEAN_ALL):
	-@$(MAKE) -s -C $@ clean
.PHONY: clean-all $(CLEAN_ALL)
