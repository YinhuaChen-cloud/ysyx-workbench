package cyhcore

import chisel3._
import chisel3.util._
import utils._

object CSROpType {
  // def jmp  = "b000".U
  def wrt  = "b001".U
  // def set  = "b010".U
  // def clr  = "b011".U
  // def wrti = "b101".U
  // def seti = "b110".U
  // def clri = "b111".U
}

trait HasCSRConst {
 // Machine Trap Setup
 val Mstatus       = 0x300
 val Mtvec         = 0x305

 // Machine Trap Handling
 val Mepc          = 0x341
 val Mcause        = 0x342
}

//class CSRIO extends FunctionUnitIO {
//  val cfIn = Flipped(new CtrlFlowIO)
//  val redirect = new RedirectIO
//  // for exception check
//  val instrValid = Input(Bool())
//  val isBackendException = Input(Bool())
//  // for differential testing
//  val intrNO = Output(UInt(XLEN.W))
//  val wenFix = Output(Bool())
//}
//
class CSR extends CyhCoreModule with HasCSRConst{
//  val io = IO(new CSRIO)

 // Machine-Level CSRs
 val mtvec = RegInit(UInt(XLEN.W), 0.U)
 // CSR reg map
 val mapping = Map(
  // Machine Trap Setup
   MaskedRegMap(Mtvec, mtvec)
 ) 

}






