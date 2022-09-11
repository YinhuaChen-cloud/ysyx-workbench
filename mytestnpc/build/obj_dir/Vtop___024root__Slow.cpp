// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop.h for the primary calling header

#include "Vtop___024root.h"
#include "Vtop__Syms.h"

//==========


void Vtop___024root___ctor_var_reset(Vtop___024root* vlSelf);

Vtop___024root::Vtop___024root(const char* _vcname__)
    : VerilatedModule(_vcname__)
 {
    // Reset structure values
    Vtop___024root___ctor_var_reset(this);
}

void Vtop___024root::__Vconfigure(Vtop__Syms* _vlSymsp, bool first) {
    if (false && first) {}  // Prevent unused
    this->vlSymsp = _vlSymsp;
}

Vtop___024root::~Vtop___024root() {
}

void Vtop___024root___settle__TOP__1(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___settle__TOP__1\n"); );
    // Body
    vlSelf->top__DOT__segs[0U] = 0xfcU;
    vlSelf->top__DOT__segs[1U] = 0x60U;
    vlSelf->top__DOT__segs[2U] = 0xdaU;
    vlSelf->top__DOT__segs[3U] = 0xf2U;
    vlSelf->top__DOT__segs[4U] = 0x66U;
    vlSelf->top__DOT__segs[5U] = 0xb6U;
    vlSelf->top__DOT__segs[6U] = 0xbeU;
    vlSelf->top__DOT__segs[7U] = 0xe0U;
    vlSelf->top__DOT__segs[8U] = 0xfeU;
    vlSelf->top__DOT__segs[9U] = 0xf6U;
    vlSelf->top__DOT__segs[0xaU] = 0xeeU;
    vlSelf->top__DOT__segs[0xbU] = 0xffU;
    vlSelf->top__DOT__segs[0xcU] = 0x9cU;
    vlSelf->top__DOT__segs[0xdU] = 0xfdU;
    vlSelf->top__DOT__segs[0xeU] = 0x9eU;
    vlSelf->top__DOT__segs[0xfU] = 0x8eU;
    vlSelf->seg0 = (0xffU & (~ vlSelf->top__DOT__segs
                             [(0xfU & (IData)(vlSelf->top__DOT__dout0))]));
    vlSelf->seg1 = (0xffU & (~ vlSelf->top__DOT__segs
                             [(0xfU & ((IData)(vlSelf->top__DOT__dout0) 
                                       >> 4U))]));
    vlSelf->seg3 = (0xffU & (~ vlSelf->top__DOT__segs
                             [(0xfU & (IData)(vlSelf->top__DOT__dout1))]));
    vlSelf->seg4 = (0xffU & (~ vlSelf->top__DOT__segs
                             [(0xfU & ((IData)(vlSelf->top__DOT__dout1) 
                                       >> 4U))]));
}

void Vtop___024root___initial__TOP__4(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___initial__TOP__4\n"); );
    // Body
    vlSelf->top__DOT__ram[7U] = 0xf0U;
    vlSelf->top__DOT__ram[6U] = 0x23U;
    vlSelf->top__DOT__ram[5U] = 0x20U;
    vlSelf->top__DOT__ram[4U] = 0x50U;
    vlSelf->top__DOT__ram[3U] = 3U;
    vlSelf->top__DOT__ram[2U] = 0x21U;
    vlSelf->top__DOT__ram[1U] = 0x82U;
    vlSelf->top__DOT__ram[0U] = 0xdU;
}

void Vtop___024root___eval_initial(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_initial\n"); );
    // Body
    vlSelf->__Vclklast__TOP__clk = vlSelf->clk;
    Vtop___024root___initial__TOP__4(vlSelf);
}

void Vtop___024root___combo__TOP__5(Vtop___024root* vlSelf);

void Vtop___024root___eval_settle(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_settle\n"); );
    // Body
    Vtop___024root___settle__TOP__1(vlSelf);
    Vtop___024root___combo__TOP__5(vlSelf);
}

void Vtop___024root___final(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___final\n"); );
}

void Vtop___024root___ctor_var_reset(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->clk = 0;
    vlSelf->we = 0;
    vlSelf->inaddr = 0;
    vlSelf->outaddr = 0;
    vlSelf->din = 0;
    vlSelf->seg0 = 0;
    vlSelf->seg1 = 0;
    vlSelf->seg3 = 0;
    vlSelf->seg4 = 0;
    vlSelf->seg6 = 0;
    vlSelf->seg7 = 0;
    vlSelf->top__DOT__dout0 = 0;
    vlSelf->top__DOT__dout1 = 0;
    for (int __Vi0=0; __Vi0<8; ++__Vi0) {
        vlSelf->top__DOT__ram[__Vi0] = 0;
    }
    for (int __Vi0=0; __Vi0<16; ++__Vi0) {
        vlSelf->top__DOT__segs[__Vi0] = 0;
    }
}
