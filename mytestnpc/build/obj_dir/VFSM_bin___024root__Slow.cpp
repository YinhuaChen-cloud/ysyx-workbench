// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VFSM_bin.h for the primary calling header

#include "VFSM_bin___024root.h"
#include "VFSM_bin__Syms.h"

//==========


void VFSM_bin___024root___ctor_var_reset(VFSM_bin___024root* vlSelf);

VFSM_bin___024root::VFSM_bin___024root(const char* _vcname__)
    : VerilatedModule(_vcname__)
 {
    // Reset structure values
    VFSM_bin___024root___ctor_var_reset(this);
}

void VFSM_bin___024root::__Vconfigure(VFSM_bin__Syms* _vlSymsp, bool first) {
    if (false && first) {}  // Prevent unused
    this->vlSymsp = _vlSymsp;
}

VFSM_bin___024root::~VFSM_bin___024root() {
}

void VFSM_bin___024root___settle__TOP__1(VFSM_bin___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VFSM_bin__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VFSM_bin___024root___settle__TOP__1\n"); );
    // Variables
    CData/*0:0*/ FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out;
    CData/*0:0*/ FSM_bin__DOT__outMux__DOT__i0__DOT__hit;
    // Body
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list[0U] = 0x11U;
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list[1U] = 0xeU;
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list[2U] = 0xcU;
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list[3U] = 0xaU;
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list[4U] = 9U;
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list[5U] = 6U;
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list[6U] = 4U;
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list[7U] = 2U;
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list[8U] = 0U;
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list[0U] 
        = (1U & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
           [0U]);
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list[0U] 
        = (0xfU & (vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
                   [0U] >> 1U));
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list[1U] 
        = (1U & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
           [1U]);
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list[1U] 
        = (0xfU & (vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
                   [1U] >> 1U));
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list[2U] 
        = (1U & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
           [2U]);
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list[2U] 
        = (0xfU & (vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
                   [2U] >> 1U));
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list[3U] 
        = (1U & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
           [3U]);
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list[3U] 
        = (0xfU & (vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
                   [3U] >> 1U));
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list[4U] 
        = (1U & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
           [4U]);
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list[4U] 
        = (0xfU & (vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
                   [4U] >> 1U));
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list[5U] 
        = (1U & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
           [5U]);
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list[5U] 
        = (0xfU & (vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
                   [5U] >> 1U));
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list[6U] 
        = (1U & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
           [6U]);
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list[6U] 
        = (0xfU & (vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
                   [6U] >> 1U));
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list[7U] 
        = (1U & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
           [7U]);
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list[7U] 
        = (0xfU & (vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
                   [7U] >> 1U));
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list[8U] 
        = (1U & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
           [8U]);
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list[8U] 
        = (0xfU & (vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
                   [8U] >> 1U));
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list[0U] 
        = (1U & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
           [0U]);
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list[0U] 
        = (0xfU & (vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
                   [0U] >> 1U));
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list[1U] 
        = (1U & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
           [1U]);
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list[1U] 
        = (0xfU & (vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
                   [1U] >> 1U));
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list[2U] 
        = (1U & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
           [2U]);
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list[2U] 
        = (0xfU & (vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
                   [2U] >> 1U));
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list[3U] 
        = (1U & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
           [3U]);
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list[3U] 
        = (0xfU & (vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
                   [3U] >> 1U));
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list[4U] 
        = (1U & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
           [4U]);
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list[4U] 
        = (0xfU & (vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
                   [4U] >> 1U));
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list[5U] 
        = (1U & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
           [5U]);
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list[5U] 
        = (0xfU & (vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
                   [5U] >> 1U));
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list[6U] 
        = (1U & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
           [6U]);
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list[6U] 
        = (0xfU & (vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
                   [6U] >> 1U));
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list[7U] 
        = (1U & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
           [7U]);
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list[7U] 
        = (0xfU & (vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
                   [7U] >> 1U));
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list[8U] 
        = (1U & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
           [8U]);
    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list[8U] 
        = (0xfU & (vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list
                   [8U] >> 1U));
    FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out = (
                                                   ((IData)(vlSelf->state_dout) 
                                                    == 
                                                    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                    [0U]) 
                                                   & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list
                                                   [0U]);
    FSM_bin__DOT__outMux__DOT__i0__DOT__hit = ((IData)(vlSelf->state_dout) 
                                               == vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                               [0U]);
    FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out) 
                                                   | (((IData)(vlSelf->state_dout) 
                                                       == 
                                                       vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                       [1U]) 
                                                      & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list
                                                      [1U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__hit = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__hit) 
                                               | ((IData)(vlSelf->state_dout) 
                                                  == 
                                                  vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                  [1U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out) 
                                                   | (((IData)(vlSelf->state_dout) 
                                                       == 
                                                       vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                       [2U]) 
                                                      & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list
                                                      [2U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__hit = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__hit) 
                                               | ((IData)(vlSelf->state_dout) 
                                                  == 
                                                  vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                  [2U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out) 
                                                   | (((IData)(vlSelf->state_dout) 
                                                       == 
                                                       vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                       [3U]) 
                                                      & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list
                                                      [3U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__hit = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__hit) 
                                               | ((IData)(vlSelf->state_dout) 
                                                  == 
                                                  vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                  [3U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out) 
                                                   | (((IData)(vlSelf->state_dout) 
                                                       == 
                                                       vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                       [4U]) 
                                                      & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list
                                                      [4U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__hit = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__hit) 
                                               | ((IData)(vlSelf->state_dout) 
                                                  == 
                                                  vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                  [4U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out) 
                                                   | (((IData)(vlSelf->state_dout) 
                                                       == 
                                                       vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                       [5U]) 
                                                      & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list
                                                      [5U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__hit = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__hit) 
                                               | ((IData)(vlSelf->state_dout) 
                                                  == 
                                                  vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                  [5U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out) 
                                                   | (((IData)(vlSelf->state_dout) 
                                                       == 
                                                       vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                       [6U]) 
                                                      & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list
                                                      [6U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__hit = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__hit) 
                                               | ((IData)(vlSelf->state_dout) 
                                                  == 
                                                  vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                  [6U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out) 
                                                   | (((IData)(vlSelf->state_dout) 
                                                       == 
                                                       vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                       [7U]) 
                                                      & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list
                                                      [7U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__hit = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__hit) 
                                               | ((IData)(vlSelf->state_dout) 
                                                  == 
                                                  vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                  [7U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out) 
                                                   | (((IData)(vlSelf->state_dout) 
                                                       == 
                                                       vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                       [8U]) 
                                                      & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list
                                                      [8U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__hit = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__hit) 
                                               | ((IData)(vlSelf->state_dout) 
                                                  == 
                                                  vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                  [8U]));
    vlSelf->out = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__hit) 
                   & (IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out));
    FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out = (
                                                   ((IData)(vlSelf->state_dout) 
                                                    == 
                                                    vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                    [0U]) 
                                                   & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list
                                                   [0U]);
    FSM_bin__DOT__outMux__DOT__i0__DOT__hit = ((IData)(vlSelf->state_dout) 
                                               == vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                               [0U]);
    FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out) 
                                                   | (((IData)(vlSelf->state_dout) 
                                                       == 
                                                       vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                       [1U]) 
                                                      & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list
                                                      [1U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__hit = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__hit) 
                                               | ((IData)(vlSelf->state_dout) 
                                                  == 
                                                  vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                  [1U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out) 
                                                   | (((IData)(vlSelf->state_dout) 
                                                       == 
                                                       vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                       [2U]) 
                                                      & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list
                                                      [2U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__hit = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__hit) 
                                               | ((IData)(vlSelf->state_dout) 
                                                  == 
                                                  vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                  [2U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out) 
                                                   | (((IData)(vlSelf->state_dout) 
                                                       == 
                                                       vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                       [3U]) 
                                                      & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list
                                                      [3U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__hit = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__hit) 
                                               | ((IData)(vlSelf->state_dout) 
                                                  == 
                                                  vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                  [3U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out) 
                                                   | (((IData)(vlSelf->state_dout) 
                                                       == 
                                                       vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                       [4U]) 
                                                      & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list
                                                      [4U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__hit = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__hit) 
                                               | ((IData)(vlSelf->state_dout) 
                                                  == 
                                                  vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                  [4U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out) 
                                                   | (((IData)(vlSelf->state_dout) 
                                                       == 
                                                       vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                       [5U]) 
                                                      & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list
                                                      [5U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__hit = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__hit) 
                                               | ((IData)(vlSelf->state_dout) 
                                                  == 
                                                  vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                  [5U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out) 
                                                   | (((IData)(vlSelf->state_dout) 
                                                       == 
                                                       vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                       [6U]) 
                                                      & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list
                                                      [6U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__hit = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__hit) 
                                               | ((IData)(vlSelf->state_dout) 
                                                  == 
                                                  vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                  [6U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out) 
                                                   | (((IData)(vlSelf->state_dout) 
                                                       == 
                                                       vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                       [7U]) 
                                                      & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list
                                                      [7U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__hit = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__hit) 
                                               | ((IData)(vlSelf->state_dout) 
                                                  == 
                                                  vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                  [7U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out) 
                                                   | (((IData)(vlSelf->state_dout) 
                                                       == 
                                                       vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                       [8U]) 
                                                      & vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list
                                                      [8U]));
    FSM_bin__DOT__outMux__DOT__i0__DOT__hit = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__hit) 
                                               | ((IData)(vlSelf->state_dout) 
                                                  == 
                                                  vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list
                                                  [8U]));
    vlSelf->out = ((IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__hit) 
                   & (IData)(FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out));
}

void VFSM_bin___024root___eval_initial(VFSM_bin___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VFSM_bin__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VFSM_bin___024root___eval_initial\n"); );
    // Body
    vlSelf->__Vclklast__TOP__clk = vlSelf->clk;
}

void VFSM_bin___024root___eval_settle(VFSM_bin___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VFSM_bin__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VFSM_bin___024root___eval_settle\n"); );
    // Body
    VFSM_bin___024root___settle__TOP__1(vlSelf);
}

void VFSM_bin___024root___final(VFSM_bin___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VFSM_bin__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VFSM_bin___024root___final\n"); );
}

void VFSM_bin___024root___ctor_var_reset(VFSM_bin___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VFSM_bin__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VFSM_bin___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->clk = 0;
    vlSelf->in = 0;
    vlSelf->reset = 0;
    vlSelf->out = 0;
    vlSelf->state_dout = 0;
    for (int __Vi0=0; __Vi0<9; ++__Vi0) {
        vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__pair_list[__Vi0] = 0;
    }
    for (int __Vi0=0; __Vi0<9; ++__Vi0) {
        vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__key_list[__Vi0] = 0;
    }
    for (int __Vi0=0; __Vi0<9; ++__Vi0) {
        vlSelf->FSM_bin__DOT__outMux__DOT__i0__DOT__data_list[__Vi0] = 0;
    }
}
