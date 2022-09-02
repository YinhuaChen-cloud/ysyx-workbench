all:
	@echo "Write this Makefile by your self."

CSRC_DIR = $(shell pwd)/csrc
VSRC_DIR = $(shell pwd)/vsrc

CSRC = $(shell find csrc/ -name "*.c" -or -name "*.cpp")
VSRC = $(shell find vsrc/ -name "*.v")

OBJS = $(addsuffix .o, $(basename $(CSRC)))

sim:
	# @echo "debug by cyh CSRC = $(CSRC)"
	# @echo "debug by cyh OBJS = $(OBJS)"
	# echo "debug by cyh VSRC = $(VSRC)"
	verilator -Wall --cc --exe --build --trace $(NPC_HOME)/csrc/main.cpp $(NPC_HOME)/vsrc/top.v
	./obj_dir/Vtop
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	@echo "Write this Makefile by your self."

clean:
	rm -rf ./logs ./obj_dir

.PHONY: clean

include ../Makefile
