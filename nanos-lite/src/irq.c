#include <common.h>

static Context* do_event(Event e, Context* c) {
  switch (e.event) {
		case EVENT_YIELD: printf("event yield handled!\n"); break;
		case EVENT_UNALIGN_MEM_ACCESS: putstr("event unalign_mem_access handled!\n"); break;
    default: panic("Unhandled event ID = %d", e.event);
  }

  return c;
}

void init_irq(void) {
  Log("Initializing interrupt/exception handler...");
  cte_init(do_event);
}
