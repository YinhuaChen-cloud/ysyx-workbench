package cyhcore

import chisel3._
import chisel3.util._

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
  val wdata = Input(UInt(XLEN.W)) // TODO: 还不知道这玩意儿用来干嘛
}

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






}





