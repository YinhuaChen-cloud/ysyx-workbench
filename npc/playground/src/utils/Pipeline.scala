package utils

import chisel3._
import chisel3.util._

// 当前假设：划分的每一个阶段，都能在一拍内完成自己的功能
// IFU -> IDU reg -> IDU -> EXU reg -> EXU -> WBU reg -> WBU (不考虑跳转指令)
object PipelineConnect {
  def apply[T <: Data](left: DecoupledIO[T], right: DecoupledIO[T]) = {

    // 这里 valid 和 regs 有一个约定: 下一拍大家一起有效
    val valid = RegInit(false.B)
    valid := left.valid

    val regs = RegEnable(left, left.valid)

    right.bits := regs
    right.valid := valid

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
