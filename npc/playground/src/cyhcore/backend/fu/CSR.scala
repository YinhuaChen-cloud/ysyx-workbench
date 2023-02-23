package cyhcore

import chisel3._
import chisel3.util._
import utils._
import Conf._

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
class CSR (implicit val conf: Configuration) extends Module with HasCSRConst{
  //  val io = IO(new CSRIO)

  // Machine-Level CSRs
  val mtvec = RegInit(UInt(conf.xlen.W), 0.U)
  // CSR reg map
  val mapping = Map(
    // Machine Trap Setup
    MaskedRegMap(Mtvec, mtvec)
  ) 
}






