package utils

import chisel3._
import chisel3.util._
import chisel3.internal.firrtl.MemPortDirection

object PipelineConnect {
  def apply[T <: Data](left: DecoupledIO[T], right: DecoupledIO[T]) = {
    val valid = RegInit(false.B)
    when (left.valid && right.ready) { valid := true.B } // 和 right.bits 同时更新

    left.ready := right.ready // 如果下游准备好了，我就准备好了
    right.bits := RegEnable(left.bits, left.valid && right.ready) // 如果下游准备好了，并且上游数据有效，那就读取输入
    right.valid := valid
  }
}

