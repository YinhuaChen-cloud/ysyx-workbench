package cyhcore

import chisel3._
import chisel3.util._

import top.Settings
import bus.simplebus._
import utils._
import chisel3.util.experimental.BoringUtils

trait HasResetVector {
  val resetVector = Settings.getLong("ResetVector")
}

class IFU extends CyhCoreModule with HasResetVector {
  val io = IO(new Bundle {
    val imem = new SimpleBusUC
    val out  = new CtrlFlowIO

    val redirect = Flipped(new RedirectIO) // 用来支持 branch, jmp 等指令的
  })

  // pc
  val pc_reg = RegInit(resetVector.U(PC_LEN.W)) // TODO：果壳里，PC寄存器的长度是39
  val bpu = Module(new BPU)
  bpu.io.instr := io.imem.resp.rdata(INST_LEN-1, 0) // io.imem.resp.rdata 刚刚读入的指令

  // io.redirect.valid, io.redirect.target 需要在第二拍才能计算出来
  // 思路：实现一个小译码，判断当前读到的指令（发送给下一级的指令）是否是branch指令（jmp属于无条件跳转指令）
  // 如果是branch，则阻塞流水线，直到io.redirect.valid为true，并且取用io.redirect.target
  // 如果是jmp，也是阻塞流水线，...... TODO：无条件跳转指令应该能进一步优化
  // 如果不是，就 PC + 4
  pc_reg := Mux(bpu.io.isBranchJmp, Mux(io.redirect.valid, io.redirect.target, pc_reg), pc_reg + 4.U) 
  // pc_reg := Mux(io.redirect.valid, io.redirect.target, pc_reg) 
  // pc_reg := pc_reg + 4.U // TODO: 先不考虑跳转指令

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
  io.out.instr := Mux(bpu.io.isBranchJmp, Instructions.NOP, io.imem.resp.rdata)(INST_LEN-1, 0)
  io.out.pc    := pc_reg

// --- Jump wire of inst to ALU, for calculating next_pc in time ---

  BoringUtils.addSource(io.imem.resp.rdata, "real_inst2")

  Debug("In IFU, The inst read is 0x%x", io.imem.resp.rdata)

}
