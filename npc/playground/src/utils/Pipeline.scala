package utils

import chisel3._
import chisel3.util._

// 当前假设：划分的每一个阶段，都能在一拍内完成自己的功能
// IFU -> IDU reg -> IDU -> EXU reg -> EXU -> WBU reg -> WBU (不考虑跳转指令)
object PipelineConnect {
  def apply[T <: Data](left: DecoupledIO[T], right: DecoupledIO[T]) = {

    val pipeline_valid = RegInit(false.B) 
    pipeline_valid := left.valid && right.ready

    // 流水级寄存器就是就是下一级的输入
    // 只有在下一级已经把当前的流水级寄存器使用完毕，流水级寄存器才能被修改
    // 什么时候使用完毕呢？一个保守的方式是：当下一级的ready为高时
    // 此外，只有在left.valid = true时，修改流水级寄存器才有效  TODO: 这行存疑
    val pipeline_regs = RegEnable(left.bits, left.valid && right.ready)  // TODO: 感觉这里还可以优化，都有握手信号了，为什么还要流水级寄存器？也许我们可以去掉流水级寄存器

    right.bits := pipeline_regs
    right.valid := pipeline_valid
    left.ready := right.ready

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
