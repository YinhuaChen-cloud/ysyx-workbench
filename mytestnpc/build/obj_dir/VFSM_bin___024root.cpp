// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VFSM_bin.h for the primary calling header

#include "VFSM_bin___024root.h"
#include "VFSM_bin__Syms.h"

//==========

void VFSM_bin___024root___eval(VFSM_bin___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VFSM_bin__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VFSM_bin___024root___eval\n"); );
    // Final
    vlSelf->__Vclklast__TOP__clk = vlSelf->clk;
}

QData VFSM_bin___024root___change_request_1(VFSM_bin___024root* vlSelf);

VL_INLINE_OPT QData VFSM_bin___024root___change_request(VFSM_bin___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VFSM_bin__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VFSM_bin___024root___change_request\n"); );
    // Body
    return (VFSM_bin___024root___change_request_1(vlSelf));
}

VL_INLINE_OPT QData VFSM_bin___024root___change_request_1(VFSM_bin___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VFSM_bin__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VFSM_bin___024root___change_request_1\n"); );
    // Body
    // Change detection
    QData __req = false;  // Logically a bool
    return __req;
}

#ifdef VL_DEBUG
void VFSM_bin___024root___eval_debug_assertions(VFSM_bin___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VFSM_bin__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VFSM_bin___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->clk & 0xfeU))) {
        Verilated::overWidthError("clk");}
    if (VL_UNLIKELY((vlSelf->in & 0xfeU))) {
        Verilated::overWidthError("in");}
    if (VL_UNLIKELY((vlSelf->reset & 0xfeU))) {
        Verilated::overWidthError("reset");}
}
#endif  // VL_DEBUG
