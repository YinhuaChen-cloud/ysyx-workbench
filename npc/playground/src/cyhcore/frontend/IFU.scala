package cyhcore

import chisel3._
import chisel3.util._
import Conf._

class IFU_to_EXU (implicit val conf: Configuration) extends Bundle() {
  val pc_next = Input(UInt(conf.pc_len.W))
  val pc      = Output(UInt(conf.pc_len.W))
}

// 1. 用RTL编写一个AXI-Lite的SRAM模块, 地址位宽为32bit, 数据位宽为64bit
// 2. 收到读请求后, 通过DPI-C调用pmem_read(), 并延迟一周期返回读出的数据
    // IFU每次取指都要等待一个周期, 才能取到指令交给IDU

class IFU (implicit val conf: Configuration) extends Module {
  val io = IO(new IFU_to_EXU())

  val pc_reg = RegInit(conf.START_ADDR)
  pc_reg := io.pc_next
  io.pc  := pc_reg

}
