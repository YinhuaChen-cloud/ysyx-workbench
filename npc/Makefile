# ==================== mill project template --- start
VSRC_DIR = ./vsrc

export PATH := $(PATH):$(abspath ./utils)

test:
	mill -i __.test

verilog:
	$(call git_commit, "generate verilog")
	mkdir -p $(VSRC_DIR)
	mill -i __.test.runMain Elaborate -td $(VSRC_DIR)

help:
	mill -i __.test.runMain Elaborate --help

compile:
	mill -i __.compile

bsp:
	mill -i mill.bsp.BSP/install

reformat:
	mill -i __.reformat

checkformat:
	mill -i __.checkFormat

.PHONY: test verilog help compile bsp reformat checkformat

sim:
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	@echo "Write this Makefile by yourself."

include ../Makefile

# ==================== mill project template --- end
TOPNAME = top
NXDC_FILES = constr/top.nxdc
VERILOG_INC_PATH ?= $(NPC_HOME)/vinclude
INC_PATH ?= $(NPC_HOME)/cinclude

VERILATOR = verilator
VERILATOR_CFLAGS += -MMD --build -cc  \
				-O0 --x-assign fast --x-initial fast 

ifeq ($(MODE), ASSERT)
	VERILATOR_CFLAGS += --assert
else
	VERILATOR_CFLAGS += --noassert
endif

ifeq ($(WALL), TRUE)
	VERILATOR_CFLAGS += -Wall 
endif

ifeq ($(MYDIFF), TRUE)
	LDFLAGS += -ldl
endif

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

ifeq ($(MAKECMDGOALS), run)
	CSRCS += $(SRC_AUTO_BIND)
endif

ifeq ($(MAKECMDGOALS), sdb)
	override ARGS += --sdb
endif

include $(NVBOARD_HOME)/scripts/nvboard.mk

run-env: $(VSRCS) $(CSRCS)
	@echo "in run-env, debug by cyh CSRCS = $(CSRCS)"
	@echo "in run-env, debug by cyh VSRCS = $(VSRCS)"
	@echo "in run-env, debug by cyh VERILATOR_CFLAGS = $(VERILATOR_CFLAGS)"
	@echo "in run-env, debug by cyh CFLAGS = $(CFLAGS)"
	@echo "in run-env, debug by cyh NPCFLAGS = $(NPCFLAGS)"
	@echo "debug by cyh $$^ = $^"
	@rm -rf $(OBJ_DIR)
	$(VERILATOR) $(VERILATOR_CFLAGS) \
		--top-module $(TOPNAME) $^ \
		$(addprefix -CFLAGS , $(CFLAGS)) $(addprefix -LDFLAGS , $(LDFLAGS)) \
		--Mdir $(OBJ_DIR) --exe -o $(abspath $(BIN))

sim: run-env 
	@echo "BIN = $(BIN)"
	@echo "ARGS = $(ARGS)"
	@echo "IMG = $(IMG)"
	$(BIN) $(ARGS) $(IMG)
# 	verilator -Wall --cc --exe --build --trace $(NPC_HOME)/csrc/main.cpp $(NPC_HOME)/vsrc/top.v
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	cd ${NPC_HOME}/..; cscope -b -R;

gdb: run-env
	$(call git_commit, "gdb NEMU")
	gdb -s $(BIN) --args $(BIN) $(ARGS) $(IMG)

sdb: sim

# rules for verilator
INCFLAGS = $(addprefix -I, $(INC_PATH))
VERILOG_INCFLAGS = $(addprefix -I, $(VERILOG_INC_PATH))
VERILATOR_CFLAGS += $(VERILOG_INCFLAGS)
CFLAGS += $(INCFLAGS) -ggdb3 -O2 -Wall -Werror -DTOP_NAME="\"V$(TOPNAME)\"" 
LDFLAGS += -lSDL2 -lSDL2_image -lreadline

# build/top: 
$(BIN): verilog $(VSRCS) $(CSRCS) $(NVBOARD_ARCHIVE)
	echo "debug by cyh VSRCS = $(VSRCS)"
	echo "debug by cyh CSRCS = $(CSRCS)"
	echo "debug by cyh NVBOARD_ARCHIVE = $(NVBOARD_ARCHIVE)"
	@rm -rf $(OBJ_DIR)
	$(VERILATOR) $(VERILATOR_CFLAGS) \
		--top-module $(TOPNAME) $(VSRCS) $(CSRCS) $(NVBOARD_ARCHIVE) \
		$(addprefix -CFLAGS , $(CFLAGS)) $(addprefix -LDFLAGS , $(LDFLAGS)) \
		--Mdir $(OBJ_DIR) --exe -o $(abspath $(BIN))
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	cd ${NPC_HOME}/..; cscope -b -R;

all: default

run: $(BIN)
	# BIN build/top
	@$^

clean:
	rm -rf $(BUILD_DIR) $(VSRC_DIR) ./out ./test_run_dir ./logs ./obj_dir

.PHONY: clean sim gdb run-env sdb


