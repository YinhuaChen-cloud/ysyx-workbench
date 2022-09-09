// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop.h for the primary calling header

#include "Vtop___024root.h"
#include "Vtop__Syms.h"

//==========

VL_INLINE_OPT void Vtop___024root___combo__TOP__1(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___combo__TOP__1\n"); );
    // Body
    vlSelf->top__DOT__choose_by_F0_1 = ((2U & (IData)(vlSelf->top__DOT__choose_by_F0_1)) 
                                        | (1U & (((~ (IData)(vlSelf->F)) 
                                                  & (IData)(vlSelf->X0)) 
                                                 | ((IData)(vlSelf->F) 
                                                    & (IData)(vlSelf->X1)))));
    vlSelf->top__DOT__choose_by_F0_1 = ((1U & (IData)(vlSelf->top__DOT__choose_by_F0_1)) 
                                        | (2U & (((
                                                   (~ (IData)(vlSelf->F)) 
                                                   << 1U) 
                                                  & (IData)(vlSelf->X0)) 
                                                 | (((IData)(vlSelf->F) 
                                                     << 1U) 
                                                    & (IData)(vlSelf->X1)))));
    vlSelf->top__DOT__choose_by_F0_2 = ((2U & (IData)(vlSelf->top__DOT__choose_by_F0_2)) 
                                        | (1U & (((~ (IData)(vlSelf->F)) 
                                                  & (IData)(vlSelf->X2)) 
                                                 | ((IData)(vlSelf->F) 
                                                    & (IData)(vlSelf->X3)))));
    vlSelf->top__DOT__choose_by_F0_2 = ((1U & (IData)(vlSelf->top__DOT__choose_by_F0_2)) 
                                        | (2U & (((
                                                   (~ (IData)(vlSelf->F)) 
                                                   << 1U) 
                                                  & (IData)(vlSelf->X2)) 
                                                 | (((IData)(vlSelf->F) 
                                                     << 1U) 
                                                    & (IData)(vlSelf->X3)))));
    vlSelf->Y = ((2U & (IData)(vlSelf->Y)) | (1U & 
                                              (((~ 
                                                 ((IData)(vlSelf->F) 
                                                  >> 1U)) 
                                                & (IData)(vlSelf->top__DOT__choose_by_F0_1)) 
                                               | (((IData)(vlSelf->F) 
                                                   >> 1U) 
                                                  & (IData)(vlSelf->top__DOT__choose_by_F0_2)))));
    vlSelf->Y = ((1U & (IData)(vlSelf->Y)) | (2U & 
                                              ((((~ 
                                                  ((IData)(vlSelf->F) 
                                                   >> 1U)) 
                                                 << 1U) 
                                                & (IData)(vlSelf->top__DOT__choose_by_F0_1)) 
                                               | ((IData)(vlSelf->F) 
                                                  & (IData)(vlSelf->top__DOT__choose_by_F0_2)))));
}

void Vtop___024root___eval(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval\n"); );
    // Body
    Vtop___024root___combo__TOP__1(vlSelf);
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
    if (VL_UNLIKELY((vlSelf->F & 0xfcU))) {
        Verilated::overWidthError("F");}
    if (VL_UNLIKELY((vlSelf->X0 & 0xfcU))) {
        Verilated::overWidthError("X0");}
    if (VL_UNLIKELY((vlSelf->X1 & 0xfcU))) {
        Verilated::overWidthError("X1");}
    if (VL_UNLIKELY((vlSelf->X2 & 0xfcU))) {
        Verilated::overWidthError("X2");}
    if (VL_UNLIKELY((vlSelf->X3 & 0xfcU))) {
        Verilated::overWidthError("X3");}
}
#endif  // VL_DEBUG
