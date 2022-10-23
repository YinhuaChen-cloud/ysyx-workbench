
NPCFLAGS += -l $(shell dirname $(IMAGE).elf)/npc-log.txt

run: image
	@echo "In abm/script/platform/npc.mk"
	@echo "IMAGE = $(IMAGE)" 	
	$(MAKE) -C $(NPC_HOME) sim ARGS="$(NPCFLAGS)" IMG=$(IMAGE).bin MODE=$(MODE) WALL=$(WALL)

gdb: image
	$(MAKE) -C $(NPC_HOME) gdb ARGS="$(NPCFLAGS)" IMG=$(IMAGE).bin MODE=$(MODE) WALL=$(WALL)
	
