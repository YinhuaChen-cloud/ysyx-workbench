// package utils

// import chisel3._
// import chisel3.util._

// // 当前假设：划分的每一个阶段，都能在一拍内完成自己的功能
// object PipelineConnect {
//   def apply[T <: Data](left: DecoupledIO[T], right: DecoupledIO[T]) = {

//     // 在left有效位set 1后，右边还没有 ready 时，流水线的valid寄存器应该一直为1
//     val valid = RegInit(false.B)
//     valid := 

//     // 这是一堆寄存器，left写进来，延迟一个周期才能读
//     val regs = RegEnable(left.bits, left.valid) // 

//     right := regs

//   }
// }
