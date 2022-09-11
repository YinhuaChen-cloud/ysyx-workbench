// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop.h for the primary calling header

#include "Vtop___024root.h"
#include "Vtop__Syms.h"

//==========

VL_INLINE_OPT void Vtop___024root___sequent__TOP__2(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___sequent__TOP__2\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->we)))) {
        vlSelf->top__DOT__dout1 = vlSelf->top__DOT__ram
            [vlSelf->outaddr];
    }
    vlSelf->seg3 = (0xffU & (~ vlSelf->top__DOT__segs
                             [(0xfU & (IData)(vlSelf->top__DOT__dout1))]));
    vlSelf->seg4 = (0xffU & (~ vlSelf->top__DOT__segs
                             [(0xfU & ((IData)(vlSelf->top__DOT__dout1) 
                                       >> 4U))]));
}

VL_INLINE_OPT void Vtop___024root___sequent__TOP__3(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___sequent__TOP__3\n"); );
    // Variables
    CData/*2:0*/ __Vdlyvdim0__top__DOT__ram__v0;
    CData/*7:0*/ __Vdlyvval__top__DOT__ram__v0;
    CData/*0:0*/ __Vdlyvset__top__DOT__ram__v0;
    // Body
    __Vdlyvset__top__DOT__ram__v0 = 0U;
    if ((1U & (~ (IData)(vlSelf->we)))) {
        vlSelf->top__DOT__dout0 = vlSelf->top__DOT__ram
            [vlSelf->outaddr];
    }
    if (vlSelf->we) {
        __Vdlyvval__top__DOT__ram__v0 = vlSelf->din;
        __Vdlyvset__top__DOT__ram__v0 = 1U;
        __Vdlyvdim0__top__DOT__ram__v0 = vlSelf->inaddr;
    }
    if (__Vdlyvset__top__DOT__ram__v0) {
        vlSelf->top__DOT__ram[__Vdlyvdim0__top__DOT__ram__v0] 
            = __Vdlyvval__top__DOT__ram__v0;
    }
    vlSelf->seg0 = (0xffU & (~ vlSelf->top__DOT__segs
                             [(0xfU & (IData)(vlSelf->top__DOT__dout0))]));
    vlSelf->seg1 = (0xffU & (~ vlSelf->top__DOT__segs
                             [(0xfU & ((IData)(vlSelf->top__DOT__dout0) 
                                       >> 4U))]));
}

VL_INLINE_OPT void Vtop___024root___combo__TOP__5(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___combo__TOP__5\n"); );
    // Variables
    CData/*7:0*/ top__DOT__dout2;
    // Body
    top__DOT__dout2 = vlSelf->top__DOT__ram[vlSelf->outaddr];
    vlSelf->seg6 = (0xffU & (~ vlSelf->top__DOT__segs
                             [(0xfU & (IData)(top__DOT__dout2))]));
    vlSelf->seg7 = (0xffU & (~ vlSelf->top__DOT__segs
                             [(0xfU & ((IData)(top__DOT__dout2) 
                                       >> 4U))]));
}

void Vtop___024root___eval(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval\n"); );
    // Body
    if (((~ (IData)(vlSelf->clk)) & (IData)(vlSelf->__Vclklast__TOP__clk))) {
        Vtop___024root___sequent__TOP__2(vlSelf);
    }
    if (((IData)(vlSelf->clk) & (~ (IData)(vlSelf->__Vclklast__TOP__clk)))) {
        Vtop___024root___sequent__TOP__3(vlSelf);
    }
    Vtop___024root___combo__TOP__5(vlSelf);
    // Final
    vlSelf->__Vclklast__TOP__clk = vlSelf->clk;
}

QData Vtop___024root___change_request_1(Vtop___024root* vlSelf);

VL_INLINE_OPT QData Vtop___024root___change_request(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___change_request\n"); );
    // Body
    return (Vtop___024root___change_request_1(vlSelf));
}

VL_INLINE_OPT QData Vtop___024root___change_request_1(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___change_request_1\n"); );
    // Body
    // Change detection
    QData __req = false;  // Logically a bool
    return __req;
}

#ifdef VL_DEBUG
void Vtop___024root___eval_debug_assertions(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->clk & 0xfeU))) {
        Verilated::overWidthError("clk");}
    if (VL_UNLIKELY((vlSelf->we & 0xfeU))) {
        Verilated::overWidthError("we");}
    if (VL_UNLIKELY((vlSelf->inaddr & 0xf8U))) {
        Verilated::overWidthError("inaddr");}
    if (VL_UNLIKELY((vlSelf->outaddr & 0xf8U))) {
        Verilated::overWidthError("outaddr");}
}
#endif  // VL_DEBUG
