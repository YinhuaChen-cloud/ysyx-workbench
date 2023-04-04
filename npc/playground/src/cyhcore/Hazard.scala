package cyhcore

import chisel3._
import chisel3.util._
import chisel3.util.experimental.BoringUtils

// 这个模块专门用来处理流水线冒险：数据冒险、（控制冒险）
// 主要用于阻塞各流水线
// 控制流水线寄存器
class Hazard extends CyhCoreModule {
  val io = IO(new Bundle {
  })

  // 由 IFU 自己使用预译码判断是否有控制冒险
  val CtrlHazard = WireInit(false.B)
  BoringUtils.addSink(CtrlHazard, "CtrlHazard")

  // 由 ISU-ScoreBoard 检测是否有 RAW 冒险
  val RAWhazard = WireInit(false.B)
  BoringUtils.addSink(RAWhazard, "RAWhazard")
  dontTouch(RAWhazard)

  // IDUreg控制信号
  val IDUregControl = Wire(Bool())
  BoringUtils.addSource(IDUregControl, "IDUregControl")
  // IDUreg有效信号
  val IDUregValid = WireInit(false.B)
  BoringUtils.addSink(IDUregValid, "IDUregValid")

  // ISUreg控制信号
  val ISUregControl = Wire(Bool())
  BoringUtils.addSource(ISUregControl, "ISUregControl")
  // ISUreg有效信号
  val ISUregValid = WireInit(false.B)
  BoringUtils.addSink(ISUregValid, "ISUregValid")

  // // EXUreg控制信号
  // val EXUregControl = Wire(Bool())
  // BoringUtils.addSource(EXUregControl, "EXUregControl")
  // EXUreg有效信号
  val EXUregValid = ISUregValid
  // val EXUregValid = WireInit(false.B)
  // BoringUtils.addSink(EXUregValid, "EXUregValid")

  // WBUreg控制信号
  val WBUregControl = Wire(Bool())
  BoringUtils.addSource(WBUregControl, "WBUregControl")

  // Debug之用 TODO: 后边可以去掉
  val HazardPC = WireInit(0.U(PC_LEN.W))
  BoringUtils.addSink(HazardPC, "HazardPC")

  // 遇到数据冒险时，阻塞整个流水线一个周期
  // 注意，IDUregControl只是阻塞IDU的输入，不会阻塞IDU的输出
  val rst = Wire(Bool())
  rst := reset
  IDUregControl := Mux(RAWhazard, false.B, !rst && !CtrlHazard)
  ISUregControl := Mux(RAWhazard, false.B, IDUregValid)
  // EXUregControl := Mux(RAWhazard, false.B, ISUregValid)
  WBUregControl := Mux(RAWhazard, false.B, EXUregValid)

  //TODO: 估计会直接冲刷整条流水  

}
