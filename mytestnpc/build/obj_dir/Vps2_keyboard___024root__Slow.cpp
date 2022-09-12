// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vps2_keyboard.h for the primary calling header

#include "Vps2_keyboard___024root.h"
#include "Vps2_keyboard__Syms.h"

//==========


void Vps2_keyboard___024root___ctor_var_reset(Vps2_keyboard___024root* vlSelf);

Vps2_keyboard___024root::Vps2_keyboard___024root(const char* _vcname__)
    : VerilatedModule(_vcname__)
 {
    // Reset structure values
    Vps2_keyboard___024root___ctor_var_reset(this);
}

void Vps2_keyboard___024root::__Vconfigure(Vps2_keyboard__Syms* _vlSymsp, bool first) {
    if (false && first) {}  // Prevent unused
    this->vlSymsp = _vlSymsp;
}

Vps2_keyboard___024root::~Vps2_keyboard___024root() {
}

void Vps2_keyboard___024root___settle__TOP__1(Vps2_keyboard___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vps2_keyboard__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vps2_keyboard___024root___settle__TOP__1\n"); );
    // Body
    vlSelf->ps2_keyboard__DOT__segs[0U] = 0xfcU;
    vlSelf->ps2_keyboard__DOT__segs[1U] = 0x60U;
    vlSelf->ps2_keyboard__DOT__segs[2U] = 0xdaU;
    vlSelf->ps2_keyboard__DOT__segs[3U] = 0xf2U;
    vlSelf->ps2_keyboard__DOT__segs[4U] = 0x66U;
    vlSelf->ps2_keyboard__DOT__segs[5U] = 0xb6U;
    vlSelf->ps2_keyboard__DOT__segs[6U] = 0xbeU;
    vlSelf->ps2_keyboard__DOT__segs[7U] = 0xe0U;
    vlSelf->ps2_keyboard__DOT__segs[8U] = 0xfeU;
    vlSelf->ps2_keyboard__DOT__segs[9U] = 0xf6U;
    vlSelf->ps2_keyboard__DOT__segs[0xaU] = 0xeeU;
    vlSelf->ps2_keyboard__DOT__segs[0xbU] = 0xffU;
    vlSelf->ps2_keyboard__DOT__segs[0xcU] = 0x9cU;
    vlSelf->ps2_keyboard__DOT__segs[0xdU] = 0xfdU;
    vlSelf->ps2_keyboard__DOT__segs[0xeU] = 0x9eU;
    vlSelf->ps2_keyboard__DOT__segs[0xfU] = 0x8eU;
    vlSelf->seg6 = (0xffU & (~ vlSelf->ps2_keyboard__DOT__segs
                             [(0xfU & (IData)(vlSelf->ps2_keyboard__DOT__timescounter))]));
    vlSelf->seg7 = (0xffU & (~ vlSelf->ps2_keyboard__DOT__segs
                             [(0xfU & ((IData)(vlSelf->ps2_keyboard__DOT__timescounter) 
                                       >> 4U))]));
    if (vlSelf->ready) {
        vlSelf->seg0 = (0xffU & (~ vlSelf->ps2_keyboard__DOT__segs
                                 [(0xfU & (IData)(vlSelf->ps2_keyboard__DOT__data))]));
        vlSelf->seg1 = (0xffU & (~ vlSelf->ps2_keyboard__DOT__segs
                                 [(0xfU & ((IData)(vlSelf->ps2_keyboard__DOT__data) 
                                           >> 4U))]));
    } else {
        vlSelf->seg0 = 0xffU;
        vlSelf->seg1 = 0xffU;
    }
}

void Vps2_keyboard___024root___eval_initial(Vps2_keyboard___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vps2_keyboard__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vps2_keyboard___024root___eval_initial\n"); );
    // Body
    vlSelf->__Vclklast__TOP__clk = vlSelf->clk;
}

void Vps2_keyboard___024root___eval_settle(Vps2_keyboard___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vps2_keyboard__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vps2_keyboard___024root___eval_settle\n"); );
    // Body
    Vps2_keyboard___024root___settle__TOP__1(vlSelf);
}

void Vps2_keyboard___024root___final(Vps2_keyboard___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vps2_keyboard__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vps2_keyboard___024root___final\n"); );
}

void Vps2_keyboard___024root___ctor_var_reset(Vps2_keyboard___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vps2_keyboard__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vps2_keyboard___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->clk = 0;
    vlSelf->rst = 0;
    vlSelf->ps2_clk = 0;
    vlSelf->ps2_data = 0;
    vlSelf->ready = 0;
    vlSelf->seg0 = 0;
    vlSelf->seg1 = 0;
    vlSelf->seg6 = 0;
    vlSelf->seg7 = 0;
    vlSelf->ps2_keyboard__DOT__data = 0;
    vlSelf->ps2_keyboard__DOT__buffer = 0;
    vlSelf->ps2_keyboard__DOT__count = 0;
    vlSelf->ps2_keyboard__DOT__ps2_clk_sync = 0;
    vlSelf->ps2_keyboard__DOT__timescounter = 0;
    for (int __Vi0=0; __Vi0<16; ++__Vi0) {
        vlSelf->ps2_keyboard__DOT__segs[__Vi0] = 0;
    }
    vlSelf->ps2_keyboard__DOT____Vlvbound1 = 0;
}
