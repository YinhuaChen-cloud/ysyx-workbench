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

  // IDUreg控制信号
  val IDUregControl = Wire(Bool())
  BoringUtils.addSource(IDUregControl, "IDUregControl")
  // IDUreg有效信号
  val IDUregValid = Wire(Bool())
  BoringUtils.addSink(IDUregValid, "IDUregValid")
  // ISUreg控制信号
  val ISUregControl = Wire(Bool())
  BoringUtils.addSource(ISUregControl, "ISUregControl")
  // EXUreg控制信号
  val EXUregControl = Wire(Bool())
  BoringUtils.addSource(EXUregControl, "EXUregControl")

  // Debug之用 TODO: 后边可以去掉
  val HazardPC = WireInit(0.U(PC_LEN.W))
  BoringUtils.addSink(HazardPC, "HazardPC")

  // 遇到数据冒险时，阻塞整个流水线一个周期
  // 注意，IDUregControl只是阻塞IDU的输入，不会阻塞IDU的输出
  val rst = Wire(Bool())
  rst := reset
  // IDUregControl := !rst & 
  // ISUregControl := RAWhazard
  // EXUregControl := 

}

  // val ppregshalt = Seq(IDUregHalt, ISUregHalt, EXUregControl)
  // val vals = Seq(ppcontrol, ppcontrol, ppcontrol) // EXU 和 WBU 不能停住，要继续运行
  // ppregshalt.zip(vals).foreach{case (a, b) => a := b}
  
