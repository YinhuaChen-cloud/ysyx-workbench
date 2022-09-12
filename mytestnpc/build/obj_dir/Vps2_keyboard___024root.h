// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vps2_keyboard.h for the primary calling header

#ifndef VERILATED_VPS2_KEYBOARD___024ROOT_H_
#define VERILATED_VPS2_KEYBOARD___024ROOT_H_  // guard

#include "verilated_heavy.h"

//==========

class Vps2_keyboard__Syms;

//----------

VL_MODULE(Vps2_keyboard___024root) {
  public:

    // PORTS
    VL_IN8(clk,0,0);
    VL_IN8(rst,0,0);
    VL_IN8(ps2_clk,0,0);
    VL_IN8(ps2_data,0,0);
    VL_OUT8(ready,0,0);
    VL_OUT8(seg0,7,0);
    VL_OUT8(seg1,7,0);
    VL_OUT8(seg6,7,0);
    VL_OUT8(seg7,7,0);

    // LOCAL SIGNALS
    CData/*3:0*/ ps2_keyboard__DOT__count;
    CData/*2:0*/ ps2_keyboard__DOT__ps2_clk_sync;
    CData/*7:0*/ ps2_keyboard__DOT__timescounter;
    SData/*15:0*/ ps2_keyboard__DOT__data;
    SData/*9:0*/ ps2_keyboard__DOT__buffer;
    VlUnpacked<CData/*7:0*/, 16> ps2_keyboard__DOT__segs;

    // LOCAL VARIABLES
    CData/*0:0*/ ps2_keyboard__DOT____Vlvbound1;
    CData/*0:0*/ __Vclklast__TOP__clk;

    // INTERNAL VARIABLES
    Vps2_keyboard__Syms* vlSymsp;  // Symbol table

    // CONSTRUCTORS
  private:
    VL_UNCOPYABLE(Vps2_keyboard___024root);  ///< Copying not allowed
  public:
    Vps2_keyboard___024root(const char* name);
    ~Vps2_keyboard___024root();

    // INTERNAL METHODS
    void __Vconfigure(Vps2_keyboard__Syms* symsp, bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

//----------


#endif  // guard
