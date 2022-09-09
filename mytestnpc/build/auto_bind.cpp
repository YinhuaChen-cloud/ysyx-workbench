#include <nvboard.h>
#include "Vtop.h"

void nvboard_bind_all_pins(Vtop* top) {
	nvboard_bind_pin( &top->result, BIND_RATE_SCR, BIND_DIR_OUT, 4, LD3, LD2, LD1, LD0);
	nvboard_bind_pin( &top->A, BIND_RATE_SCR, BIND_DIR_IN , 4, SW3, SW2, SW1, SW0);
	nvboard_bind_pin( &top->B, BIND_RATE_SCR, BIND_DIR_IN , 4, SW7, SW6, SW5, SW4);
	nvboard_bind_pin( &top->func, BIND_RATE_SCR, BIND_DIR_IN , 3, SW11, SW10, SW9);
}
