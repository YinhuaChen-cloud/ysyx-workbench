package cyhcore

import chisel3._
import chisel3.util._

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





