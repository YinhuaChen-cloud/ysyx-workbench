include $(AM_HOME)/scripts/isa/riscv64.mk
# CROSS_COMPILE := riscv64-linux-gnu-
# COMMON_FLAGS  := -fno-pic -march=rv64g -mcmodel=medany -mstrict-align
# CFLAGS        += $(COMMON_FLAGS) -static
# ASFLAGS       += $(COMMON_FLAGS) -O0
# LDFLAGS       += -melf64lriscv
include $(AM_HOME)/scripts/platform/nemu.mk
#
# CFLAGS    += -fdata-sections -ffunction-sections
# LDFLAGS   += -T $(AM_HOME)/scripts/linker.ld \
#              --defsym=_pmem_start=0x80000000 --defsym=_entry_offset=0x0
# LDFLAGS   += --gc-sections -e _start
# NEMUFLAGS += -b -l $(shell dirname $(IMAGE).elf)/nemu-log.txt
# 
# CFLAGS += -DMAINARGS=\"$(mainargs)\"
# CFLAGS += -I$(AM_HOME)/am/src/platform/nemu/include

CFLAGS  += -DISA_H=\"riscv/riscv.h\"

AM_SRCS += riscv/nemu/start.S \
           riscv/nemu/cte.c \
           riscv/nemu/trap.S \
           riscv/nemu/vme.c
# AM_SRCS := platform/nemu/trm.c \
#            platform/nemu/ioe/ioe.c \
#            platform/nemu/ioe/timer.c \
#            platform/nemu/ioe/input.c \
#            platform/nemu/ioe/gpu.c \
#            platform/nemu/ioe/audio.c \
#            platform/nemu/ioe/disk.c \
#            platform/nemu/mpe.c
