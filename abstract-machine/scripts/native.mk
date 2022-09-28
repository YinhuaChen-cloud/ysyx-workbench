AM_SRCS := native/trm.c \
           native/ioe.c \
           native/cte.c \
           native/trap.S \
           native/vme.c \
           native/mpe.c \
           native/platform.c \
           native/ioe/input.c \
           native/ioe/timer.c \
           native/ioe/gpu.c \
           native/ioe/audio.c \
           native/ioe/disk.c \

CFLAGS  += -fpie
ASFLAGS += -fpie -pie

# NAME = recursion
# IMAGE_REL = build/$(NAME)-$(ARCH) = build/recursion-native
# IMAGE     = $(abspath $(IMAGE_REL)) = /home/chenyinhua/sda3/ics2021/am-kernels/tests/cpu-tests/build/recursion-native
# LINKAGE   = $(OBJS) \
  $(addsuffix -$(ARCH).a, $(join \
    $(addsuffix /build/, $(addprefix $(AM_HOME)/, $(LIBS))), \
    $(LIBS) ))
# LINKAGE = /home/chenyinhua/sda3/ics2021/am-kernels/tests/cpu-tests/build/native/tests/recursion.o \
 /home/chenyinhua/sda3/ics2021/abstract-machine/am/build/am-native.a\
 /home/chenyinhua/sda3/ics2021/abstract-machine/klib/build/klib-native.a
# LIBS = am klib 

# image has actually a dependency - image-dep, which is specified in ${AM_HOME}/Makefile
image:
	@echo "added by cyh, this is one image target"
	echo "IMAGE_REL = $(IMAGE_REL)"
	echo "IMAGE = $(IMAGE)"
	echo "LINKAGE = $(LINKAGE)"
	echo "WORK_DIR = $(WORK_DIR)"
	echo "LIBS = $(LIBS)"
	@echo + LD "->" $(IMAGE_REL)
	@g++ -pie -o $(IMAGE) -Wl,--whole-archive $(LINKAGE) -Wl,-no-whole-archive -lSDL2 -ldl
	# g++ -pie -o $(abspath of IMAGE_REL) -Wl,--whole-archive $(LINKAGE) -Wl,-no-whole-archive -lSDL2 -ldl
	# -pie: Produce a dynamically linked position independent executable
	# -Wl

# 	run = MAKECMDGOALS
run: image
	$(IMAGE) # I guess this is the executable file?

gdb: image
	gdb -ex "handle SIGUSR1 SIGUSR2 SIGSEGV noprint nostop" $(IMAGE)
