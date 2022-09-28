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

COLOR_RED := $(shell echo "\033[1;31m")
COLOR_END := $(shell echo "\033[0m")

ifeq ($(wildcard .config),)
$(warning $(COLOR_RED)Warning: .config does not exists!$(COLOR_END))
$(warning $(COLOR_RED)To build the project, first run 'make menuconfig'.$(COLOR_END))
endif

Q            := @
KCONFIG_PATH := $(NEMU_HOME)/tools/kconfig
FIXDEP_PATH  := $(NEMU_HOME)/tools/fixdep
Kconfig      := $(NEMU_HOME)/Kconfig
rm-distclean += include/generated include/config .config .config.old
silent := -s

CONF   := $(KCONFIG_PATH)/build/conf
MCONF  := $(KCONFIG_PATH)/build/mconf
FIXDEP := $(FIXDEP_PATH)/build/fixdep

$(CONF):
	$(Q)$(MAKE) $(silent) -C $(KCONFIG_PATH) NAME=conf

$(MCONF):
	$(Q)$(MAKE) $(silent) -C $(KCONFIG_PATH) NAME=mconf

$(FIXDEP):
	$(Q)$(MAKE) $(silent) -C $(FIXDEP_PATH)

menuconfig: $(MCONF) $(CONF) $(FIXDEP)
	$(Q)$(MCONF) $(Kconfig)
	$(Q)$(CONF) $(silent) --syncconfig $(Kconfig)

savedefconfig: $(CONF)
	echo "added by cyh, CONF = $(CONF)"
	echo "Kconfig = $(Kconfig)"
	# @/home/chenyinhua/sda3/ics2021/nemu/tools/kconfig/build/conf -s --savedefconfig=configs/defconfig /home/chenyinhua/sda3/ics2021/nemu/Kconfig 
	# Explain: --savedefconfig <file>  Save the minimal current configuration to <file>	
	$(Q)$< $(silent) --$@=configs/defconfig $(Kconfig)

%defconfig: $(CONF) $(FIXDEP)
	echo "added by cyh for debug: the config file we use this time is $@"
	echo "Kconfig = $(Kconfig)"
	# change Kconfig to the specific config_file
	$(Q)$< $(silent) --defconfig=configs/$@ $(Kconfig)
	# generates configuration for C project according to Kconfig
	$(Q)$< $(silent) --syncconfig $(Kconfig)

.PHONY: menuconfig savedefconfig defconfig

# Help text used by make help
help:
	@echo  '  menuconfig	  - Update current config utilising a menu based program'
	@echo  '  savedefconfig   - Save current config as configs/defconfig (minimal config)'

distclean: clean
	-@rm -rf $(rm-distclean)

.PHONY: help distclean

define call_fixdep
	@$(FIXDEP) $(1) $(2) unused > $(1).tmp
	@mv $(1).tmp $(1)
endef
