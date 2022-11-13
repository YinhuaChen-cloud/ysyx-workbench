#include <common.h>

#define BITMASK(bits) ((1ull << (bits)) - 1)
#define BITS(x, hi, lo) (((x) >> (lo)) & BITMASK((hi) - (lo) + 1)) // similar to x[hi:lo] in verilog

static Context* do_event(Event e, Context* c) {
  switch (e.event) {
		case EVENT_YIELD: printf("event yield handled!\n"); c->mepc += 4; break;
		case EVENT_UNALIGN_MEM_ACCESS:
			printf("event unalign_mem_access handled start!\n"); 
			printf("c->mepc = 0x%lx\n", c->mepc);
			uint32_t tmp_inst = *(uint32_t *)c->mepc;
			printf("tmp_inst = 0x%lx\n", tmp_inst);
			int rd  = BITS(tmp_inst, 11, 7);
			printf("rd = %d\n", rd);
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
