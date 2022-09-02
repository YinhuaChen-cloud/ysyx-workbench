all:
	@echo "Write this Makefile by your self."

CSRC_DIR = $(shell pwd)/csrc
VSRC_DIR = $(shell pwd)/vsrc

CSRC = $(shell find csrc/ -name "*.c" -or -name "*.cpp")
VSRC = $(shell find vsrc/ -name "*.v")

OBJS = $(addsuffix .o, $(basename $(CSRC)))

OBJS: %.o: %.c

sim:
	@echo "debug by cyh CSRC = $(CSRC)"
	@echo "debug by cyh OBJS = $(OBJS)"
	# echo "debug by cyh VSRC = $(VSRC)"
	verilator -Wall --cc --exe --build --trace $(NPC_HOME)/csrc/main.cpp $(NPC_HOME)/vsrc/top.v
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	@echo "Write this Makefile by your self."

include ../Makefile
