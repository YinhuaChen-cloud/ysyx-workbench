TOPNAME = top
NXDC_FILES = constr/top.nxdc
INC_PATH ?=

VERILATOR = verilator
VERILATOR_CFLAGS += -MMD --build -cc  \
				-O3 --x-assign fast --x-initial fast --noassert

BUILD_DIR = ./build
OBJ_DIR = $(BUILD_DIR)/obj_dir
BIN = $(BUILD_DIR)/$(TOPNAME)

default: $(BIN)

$(shell mkdir -p $(BUILD_DIR))

# constraint file
SRC_AUTO_BIND = $(abspath $(BUILD_DIR)/auto_bind.cpp)
# 通过命令python $(NVBOARD_HOME)/scripts/auto_pin_bind.py nxdc约束文件路径 auto_bind.cpp输出路径来生成C++文件
$(SRC_AUTO_BIND): $(NXDC_FILES)
	echo "debug by cyh SRC_AUTO_BIND = $(SRC_AUTO_BIND)"
	python3 $(NVBOARD_HOME)/scripts/auto_pin_bind.py $^ $@

# project source
VSRCS = $(shell find $(abspath ./vsrc) -name "*.v")
CSRCS = $(shell find $(abspath ./csrc) -name "*.c" -or -name "*.cc" -or -name "*.cpp")
CSRCS += $(SRC_AUTO_BIND)

include $(NVBOARD_HOME)/scripts/nvboard.mk

sim:
	# @echo "debug by cyh CSRC = $(CSRC)"
	# @echo "debug by cyh OBJS = $(OBJS)"
	# echo "debug by cyh VSRC = $(VSRC)"
	verilator -Wall --cc --exe --build --trace $(NPC_HOME)/csrc/main.cpp $(NPC_HOME)/vsrc/top.v
	./obj_dir/Vtop
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	@echo "Write this Makefile by your self."

# rules for verilator
INCFLAGS = $(addprefix -I, $(INC_PATH))
CFLAGS += $(INCFLAGS) -DTOP_NAME="\"V$(TOPNAME)\""
LDFLAGS += -lSDL2 -lSDL2_image

# build/top: 
$(BIN): $(VSRCS) $(CSRCS) $(NVBOARD_ARCHIVE)
	echo "debug by cyh VSRCS = $(VSRCS)"
	echo "debug by cyh CSRCS = $(CSRCS)"
	echo "debug by cyh NVBOARD_ARCHIVE = $(NVBOARD_ARCHIVE)"
	@rm -rf $(OBJ_DIR)
	$(VERILATOR) $(VERILATOR_CFLAGS) \
		--top-module $(TOPNAME) $^ \
		$(addprefix -CFLAGS , $(CFLAGS)) $(addprefix -LDFLAGS , $(LDFLAGS)) \
		--Mdir $(OBJ_DIR) --exe -o $(abspath $(BIN))
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	cd ${NPC_HOME}/..; cscope -b -R;

all: default

run: $(BIN)
	# BIN build/top
	@$^

clean:
	rm -rf ./logs ./obj_dir $(BUILD_DIR)

.PHONY: clean

include ../Makefile
