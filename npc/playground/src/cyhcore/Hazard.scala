package cyhcore

import chisel3._
import chisel3.util._

// 这个模块专门用来处理流水线冒险：数据冒险、（控制冒险）
// 主要用于阻塞各流水线
class Hazard extends CyhCoreModule {
  val io = IO(new Bundle {
  })

  val IDUregHalt = Wire(Bool())
  val ISUregHalt = Wire(Bool())
  val EXUregHalt = Wire(Bool())
  
}

