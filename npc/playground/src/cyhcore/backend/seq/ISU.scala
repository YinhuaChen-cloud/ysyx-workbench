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

  // 寄存器堆，
  val rf = new RegFile

  // write rf
  when (io.wb.rfWen) { rf.write(io.wb.rfDest, io.wb.rfData) }

  // 计分板，用来处理数据冒险
  val sb = new ScoreBoard
  val src1Ready = !sb.isBusy(rfSrc1)
  val src2Ready = !sb.isBusy(rfSrc2)

// out(DecodeIO) -------------------------------------- cf(CtrlFlowIO)
//   val instr = Output(UInt(64.W))
//   val pc = Output(UInt(VAddrBits.W))
//   val redirect = new RedirectIO  // TODO: 我猜测这个应该是用来处理跳转指令的

  io.in.bits.cf <> io.out.cf

// out(DecodeIO) -------------------------------------- ctrl(CtrlSignalIO)
//   val src1Type = Output(SrcType())
//   val src2Type = Output(SrcType())
//   val fuType = Output(FuType())
//   val fuOpType = Output(FuOpType())
//   val rfSrc1 = Output(UInt(5.W))     // 来自 Decoder 的 rf1 addr
//   val rfSrc2 = Output(UInt(5.W))     // 来自 Decoder 的 rf2 addr
//   val rfWen = Output(Bool())         // 是否写入寄存器
//   val rfDest = Output(UInt(5.W))     // 写入的目标寄存器的 addr

  io.out.ctrl <> io.in.bits.ctrl

// out(DecodeIO) -------------------------------------- data(DataSrcIO)
//   val src1 = Output(UInt(XLEN.W))
//   val src2 = Output(UInt(XLEN.W))
//   val imm  = Output(UInt(XLEN.W))

  val rfSrc1 = io.in.bits.ctrl.rfSrc1
  val rfSrc2 = io.in.bits.ctrl.rfSrc2
  val rfDest = io.in.bits.ctrl.rfDest

  io.out.data.src1 := Mux1H(List(
    (io.in.bits.ctrl.src1Type === SrcType.pc)                                            -> SignExt(io.in.bits.cf.pc, PC_LEN), // TODO: 为什么用 pc 作为src1要进行有符号扩展？ 为什么不是无符号扩展？
    // src1ForwardNextCycle                                                            -> io.forward.wb.rfData, //io.forward.wb.rfData,
    // (src1Forward && !src1ForwardNextCycle)                                          -> io.wb.rfData, //io.wb.rfData,
    // ((io.in.bits.ctrl.src1Type =/= SrcType.pc) && !src1ForwardNextCycle && !src1Forward) -> rf.read(rfSrc1)
    (io.in.bits.ctrl.src1Type =/= SrcType.pc)                                            -> rf.read(rfSrc1)
  ))

  io.out.data.src2 := Mux1H(List(
    (io.in.bits.ctrl.src2Type =/= SrcType.reg)                                           -> io.in.bits.data.imm, // TODO: 为什么我们仍然需要 io.out.data.imm 端口？
    // src2ForwardNextCycle                                                             -> io.forward.wb.rfData, //io.forward.wb.rfData,
    // (src2Forward && !src2ForwardNextCycle)                                           -> io.wb.rfData, //io.wb.rfData,
    // ((io.in.bits.ctrl.src2Type === SrcType.reg) && !src2ForwardNextCycle && !src2Forward) -> rf.read(rfSrc2)
    (io.in.bits.ctrl.src2Type === SrcType.reg)                                           -> rf.read(rfSrc2)
  ))

  io.out.data.imm  := io.in.bits.data.imm

// handshake ------------------------------------------ 
  
  io.in.ready  := DontCare
  // 默认ISU可以在一拍内完成工作，所以io.out.valid仅在 in.valid 且 src1 src2 都准备好时，才 valid
  io.out.valid := io.in(0).valid && src1Ready && src2Ready 

// for difftest ---------------------------------------

  BoringUtils.addSource(VecInit((0 to NRReg-1).map(i => rf.read(i.U))), "difftestRegs")

  Debug(p"In ISU data, ${io.out.data}")
  Debug(p"In ISU wb, ${io.wb}")
  Debug(p"In ISU ctrl, ${io.out.ctrl}")

}

