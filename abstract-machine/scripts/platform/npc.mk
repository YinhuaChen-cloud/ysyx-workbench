
NPCFLAGS += -l $(shell dirname $(IMAGE).elf)/npc-log.txt

ifeq ($(MYDIFF), TRUE)
	NPCFLAGS += --diff=${NEMU_HOME}/build/riscv64-nemu-interpreter-so
endif

NPCFLAGS += -l $(shell dirname $(IMAGE).elf)/npc-log.txt

run: image
	@echo "In abm/script/platform/npc.mk"
	@echo "IMAGE = $(IMAGE)" 	
	$(MAKE) -C $(NPC_HOME) sim ARGS="$(NPCFLAGS)" IMG=$(IMAGE).bin MODE=$(MODE) WALL=$(WALL)

gdb: image
	$(MAKE) -C $(NPC_HOME) gdb ARGS="$(NPCFLAGS)" IMG=$(IMAGE).bin MODE=$(MODE) WALL=$(WALL)
	
