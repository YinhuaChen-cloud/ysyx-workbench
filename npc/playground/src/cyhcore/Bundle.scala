package cyhcore

import chisel3._
import chisel3.util._

class FunctionUnitIO extends CyhCoreBundle {
  val in = Flipped(new Bundle {
    val src1 = Output(UInt(XLEN.W))
    val src2 = Output(UInt(XLEN.W))
    val func = Output(FuOpType())
  })
  val out = Output(UInt(XLEN.W))
}

class CtrlFlowIO extends CyhCoreBundle {
  val instr = Output(UInt(64.W))
  val pc = Output(UInt(VAddrBits.W))
  // val pnpc = Output(UInt(VAddrBits.W)) // predicted next pc
  // val redirect = new RedirectIO
  // val exceptionVec = Output(Vec(16, Bool()))
  // val intrVec = Output(Vec(12, Bool()))
  // val brIdx = Output(UInt(4.W))
  // val isRVC = Output(Bool())
  // val crossPageIPFFix = Output(Bool())
}


