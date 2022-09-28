#***************************************************************************************
# Copyright (c) 2014-2022 Zihao Yu, Nanjing University
#
# NEMU is licensed under Mulan PSL v2.
# You can use this software according to the terms and conditions of the Mulan PSL v2.
# You may obtain a copy of Mulan PSL v2 at:
#          http://license.coscl.org.cn/MulanPSL2
#
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
# EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
# MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
#
# See the Mulan PSL v2 for more details.
#**************************************************************************************/

-include $(NEMU_HOME)/../Makefile
include $(NEMU_HOME)/scripts/build.mk

include $(NEMU_HOME)/tools/difftest.mk

compile_git:
	$(call git_commit, "compile NEMU")
$(BINARY): compile_git

# Some convenient rules

override ARGS ?= --log=$(BUILD_DIR)/nemu-log.txt
override ARGS += $(ARGS_DIFF)
# addedsimm by chenyinhua starts
ifdef IMG
	ELF_FILE = --elf=$(basename $(IMG)).elf
	FTRACE_FILE = --ftrace=$(basename $(IMG))-ftrace-log.txt
	DTRACE_FILE = --dtrace=$(basename $(IMG))-dtrace-log.txt
endif
override ARGS += $(ELF_FILE)
override ARGS += $(FTRACE_FILE)
override ARGS += $(DTRACE_FILE)
# added by chenyinhua ends

# Command to execute NEMU
IMG ?=
NEMU_EXEC := $(BINARY) $(ARGS) $(IMG)

run-env: $(BINARY) $(DIFF_REF_SO)
	@echo "We are generating cscopes and ctags"
	cd $(NEMU_HOME)/..; ctags -R; cscope -b -R;
	@echo "In run-env, BINARY = $(BINARY), DIFF_REF_SO = $(DIFF_REF_SO)"

run: run-env
	$(call git_commit, "run NEMU")
	@echo "NEMU_EXEC = $(NEMU_EXEC)"
	@echo "BINARY = $(BINARY)"
	@echo "ARGS = $(ARGS)"
	@echo "IMG = $(IMG)"
	@echo "ELF_FILE = $(ELF_FILE)"
	@echo "FTRACE_FILE = $(FTRACE_FILE)"
	@echo "chenyinhua ends"
	$(NEMU_EXEC)

gdb: run-env
	$(call git_commit, "gdb NEMU")
	gdb -s $(BINARY) --args $(NEMU_EXEC)

clean-tools = $(dir $(shell find ./tools -maxdepth 2 -mindepth 2 -name "Makefile"))
$(clean-tools):
	-@$(MAKE) -s -C $@ clean
clean-tools: $(clean-tools)
clean-all: clean distclean clean-tools

.PHONY: run gdb run-env clean-tools clean-all $(clean-tools)

