#include <common.h>

static Context* do_event(Event e, Context* c) {
  switch (e.event) {
		case EVENT_YIELD: printf("event yield handled!\n"); c->mepc += 4; break;
		case EVENT_UNALIGN_MEM_ACCESS:
			printf("event unalign_mem_access handled start!\n"); 
			printf("c->mepc = 0x%lx\n", c->mepc);
			printf("event unalign_mem_access handled end!\n"); 
			c->mepc += 4; 
			break;
    default: panic("Unhandled event ID = %d", e.event);
  }

  return c;
}

void init_irq(void) {
  Log("Initializing interrupt/exception handler...");
  cte_init(do_event);
}
