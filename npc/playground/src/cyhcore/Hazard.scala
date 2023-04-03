package cyhcore

import chisel3._
import chisel3.util._
import chisel3.util.experimental.BoringUtils

// 这个模块专门用来处理流水线冒险：数据冒险、（控制冒险）
// 主要用于阻塞各流水线
class Hazard extends CyhCoreModule {
  val io = IO(new Bundle {
  })

  // 由 ISU-ScoreBoard 检测是否有 RAW 冒险
  val RAWhazard3 = WireInit(false.B)
  dontTouch(RAWhazard3)
  BoringUtils.addSink(RAWhazard3, "RAWhazard0")

  val IDUregHalt = Wire(Bool())
  val ISUregHalt = Wire(Bool())
  val EXUregHalt = Wire(Bool())
  
}

