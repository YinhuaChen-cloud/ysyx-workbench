
NPCFLAGS += -l $(shell dirname $(IMAGE).elf)/npc-log.txt

ifeq ($(MYDIFF), TRUE)
	# NPCFLAGS += --diff=${NEMU_HOME}/build/riscv64-nemu-interpreter-so
	NPCFLAGS += --diff=/home/chenyinhua/sda3/ysyx-workbench/nemu/tools/spike-diff/build/riscv64-spike-so
endif

NPCFLAGS += -l $(shell dirname $(IMAGE).elf)/npc-log.txt

run: image
	@echo "In abm/script/platform/npc.mk"
	@echo "IMAGE = $(IMAGE)" 	
	$(MAKE) -C $(NPC_HOME) sim ARGS="$(NPCFLAGS)" IMG=$(IMAGE).bin MODE=$(MODE) WALL=$(WALL) \
		MYDIFF=$(MYDIFF)

gdb: image
	$(MAKE) -C $(NPC_HOME) gdb ARGS="$(NPCFLAGS)" IMG=$(IMAGE).bin MODE=$(MODE) WALL=$(WALL) \
		MYDIFF=$(MYDIFF)
	
