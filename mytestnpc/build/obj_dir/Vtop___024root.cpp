// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop.h for the primary calling header

#include "Vtop___024root.h"
#include "Vtop__Syms.h"

//==========

VL_INLINE_OPT void Vtop___024root___sequent__TOP__3(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___sequent__TOP__3\n"); );
    // Variables
    SData/*9:0*/ __Vdly__top__DOT__my_vga_ctrl__DOT__y_cnt;
    // Body
    __Vdly__top__DOT__my_vga_ctrl__DOT__y_cnt = vlSelf->top__DOT__my_vga_ctrl__DOT__y_cnt;
    if (vlSelf->rst) {
        __Vdly__top__DOT__my_vga_ctrl__DOT__y_cnt = 1U;
    } else if (((0x20dU == (IData)(vlSelf->top__DOT__my_vga_ctrl__DOT__y_cnt)) 
                & (0x320U == (IData)(vlSelf->top__DOT__my_vga_ctrl__DOT__x_cnt)))) {
        __Vdly__top__DOT__my_vga_ctrl__DOT__y_cnt = 1U;
    } else if ((0x320U == (IData)(vlSelf->top__DOT__my_vga_ctrl__DOT__x_cnt))) {
        __Vdly__top__DOT__my_vga_ctrl__DOT__y_cnt = 
            (0x3ffU & ((IData)(1U) + (IData)(vlSelf->top__DOT__my_vga_ctrl__DOT__y_cnt)));
    }
    vlSelf->top__DOT__my_vga_ctrl__DOT__y_cnt = __Vdly__top__DOT__my_vga_ctrl__DOT__y_cnt;
    vlSelf->VGA_VSYNC = (2U < (IData)(vlSelf->top__DOT__my_vga_ctrl__DOT__y_cnt));
    vlSelf->top__DOT__my_vga_ctrl__DOT__v_valid = (
                                                   (0x23U 
                                                    < (IData)(vlSelf->top__DOT__my_vga_ctrl__DOT__y_cnt)) 
                                                   & (0x203U 
                                                      >= (IData)(vlSelf->top__DOT__my_vga_ctrl__DOT__y_cnt)));
    vlSelf->top__DOT__v_addr = ((IData)(vlSelf->top__DOT__my_vga_ctrl__DOT__v_valid)
                                 ? (0x3ffU & ((IData)(vlSelf->top__DOT__my_vga_ctrl__DOT__y_cnt) 
                                              - (IData)(0x24U)))
                                 : 0U);
}

VL_INLINE_OPT void Vtop___024root___sequent__TOP__4(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___sequent__TOP__4\n"); );
    // Variables
    CData/*7:0*/ top__DOT__asciidata;
    CData/*0:0*/ top__DOT__my_vga_ctrl__DOT__h_valid;
    SData/*9:0*/ top__DOT__h_addr;
    IData/*31:0*/ top__DOT__i;
    IData/*23:0*/ top__DOT__vga_data;
    // Body
    vlSelf->top__DOT__my_vga_ctrl__DOT__x_cnt = ((IData)(vlSelf->rst)
                                                  ? 1U
                                                  : 
                                                 ((0x320U 
                                                   == (IData)(vlSelf->top__DOT__my_vga_ctrl__DOT__x_cnt))
                                                   ? 1U
                                                   : 
                                                  (0x3ffU 
                                                   & ((IData)(1U) 
                                                      + (IData)(vlSelf->top__DOT__my_vga_ctrl__DOT__x_cnt)))));
    vlSelf->VGA_HSYNC = (0x60U < (IData)(vlSelf->top__DOT__my_vga_ctrl__DOT__x_cnt));
    top__DOT__my_vga_ctrl__DOT__h_valid = ((0x90U < (IData)(vlSelf->top__DOT__my_vga_ctrl__DOT__x_cnt)) 
                                           & (0x310U 
                                              >= (IData)(vlSelf->top__DOT__my_vga_ctrl__DOT__x_cnt)));
    vlSelf->VGA_BLANK_N = ((IData)(top__DOT__my_vga_ctrl__DOT__h_valid) 
                           & (IData)(vlSelf->top__DOT__my_vga_ctrl__DOT__v_valid));
    top__DOT__h_addr = ((IData)(top__DOT__my_vga_ctrl__DOT__h_valid)
                         ? (0x3ffU & ((IData)(vlSelf->top__DOT__my_vga_ctrl__DOT__x_cnt) 
                                      - (IData)(0x91U)))
                         : 0U);
    vlSelf->top__DOT__col = 0U;
    vlSelf->top__DOT__col_remainder = 0U;
    top__DOT__i = 0U;
    while (VL_GTS_III(1,32,32, 0x46U, top__DOT__i)) {
        if (((((IData)(9U) * top__DOT__i) <= (IData)(top__DOT__h_addr)) 
             & ((IData)(top__DOT__h_addr) < ((IData)(9U) 
                                             + ((IData)(9U) 
                                                * top__DOT__i))))) {
            vlSelf->top__DOT__col = (0x7fU & top__DOT__i);
        }
        if ((((IData)(0x46U) * top__DOT__i) == (IData)(top__DOT__h_addr))) {
            vlSelf->top__DOT__col_remainder = 0U;
        }
        if ((((IData)(1U) + ((IData)(0x46U) * top__DOT__i)) 
             == (IData)(top__DOT__h_addr))) {
            vlSelf->top__DOT__col_remainder = 1U;
        }
        if ((((IData)(2U) + ((IData)(0x46U) * top__DOT__i)) 
             == (IData)(top__DOT__h_addr))) {
            vlSelf->top__DOT__col_remainder = 2U;
        }
        if ((((IData)(3U) + ((IData)(0x46U) * top__DOT__i)) 
             == (IData)(top__DOT__h_addr))) {
            vlSelf->top__DOT__col_remainder = 3U;
        }
        if ((((IData)(4U) + ((IData)(0x46U) * top__DOT__i)) 
             == (IData)(top__DOT__h_addr))) {
            vlSelf->top__DOT__col_remainder = 4U;
        }
        if ((((IData)(5U) + ((IData)(0x46U) * top__DOT__i)) 
             == (IData)(top__DOT__h_addr))) {
            vlSelf->top__DOT__col_remainder = 5U;
        }
        if ((((IData)(6U) + ((IData)(0x46U) * top__DOT__i)) 
             == (IData)(top__DOT__h_addr))) {
            vlSelf->top__DOT__col_remainder = 6U;
        }
        if ((((IData)(7U) + ((IData)(0x46U) * top__DOT__i)) 
             == (IData)(top__DOT__h_addr))) {
            vlSelf->top__DOT__col_remainder = 7U;
        }
        if ((((IData)(8U) + ((IData)(0x46U) * top__DOT__i)) 
             == (IData)(top__DOT__h_addr))) {
            vlSelf->top__DOT__col_remainder = 8U;
        }
        top__DOT__i = ((IData)(1U) + top__DOT__i);
    }
    top__DOT__asciidata = ((0x8bfU >= (((IData)(vlSelf->top__DOT__col) 
                                        << 5U) | (0x1fU 
                                                  & ((IData)(vlSelf->top__DOT__v_addr) 
                                                     >> 4U))))
                            ? vlSelf->top__DOT__vmem
                           [(((IData)(vlSelf->top__DOT__col) 
                              << 5U) | (0x1fU & ((IData)(vlSelf->top__DOT__v_addr) 
                                                 >> 4U)))]
                            : 0U);
    vlSelf->top__DOT__font[0U] = vlSelf->top__DOT__dotmatrix
        [((IData)(top__DOT__asciidata) << 4U)];
    vlSelf->top__DOT__font[0U] = vlSelf->top__DOT__dotmatrix
        [((IData)(top__DOT__asciidata) << 4U)];
    top__DOT__vga_data = (((0xbU >= (IData)(vlSelf->top__DOT__col_remainder)) 
                           & (vlSelf->top__DOT__font
                              [(0xfU & (IData)(vlSelf->top__DOT__v_addr))] 
                              >> (IData)(vlSelf->top__DOT__col_remainder)))
                           ? 0xfffU : 0U);
    vlSelf->VGA_R = (0xffU & (top__DOT__vga_data >> 0x10U));
    vlSelf->VGA_G = (0xffU & (top__DOT__vga_data >> 8U));
    vlSelf->VGA_B = (0xffU & top__DOT__vga_data);
}

void Vtop___024root___eval(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval\n"); );
    // Body
    if (((IData)(vlSelf->clk) & (~ (IData)(vlSelf->__Vclklast__TOP__clk)))) {
        Vtop___024root___sequent__TOP__3(vlSelf);
    }
    if ((((IData)(vlSelf->clk) & (~ (IData)(vlSelf->__Vclklast__TOP__clk))) 
         | ((IData)(vlSelf->rst) & (~ (IData)(vlSelf->__Vclklast__TOP__rst))))) {
        Vtop___024root___sequent__TOP__4(vlSelf);
    }
    // Final
    vlSelf->__Vclklast__TOP__clk = vlSelf->clk;
    vlSelf->__Vclklast__TOP__rst = vlSelf->rst;
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
    if (VL_UNLIKELY((vlSelf->rst & 0xfeU))) {
        Verilated::overWidthError("rst");}
}
#endif  // VL_DEBUG
