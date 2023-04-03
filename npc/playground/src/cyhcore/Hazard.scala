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
  val RAWhazard = WireInit(false.B)
  dontTouch(RAWhazard)
  BoringUtils.addSink(RAWhazard, "RAWhazard")

  // 译码级停住
  val IDUregHalt = Wire(Bool())
  BoringUtils.addSource(IDUregHalt, "IDUregHalt")
  // ISU停住
  val ISUregHalt = Wire(Bool())
  BoringUtils.addSource(ISUregHalt, "ISUregHalt")
  // EXU停住
  val EXUregHalt = Wire(Bool())
  BoringUtils.addSource(EXUregHalt, "EXUregHalt")

  // Debug之用
  val HazardPC = WireInit(0.U(PC_LEN.W))
  BoringUtils.addSink(HazardPC, "HazardPC")

  // 遇到数据冒险时，阻塞整个流水线一个周期
  Cat(IDUregHalt, ISUregHalt, EXUregHalt) := Cat(RAWhazard, RAWhazard, RAWhazard)
  
}

