.DEFAULT_GOAL = app

# Add necessary options if the target is a shared library
ifeq ($(SHARE),1)
SO = -so
CFLAGS  += -fPIC
LDFLAGS += -rdynamic -shared -fPIC
endif

WORK_DIR  = $(shell pwd)
BUILD_DIR = $(WORK_DIR)/build

INC_PATH := $(WORK_DIR)/include $(INC_PATH)
INC_PATH += /home/chenyinhua/sda3/ics2021/nemu/src/monitor/sdb
OBJ_DIR  = $(BUILD_DIR)/obj-$(NAME)$(SO)
BINARY   = $(BUILD_DIR)/$(NAME)$(SO)

# Compilation flags
ifeq ($(CC),clang)
CXX := clang++
else
CXX := g++
endif
LD := $(CXX)
INCLUDES = $(addprefix -I, $(INC_PATH))
CFLAGS  := -ggdb3 -O2 -MMD -Wall -Werror $(INCLUDES) $(CFLAGS)
LDFLAGS := -O2 $(LDFLAGS)

# added by chenyinhua
CXXSRC += src/monitor/sdb/intStackforC.cc
# added by chenyinhua ends

OBJS = $(SRCS:%.c=$(OBJ_DIR)/%.o) $(CXXSRC:%.cc=$(OBJ_DIR)/%.o)

# Compilation patterns 	
$(OBJ_DIR)/%.o: %.c
	@echo "INC_PATH = $(INC_PATH)"
	@echo + CC $<
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) -c -o $@ $<
	$(call call_fixdep, $(@:.o=.d), $@)

$(OBJ_DIR)/%.o: %.cc
	@echo + CXX $<
	@echo "added by chenyinhua start"
	@echo "OBJS = $(OBJS)"
	@echo "OBJ_DIR = $(OBJ_DIR)"
	@echo "$$@ = $@"
	@echo "CXXSRC = $(CXXSRC)"
	@echo "added by chenyinhua ends"
	@mkdir -p $(dir $@)
	@$(CXX) $(CFLAGS) $(CXXFLAGS) -c -o $@ $<
	$(call call_fixdep, $(@:.o=.d), $@)

# Depencies
-include $(OBJS:.o=.d)

# Some convenient rules

.PHONY: app clean

app: $(BINARY)

$(BINARY): $(OBJS) $(ARCHIVES)
	@echo + LD $@
	@echo "added by chenyinhua start"
	@echo "OBJS = $(OBJS)"
	@echo "added by chenyinhua ends"
	@$(LD) -o $@ $(OBJS) $(LDFLAGS) $(ARCHIVES) $(LIBS)

clean:
	-rm -rf $(BUILD_DIR)
