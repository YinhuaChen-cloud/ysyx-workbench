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
    val out  = Decoupled(new CtrlFlowIO)

    val redirect = Flipped(new RedirectIO) // 用来支持 branch, jmp 等指令的
  })

  // pc
  val pc_reg = RegInit(resetVector.U(PC_LEN.W)) // TODO：果壳里，PC寄存器的长度是39
  val bpu = Module(new BPU)
  bpu.io.instr := io.imem.resp.rdata(INST_LEN-1, 0) // imem.resp.rdata 是从 imem 中读取的真正的指令
  // 每次遇到控制冒险，需要生成两个气泡，使用计数器来计气泡的数量
  val (counterValue, whatever) = Counter(true.B, 2)
  val isNOP = RegInit(false.B)
  // 如果当前取到的指令是 branch/jmp，那么isNOP置 1，它会在下一周期为1，表示下一条指令是NOP
  isNOP := Mux(bpu.io.isBranchJmp & !isNOP, true.B, false.B)

  // io.redirect.valid, io.redirect.target 需要在第二拍才能计算出来
  // 思路：实现一个小译码，判断当前读到的指令（发送给下一级的指令）是否是branch指令（jmp属于无条件跳转指令）
  // 如果是branch，则阻塞流水线(pc不变，下一周期发送NOP)，直到io.redirect.valid为true，并且取用io.redirect.target
  // 如果是jmp，也是阻塞流水线(pc不变，下一周期发送NOP)，...... TODO：无条件跳转指令应该能进一步优化
  // 如果不是，就 PC + 4
  // 如果这一周期 bpu.io.isBranchJmp 为真，说明下一周期不需要取指令（发出NOP）, 等待ALU计算redirect结果，再更新
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
  // 如果发现 isNOP = true.B，说明这一回合应该发送气泡指令，而非真正的指令，真正的指令需要保留一回合
  io.out.bits.instr := Mux(isNOP, Instructions.NOP, io.imem.resp.rdata)(INST_LEN-1, 0)
  io.out.bits.pc    := pc_reg

// handshake ------------------------------------------------

  val rst = Wire(Bool())
  rst := reset
  io.out.valid := !rst // 目前，IFU只要不是reset，它的输出结果就是有效的

// --- Jump wire of inst to ALU, for calculating next_pc in time ---

  Debug("In IFU, The inst read is 0x%x", io.imem.resp.rdata)

}
