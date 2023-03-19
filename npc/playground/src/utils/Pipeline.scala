package utils

import chisel3._
import chisel3.util._

object PipelineConnect {
  def apply[T <: Data](left: T, right: T) = {

    val valid = RegInit(true.B)

    val regs = RegEnable(left, true.B) // left写进来，会延迟一个周期

    right := regs

  }
}
