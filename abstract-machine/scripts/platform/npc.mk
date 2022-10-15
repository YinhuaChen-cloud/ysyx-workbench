
NPCFLAGS += -l $(shell dirname $(IMAGE).elf)/npc-log.txt

run: image
	@echo "In abm/script/platform/npc.mk"
	@echo "IMAGE = $(IMAGE)" 	
	$(MAKE) -C $(NPC_HOME) sim ARGS="$(NPCFLAGS)" IMG=$(IMAGE).bin

# gdb: image
	# $(MAKE) -C $(NPC_HOME) ISA=$(ISA) gdb ARGS="$(NPCFLAGS)" IMG=$(IMAGE).bin
	
