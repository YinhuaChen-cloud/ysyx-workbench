package utils

import chisel3._
import chisel3.util._

// 当前假设：划分的每一个阶段，都能在一拍内完成自己的功能
// IFU -> IDU reg -> IDU -> EXU reg -> EXU -> WBU reg -> WBU (不考虑跳转指令)
object PipelineConnect {
  def apply[T <: Data](left: T, right: DecoupledIO[T]) = {
    // 每一回合都有新数据写入，每一回合数据都有效

    val valid = RegInit(false.B)
    valid := true.B 

    val regs = RegEnable(left, true.B)

    right.bits := regs
    right.valid := valid

  }
}
