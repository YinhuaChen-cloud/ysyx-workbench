// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vvga.h for the primary calling header

#include "Vvga___024root.h"
#include "Vvga__Syms.h"

//==========

VL_INLINE_OPT void Vvga___024root___sequent__TOP__2(Vvga___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vvga__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvga___024root___sequent__TOP__2\n"); );
    // Body
    vlSelf->__Vdly__vga__DOT__my_vga_ctrl__DOT__x_cnt 
        = vlSelf->vga__DOT__my_vga_ctrl__DOT__x_cnt;
    vlSelf->__Vdly__vga__DOT__my_vga_ctrl__DOT__x_cnt 
        = ((IData)(vlSelf->rst) ? 1U : ((0x320U == (IData)(vlSelf->vga__DOT__my_vga_ctrl__DOT__x_cnt))
                                         ? 1U : (0x3ffU 
                                                 & ((IData)(1U) 
                                                    + (IData)(vlSelf->vga__DOT__my_vga_ctrl__DOT__x_cnt)))));
}

VL_INLINE_OPT void Vvga___024root___sequent__TOP__3(Vvga___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vvga__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvga___024root___sequent__TOP__3\n"); );
    // Variables
    SData/*9:0*/ __Vdly__vga__DOT__my_vga_ctrl__DOT__y_cnt;
    // Body
    __Vdly__vga__DOT__my_vga_ctrl__DOT__y_cnt = vlSelf->vga__DOT__my_vga_ctrl__DOT__y_cnt;
    if (vlSelf->rst) {
        __Vdly__vga__DOT__my_vga_ctrl__DOT__y_cnt = 1U;
    } else if (((0x20dU == (IData)(vlSelf->vga__DOT__my_vga_ctrl__DOT__y_cnt)) 
                & (0x320U == (IData)(vlSelf->vga__DOT__my_vga_ctrl__DOT__x_cnt)))) {
        __Vdly__vga__DOT__my_vga_ctrl__DOT__y_cnt = 1U;
    } else if ((0x320U == (IData)(vlSelf->vga__DOT__my_vga_ctrl__DOT__x_cnt))) {
        __Vdly__vga__DOT__my_vga_ctrl__DOT__y_cnt = 
            (0x3ffU & ((IData)(1U) + (IData)(vlSelf->vga__DOT__my_vga_ctrl__DOT__y_cnt)));
    }
    vlSelf->vga__DOT__my_vga_ctrl__DOT__y_cnt = __Vdly__vga__DOT__my_vga_ctrl__DOT__y_cnt;
    vlSelf->VGA_VSYNC = (2U < (IData)(vlSelf->vga__DOT__my_vga_ctrl__DOT__y_cnt));
    vlSelf->vga__DOT__my_vga_ctrl__DOT__v_valid = (
                                                   (0x23U 
                                                    < (IData)(vlSelf->vga__DOT__my_vga_ctrl__DOT__y_cnt)) 
                                                   & (0x203U 
                                                      >= (IData)(vlSelf->vga__DOT__my_vga_ctrl__DOT__y_cnt)));
}

VL_INLINE_OPT void Vvga___024root___sequent__TOP__5(Vvga___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vvga__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvga___024root___sequent__TOP__5\n"); );
    // Variables
    CData/*0:0*/ vga__DOT__my_vga_ctrl__DOT__h_valid;
    IData/*23:0*/ vga__DOT__vga_data;
    // Body
    vlSelf->vga__DOT__my_vga_ctrl__DOT__x_cnt = vlSelf->__Vdly__vga__DOT__my_vga_ctrl__DOT__x_cnt;
    vlSelf->VGA_HSYNC = (0x60U < (IData)(vlSelf->vga__DOT__my_vga_ctrl__DOT__x_cnt));
    vga__DOT__my_vga_ctrl__DOT__h_valid = ((0x90U < (IData)(vlSelf->vga__DOT__my_vga_ctrl__DOT__x_cnt)) 
                                           & (0x310U 
                                              >= (IData)(vlSelf->vga__DOT__my_vga_ctrl__DOT__x_cnt)));
    vlSelf->VGA_BLANK_N = ((IData)(vga__DOT__my_vga_ctrl__DOT__h_valid) 
                           & (IData)(vlSelf->vga__DOT__my_vga_ctrl__DOT__v_valid));
    vga__DOT__vga_data = vlSelf->vga__DOT__vmem[((((IData)(vlSelf->vga__DOT__my_vga_ctrl__DOT__v_valid)
                                                    ? 
                                                   (0x1ffU 
                                                    & ((IData)(vlSelf->vga__DOT__my_vga_ctrl__DOT__y_cnt) 
                                                       - (IData)(0x24U)))
                                                    : 0U) 
                                                  << 0xaU) 
                                                 | ((IData)(vga__DOT__my_vga_ctrl__DOT__h_valid)
                                                     ? 
                                                    (0x3ffU 
                                                     & ((IData)(vlSelf->vga__DOT__my_vga_ctrl__DOT__x_cnt) 
                                                        - (IData)(0x91U)))
                                                     : 0U))];
    vlSelf->VGA_R = (0xffU & (vga__DOT__vga_data >> 0x10U));
    vlSelf->VGA_G = (0xffU & (vga__DOT__vga_data >> 8U));
    vlSelf->VGA_B = (0xffU & vga__DOT__vga_data);
}

void Vvga___024root___eval(Vvga___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vvga__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvga___024root___eval\n"); );
    // Body
    if ((((IData)(vlSelf->clk) & (~ (IData)(vlSelf->__Vclklast__TOP__clk))) 
         | ((IData)(vlSelf->rst) & (~ (IData)(vlSelf->__Vclklast__TOP__rst))))) {
        Vvga___024root___sequent__TOP__2(vlSelf);
    }
    if (((IData)(vlSelf->clk) & (~ (IData)(vlSelf->__Vclklast__TOP__clk)))) {
        Vvga___024root___sequent__TOP__3(vlSelf);
    }
    if ((((IData)(vlSelf->clk) & (~ (IData)(vlSelf->__Vclklast__TOP__clk))) 
         | ((IData)(vlSelf->rst) & (~ (IData)(vlSelf->__Vclklast__TOP__rst))))) {
        Vvga___024root___sequent__TOP__5(vlSelf);
    }
    // Final
    vlSelf->__Vclklast__TOP__clk = vlSelf->clk;
    vlSelf->__Vclklast__TOP__rst = vlSelf->rst;
}

QData Vvga___024root___change_request_1(Vvga___024root* vlSelf);

VL_INLINE_OPT QData Vvga___024root___change_request(Vvga___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vvga__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvga___024root___change_request\n"); );
    // Body
    return (Vvga___024root___change_request_1(vlSelf));
}

VL_INLINE_OPT QData Vvga___024root___change_request_1(Vvga___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vvga__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvga___024root___change_request_1\n"); );
    // Body
    // Change detection
    QData __req = false;  // Logically a bool
    return __req;
}

#ifdef VL_DEBUG
void Vvga___024root___eval_debug_assertions(Vvga___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vvga__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvga___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->clk & 0xfeU))) {
        Verilated::overWidthError("clk");}
    if (VL_UNLIKELY((vlSelf->rst & 0xfeU))) {
        Verilated::overWidthError("rst");}
}
#endif  // VL_DEBUG
