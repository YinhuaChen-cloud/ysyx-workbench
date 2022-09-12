// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vps2_keyboard.h for the primary calling header

#include "Vps2_keyboard___024root.h"
#include "Vps2_keyboard__Syms.h"

//==========

VL_INLINE_OPT void Vps2_keyboard___024root___sequent__TOP__2(Vps2_keyboard___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vps2_keyboard__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vps2_keyboard___024root___sequent__TOP__2\n"); );
    // Variables
    CData/*2:0*/ __Vdly__ps2_keyboard__DOT__ps2_clk_sync;
    CData/*3:0*/ __Vdly__ps2_keyboard__DOT__count;
    SData/*15:0*/ __Vdly__ps2_keyboard__DOT__data;
    // Body
    __Vdly__ps2_keyboard__DOT__ps2_clk_sync = vlSelf->ps2_keyboard__DOT__ps2_clk_sync;
    __Vdly__ps2_keyboard__DOT__count = vlSelf->ps2_keyboard__DOT__count;
    __Vdly__ps2_keyboard__DOT__data = vlSelf->ps2_keyboard__DOT__data;
    __Vdly__ps2_keyboard__DOT__ps2_clk_sync = ((6U 
                                                & ((IData)(vlSelf->ps2_keyboard__DOT__ps2_clk_sync) 
                                                   << 1U)) 
                                               | (IData)(vlSelf->ps2_clk));
    if (vlSelf->rst) {
        __Vdly__ps2_keyboard__DOT__count = 0U;
        vlSelf->ready = 0U;
    } else {
        vlSelf->ready = 1U;
        if ((IData)((4U == (6U & (IData)(vlSelf->ps2_keyboard__DOT__ps2_clk_sync))))) {
            if ((0xaU == (IData)(vlSelf->ps2_keyboard__DOT__count))) {
                if (VL_UNLIKELY((((~ (IData)(vlSelf->ps2_keyboard__DOT__buffer)) 
                                  & (IData)(vlSelf->ps2_data)) 
                                 & VL_REDXOR_32((0x1ffU 
                                                 & ((IData)(vlSelf->ps2_keyboard__DOT__buffer) 
                                                    >> 1U)))))) {
                    __Vdly__ps2_keyboard__DOT__data 
                        = ((0xff00U & ((IData)(vlSelf->ps2_keyboard__DOT__data) 
                                       << 8U)) | (0xffU 
                                                  & ((IData)(vlSelf->ps2_keyboard__DOT__buffer) 
                                                     >> 1U)));
                    VL_WRITEF("receive %x\n",8,(0xffU 
                                                & ((IData)(vlSelf->ps2_keyboard__DOT__buffer) 
                                                   >> 1U)));
                    vlSelf->ready = ((0xf0U == (0xffU 
                                                & (IData)(vlSelf->ps2_keyboard__DOT__data)))
                                      ? 0U : 1U);
                }
                __Vdly__ps2_keyboard__DOT__count = 0U;
            } else {
                vlSelf->ps2_keyboard__DOT____Vlvbound1 
                    = vlSelf->ps2_data;
                if (VL_LIKELY((9U >= (IData)(vlSelf->ps2_keyboard__DOT__count)))) {
                    vlSelf->ps2_keyboard__DOT__buffer 
                        = (((~ ((IData)(1U) << (IData)(vlSelf->ps2_keyboard__DOT__count))) 
                            & (IData)(vlSelf->ps2_keyboard__DOT__buffer)) 
                           | (0x3ffU & ((IData)(vlSelf->ps2_keyboard__DOT____Vlvbound1) 
                                        << (IData)(vlSelf->ps2_keyboard__DOT__count))));
                }
                __Vdly__ps2_keyboard__DOT__count = 
                    (0xfU & ((IData)(1U) + (IData)(vlSelf->ps2_keyboard__DOT__count)));
            }
        }
    }
    vlSelf->ps2_keyboard__DOT__count = __Vdly__ps2_keyboard__DOT__count;
    vlSelf->ps2_keyboard__DOT__ps2_clk_sync = __Vdly__ps2_keyboard__DOT__ps2_clk_sync;
    vlSelf->ps2_keyboard__DOT__data = __Vdly__ps2_keyboard__DOT__data;
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

void Vps2_keyboard___024root___eval(Vps2_keyboard___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vps2_keyboard__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vps2_keyboard___024root___eval\n"); );
    // Body
    if (((IData)(vlSelf->clk) & (~ (IData)(vlSelf->__Vclklast__TOP__clk)))) {
        Vps2_keyboard___024root___sequent__TOP__2(vlSelf);
    }
    // Final
    vlSelf->__Vclklast__TOP__clk = vlSelf->clk;
}

QData Vps2_keyboard___024root___change_request_1(Vps2_keyboard___024root* vlSelf);

VL_INLINE_OPT QData Vps2_keyboard___024root___change_request(Vps2_keyboard___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vps2_keyboard__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vps2_keyboard___024root___change_request\n"); );
    // Body
    return (Vps2_keyboard___024root___change_request_1(vlSelf));
}

VL_INLINE_OPT QData Vps2_keyboard___024root___change_request_1(Vps2_keyboard___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vps2_keyboard__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vps2_keyboard___024root___change_request_1\n"); );
    // Body
    // Change detection
    QData __req = false;  // Logically a bool
    return __req;
}

#ifdef VL_DEBUG
void Vps2_keyboard___024root___eval_debug_assertions(Vps2_keyboard___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vps2_keyboard__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vps2_keyboard___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->clk & 0xfeU))) {
        Verilated::overWidthError("clk");}
    if (VL_UNLIKELY((vlSelf->rst & 0xfeU))) {
        Verilated::overWidthError("rst");}
    if (VL_UNLIKELY((vlSelf->ps2_clk & 0xfeU))) {
        Verilated::overWidthError("ps2_clk");}
    if (VL_UNLIKELY((vlSelf->ps2_data & 0xfeU))) {
        Verilated::overWidthError("ps2_data");}
}
#endif  // VL_DEBUG
