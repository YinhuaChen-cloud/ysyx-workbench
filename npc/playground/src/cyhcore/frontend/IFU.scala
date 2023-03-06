package cyhcore

import chisel3._
import chisel3.util._
import top.Settings
import bus.axi4.AXI4Lite
import bus.axi4.AXI4

trait HasResetVector {
  val resetVector = Settings.getLong("ResetVector")
}

class IFU_to_EXU extends CyhCoreBundle() {
  val pc_next = Input(UInt(PC_LEN.W))
  val pc      = Output(UInt(PC_LEN.W))
}

class IFU extends CyhCoreModule with HasResetVector {
  val io = IO(new IFU_to_EXU())

  val pc_reg = RegInit(resetVector.U(PC_LEN.W)) // TODO：果壳里，PC寄存器的长度是39
  pc_reg := io.pc_next
  io.pc  := pc_reg
}

// 完成一次指令读取
// 通过上面的资料学习，相信你已经对总线有一个大概的了解，现在我们来整理一次完整的指令读取的过程
// （当然如果基础够好的同学可以直接实现AXI4的读写过程）。
// 指令读取过程：
// 1. 我们的取指级（IF）应该发出取指信号，包括读请求（valid）和读地址（pc），
// 2. 这时AXI模块应该收到取指级的信号，如果AXI模块处于空闲状态, 则对本次读请求做出响应，AXI内部状态由空闲
// 跳转到读请求状态，产生并发送读请求（ar-valid）、读地址（ar-addr）、
// 读字节数（ar-size）、读个数（ar-len）， ------------------ 这两个不属于 AXILite，暂时不管

class IFUnew extends CyhCoreModule with HasResetVector {
  val io = IO(new AXI4Lite()) // AXI4Lite 默认接Master端

  val idle :: reading_request :: Nil = Enum(2)
  val state  = RegInit(idle)

  val pc_reg = RegInit(resetVector.U(PC_LEN.W)) // TODO：果壳里，PC寄存器的长度是39, 我们这里使用 XLEN，即64

  // 1. 我们的取指级（IF）应该发出取指信号，包括读请求（valid）和读地址（pc），
  io.ar.valid := true.B
  io.ar.bits.addr  := pc_reg
  // 2. 这时AXI模块应该收到取指级的信号，如果AXI模块处于空闲状态, 则对本次读请求做出响应，AXI内部状态由空闲
  // 跳转到读请求状态，产生并发送读请求（ar-valid）、读地址（ar-addr）、
  // when(state === idle) {
  //   state := reading_request TODO: we are here
  // } .otherwise {
  // }

  // pc_reg := io.pc_next
  // io.pc  := pc_reg
}

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

// 先写从机 ---- Look here!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

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
