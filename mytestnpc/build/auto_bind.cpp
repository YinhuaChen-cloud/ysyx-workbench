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
	nvboard_bind_pin( &top->seg3, BIND_RATE_SCR, BIND_DIR_OUT, 8, SEG3A, SEG3B, SEG3C, SEG3D, SEG3E, SEG3F, SEG3G, DEC3P);
	nvboard_bind_pin( &top->seg4, BIND_RATE_SCR, BIND_DIR_OUT, 8, SEG4A, SEG4B, SEG4C, SEG4D, SEG4E, SEG4F, SEG4G, DEC4P);
	nvboard_bind_pin( &top->seg6, BIND_RATE_SCR, BIND_DIR_OUT, 8, SEG6A, SEG6B, SEG6C, SEG6D, SEG6E, SEG6F, SEG6G, DEC6P);
	nvboard_bind_pin( &top->seg7, BIND_RATE_SCR, BIND_DIR_OUT, 8, SEG7A, SEG7B, SEG7C, SEG7D, SEG7E, SEG7F, SEG7G, DEC7P);
}
