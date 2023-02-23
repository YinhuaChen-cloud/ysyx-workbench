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

