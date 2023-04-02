package utils

import chisel3._
import chisel3.util._

// 当前假设：划分的每一个阶段，都能在一拍内完成自己的功能
// IFU -> IDU reg -> IDU -> EXU reg -> EXU -> WBU reg -> WBU (不考虑跳转指令)
object PipelineConnect {
  def apply[T <: Data](left: DecoupledIO[T], right: DecoupledIO[T]) = {

    // 流水级寄存器的 valid 应该和它的寄存器在同一个时钟上升沿有效
    // 也许你会有疑问，使用  left.valid && right.ready  的做法，会不会让流水级寄存器有效的时候，实际上valid 为false
    // 答案是不会的，下一级的ready为高，说明下一级能够在当前拍内读取流水级寄存器的数据
    val pipeline_valid = RegInit(false.B)  // 一开始是无效的
    pipeline_valid := left.valid && right.ready

    // 流水级寄存器就是就是下一级的输入
    // 只有在上一级的数据确实被下一级接收之后，流水线寄存器才能被修改
    // 而这种时候，就是在fire的下一个时钟上升沿，即 left.valid && right.ready 之后的时钟上升沿
    val pipeline_regs = RegEnable(left.bits, left.valid && right.ready)  // TODO: 感觉这里还可以优化，都有握手信号了，为什么还要流水级寄存器？也许我们可以去掉流水级寄存器

    left.ready := right.ready
    right.valid := pipeline_valid
    right.bits := pipeline_regs

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
