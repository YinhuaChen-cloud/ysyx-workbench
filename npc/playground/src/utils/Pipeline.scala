package utils

import chisel3._
import chisel3.util._

object PipelineConnect {
  // def apply[T <: Data](left: DecoupledIO[T], right: DecoupledIO[T], isFlush: Bool) = {
  def apply[T <: Data](left: DecoupledIO[T], right: DecoupledIO[T], valid_in: Bool) = {

    // 这里 valid 和 regs 有一个约定: 下一拍大家一起有效
    val pipeline_valid = RegInit(false.B)
    // valid := left.valid & !isFlush // 当 isFlush 为 false.B，left.valid 才会起作用
    // valid := left.valid
    pipeline_valid := valid_in

    val pipeline_regs = RegEnable(left.bits, valid_in)
    // val pipeline_regs = RegEnable(left.bits, left.valid & !isFlush)
    // val regs = RegEnable(left.bits, left.valid)

    right.bits := left.bits
    right.valid := pipeline_valid

    // ready 暂时不care
    left.ready := DontCare
    // left.ready := right.ready

    pipeline_valid // 以 valid 作为返回值
  }

}

// object PipelineConnect_noDecouple {
//   def apply[T <: Data](left: T, right: T, valid_cond: Bool) = {
//     // 每一回合都有新数据写入，每一回合数据都有效

//     // 这里 valid 和 regs 有一个约定: 下一拍大家一起有效
//     val valid = RegInit(false.B)
//     valid := valid_cond

//     val regs = RegEnable(left, valid_cond)

//     right.bits := regs
//     right.valid := valid

//   }
// }
