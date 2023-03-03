package cyhcore

import chisel3._
import chisel3.util._
import Conf._
import top.Settings

trait HasResetVector {
  val resetVector = Settings.getLong("ResetVector")
}

class IFU_to_EXU (implicit val conf: Configuration) extends Bundle() {
  val pc_next = Input(UInt(conf.pc_len.W))
  val pc      = Output(UInt(conf.pc_len.W))
}

class IFU (implicit val conf: Configuration) extends Module {
  val io = IO(new IFU_to_EXU())

  val pc_reg = RegInit(conf.START_ADDR)
  pc_reg := io.pc_next
  io.pc  := pc_reg

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
// 跳转到读请求状态，产生并发送读请求（ar-valid）、读地址（ar-addr）、读字节数（ar-size）、读个数（ar-len），

// 本次总线支持的宽度是8 Byte，所以如果不是突发传输（burst），一次只能读写8 Byte。

// 3. 当从机（slave）接收到读请求（ar-valid）且处于空闲状态则产生返还给主机（master）读准备(ar-ready)信号
// 表明可以进行读取操作，这时就完成了一次读地址的握手，
// 4. 从机（slave）开始准备需要返回的数据（r-data）、读返回请求（r-valid）、读完成（r-last），
// 5. 主机此时也跳变到下一个读数据状态，产生并发出可以读取返回数据的状态读准备（r-ready），当主机的r-valid & r-ready
// 完成握手，主机得到需要的数据（r-data），
// 6. 当主机接收到读完成（r-last）则完成了一次读事务同时状态跳变到空闲状态，并且产生读完成信号（ready），
// 将指令数据（inst）返还给取指模块（IF）。

// ================================================

// class IFU extends CyhCoreModule with HasResetVector {
//   val io = IO(new Bundle {
//     val out = (new CtrlFlowIO)
//   })

//   // pc 寄存器
//   val pc = RegInit(resetVector.U(VAddrBits.W))
//   val snpc = pc + 4.U // no compression inst, + 4 by default

// }
