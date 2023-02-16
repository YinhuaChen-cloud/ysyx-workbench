-include $(NPC_HOME)/include/config/auto.conf
-include $(NPC_HOME)/include/config/auto.conf.cmd

# ifeq ($(CONFIG_DIFFTEST), y)
	# NPCFLAGS += --diff=${NEMU_HOME}/build/riscv64-nemu-interpreter-so
# endif

NPCFLAGS += -l $(shell dirname $(IMAGE).elf)/npc-log.txt

NPCFLAGS += --mtrace=$(IMAGE)-mtrace.txt

run: image
	@echo "In abm/script/platform/npc.mk"
	@echo "IMAGE = $(IMAGE)" 	
	$(MAKE) -C $(NPC_HOME) sim ARGS="$(NPCFLAGS)" IMG=$(IMAGE).bin WALL=$(WALL)

gdb: image
	$(MAKE) -C $(NPC_HOME) gdb ARGS="$(NPCFLAGS)" IMG=$(IMAGE).bin WALL=$(WALL)
	
sdb: image
	@echo "In npc.mk, I am sdb=========="
	@echo "In npc.mk, NPCFLAGS = $(NPCFLAGS), IMAGE = $(IMAGE)"
	$(MAKE) -C $(NPC_HOME) sdb ARGS="$(NPCFLAGS)" IMG=$(IMAGE).bin WALL=$(WALL)
	
