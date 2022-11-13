#include <common.h>

typedef uint64_t word_t;
typedef word_t vaddr_t;
#define SEXT(x, len) ({ struct { int64_t n : len; } __x = { .n = x }; (uint64_t)__x.n; })
#define BITMASK(bits) ((1ull << (bits)) - 1)
#define BITS(x, hi, lo) (((x) >> (lo)) & BITMASK((hi) - (lo) + 1)) // similar to x[hi:lo] in verilog
static word_t immI(uint32_t i) { return SEXT(BITS(i, 31, 20), 12); }

static Context* do_event(Event e, Context* c) {
  switch (e.event) {
		case EVENT_YIELD: printf("event yield handled!\n"); c->mepc += 4; break;
		case EVENT_UNALIGN_MEM_ACCESS:
			printf("event unalign_mem_access handled start!\n"); 
			printf("c->mepc = 0x%lx\n", c->mepc);
			uint32_t tmp_inst = *(uint32_t *)c->mepc;
//			printf("tmp_inst = 0x%lx\n", tmp_inst);
			int rd  = BITS(tmp_inst, 11, 7);
			int rs1 = BITS(tmp_inst, 19, 15);
			word_t immediate = immI(tmp_inst);
			int func3 = BITS(tmp_inst, 14,12);
			vaddr_t src = immediate + c->gpr[rs1];
//			printf("the mem I want to access is 0x%lx\n", src);
			switch(func3)	{
				case 3: // imm[11:0] rs1 011 rd 0000011 LD
					{
					}
				case 2: // imm[11:0] rs1 010 rd 0000011 LW
				case 6: // imm[11:0] rs1 110 rd 0000011 LWU
					{
						int offset = src & 0x7ull;
						src &= ~0x7ull;
						uint64_t twohalf[2];
						twohalf[0] = *(uint64_t *)src;		// little-endian, low pos high bit
						twohalf[1] = *(uint64_t *)(src + 8);		
						uint64_t result = 0;
						for(uint8_t *pos = (uint8_t *)twohalf + offset; pos < (uint8_t *)twohalf + offset + 8; pos++) {
							result |= *pos;		
							result <<= 8;
						}
						printf("result = %lx\n", result);
						c->gpr[rd] = result;
						break;
					}
				default:
					assert(0);
//			imm[11:0] rs1 000 rd 0000011 LB
//			imm[11:0] rs1 100 rd 0000011 LBU
//			other invalid situation
			}

//			imm[11:0] rs1 001 rd 0000011 LH
//			imm[11:0] rs1 101 rd 0000011 LHU
//			
//			

//			printf("rd = %d\n", rd);
//			printf("rs1 = %d\n", rs1);
//			printf("immediate = 0x%x\n", immediate);
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
