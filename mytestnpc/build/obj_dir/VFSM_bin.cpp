// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "VFSM_bin.h"
#include "VFSM_bin__Syms.h"

//============================================================
// Constructors

VFSM_bin::VFSM_bin(VerilatedContext* _vcontextp__, const char* _vcname__)
    : vlSymsp{new VFSM_bin__Syms(_vcontextp__, _vcname__, this)}
    , clk{vlSymsp->TOP.clk}
    , in{vlSymsp->TOP.in}
    , reset{vlSymsp->TOP.reset}
    , out{vlSymsp->TOP.out}
    , state_dout{vlSymsp->TOP.state_dout}
    , rootp{&(vlSymsp->TOP)}
{
}

VFSM_bin::VFSM_bin(const char* _vcname__)
    : VFSM_bin(nullptr, _vcname__)
{
}

//============================================================
// Destructor

VFSM_bin::~VFSM_bin() {
    delete vlSymsp;
}

//============================================================
// Evaluation loop

void VFSM_bin___024root___eval_initial(VFSM_bin___024root* vlSelf);
void VFSM_bin___024root___eval_settle(VFSM_bin___024root* vlSelf);
void VFSM_bin___024root___eval(VFSM_bin___024root* vlSelf);
QData VFSM_bin___024root___change_request(VFSM_bin___024root* vlSelf);
#ifdef VL_DEBUG
void VFSM_bin___024root___eval_debug_assertions(VFSM_bin___024root* vlSelf);
#endif  // VL_DEBUG
void VFSM_bin___024root___final(VFSM_bin___024root* vlSelf);

static void _eval_initial_loop(VFSM_bin__Syms* __restrict vlSymsp) {
    vlSymsp->__Vm_didInit = true;
    VFSM_bin___024root___eval_initial(&(vlSymsp->TOP));
    // Evaluate till stable
    int __VclockLoop = 0;
    QData __Vchange = 1;
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial loop\n"););
        VFSM_bin___024root___eval_settle(&(vlSymsp->TOP));
        VFSM_bin___024root___eval(&(vlSymsp->TOP));
        if (VL_UNLIKELY(++__VclockLoop > 100)) {
            // About to fail, so enable debug to see what's not settling.
            // Note you must run make with OPT=-DVL_DEBUG for debug prints.
            int __Vsaved_debug = Verilated::debug();
            Verilated::debug(1);
            __Vchange = VFSM_bin___024root___change_request(&(vlSymsp->TOP));
            Verilated::debug(__Vsaved_debug);
            VL_FATAL_MT("/home/chenyinhua/sda3/ysyx-workbench/mytestnpc/vsrc/FSM_bin.v", 1, "",
                "Verilated model didn't DC converge\n"
                "- See https://verilator.org/warn/DIDNOTCONVERGE");
        } else {
            __Vchange = VFSM_bin___024root___change_request(&(vlSymsp->TOP));
        }
    } while (VL_UNLIKELY(__Vchange));
}

void VFSM_bin::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate VFSM_bin::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    VFSM_bin___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    // Initialize
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) _eval_initial_loop(vlSymsp);
    // Evaluate till stable
    int __VclockLoop = 0;
    QData __Vchange = 1;
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Clock loop\n"););
        VFSM_bin___024root___eval(&(vlSymsp->TOP));
        if (VL_UNLIKELY(++__VclockLoop > 100)) {
            // About to fail, so enable debug to see what's not settling.
            // Note you must run make with OPT=-DVL_DEBUG for debug prints.
            int __Vsaved_debug = Verilated::debug();
            Verilated::debug(1);
            __Vchange = VFSM_bin___024root___change_request(&(vlSymsp->TOP));
            Verilated::debug(__Vsaved_debug);
            VL_FATAL_MT("/home/chenyinhua/sda3/ysyx-workbench/mytestnpc/vsrc/FSM_bin.v", 1, "",
                "Verilated model didn't converge\n"
                "- See https://verilator.org/warn/DIDNOTCONVERGE");
        } else {
            __Vchange = VFSM_bin___024root___change_request(&(vlSymsp->TOP));
        }
    } while (VL_UNLIKELY(__Vchange));
}

//============================================================
// Invoke final blocks

void VFSM_bin::final() {
    VFSM_bin___024root___final(&(vlSymsp->TOP));
}

//============================================================
// Utilities

VerilatedContext* VFSM_bin::contextp() const {
    return vlSymsp->_vm_contextp__;
}

const char* VFSM_bin::name() const {
    return vlSymsp->name();
}
