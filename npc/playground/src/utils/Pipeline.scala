package utils

import chisel3._
import chisel3.util._
import chisel3.internal.firrtl.MemPortDirection

// 当前假设：划分的每一个阶段，都能在一拍内完成自己的功能
// IFU -> IDU reg -> IDU -> EXU reg -> EXU -> WBU reg -> WBU (不考虑跳转指令)
object PipelineConnect2 {
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

object PipelineConnect3 {
  def apply[T <: Data](left: DecoupledIO[T], right: DecoupledIO[T]) = {

    // 流水级寄存器的 valid 应该和它的寄存器在同一个时钟上升沿有效
    val pipeline_valid = RegInit(false.B) // 一开始是无效的，流水级寄存器的数据不能被下一级读取
    // val pipeline_regs = RegEnable(left.bits, ) // 流水级寄存器
    val pipeline_regs = RegInit(left.bits) // 流水级寄存器

    // 流水级寄存器的状态，分为
    // 1. READY, 准备好接收来自上一级的数据  false.B
    // 1. WAIT, 等待下一级接收来自流水级的数据  true.B
    val READY = true.B
    val WAIT  = false.B
    val pipeline_state = RegInit(READY)  // 初始状态为 ready

    // 流水级寄存器什么时候有效？
    // 当 state 为 READY 时，只要 left.valid == true
    // 则下一个时钟上升沿和流水线寄存器共同更新，valid = true, regs更新，接着 state 更新为 WAIT
    when(pipeline_state === READY) {
      when(left.valid) {
        pipeline_regs  := left.bits
        pipeline_valid := true.B
        pipeline_state := WAIT
      } .otherwise {
        // pipeline_regs  := DontCare
        pipeline_valid := false.B 
        // pipeline_state := READY // 不变
      }
    } .otherwise { // WAIT时，在等待右边的ready信号
      // 不关心 valid
      when(right.ready) { 
        // pipeline_regs  := DontCare 
        pipeline_valid := false.B // 可知当前周期内，流水线寄存器就会被接收
        pipeline_state := READY
      } .otherwise {
        // pipeline_regs  := pipeline_regs 保持
        // pipeline_valid := true.B  保持即可
        // pipeline_state := WAIT // 不变
      }
    }

    left.ready  := pipeline_state
    right.valid := pipeline_valid
    right.bits  := pipeline_regs

  }
}


object PipelineConnect {
  def apply[T <: Data](left: DecoupledIO[T], right: DecoupledIO[T]) = {

    val pipeline_regs = RegInit(left.bits) // 流水级寄存器
    // 流水级寄存器的状态，分为
    // 1. READY, 准备好接收来自上一级的数据  false.B
    // 1. WAIT, 等待下一级接收来自流水级的数据  true.B
    val READY = false.B
    val WAIT  = true.B
    val pipeline_state = RegInit(READY)  // 初始状态为 ready   扮演 valid

    when(pipeline_state === READY) {
      when(left.valid) {
        pipeline_regs  := left.bits
        pipeline_state := WAIT
      } .otherwise {
        // pipeline_regs  := DontCare
        // pipeline_state := READY // 不变
      }
    } .otherwise { // WAIT时，在等待右边的ready信号
      // 不关心 valid
      when(right.ready) { 
        // pipeline_regs  := DontCare 
        pipeline_state := READY
      } .otherwise {
        // pipeline_regs  := pipeline_regs 保持
        // pipeline_valid := true.B  保持即可
        // pipeline_state := WAIT // 不变
      }
    }

    left.ready  := (pipeline_state === READY)
    right.valid := (pipeline_state === WAIT)
    right.bits  := pipeline_regs

  }
}
