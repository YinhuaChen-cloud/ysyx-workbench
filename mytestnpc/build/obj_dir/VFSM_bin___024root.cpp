// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VFSM_bin.h for the primary calling header

#include "VFSM_bin___024root.h"
#include "VFSM_bin__Syms.h"

//==========

VL_INLINE_OPT void VFSM_bin___024root___sequent__TOP__2(VFSM_bin___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VFSM_bin__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VFSM_bin___024root___sequent__TOP__2\n"); );
    // Variables
    CData/*0:0*/ FSM_bin__DOT__outMux__DOT__i0__DOT__lut_out;
    CData/*0:0*/ FSM_bin__DOT__outMux__DOT__i0__DOT__hit;
    // Body
    vlSelf->FSM_bin__DOT__state__DOT__state = ((IData)(vlSelf->reset)
                                                ? 0U
                                                : (IData)(vlSelf->FSM_bin__DOT__state_din));
    vlSelf->state_dout = vlSelf->FSM_bin__DOT__state__DOT__state;
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

VL_INLINE_OPT void VFSM_bin___024root___combo__TOP__3(VFSM_bin___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VFSM_bin__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VFSM_bin___024root___combo__TOP__3\n"); );
    // Variables
    CData/*3:0*/ FSM_bin__DOT__stateMux__DOT__i0__DOT__lut_out;
    CData/*0:0*/ FSM_bin__DOT__stateMux__DOT__i0__DOT__hit;
    VlWide<3>/*71:0*/ FSM_bin__DOT____Vcellinp__stateMux__lut;
    VlWide<3>/*95:0*/ __Vtemp50;
    // Body
    __Vtemp50[0U] = (0x80U | (((IData)((((QData)((IData)(
                                                         (0x102030U 
                                                          | ((((IData)(vlSelf->in)
                                                                ? 5U
                                                                : 1U) 
                                                              << 0x18U) 
                                                             | ((((IData)(vlSelf->in)
                                                                   ? 5U
                                                                   : 2U) 
                                                                 << 0x10U) 
                                                                | ((((IData)(vlSelf->in)
                                                                      ? 5U
                                                                      : 3U) 
                                                                    << 8U) 
                                                                   | ((IData)(vlSelf->in)
                                                                       ? 5U
                                                                       : 4U))))))) 
                                         << 0x20U) 
                                        | (QData)((IData)(
                                                          (0x40506070U 
                                                           | ((((IData)(vlSelf->in)
                                                                 ? 5U
                                                                 : 4U) 
                                                               << 0x18U) 
                                                              | ((((IData)(vlSelf->in)
                                                                    ? 6U
                                                                    : 1U) 
                                                                  << 0x10U) 
                                                                 | ((((IData)(vlSelf->in)
                                                                       ? 7U
                                                                       : 1U) 
                                                                     << 8U) 
                                                                    | ((IData)(vlSelf->in)
                                                                        ? 8U
                                                                        : 1U))))))))) 
                               << 8U) | ((IData)(vlSelf->in)
                                          ? 8U : 1U)));
    __Vtemp50[1U] = (((IData)((((QData)((IData)((0x102030U 
                                                 | ((((IData)(vlSelf->in)
                                                       ? 5U
                                                       : 1U) 
                                                     << 0x18U) 
                                                    | ((((IData)(vlSelf->in)
                                                          ? 5U
                                                          : 2U) 
                                                        << 0x10U) 
                                                       | ((((IData)(vlSelf->in)
                                                             ? 5U
                                                             : 3U) 
                                                           << 8U) 
                                                          | ((IData)(vlSelf->in)
                                                              ? 5U
                                                              : 4U))))))) 
                                << 0x20U) | (QData)((IData)(
                                                            (0x40506070U 
                                                             | ((((IData)(vlSelf->in)
                                                                   ? 5U
                                                                   : 4U) 
                                                                 << 0x18U) 
                                                                | ((((IData)(vlSelf->in)
                                                                      ? 6U
                                                                      : 1U) 
                                                                    << 0x10U) 
                                                                   | ((((IData)(vlSelf->in)
                                                                         ? 7U
                                                                         : 1U) 
                                                                       << 8U) 
                                                                      | ((IData)(vlSelf->in)
                                                                          ? 8U
                                                                          : 1U))))))))) 
                      >> 0x18U) | ((IData)(((((QData)((IData)(
                                                              (0x102030U 
                                                               | ((((IData)(vlSelf->in)
                                                                     ? 5U
                                                                     : 1U) 
                                                                   << 0x18U) 
                                                                  | ((((IData)(vlSelf->in)
                                                                        ? 5U
                                                                        : 2U) 
                                                                      << 0x10U) 
                                                                     | ((((IData)(vlSelf->in)
                                                                           ? 5U
                                                                           : 3U) 
                                                                         << 8U) 
                                                                        | ((IData)(vlSelf->in)
                                                                            ? 5U
                                                                            : 4U))))))) 
                                              << 0x20U) 
                                             | (QData)((IData)(
                                                               (0x40506070U 
                                                                | ((((IData)(vlSelf->in)
                                                                      ? 5U
                                                                      : 4U) 
                                                                    << 0x18U) 
                                                                   | ((((IData)(vlSelf->in)
                                                                         ? 6U
                                                                         : 1U) 
                                                                       << 0x10U) 
                                                                      | ((((IData)(vlSelf->in)
                                                                            ? 7U
                                                                            : 1U) 
                                                                          << 8U) 
                                                                         | ((IData)(vlSelf->in)
                                                                             ? 8U
                                                                             : 1U)))))))) 
                                            >> 0x20U)) 
                                   << 8U));
    FSM_bin__DOT____Vcellinp__stateMux__lut[0U] = __Vtemp50[0U];
    FSM_bin__DOT____Vcellinp__stateMux__lut[1U] = __Vtemp50[1U];
    FSM_bin__DOT____Vcellinp__stateMux__lut[2U] = ((IData)(
                                                           ((((QData)((IData)(
                                                                              (0x102030U 
                                                                               | ((((IData)(vlSelf->in)
                                                                                 ? 5U
                                                                                 : 1U) 
                                                                                << 0x18U) 
                                                                                | ((((IData)(vlSelf->in)
                                                                                 ? 5U
                                                                                 : 2U) 
                                                                                << 0x10U) 
                                                                                | ((((IData)(vlSelf->in)
                                                                                 ? 5U
                                                                                 : 3U) 
                                                                                << 8U) 
                                                                                | ((IData)(vlSelf->in)
                                                                                 ? 5U
                                                                                 : 4U))))))) 
                                                              << 0x20U) 
                                                             | (QData)((IData)(
                                                                               (0x40506070U 
                                                                                | ((((IData)(vlSelf->in)
                                                                                 ? 5U
                                                                                 : 4U) 
                                                                                << 0x18U) 
                                                                                | ((((IData)(vlSelf->in)
                                                                                 ? 6U
                                                                                 : 1U) 
                                                                                << 0x10U) 
                                                                                | ((((IData)(vlSelf->in)
                                                                                 ? 7U
                                                                                 : 1U) 
                                                                                << 8U) 
                                                                                | ((IData)(vlSelf->in)
                                                                                 ? 8U
                                                                                 : 1U)))))))) 
                                                            >> 0x20U)) 
                                                   >> 0x18U);
    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__pair_list[0U] 
        = (0xffU & FSM_bin__DOT____Vcellinp__stateMux__lut[0U]);
    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__pair_list[1U] 
        = (0xffU & (FSM_bin__DOT____Vcellinp__stateMux__lut[0U] 
                    >> 8U));
    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__pair_list[2U] 
        = (0xffU & (FSM_bin__DOT____Vcellinp__stateMux__lut[0U] 
                    >> 0x10U));
    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__pair_list[3U] 
        = (FSM_bin__DOT____Vcellinp__stateMux__lut[0U] 
           >> 0x18U);
    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__pair_list[4U] 
        = (0xffU & FSM_bin__DOT____Vcellinp__stateMux__lut[1U]);
    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__pair_list[5U] 
        = (0xffU & (FSM_bin__DOT____Vcellinp__stateMux__lut[1U] 
                    >> 8U));
    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__pair_list[6U] 
        = (0xffU & (FSM_bin__DOT____Vcellinp__stateMux__lut[1U] 
                    >> 0x10U));
    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__pair_list[7U] 
        = (FSM_bin__DOT____Vcellinp__stateMux__lut[1U] 
           >> 0x18U);
    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__pair_list[8U] 
        = (0xffU & FSM_bin__DOT____Vcellinp__stateMux__lut[2U]);
    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__data_list[0U] 
        = (0xfU & vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__pair_list
           [0U]);
    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__key_list[0U] 
        = (0xfU & (vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__pair_list
                   [0U] >> 4U));
    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__data_list[1U] 
        = (0xfU & vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__pair_list
           [1U]);
    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__key_list[1U] 
        = (0xfU & (vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__pair_list
                   [1U] >> 4U));
    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__data_list[2U] 
        = (0xfU & vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__pair_list
           [2U]);
    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__key_list[2U] 
        = (0xfU & (vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__pair_list
                   [2U] >> 4U));
    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__data_list[3U] 
        = (0xfU & vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__pair_list
           [3U]);
    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__key_list[3U] 
        = (0xfU & (vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__pair_list
                   [3U] >> 4U));
    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__data_list[4U] 
        = (0xfU & vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__pair_list
           [4U]);
    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__key_list[4U] 
        = (0xfU & (vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__pair_list
                   [4U] >> 4U));
    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__data_list[5U] 
        = (0xfU & vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__pair_list
           [5U]);
    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__key_list[5U] 
        = (0xfU & (vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__pair_list
                   [5U] >> 4U));
    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__data_list[6U] 
        = (0xfU & vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__pair_list
           [6U]);
    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__key_list[6U] 
        = (0xfU & (vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__pair_list
                   [6U] >> 4U));
    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__data_list[7U] 
        = (0xfU & vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__pair_list
           [7U]);
    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__key_list[7U] 
        = (0xfU & (vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__pair_list
                   [7U] >> 4U));
    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__data_list[8U] 
        = (0xfU & vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__pair_list
           [8U]);
    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__key_list[8U] 
        = (0xfU & (vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__pair_list
                   [8U] >> 4U));
    FSM_bin__DOT__stateMux__DOT__i0__DOT__lut_out = 
        ((- (IData)(((IData)(vlSelf->state_dout) == 
                     vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__key_list
                     [0U]))) & vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__data_list
         [0U]);
    FSM_bin__DOT__stateMux__DOT__i0__DOT__hit = ((IData)(vlSelf->state_dout) 
                                                 == 
                                                 vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__key_list
                                                 [0U]);
    FSM_bin__DOT__stateMux__DOT__i0__DOT__lut_out = 
        ((IData)(FSM_bin__DOT__stateMux__DOT__i0__DOT__lut_out) 
         | ((- (IData)(((IData)(vlSelf->state_dout) 
                        == vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__key_list
                        [1U]))) & vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__data_list
            [1U]));
    FSM_bin__DOT__stateMux__DOT__i0__DOT__hit = ((IData)(FSM_bin__DOT__stateMux__DOT__i0__DOT__hit) 
                                                 | ((IData)(vlSelf->state_dout) 
                                                    == 
                                                    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__key_list
                                                    [1U]));
    FSM_bin__DOT__stateMux__DOT__i0__DOT__lut_out = 
        ((IData)(FSM_bin__DOT__stateMux__DOT__i0__DOT__lut_out) 
         | ((- (IData)(((IData)(vlSelf->state_dout) 
                        == vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__key_list
                        [2U]))) & vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__data_list
            [2U]));
    FSM_bin__DOT__stateMux__DOT__i0__DOT__hit = ((IData)(FSM_bin__DOT__stateMux__DOT__i0__DOT__hit) 
                                                 | ((IData)(vlSelf->state_dout) 
                                                    == 
                                                    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__key_list
                                                    [2U]));
    FSM_bin__DOT__stateMux__DOT__i0__DOT__lut_out = 
        ((IData)(FSM_bin__DOT__stateMux__DOT__i0__DOT__lut_out) 
         | ((- (IData)(((IData)(vlSelf->state_dout) 
                        == vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__key_list
                        [3U]))) & vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__data_list
            [3U]));
    FSM_bin__DOT__stateMux__DOT__i0__DOT__hit = ((IData)(FSM_bin__DOT__stateMux__DOT__i0__DOT__hit) 
                                                 | ((IData)(vlSelf->state_dout) 
                                                    == 
                                                    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__key_list
                                                    [3U]));
    FSM_bin__DOT__stateMux__DOT__i0__DOT__lut_out = 
        ((IData)(FSM_bin__DOT__stateMux__DOT__i0__DOT__lut_out) 
         | ((- (IData)(((IData)(vlSelf->state_dout) 
                        == vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__key_list
                        [4U]))) & vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__data_list
            [4U]));
    FSM_bin__DOT__stateMux__DOT__i0__DOT__hit = ((IData)(FSM_bin__DOT__stateMux__DOT__i0__DOT__hit) 
                                                 | ((IData)(vlSelf->state_dout) 
                                                    == 
                                                    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__key_list
                                                    [4U]));
    FSM_bin__DOT__stateMux__DOT__i0__DOT__lut_out = 
        ((IData)(FSM_bin__DOT__stateMux__DOT__i0__DOT__lut_out) 
         | ((- (IData)(((IData)(vlSelf->state_dout) 
                        == vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__key_list
                        [5U]))) & vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__data_list
            [5U]));
    FSM_bin__DOT__stateMux__DOT__i0__DOT__hit = ((IData)(FSM_bin__DOT__stateMux__DOT__i0__DOT__hit) 
                                                 | ((IData)(vlSelf->state_dout) 
                                                    == 
                                                    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__key_list
                                                    [5U]));
    FSM_bin__DOT__stateMux__DOT__i0__DOT__lut_out = 
        ((IData)(FSM_bin__DOT__stateMux__DOT__i0__DOT__lut_out) 
         | ((- (IData)(((IData)(vlSelf->state_dout) 
                        == vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__key_list
                        [6U]))) & vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__data_list
            [6U]));
    FSM_bin__DOT__stateMux__DOT__i0__DOT__hit = ((IData)(FSM_bin__DOT__stateMux__DOT__i0__DOT__hit) 
                                                 | ((IData)(vlSelf->state_dout) 
                                                    == 
                                                    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__key_list
                                                    [6U]));
    FSM_bin__DOT__stateMux__DOT__i0__DOT__lut_out = 
        ((IData)(FSM_bin__DOT__stateMux__DOT__i0__DOT__lut_out) 
         | ((- (IData)(((IData)(vlSelf->state_dout) 
                        == vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__key_list
                        [7U]))) & vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__data_list
            [7U]));
    FSM_bin__DOT__stateMux__DOT__i0__DOT__hit = ((IData)(FSM_bin__DOT__stateMux__DOT__i0__DOT__hit) 
                                                 | ((IData)(vlSelf->state_dout) 
                                                    == 
                                                    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__key_list
                                                    [7U]));
    FSM_bin__DOT__stateMux__DOT__i0__DOT__lut_out = 
        ((IData)(FSM_bin__DOT__stateMux__DOT__i0__DOT__lut_out) 
         | ((- (IData)(((IData)(vlSelf->state_dout) 
                        == vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__key_list
                        [8U]))) & vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__data_list
            [8U]));
    FSM_bin__DOT__stateMux__DOT__i0__DOT__hit = ((IData)(FSM_bin__DOT__stateMux__DOT__i0__DOT__hit) 
                                                 | ((IData)(vlSelf->state_dout) 
                                                    == 
                                                    vlSelf->FSM_bin__DOT__stateMux__DOT__i0__DOT__key_list
                                                    [8U]));
    vlSelf->FSM_bin__DOT__state_din = ((IData)(FSM_bin__DOT__stateMux__DOT__i0__DOT__hit)
                                        ? (IData)(FSM_bin__DOT__stateMux__DOT__i0__DOT__lut_out)
                                        : 0U);
}

void VFSM_bin___024root___eval(VFSM_bin___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VFSM_bin__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VFSM_bin___024root___eval\n"); );
    // Body
    if (((IData)(vlSelf->clk) & (~ (IData)(vlSelf->__Vclklast__TOP__clk)))) {
        VFSM_bin___024root___sequent__TOP__2(vlSelf);
    }
    VFSM_bin___024root___combo__TOP__3(vlSelf);
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
