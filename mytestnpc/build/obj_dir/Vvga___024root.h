// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vvga.h for the primary calling header

#ifndef VERILATED_VVGA___024ROOT_H_
#define VERILATED_VVGA___024ROOT_H_  // guard

#include "verilated_heavy.h"

//==========

class Vvga__Syms;

//----------

VL_MODULE(Vvga___024root) {
  public:

    // PORTS
    VL_IN8(clk,0,0);
    VL_IN8(rst,0,0);
    VL_OUT8(VGA_VSYNC,0,0);
    VL_OUT8(VGA_HSYNC,0,0);
    VL_OUT8(VGA_BLANK_N,0,0);
    VL_OUT8(VGA_R,7,0);
    VL_OUT8(VGA_G,7,0);
    VL_OUT8(VGA_B,7,0);

    // LOCAL SIGNALS
    CData/*0:0*/ vga__DOT__my_vga_ctrl__DOT__v_valid;
    SData/*9:0*/ vga__DOT__v_addr;
    SData/*9:0*/ vga__DOT__my_vga_ctrl__DOT__x_cnt;
    SData/*9:0*/ vga__DOT__my_vga_ctrl__DOT__y_cnt;
    VlUnpacked<IData/*23:0*/, 307201> vga__DOT__vmem;

    // LOCAL VARIABLES
    CData/*0:0*/ __Vclklast__TOP__clk;
    CData/*0:0*/ __Vclklast__TOP__rst;
    SData/*9:0*/ __Vdly__vga__DOT__my_vga_ctrl__DOT__x_cnt;

    // INTERNAL VARIABLES
    Vvga__Syms* vlSymsp;  // Symbol table

    // CONSTRUCTORS
  private:
    VL_UNCOPYABLE(Vvga___024root);  ///< Copying not allowed
  public:
    Vvga___024root(const char* name);
    ~Vvga___024root();

    // INTERNAL METHODS
    void __Vconfigure(Vvga__Syms* symsp, bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

//----------


#endif  // guard
