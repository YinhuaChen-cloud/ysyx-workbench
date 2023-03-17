package cyhcore

import chisel3._
import chisel3.util._

import bus.simplebus._
import utils._

object LSUOpType { //TODO: refactor LSU fuop
  def lb   = "b0000000".U
  def lh   = "b0000001".U
  def lw   = "b0000010".U
  def ld   = "b0000011".U
  def lbu  = "b0000100".U
  def lhu  = "b0000101".U
  def lwu  = "b0000110".U
  def sb   = "b0001000".U
  def sh   = "b0001001".U
  def sw   = "b0001010".U
  def sd   = "b0001011".U

  def isStore(func: UInt): Bool = func(3)
  def isLoad(func: UInt): Bool = !isStore(func)

  def needMemRead(func: UInt): Bool = isLoad(func) 
  def needMemWrite(func: UInt): Bool = isStore(func)
}

class LSUIO extends FunctionUnitIO {
  val wdata = Input(UInt(XLEN.W)) // SOLVED: 这个东西用来装sd等指令的写数据
  val dmem = new SimpleBusUC
}

// ld : InstrI  R[rd] = (R[rs1] + imm)
// 在 IDU 内决定的 ------------------- 
// rfSrc1(CtrlSignalIO)  = rs1
// rfSrc2(CtrlSignalIO)  = -
// rfDest(CtrlSignalIO)  = rd
// imm(DataSrcIO)        = SignExt(instr(31, 20), XLEN)     12 -> 64
// 在 ISU 内决定的 ------------------- 
// src1 = R[rs1]
// src2 = imm
// 只要知道 src1, src2 即可读出数据，ISU知道 rd，可以写入rd寄存器，因此这里信息足够

// sd : InstrS (imm + R[rs1]) = R[rs2]
// 在 IDU 内决定的 ------------------- 
// rfSrc1(CtrlSignalIO)  = rs1
// rfSrc2(CtrlSignalIO)  = rs2
// rfDest(CtrlSignalIO)  = -
// imm(DataSrcIO)        = SignExt(Cat(instr(31, 25), instr(11, 7)), XLEN)    12 -> 64
// 在 ISU 内决定的 ------------------- 
// src1 = R[rs1]
// src2 = R[rs2]
// 还差了一个 imm，因此，多加一个 wdata端口，在EXU那一层，src1=src1, src2=imm, wdata=src2
// 保持 src1+src2 这个运算和ld一致，可以省去一些运算逻辑

// Unit implementing Load/Store
class LSU extends CyhCoreModule {
  val io = IO(new LSUIO)
  // 下面这两行是为了缩短端口名，方便维护和增强可读性。实例化LSU的代码使用access进行连线即可
  val (src1, src2, func) = (io.in.src1, io.in.src2, io.in.func)
  def access(src1: UInt, src2: UInt, func: UInt): UInt = {
    this.src1 := src1
    this.src2 := src2
    this.func := func
    io.out
  }

  // 判断是 store 还是 load
  val isStore = LSUOpType.isStore(func)
  // 根据是 load 还是 store，计算读写的地址
  val addr = io.in.src1
  // 判断是 load 8 字节还是 load 部分
  val partialLoad = !isStore && (func =/= LSUOpType.ld) // 如果不是 Store　指令，同时又不是load指令
  // ld, lw...
  val rdata    = io.dmem.resp.rdata // 从 simplebus 传来的读数据, 注意：rdata默认是对齐8字节读取内存
  // 在没有发生非对齐访存的前提下，以下代码的逻辑是没有问题的
  val rdataSel = OneHotTree(addr(2, 0), List(
    "b000".U -> rdata(63, 0), 
    "b001".U -> rdata(63, 8),
    "b010".U -> rdata(63, 16),
    "b011".U -> rdata(63, 24),
    "b100".U -> rdata(63, 32),
    "b101".U -> rdata(63, 40),
    "b110".U -> rdata(63, 48),
    "b111".U -> rdata(63, 56)
  ))
  // 已经读取到了数据，要从读到的数据中选择一部分
  val rdataPartialLoad = OneHotTree(func, List( 
      LSUOpType.lb   -> SignExt(rdataSel(7, 0) , XLEN),
      LSUOpType.lh   -> SignExt(rdataSel(15, 0), XLEN),
      LSUOpType.lw   -> SignExt(rdataSel(31, 0), XLEN),
      LSUOpType.lbu  -> ZeroExt(rdataSel(7, 0) , XLEN),
      LSUOpType.lhu  -> ZeroExt(rdataSel(15, 0), XLEN),
      LSUOpType.lwu  -> ZeroExt(rdataSel(31, 0), XLEN)
  ))

  // sd, sw...

}





