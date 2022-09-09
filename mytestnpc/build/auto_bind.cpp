#include <nvboard.h>
#include "Vtop.h"

void nvboard_bind_all_pins(Vtop* top) {
	nvboard_bind_pin( &top->Y, BIND_RATE_SCR, BIND_DIR_OUT, 2, LD1, LD0);
	nvboard_bind_pin( &top->F, BIND_RATE_SCR, BIND_DIR_IN , 2, SW1, SW0);
	nvboard_bind_pin( &top->X0, BIND_RATE_SCR, BIND_DIR_IN , 2, SW3, SW2);
	nvboard_bind_pin( &top->X1, BIND_RATE_SCR, BIND_DIR_IN , 2, SW5, SW4);
	nvboard_bind_pin( &top->X2, BIND_RATE_SCR, BIND_DIR_IN , 2, SW7, SW6);
	nvboard_bind_pin( &top->X3, BIND_RATE_SCR, BIND_DIR_IN , 2, SW9, SW8);
}
