// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See VFSM_bin.h for the primary calling header

#ifndef VERILATED_VFSM_BIN___024ROOT_H_
#define VERILATED_VFSM_BIN___024ROOT_H_  // guard

#include "verilated_heavy.h"

//==========

class VFSM_bin__Syms;

//----------

VL_MODULE(VFSM_bin___024root) {
  public:

    // PORTS
    VL_IN8(clk,0,0);
    VL_IN8(in,0,0);
    VL_IN8(reset,0,0);
    VL_OUT8(out,0,0);
    VL_OUT8(state_dout,3,0);

    // LOCAL SIGNALS
    VlUnpacked<CData/*4:0*/, 9> FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list;
    VlUnpacked<CData/*3:0*/, 9> FSM_bin__DOT__outMux__DOT__i0__DOT__key_list;
    VlUnpacked<CData/*0:0*/, 9> FSM_bin__DOT__outMux__DOT__i0__DOT__data_list;

    // LOCAL VARIABLES
    CData/*0:0*/ __Vclklast__TOP__clk;

    // INTERNAL VARIABLES
    VFSM_bin__Syms* vlSymsp;  // Symbol table

    // CONSTRUCTORS
  private:
    VL_UNCOPYABLE(VFSM_bin___024root);  ///< Copying not allowed
  public:
    VFSM_bin___024root(const char* name);
    ~VFSM_bin___024root();

    // INTERNAL METHODS
    void __Vconfigure(VFSM_bin__Syms* symsp, bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

//----------


#endif  // guard
