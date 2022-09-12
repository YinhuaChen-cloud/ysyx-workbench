#include <nvboard.h>
#include "VFSM_bin.h"

void nvboard_bind_all_pins(VFSM_bin* top) {
	nvboard_bind_pin( &top->clk, BIND_RATE_SCR, BIND_DIR_IN , 1, BTNC);
	nvboard_bind_pin( &top->in, BIND_RATE_SCR, BIND_DIR_IN , 1, SW1);
	nvboard_bind_pin( &top->reset, BIND_RATE_SCR, BIND_DIR_IN , 1, SW0);
	nvboard_bind_pin( &top->out, BIND_RATE_SCR, BIND_DIR_OUT, 1, LD0);
	nvboard_bind_pin( &top->state_dout, BIND_RATE_SCR, BIND_DIR_OUT, 4, LD7, LD6, LD5, LD4);
}
