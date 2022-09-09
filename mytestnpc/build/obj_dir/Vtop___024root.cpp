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
    // Variables
    CData/*1:0*/ top__DOT__i0__DOT__i0__DOT__lut_out;
    // Body
    vlSelf->top__DOT__lut = ((0xff00U & (IData)(vlSelf->top__DOT__lut)) 
                             | (0x40U | (((IData)(vlSelf->X0) 
                                          << 4U) | (IData)(vlSelf->X0))));
    vlSelf->top__DOT__lut = ((0xffU & (IData)(vlSelf->top__DOT__lut)) 
                             | (0xc800U | (((IData)(vlSelf->X0) 
                                            << 0xcU) 
                                           | ((IData)(vlSelf->X0) 
                                              << 8U))));
    vlSelf->top__DOT__i0__DOT__i0__DOT__pair_list[0U] 
        = (0xfU & (IData)(vlSelf->top__DOT__lut));
    vlSelf->top__DOT__i0__DOT__i0__DOT__pair_list[1U] 
        = (0xfU & ((IData)(vlSelf->top__DOT__lut) >> 4U));
    vlSelf->top__DOT__i0__DOT__i0__DOT__pair_list[2U] 
        = (0xfU & ((IData)(vlSelf->top__DOT__lut) >> 8U));
    vlSelf->top__DOT__i0__DOT__i0__DOT__pair_list[3U] 
        = (0xfU & ((IData)(vlSelf->top__DOT__lut) >> 0xcU));
    vlSelf->top__DOT__i0__DOT__i0__DOT__data_list[0U] 
        = (3U & vlSelf->top__DOT__i0__DOT__i0__DOT__pair_list
           [0U]);
    vlSelf->top__DOT__i0__DOT__i0__DOT__key_list[0U] 
        = (3U & (vlSelf->top__DOT__i0__DOT__i0__DOT__pair_list
                 [0U] >> 2U));
    vlSelf->top__DOT__i0__DOT__i0__DOT__data_list[1U] 
        = (3U & vlSelf->top__DOT__i0__DOT__i0__DOT__pair_list
           [1U]);
    vlSelf->top__DOT__i0__DOT__i0__DOT__key_list[1U] 
        = (3U & (vlSelf->top__DOT__i0__DOT__i0__DOT__pair_list
                 [1U] >> 2U));
    vlSelf->top__DOT__i0__DOT__i0__DOT__data_list[2U] 
        = (3U & vlSelf->top__DOT__i0__DOT__i0__DOT__pair_list
           [2U]);
    vlSelf->top__DOT__i0__DOT__i0__DOT__key_list[2U] 
        = (3U & (vlSelf->top__DOT__i0__DOT__i0__DOT__pair_list
                 [2U] >> 2U));
    vlSelf->top__DOT__i0__DOT__i0__DOT__data_list[3U] 
        = (3U & vlSelf->top__DOT__i0__DOT__i0__DOT__pair_list
           [3U]);
    vlSelf->top__DOT__i0__DOT__i0__DOT__key_list[3U] 
        = (3U & (vlSelf->top__DOT__i0__DOT__i0__DOT__pair_list
                 [3U] >> 2U));
    top__DOT__i0__DOT__i0__DOT__lut_out = ((- (IData)(
                                                      ((IData)(vlSelf->F) 
                                                       == 
                                                       vlSelf->top__DOT__i0__DOT__i0__DOT__key_list
                                                       [0U]))) 
                                           & vlSelf->top__DOT__i0__DOT__i0__DOT__data_list
                                           [0U]);
    top__DOT__i0__DOT__i0__DOT__lut_out = ((IData)(top__DOT__i0__DOT__i0__DOT__lut_out) 
                                           | ((- (IData)(
                                                         ((IData)(vlSelf->F) 
                                                          == 
                                                          vlSelf->top__DOT__i0__DOT__i0__DOT__key_list
                                                          [1U]))) 
                                              & vlSelf->top__DOT__i0__DOT__i0__DOT__data_list
                                              [1U]));
    top__DOT__i0__DOT__i0__DOT__lut_out = ((IData)(top__DOT__i0__DOT__i0__DOT__lut_out) 
                                           | ((- (IData)(
                                                         ((IData)(vlSelf->F) 
                                                          == 
                                                          vlSelf->top__DOT__i0__DOT__i0__DOT__key_list
                                                          [2U]))) 
                                              & vlSelf->top__DOT__i0__DOT__i0__DOT__data_list
                                              [2U]));
    top__DOT__i0__DOT__i0__DOT__lut_out = ((IData)(top__DOT__i0__DOT__i0__DOT__lut_out) 
                                           | ((- (IData)(
                                                         ((IData)(vlSelf->F) 
                                                          == 
                                                          vlSelf->top__DOT__i0__DOT__i0__DOT__key_list
                                                          [3U]))) 
                                              & vlSelf->top__DOT__i0__DOT__i0__DOT__data_list
                                              [3U]));
    vlSelf->Y = top__DOT__i0__DOT__i0__DOT__lut_out;
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
