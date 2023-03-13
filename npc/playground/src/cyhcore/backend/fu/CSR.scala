package cyhcore

import chisel3._
import chisel3.util._
import utils._

object CSROpType {
  def jmp  = "b000".U
  def wrt  = "b001".U
  def set  = "b010".U
  def clr  = "b011".U
  def wrti = "b101".U
  def seti = "b110".U
  def clri = "b111".U
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
  def access(src1: UInt, src2: UInt, func: UInt): UInt = {
    this.src1 := src1 // 在 csrrw 指令中，这个是从rs1寄存器读入的值，将要写入CSR
    this.src2 := src2 // csrid，在csrrw指令中，决定要操作的CSR是哪个
    this.func := func // 用来决定要对CSR进行什么操作
    io.out
  }

  // Machine-Level CSRs
  val mtvec = RegInit(UInt(XLEN.W), 0.U)
  // CSR reg map
  val mapping = Map(
    // Machine Trap Setup
    MaskedRegMap(Mtvec, mtvec)
  ) 

  val addr = src2(11, 0)
  val rdata = Wire(UInt(XLEN.W)) // 在 csrrw 指令中，这个用来读取CSR的值，然后给出去
  val wdata = OneHotTree(func, List( // 在 csrrw 指令中，用来决定写入CSR的值
    CSROpType.wrt  -> src1,
    // CSROpType.set  -> (rdata | src1),
    // CSROpType.clr  -> (rdata & ~src1),
    // CSROpType.wrti -> csri,//TODO: csri --> src2
    // CSROpType.seti -> (rdata | csri),
    // CSROpType.clri -> (rdata & ~csri)
  ))

  // General CSR wen check
  val wen = (func === CSROpType.wrt)

  // TODO: 我们可以加上 illegal 地址的报错, 果壳中，CSRID的非法地址似乎以Exception实现
  MaskedRegMap.generate(mapping, raddr=addr, rdata, waddr=addr, wen, wdata)
  io.out := rdata

}






