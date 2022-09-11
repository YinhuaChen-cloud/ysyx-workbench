#include <nvboard.h>
#include "Vtop.h"

void nvboard_bind_all_pins(Vtop* top) {
	nvboard_bind_pin( &top->clk, BIND_RATE_SCR, BIND_DIR_IN , 1, BTNC);
	nvboard_bind_pin( &top->we, BIND_RATE_SCR, BIND_DIR_IN , 1, SW14);
	nvboard_bind_pin( &top->inaddr, BIND_RATE_SCR, BIND_DIR_IN , 3, SW2, SW1, SW0);
	nvboard_bind_pin( &top->outaddr, BIND_RATE_SCR, BIND_DIR_IN , 3, SW5, SW4, SW3);
	nvboard_bind_pin( &top->din, BIND_RATE_SCR, BIND_DIR_IN , 8, SW6, SW7, SW8, SW9, SW10, SW11, SW12, SW13);
	nvboard_bind_pin( &top->seg0, BIND_RATE_SCR, BIND_DIR_OUT, 8, SEG0A, SEG0B, SEG0C, SEG0D, SEG0E, SEG0F, SEG0G, DEC0P);
	nvboard_bind_pin( &top->seg1, BIND_RATE_SCR, BIND_DIR_OUT, 8, SEG1A, SEG1B, SEG1C, SEG1D, SEG1E, SEG1F, SEG1G, DEC1P);
}
