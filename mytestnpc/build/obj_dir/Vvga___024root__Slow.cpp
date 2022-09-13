// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vvga.h for the primary calling header

#include "Vvga___024root.h"
#include "Vvga__Syms.h"

//==========


void Vvga___024root___ctor_var_reset(Vvga___024root* vlSelf);

Vvga___024root::Vvga___024root(const char* _vcname__)
    : VerilatedModule(_vcname__)
 {
    // Reset structure values
    Vvga___024root___ctor_var_reset(this);
}

void Vvga___024root::__Vconfigure(Vvga__Syms* _vlSymsp, bool first) {
    if (false && first) {}  // Prevent unused
    this->vlSymsp = _vlSymsp;
}

Vvga___024root::~Vvga___024root() {
}

void Vvga___024root___initial__TOP__1(Vvga___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vvga__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvga___024root___initial__TOP__1\n"); );
    // Variables
    VlWide<6>/*191:0*/ __Vtemp1;
    // Body
    __Vtemp1[0U] = 0x2e747874U;
    __Vtemp1[1U] = 0x74486578U;
    __Vtemp1[2U] = 0x696e7075U;
    __Vtemp1[3U] = 0x7263652fU;
    __Vtemp1[4U] = 0x65736f75U;
    __Vtemp1[5U] = 0x72U;
    VL_READMEM_N(true, 24, 307201, 0, VL_CVT_PACK_STR_NW(6, __Vtemp1)
                 ,  &(vlSelf->vga__DOT__vmem), 0, ~0ULL);
}

void Vvga___024root___settle__TOP__3(Vvga___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vvga__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvga___024root___settle__TOP__3\n"); );
    // Variables
    CData/*0:0*/ vga__DOT__my_vga_ctrl__DOT__h_valid;
    SData/*9:0*/ vga__DOT__h_addr;
    IData/*23:0*/ vga__DOT__vga_data;
    // Body
    vlSelf->VGA_HSYNC = (0x60U < (IData)(vlSelf->vga__DOT__my_vga_ctrl__DOT__x_cnt));
    vlSelf->VGA_VSYNC = (2U < (IData)(vlSelf->vga__DOT__my_vga_ctrl__DOT__y_cnt));
    vga__DOT__my_vga_ctrl__DOT__h_valid = ((0x90U < (IData)(vlSelf->vga__DOT__my_vga_ctrl__DOT__x_cnt)) 
                                           & (0x310U 
                                              >= (IData)(vlSelf->vga__DOT__my_vga_ctrl__DOT__x_cnt)));
    vlSelf->vga__DOT__my_vga_ctrl__DOT__v_valid = (
                                                   (0x23U 
                                                    < (IData)(vlSelf->vga__DOT__my_vga_ctrl__DOT__y_cnt)) 
                                                   & (0x203U 
                                                      >= (IData)(vlSelf->vga__DOT__my_vga_ctrl__DOT__y_cnt)));
    if (vga__DOT__my_vga_ctrl__DOT__h_valid) {
        vga__DOT__h_addr = (0x3ffU & ((IData)(vlSelf->vga__DOT__my_vga_ctrl__DOT__x_cnt) 
                                      - (IData)(0x91U)));
        vlSelf->VGA_BLANK_N = ((IData)(vlSelf->vga__DOT__my_vga_ctrl__DOT__v_valid) 
                               & 1U);
    } else {
        vga__DOT__h_addr = 0U;
        vlSelf->VGA_BLANK_N = 0U;
    }
    vlSelf->vga__DOT__v_addr = ((IData)(vlSelf->vga__DOT__my_vga_ctrl__DOT__v_valid)
                                 ? (0x3ffU & ((IData)(vlSelf->vga__DOT__my_vga_ctrl__DOT__y_cnt) 
                                              - (IData)(0x24U)))
                                 : 0U);
    vga__DOT__vga_data = ((0x4b000U >= (0x7ffffU & 
                                        (((IData)(0x280U) 
                                          * (IData)(vlSelf->vga__DOT__v_addr)) 
                                         + (IData)(vga__DOT__h_addr))))
                           ? vlSelf->vga__DOT__vmem
                          [(0x7ffffU & (((IData)(0x280U) 
                                         * (IData)(vlSelf->vga__DOT__v_addr)) 
                                        + (IData)(vga__DOT__h_addr)))]
                           : 0U);
    vlSelf->VGA_R = (0xffU & (vga__DOT__vga_data >> 0x10U));
    vlSelf->VGA_G = (0xffU & (vga__DOT__vga_data >> 8U));
    vlSelf->VGA_B = (0xffU & vga__DOT__vga_data);
}

void Vvga___024root___eval_initial(Vvga___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vvga__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvga___024root___eval_initial\n"); );
    // Body
    Vvga___024root___initial__TOP__1(vlSelf);
    vlSelf->__Vclklast__TOP__clk = vlSelf->clk;
    vlSelf->__Vclklast__TOP__rst = vlSelf->rst;
    vlSelf->__Vclklast__TOP__vga__DOT__freqclk = vlSelf->vga__DOT__freqclk;
}

void Vvga___024root___eval_settle(Vvga___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vvga__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvga___024root___eval_settle\n"); );
    // Body
    Vvga___024root___settle__TOP__3(vlSelf);
}

void Vvga___024root___final(Vvga___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vvga__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvga___024root___final\n"); );
}

void Vvga___024root___ctor_var_reset(Vvga___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vvga__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vvga___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->clk = 0;
    vlSelf->rst = 0;
    vlSelf->VGA_VSYNC = 0;
    vlSelf->VGA_HSYNC = 0;
    vlSelf->VGA_BLANK_N = 0;
    vlSelf->VGA_R = 0;
    vlSelf->VGA_G = 0;
    vlSelf->VGA_B = 0;
    vlSelf->vga__DOT__v_addr = 0;
    for (int __Vi0=0; __Vi0<307201; ++__Vi0) {
        vlSelf->vga__DOT__vmem[__Vi0] = 0;
    }
    vlSelf->vga__DOT__freqclk = 0;
    vlSelf->vga__DOT__myclk__DOT__clkcount = 0;
    vlSelf->vga__DOT__my_vga_ctrl__DOT__x_cnt = 0;
    vlSelf->vga__DOT__my_vga_ctrl__DOT__y_cnt = 0;
    vlSelf->vga__DOT__my_vga_ctrl__DOT__v_valid = 0;
    vlSelf->__Vdly__vga__DOT__my_vga_ctrl__DOT__x_cnt = 0;
}
