package cyhcore

import chisel3._
import chisel3.util._

import top.Settings
import bus.simplebus._
import utils._

trait HasResetVector {
  val resetVector = Settings.getLong("ResetVector")
}

// class IFU_to_EXU extends CyhCoreBundle() { // TODO: 下一个步骤，让 IFU 获得指令，再交给 IDU/EXU
//   val pc_next  = Input(UInt(PC_LEN.W))
//   val pc       = Output(UInt(PC_LEN.W))
//   val inst = Output(UInt(INST_LEN.W))
// }

// class IFU_to_AXI4SRAM extends CyhCoreBundle() { // TODO: 下一个步骤，让 IFU 获得指令，再交给 IDU/EXU
//   val pc      = Output(UInt(PC_LEN.W))
//   val inst_in = Input(UInt(INST_LEN.W))
// }

// class IFU_bundle extends CyhCoreBundle() {
//   // val ifu_to_exu = new IFU_to_EXU()
//   val ifu_to_axi4sram = new IFU_to_AXI4SRAM()
// }

class IFU extends CyhCoreModule with HasResetVector {
  // val io = IO(new IFU_bundle())
  val io = IO(new Bundle {
    val imem = new SimpleBusUC
    val out  = new CtrlFlowIO

    val redirect = Flipped(new RedirectIO) // 用来支持 branch, jmp 等指令的
  })

  val pc_reg = RegInit(resetVector.U(PC_LEN.W)) // TODO：果壳里，PC寄存器的长度是39
  // val pcUpdate = io.redirect.valid // TODO: 谁 drive 这个信号？
  // val snpc = pc_reg + 4.U // static next pc
  // pc_reg := io.ifu_to_exu.pc_next
  // io.ifu_to_exu.pc  := pc_reg
  // io.ifu_to_axi4sram.pc  := pc_reg
  // io.ifu_to_exu.inst := io.ifu_to_axi4sram.inst_in
  // val dnpc = Mux(io.redirect.valid, io.redirect.target, snpc) // dynamic next pc

  pc_reg := Mux(io.redirect.valid, io.redirect.target, pc_reg)

// imem(SimpleBusUC) ------------------------------------ req(SimpleBusReqBundle)
  // val addr = Output(UInt(PAddrBits.W)) // 访存地址（位宽与体系结构实现相关）, 默认 32 位

  io.imem.req.addr  := pc_reg

// out(CtrlFlowIO) ------------------------------------------ 
  // val instr = Output(UInt(64.W))
  // val pc = Output(UInt(VAddrBits.W))
  // val redirect = new RedirectIO  // TODO: 我猜测这个应该是用来处理跳转指令的

  io.out       := DontCare
  io.out.instr := io.imem.resp.rdata
  io.out.pc    := pc_reg

  Debug("In IFU, The inst read is 0x%x", io.imem.resp.rdata)

}
