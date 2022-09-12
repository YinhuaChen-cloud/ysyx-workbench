// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table implementation internals

#include "VFSM_bin__Syms.h"
#include "VFSM_bin.h"
#include "VFSM_bin___024root.h"

// FUNCTIONS
VFSM_bin__Syms::~VFSM_bin__Syms()
{
}

VFSM_bin__Syms::VFSM_bin__Syms(VerilatedContext* contextp, const char* namep,VFSM_bin* modelp)
    : VerilatedSyms{contextp}
    // Setup internal state of the Syms class
    , __Vm_modelp(modelp)
    // Setup module instances
    , TOP(namep)
{
    // Configure time unit / time precision
    _vm_contextp__->timeunit(-12);
    _vm_contextp__->timeprecision(-12);
    // Setup each module's pointers to their submodules
    // Setup each module's pointer back to symbol table (for public functions)
    TOP.__Vconfigure(this, true);
}
