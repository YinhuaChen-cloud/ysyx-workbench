# The following is the file cpu-tests/Makefile.recursion
	# NAME = recursion 
	# SRCS = tests/recursion.c 
	# LIBS += klib 
	# include ${AM_HOME}/Makefile
# The above commands are from cpu-tests/Makefile for recursion.c test
# From commands:
# 	ARCH=riscv64-nemu
# 	run

AM_SRCS := platform/nemu/trm.c \
           platform/nemu/ioe/ioe.c \
           platform/nemu/ioe/timer.c \
           platform/nemu/ioe/input.c \
           platform/nemu/ioe/gpu.c \
           platform/nemu/ioe/audio.c \
           platform/nemu/ioe/disk.c \
           platform/nemu/mpe.c

CFLAGS    += -fdata-sections -ffunction-sections
LDFLAGS   += -T $(AM_HOME)/scripts/linker.ld \
             --defsym=_pmem_start=0x80000000 --defsym=_entry_offset=0x0
LDFLAGS   += --gc-sections -e _start
NEMUFLAGS += -l $(shell dirname $(IMAGE).elf)/nemu-log.txt

CFLAGS += -DMAINARGS=\"$(mainargs)\"
CFLAGS += -I$(AM_HOME)/am/src/platform/nemu/include
.PHONY: $(AM_HOME)/am/src/platform/nemu/trm.c

# added by cyh, In image target IMAGE = /home/chenyinhua/sda3/ics2021/am-kernels/tests/cpu-tests/build/recursion-riscv64-nemu
# NAME = recursion
# ARCH = riscv64-nemu
# IMAGE_REL = build/$(NAME)-$(ARCH) = build/recursion-riscv64-nemu
# image is a PHONY target

image: $(IMAGE).elf # image: recursion-riscv64-nemu.elf
	@echo "added by cyh, In image target IMAGE = $(IMAGE)"
	@echo "IMAGE_REL = $(IMAGE_REL)" 
	@echo "NAME = $(NAME)"
	@echo "ARCH = $(ARCH)"
	@$(OBJDUMP) -d $(IMAGE).elf > $(IMAGE).txt # objdump -d is used for disassemble
	@echo + OBJCOPY "->" $(IMAGE_REL).bin
	@$(OBJCOPY) -S --set-section-flags .bss=alloc,contents -O binary $(IMAGE).elf $(IMAGE).bin
	# objcopy flags:
	# -S: Do not copy relocation and symbol information from the source file.
	# --set-section-flags sectionpattern=flags:
	# Set the flags for any sections matching sectionpattern.  The flags argument is a comma separated string of flag names.  The recognized names are alloc, contents, load, noload, readonly, code, data, rom, share, and debug.
	# alloc: Section will have space allocated in the process when loaded
	# contents: Section is not empty
	# -O binary: In this context "binary" is an unfortunate choice of name since it refers to a file format called "binary" which is designed to be very simple and space efficient, so that it is often used in embedded devices. It does not necessarily mean that the contents of the data in such files can only be executables; it is also possible for them to contain data and text.

run: image
	@echo "In ab/script/platform/nemu.mk, NEMUFLAGS = $(NEMUFLAGS)"
	$(MAKE) -C $(NEMU_HOME) ISA=$(ISA) run ARGS="$(NEMUFLAGS)" IMG=$(IMAGE).bin

gdb: image
	$(MAKE) -C $(NEMU_HOME) ISA=$(ISA) gdb ARGS="$(NEMUFLAGS)" IMG=$(IMAGE).bin
