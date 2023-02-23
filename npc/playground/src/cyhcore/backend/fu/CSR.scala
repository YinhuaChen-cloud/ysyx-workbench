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

class CSRIO extends FunctionUnitIO {
}

class CSR extends CyhCoreModule with HasCSRConst{
  val io = IO(new CSRIO)

  val (src1, src2, func) = (io.in.src1, io.in.src2, io.in.func) // 这里只是纯粹为了改名
  // def access(valid: Bool, src1: UInt, src2: UInt, func: UInt): UInt = {
    // this.valid := valid
    // this.src1 := src1
    // this.src2 := src2
    // this.func := func
    // io.out.bits
  // }

 // Machine-Level CSRs
 val mtvec = RegInit(UInt(XLEN.W), 0.U)
 // CSR reg map
 val mapping = Map(
  // Machine Trap Setup
   MaskedRegMap(Mtvec, mtvec)
 ) 

  val wdata = OneHotTree(func, List(
    CSROpType.wrt  -> src1,
    // CSROpType.set  -> (rdata | src1),
    // CSROpType.clr  -> (rdata & ~src1),
    // CSROpType.wrti -> csri,//TODO: csri --> src2
    // CSROpType.seti -> (rdata | csri),
    // CSROpType.clri -> (rdata & ~csri)
  ))


}






