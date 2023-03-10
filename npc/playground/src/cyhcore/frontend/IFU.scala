package cyhcore

import chisel3._
import chisel3.util._
import top.Settings
import bus.axi4.AXI4Lite
import bus.axi4.AXI4

trait HasResetVector {
  val resetVector = Settings.getLong("ResetVector")
}

              // |           // AXI4-Lite ar channel
              // |           input pc_valid,
              // |           input [${XLEN}-1:0] pc,
              // |           output reg pc_ready,
              // |           // AXI4-Lite r channel
              // |           output reg inst_valid,
              // |           output reg [${INST_LEN} - 1:0] inst,
              // |           input inst_ready);
class IFU_to_EXU extends CyhCoreBundle() { // TODO: 下一个步骤，让 IFU 获得指令，再交给 IDU/EXU
  val pc_next  = Input(UInt(PC_LEN.W))
  val pc_op    = Output(UInt(PC_LEN.W))  // 用来作为指令操作数的pc (比如 auipc 指令)
  val pc       = Output(UInt(PC_LEN.W))  // 用来计算 next_pc 的pc (比如 beq 等指令)
  val inst = Output(UInt(INST_LEN.W))
}

class IFU_to_AXI4SRAM extends CyhCoreBundle() { // TODO: 下一个步骤，让 IFU 获得指令，再交给 IDU/EXU
  val pc      =  Decoupled(UInt(PC_LEN.W)) // 输出
  val inst_in =  Flipped(Decoupled(UInt(INST_LEN.W))) // 输入
  val pc_for_diff   =  Output(UInt(PC_LEN.W)) // 输出
  // val pc      = Output(UInt(PC_LEN.W))
  // val inst_in = Input(UInt(INST_LEN.W))
}

class IFU_bundle extends CyhCoreBundle() {
  val ifu_to_exu = new IFU_to_EXU()
  val ifu_to_axi4sram = new IFU_to_AXI4SRAM()
  // 在加入流水线之前，用来适配 IFU-AXI4SRAM 总线
  val enable = Input(Bool()) // IFU 不需要，IFU 本来就每隔四个周期(fire) 才更新
}

class IFU extends CyhCoreModule with HasResetVector {
  val io = IO(new IFU_bundle())

  // TODO：果壳里，PC寄存器的长度是39
  val lastPC = RegInit(resetVector.U(PC_LEN.W)) // 用来给IDU/EXU当操作数（比如 auipc 指令）的PC
  val pc_reg = RegInit(resetVector.U(PC_LEN.W)) // 用来取指的PC
  lastPC := Mux(io.ifu_to_axi4sram.pc.fire, pc_reg, lastPC) // lastPC 在 pc_reg 更新时(pc.fire)才会更新

  // IFU-to-EXU 相关连线
  io.ifu_to_exu.pc         := pc_reg
  io.ifu_to_exu.pc_op      := lastPC
  io.ifu_to_exu.inst       := io.ifu_to_axi4sram.inst_in.bits
  // for diff
  // io.ifu_to_axi4sram.pc_for_diff := io.ifu_to_exu.pc_op 
  io.ifu_to_axi4sram.pc_for_diff := pc_reg

  // for IFU-AXI4SRAM bus --- start
  // pc valid
  val pc_valid = RegInit(false.B)
  io.ifu_to_axi4sram.pc.valid := pc_valid
  when(io.ifu_to_axi4sram.pc.ready === true.B) {
    pc_valid  := false.B  // 一个周期之后变成false
  } .otherwise {
    pc_valid  := true.B
  }
  // pc
  io.ifu_to_axi4sram.pc.bits  := pc_reg
  pc_reg := Mux(io.ifu_to_axi4sram.pc.fire, io.ifu_to_exu.pc_next, pc_reg)
  // inst ready
  val inst_ready = RegInit(false.B)
  io.ifu_to_axi4sram.inst_in.ready := inst_ready
  when(io.ifu_to_axi4sram.inst_in.valid === true.B) {
    inst_ready := true.B
  } .otherwise {
    inst_ready := false.B
  }
  // for IFU-AXI4SRAM bus --- end

}

  // 1. 我们的取指级（IF）应该发出取指信号，包括读请求（valid）和读地址（pc），
  // 2. 这时AXI模块应该收到取指级的信号，如果AXI模块处于空闲状态, 则对本次读请求做出响应，AXI内部状态由空闲
  // 跳转到读请求状态，产生并发送读请求（ar-valid）、读地址（ar-addr）、

// ================================================
// 将IFU的取指接口改造成AXI-Lite
// 1. 用RTL编写一个AXI-Lite的SRAM模块, 地址位宽为32bit, 数据位宽为64bit
// 2. 收到读请求后, 通过DPI-C调用pmem_read(), 并延迟一周期返回读出的数据
    // IFU每次取指都要等待一个周期, 才能取到指令交给IDU
// ================================================

// 完成一次指令读取
// 通过上面的资料学习，相信你已经对总线有一个大概的了解，现在我们来整理一次完整的指令读取的过程
// （当然如果基础够好的同学可以直接实现AXI4的读写过程）。
// 指令读取过程：
// 1. 我们的取指级（IF）应该发出取指信号，包括读请求（valid）和读地址（pc），
// 2. 这时AXI模块应该收到取指级的信号，如果AXI模块处于空闲状态, 则对本次读请求做出响应，AXI内部状态由空闲
// 跳转到读请求状态，产生并发送读请求（ar-valid）、读地址（ar-addr）、
// 读字节数（ar-size）、读个数（ar-len）， ------------------ 这两个不属于 AXILite，暂时不管

// 本次总线支持的宽度是8 Byte，所以如果不是突发传输（burst），一次只能读写8 Byte。

// 从机部分讲义：看 AXI4SRAM, AXI4Slave

// ===============================================================================================

// caution::实现总线读
// 通过上面一次指令读取的讲解，相信你对总线了解更进一步了，现在你可以整理上面的思路，自己整
// 理出一个总线读的状态机，然后将两个读通道的信号整理出来（上面基本给出了读信号，当然还有其
// 他信号的作用需要你自己查找），现在让你的取指模块通过总线读取指令吧，下面给出一个AXI4五个
// 信号通道的Verilog模板和位宽，暂时不需要你了解的信号已经标注初始化即可。
// 注意：千万不要让你的valid & ready 产生依赖关系，这两个信号最好独立产生（例如，你的读准备
// （r-ready）应该由状态切换产生，不能依赖从机（slave）的读返回（r-valid）产生而产生，不然后面
// 跑SOC和后端测试会很惨，一定要按照AXI4的规范来）。

// ================================================

// class IFU extends CyhCoreModule with HasResetVector {
//   val io = IO(new Bundle {
//     val out = (new CtrlFlowIO)
//   })

//   // pc 寄存器
//   val pc = RegInit(resetVector.U(VAddrBits.W))
//   val snpc = pc + 4.U // no compression inst, + 4 by default

// }
