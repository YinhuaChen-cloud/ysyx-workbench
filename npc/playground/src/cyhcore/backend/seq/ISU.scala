package cyhcore

import chisel3._
import chisel3.util._

import utils._
import sim.DiffTest
import chisel3.util.experimental.BoringUtils

class ISU extends CyhCoreModule with HasRegFileParameter {
  val io = IO(new Bundle {
    val in  = Flipped(Decoupled(new DecodeIO)) // make in-order backend compatible with high performance frontend  TODO: how? (make in-order backend compatible with high performance frontend)  
    val wb  = Flipped(new WriteBackIO)
    val out = Decoupled(new DecodeIO)
  })

  // 简化命名(都是in，不是out)
  val rfSrc1 = io.in.bits.ctrl.rfSrc1 
  val rfSrc2 = io.in.bits.ctrl.rfSrc2
  val rfDest = io.in.bits.ctrl.rfDest
  val rfWen  = io.in.bits.ctrl.rfWen

  // 寄存器堆
  val rf = new RegFile
  // write rf
  when (io.wb.rfWen) { rf.write(io.wb.rfDest, io.wb.rfData) }

  // 计分板（处理数据冒险如RAW）
  val sb = new ScoreBoard
  val src1Ready = !sb.isBusy(rfSrc1)
  val src2Ready = !sb.isBusy(rfSrc2)
  // 当IDU发现要写入某个寄存器时，把 busy(x) = 1
  val idSetMask   = Mux(io.in.valid & rfWen & src1Ready & src2Ready, sb.mask(rfDest), 0.U)
  // 当WBU完成写入某个寄存器时，把 busy(x) = 0
  val wbClearMask = Mux(io.wb.rfWen, sb.mask(io.wb.rfDest), 0.U(NRReg.W))
  // 每周期更新一遍busy数组(关于enable/disable，已经暗含在 idSetMask 和 wbClearMask里了)
  sb.update(idSetMask, wbClearMask)
  // 光有 busy 是不够的，因为有可能当前指令和上一条指令要写入同一个寄存器，这会导致连续busy，
  // src1Ready连续为false(哪怕上一条指令已经成功将结果写入寄存器)
  // 但是我们知道，只要等待一个周期，就一定能等到寄存器被写入
  // 使用一个标记寄存器wati_a_cycle，当它为false的时候，表示无需等待，src1/2操作数都没有冲突
  // 当它为true时，表示正在等待一个周期，因为src1/src2操作数有冲突
  // val wait_a_cycle = RegInit(false.B)
  // wait_a_cycle := Mux(wait_a_cycle, false.B, sb.isBusy(rfSrc1) || sb.isBusy(rfSrc2)) // 等待一个周期，就能等到寄存器被写入
  // val src1Ready = !sb.isBusy(rfSrc1) || (idSetMask === wbClearMask && idSetMask =/= 0.U)
  // val src2Ready = !sb.isBusy(rfSrc2) || (idSetMask === wbClearMask && idSetMask =/= 0.U)


// out(DecodeIO) -------------------------------------- cf(CtrlFlowIO)
//   val instr = Output(UInt(64.W))
//   val pc = Output(UInt(VAddrBits.W))
//   val redirect = new RedirectIO  // TODO: 我猜测这个应该是用来处理跳转指令的

  io.in.bits.cf <> io.out.bits.cf

// out(DecodeIO) -------------------------------------- ctrl(CtrlSignalIO)
//   val src1Type = Output(SrcType())
//   val src2Type = Output(SrcType())
//   val fuType = Output(FuType())
//   val fuOpType = Output(FuOpType())
//   val rfSrc1 = Output(UInt(5.W))     // 来自 Decoder 的 rf1 addr
//   val rfSrc2 = Output(UInt(5.W))     // 来自 Decoder 的 rf2 addr
//   val rfWen = Output(Bool())         // 是否写入寄存器
//   val rfDest = Output(UInt(5.W))     // 写入的目标寄存器的 addr

  io.out.bits.ctrl <> io.in.bits.ctrl

// out(DecodeIO) -------------------------------------- data(DataSrcIO)
//   val src1 = Output(UInt(XLEN.W))
//   val src2 = Output(UInt(XLEN.W))
//   val imm  = Output(UInt(XLEN.W))

  io.out.bits.data.src1 := Mux1H(List(
    (io.in.bits.ctrl.src1Type === SrcType.pc)                                            -> SignExt(io.in.bits.cf.pc, PC_LEN), // TODO: 为什么用 pc 作为src1要进行有符号扩展？ 为什么不是无符号扩展？
    // src1ForwardNextCycle                                                            -> io.forward.wb.rfData, //io.forward.wb.rfData,
    // (src1Forward && !src1ForwardNextCycle)                                          -> io.wb.rfData, //io.wb.rfData,
    // ((io.in.bits.ctrl.src1Type =/= SrcType.pc) && !src1ForwardNextCycle && !src1Forward) -> rf.read(rfSrc1)
    (io.in.bits.ctrl.src1Type =/= SrcType.pc)                                            -> rf.read(rfSrc1)
  ))

  io.out.bits.data.src2 := Mux1H(List(
    (io.in.bits.ctrl.src2Type =/= SrcType.reg)                                           -> io.in.bits.data.imm, // TODO: 为什么我们仍然需要 io.out.bits.data.imm 端口？
    // src2ForwardNextCycle                                                             -> io.forward.wb.rfData, //io.forward.wb.rfData,
    // (src2Forward && !src2ForwardNextCycle)                                           -> io.wb.rfData, //io.wb.rfData,
    // ((io.in.bits.ctrl.src2Type === SrcType.reg) && !src2ForwardNextCycle && !src2Forward) -> rf.read(rfSrc2)
    (io.in.bits.ctrl.src2Type === SrcType.reg)                                           -> rf.read(rfSrc2)
  ))

  io.out.bits.data.imm  := io.in.bits.data.imm

// handshake ------------------------------------------ 
  
  // ready什么时候为false? 当 ISU 并没有处理好当下的数据，无法接收新数据的时候
  // 当 io.in.valid = true && !io.out.fire 时，就是没有处理好当下数据的时候
  // 把上面这个表达式取反，就是ready取true的时候，即 (!io.in.valid) || io.out.fire
  io.in.ready  := !io.in.valid || io.out.fire
  io.out.valid := io.in.valid && src1Ready && src2Ready

// for difftest ---------------------------------------

  BoringUtils.addSource(VecInit((0 to NRReg-1).map(i => rf.read(i.U))), "difftestRegs")

  Debug(p"In ISU data, ${io.out.bits.data}")
  Debug(p"In ISU wb, ${io.wb}")
  Debug(p"In ISU ctrl, ${io.out.bits.ctrl}")

}

// 在检测到流水线存在指令相关性冲突后，我们要如何解决这个问题呢？答案是流水线阻塞。这里介绍一个流水线阻塞的实现思路。
// 假设我们要阻塞执行级，也是说执行级、译码级和取指级“停住”，访存级和写回级可以继续“流动”。要实现这个效果需要：

// MEM reg的valid的输入为false，其他级的流水线寄存器的valid的输入为上一级的流水线寄存器的valid的输出。
// ID reg和EXE reg的enable置为false，MEM reg和WB reg的enable置为true。

// 如果你对此感到疑惑，你可以通过打草稿的方式来进行验证。回到最开始的问题，我们如何解决指令相关性冲突？
// 答案是当检测到存在指令相关性冲突时我们需要阻塞译码级直到相关性冲突消失。

