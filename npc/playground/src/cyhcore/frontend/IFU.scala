package cyhcore

import chisel3._
import chisel3.util._
import top.Settings
import bus.axi4.AXI4Lite

trait HasResetVector {
  val resetVector = Settings.getLong("ResetVector")
}

class IFU_to_EXU extends CyhCoreBundle() {
  val pc_next = Input(UInt(PC_LEN.W))
  val pc      = Output(UInt(PC_LEN.W))
}

// map函数中，参数为 _ 是什么意思？ 回答：通常用来表示对输入集合中每个元素的操作
object MaskExpand {
  // 假如 m 为 0x0f, 则 m.asBools = Vec(4x false, 4x true), m.asBools.map(Fill(8, _)) = Vec(8个0， 8个0, ..., 8个1， 8个1)。 加上reverse = Vec(8个1， 8个1, ..., 8个0， 8个0)
  // def apply(m: UInt) = Cat(m.asBools.map(Fill(8, _)))
  def apply(m: UInt) = Cat(m.asBools)
}

class IFU extends CyhCoreModule with HasResetVector {
  val io = IO(new IFU_to_EXU())

  val pc_reg = RegInit(resetVector.U(PC_LEN.W)) // TODO：果壳里，PC寄存器的长度是39
  pc_reg := io.pc_next
  io.pc  := pc_reg

  val fullMask = MaskExpand(0x0f.U(8.W)) // 从小 strb 获取 fullMask
  printf("fullMask = 0x%x\n", fullMask)

}

// class IFUnew extends CyhCoreModule with HasResetVector { // 先写从机
//   val io = IO(new AXI4Lite())

//   val pc_reg = RegInit(resetVector.U(PC_LEN.W)) // TODO：果壳里，PC寄存器的长度是39
//   pc_reg := io.pc_next
//   io.pc  := pc_reg

// }

// class IFUnew extends CyhCoreModule with HasResetVector {
//   val io = IO(new AXI4Lite())

//   val pc_reg = RegInit(resetVector.U(XLEN.W)) // TODO：果壳这里长度是39位
//   pc_reg := io.pc_next
//   io.pc  := pc_reg

// }

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
// 跳转到读请求状态，产生并发送读请求（ar-valid）、读地址（ar-addr）、读字节数（ar-size）、读个数（ar-len），

// 本次总线支持的宽度是8 Byte，所以如果不是突发传输（burst），一次只能读写8 Byte。

// 先写从机

// 3. 当从机（slave）接收到读请求（ar-valid）且处于空闲状态则产生返还给主机（master）读准备(ar-ready)信号
// 表明可以进行读取操作，这时就完成了一次读地址的握手，
// 4. 从机（slave）开始准备需要返回的数据（r-data）、读返回请求（r-valid）、读完成（r-last），
// 5. 主机此时也跳变到下一个读数据状态，产生并发出可以读取返回数据的状态读准备（r-ready），当主机的r-valid & r-ready
// 完成握手，主机得到需要的数据（r-data），
// 6. 当主机接收到读完成（r-last）则完成了一次读事务同时状态跳变到空闲状态，并且产生读完成信号（ready），
// 将指令数据（inst）返还给取指模块（IF）。

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
