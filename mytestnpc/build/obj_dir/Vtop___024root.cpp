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
    vlSelf->L = 0U;
    if (((((((((0U == (IData)(vlSelf->func)) | (1U 
                                                == (IData)(vlSelf->func))) 
              | (2U == (IData)(vlSelf->func))) | (3U 
                                                  == (IData)(vlSelf->func))) 
            | (4U == (IData)(vlSelf->func))) | (5U 
                                                == (IData)(vlSelf->func))) 
          | (6U == (IData)(vlSelf->func))) | (7U == (IData)(vlSelf->func)))) {
        if ((0U != (IData)(vlSelf->func))) {
            if ((1U != (IData)(vlSelf->func))) {
                if ((2U != (IData)(vlSelf->func))) {
                    if ((3U != (IData)(vlSelf->func))) {
                        if ((4U != (IData)(vlSelf->func))) {
                            if ((5U != (IData)(vlSelf->func))) {
                                if ((6U == (IData)(vlSelf->func))) {
                                    vlSelf->L = 1U;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    vlSelf->Z = 0U;
    if (((((((((0U == (IData)(vlSelf->func)) | (1U 
                                                == (IData)(vlSelf->func))) 
              | (2U == (IData)(vlSelf->func))) | (3U 
                                                  == (IData)(vlSelf->func))) 
            | (4U == (IData)(vlSelf->func))) | (5U 
                                                == (IData)(vlSelf->func))) 
          | (6U == (IData)(vlSelf->func))) | (7U == (IData)(vlSelf->func)))) {
        if ((0U != (IData)(vlSelf->func))) {
            if ((1U != (IData)(vlSelf->func))) {
                if ((2U != (IData)(vlSelf->func))) {
                    if ((3U != (IData)(vlSelf->func))) {
                        if ((4U != (IData)(vlSelf->func))) {
                            if ((5U != (IData)(vlSelf->func))) {
                                if ((6U != (IData)(vlSelf->func))) {
                                    vlSelf->Z = 1U;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    vlSelf->result = 0U;
    if (((((((((0U == (IData)(vlSelf->func)) | (1U 
                                                == (IData)(vlSelf->func))) 
              | (2U == (IData)(vlSelf->func))) | (3U 
                                                  == (IData)(vlSelf->func))) 
            | (4U == (IData)(vlSelf->func))) | (5U 
                                                == (IData)(vlSelf->func))) 
          | (6U == (IData)(vlSelf->func))) | (7U == (IData)(vlSelf->func)))) {
        if ((0U == (IData)(vlSelf->func))) {
            vlSelf->result = (0xfU & ((IData)(vlSelf->A) 
                                      + (IData)(vlSelf->B)));
        } else if ((1U == (IData)(vlSelf->func))) {
            vlSelf->result = (0xfU & ((IData)(vlSelf->A) 
                                      - (IData)(vlSelf->B)));
        } else if ((2U == (IData)(vlSelf->func))) {
            vlSelf->result = (0xfU & (~ (IData)(vlSelf->A)));
        } else if ((3U == (IData)(vlSelf->func))) {
            vlSelf->result = ((IData)(vlSelf->A) & (IData)(vlSelf->B));
        } else if ((4U == (IData)(vlSelf->func))) {
            vlSelf->result = ((IData)(vlSelf->A) | (IData)(vlSelf->B));
        } else if ((5U == (IData)(vlSelf->func))) {
            vlSelf->result = ((IData)(vlSelf->A) ^ (IData)(vlSelf->B));
        }
    }
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
    if (VL_UNLIKELY((vlSelf->A & 0xf0U))) {
        Verilated::overWidthError("A");}
    if (VL_UNLIKELY((vlSelf->B & 0xf0U))) {
        Verilated::overWidthError("B");}
    if (VL_UNLIKELY((vlSelf->func & 0xf8U))) {
        Verilated::overWidthError("func");}
}
#endif  // VL_DEBUG
