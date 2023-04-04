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
  val CtrlHazard_next_cycle = RegNext(CtrlHazard) // 控制冒险的延时一周期

  // 由 ISU-ScoreBoard 检测是否有 RAW 冒险
  val RAWhazard = WireInit(false.B)
  BoringUtils.addSink(RAWhazard, "RAWhazard")

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

  // Flush 控制信号，决定是否冲刷整条流水线(置所有流水级寄存器为false一个周期，然后置它们为正常)
  val Flush = Wire(Bool())
  Flush := reset

  // 遇到数据冒险时，阻塞整个流水线一个周期
  // 在 RAWhazard后，部分流水线寄存器需要 valid=true.B 一个周期，因此使用下面这个延时一个周期的信号
  val RAWhazard_next_cycle = RegNext(RAWhazard)

  // IDUregControl
  // ------------------------- 处理控制冒险和数据冒险同时出现的情况 -------------- start

  // 1. 先出现控制冒险，再出现数据冒险: IFU 的指令已经发射，正常等待数据冒险处理，接着等待跳转指令处理即可 -- skip
  // 2. 先出现数据冒险，再出现控制冒险: WBU 是最后一级，这种情况不存在的 -- skip

  // 3. 两种冒险同时出现：
  val conflict = RegInit(false.B) // 检测两种冒险是否同时出现
  when(conflict && !RAWhazard) { // 当RAW冒险已经结束时
    IDUregControl := true.B
    conflict := false.B
  } .elsewhen(!conflict && CtrlHazard && !CtrlHazard_next_cycle && RAWhazard) { // 当出现冒险冲突时
    IDUregControl := false.B
    conflict := true.B
  } .otherwise { // 在没有冲突时
    IDUregControl := Mux(Flush, false.B,  // flush 时，置 invalid
      Mux(CtrlHazard, false.B,             // 遇到控制冒险，阻塞IFU->IDU，直到pc_reg跳转（已经延迟一周期）
      Mux(RAWhazard, false.B,             // RAWhazard 没消失时，置invalid，停住这一级，防止冲刷下级指令
      true.B)))                           // 平时设置 true.B 即可
  }
  // conflict := Mux(!conflict, Mux(CtrlHazard && !CtrlHazard_next_cycle && RAWhazard, true.B, conflict), 
  //   Mux(!RAWhazard, false.B, conflict))

  // // IDUregControl := Mux(RAWhazard, false.B, !rst && !CtrlHazard)
  // IDUregControl := Mux(Flush, false.B,  // flush 时，置 invalid
  //   Mux(CtrlHazard, false.B,             // 遇到控制冒险，阻塞IFU->IDU，直到pc_reg跳转（已经延迟一周期）
  //   Mux(RAWhazard, false.B,             // RAWhazard 没消失时，置invalid，停住这一级，防止冲刷下级指令
  //   true.B)))                           // 平时设置 true.B 即可

  // ------------------------- 处理控制冒险和数据冒险同时出现的情况 -------------- end


  // ISUregControl := Mux(RAWhazard, false.B, IDUregValid)
  ISUregControl := Mux(Flush, false.B,  // flush 时，置 invalid
    Mux(RAWhazard, false.B,             // RAWhazard 没消失时，置invalid，停住这一级
    Mux(RAWhazard_next_cycle, true.B,   // RAWhazard刚消失的那个周期，需要设置 valid=true.B 一个周期
    IDUregValid)))                      // 平时读取 上级流水线Valid 即可
    
  // EXUregControl := Mux(RAWhazard, false.B, ISUregValid)
  // WBUregControl := Mux(RAWhazard, false.B, EXUregValid)
  WBUregControl := Mux(Flush, false.B,  // flush 时，置 invalid
    Mux(RAWhazard, false.B,             // 遇到RAWhazard时，设置invalid，让下一周期停住，这一周期依然会继续流动
    Mux(RAWhazard_next_cycle, true.B,   // RAWhazard刚消失的那个周期，需要设置 valid=true.B 一个周期
    EXUregValid)))                      // 平时读取 上级流水线Valid 即可

  //TODO: 估计会直接冲刷整条流水  
  //TODO: 当控制冒险和数据冒险一同出现时，之前放置流水级寄存器整体为 invalid 的行为会导致等不来 redirect_valid = true.B

  // Debug之用 TODO: 后边可以去掉
  val HazardPC = WireInit(0.U(PC_LEN.W))
  BoringUtils.addSink(HazardPC, "HazardPC")

}
