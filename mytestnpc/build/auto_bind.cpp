#include <nvboard.h>
#include "Vps2_keyboard.h"

void nvboard_bind_all_pins(Vps2_keyboard* top) {
	nvboard_bind_pin( &top->ready, BIND_RATE_SCR, BIND_DIR_OUT, 1, LD0);
	nvboard_bind_pin( &top->seg0, BIND_RATE_SCR, BIND_DIR_OUT, 8, SEG0A, SEG0B, SEG0C, SEG0D, SEG0E, SEG0F, SEG0G, DEC0P);
	nvboard_bind_pin( &top->seg1, BIND_RATE_SCR, BIND_DIR_OUT, 8, SEG1A, SEG1B, SEG1C, SEG1D, SEG1E, SEG1F, SEG1G, DEC1P);
	nvboard_bind_pin( &top->seg6, BIND_RATE_SCR, BIND_DIR_OUT, 8, SEG6A, SEG6B, SEG6C, SEG6D, SEG6E, SEG6F, SEG6G, DEC6P);
	nvboard_bind_pin( &top->seg7, BIND_RATE_SCR, BIND_DIR_OUT, 8, SEG7A, SEG7B, SEG7C, SEG7D, SEG7E, SEG7F, SEG7G, DEC7P);
	nvboard_bind_pin( &top->ps2_clk, BIND_RATE_RT , BIND_DIR_IN , 1, PS2_CLK);
	nvboard_bind_pin( &top->ps2_data, BIND_RATE_RT , BIND_DIR_IN , 1, PS2_DAT);
}
