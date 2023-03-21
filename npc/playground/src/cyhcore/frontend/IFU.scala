package cyhcore

import chisel3._
import chisel3.util._

import top.Settings
import bus.simplebus._
import utils._

trait HasResetVector {
  val resetVector = Settings.getLong("ResetVector")
}

class IFU extends CyhCoreModule with HasResetVector {
  val io = IO(new Bundle {
    val imem = new SimpleBusUC
    val out  = new CtrlFlowIO

    val redirect = Flipped(new RedirectIO) // 用来支持 branch, jmp 等指令的
  })

  val pc_reg = RegInit(resetVector.U(PC_LEN.W)) // TODO：果壳里，PC寄存器的长度是39

  dontTouch(io.redirect.target)
  dontTouch(io.redirect.valid)
  // pc_reg := Mux(io.redirect.valid, io.redirect.target, pc_reg)
  pc_reg := pc_reg + 4.U // TODO: 先不考虑跳转指令

// imem(SimpleBusUC) ------------------------------------ req(SimpleBusReqBundle)
  // val addr = Output(UInt(PAddrBits.W)) // 访存地址（位宽与体系结构实现相关）, 默认 32 位

  io.imem.req       := DontCare
  io.imem.req.addr  := pc_reg
  io.imem.req.cmd   := SimpleBusCmd.read

// out(CtrlFlowIO) ------------------------------------------ 
  // val instr = Output(UInt(64.W))
  // val pc = Output(UInt(VAddrBits.W))
  // val redirect = new RedirectIO  

  io.out       := DontCare
  // io.out.instr := io.imem.resp.rdata
  io.out.instr := Instructions.NOP
  io.out.pc    := pc_reg

  Debug("In IFU, The inst read is 0x%x", io.imem.resp.rdata)

}
