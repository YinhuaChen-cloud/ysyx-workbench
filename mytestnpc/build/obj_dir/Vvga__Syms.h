// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VVGA__SYMS_H_
#define VERILATED_VVGA__SYMS_H_  // guard

#include "verilated_heavy.h"

// INCLUDE MODEL CLASS

#include "Vvga.h"

// INCLUDE MODULE CLASSES
#include "Vvga___024root.h"

// SYMS CLASS (contains all model state)
class Vvga__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vvga* const __Vm_modelp;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vvga___024root                 TOP;

    // CONSTRUCTORS
    Vvga__Syms(VerilatedContext* contextp, const char* namep, Vvga* modelp);
    ~Vvga__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

#endif  // guard
