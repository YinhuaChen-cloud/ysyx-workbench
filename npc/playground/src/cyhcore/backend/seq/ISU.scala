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

  // 简化命名(都是in，没有out)
  val rfSrc1 = io.in.bits.ctrl.rfSrc1 
  val rfSrc2 = io.in.bits.ctrl.rfSrc2
  val rfDest = io.in.bits.ctrl.rfDest
  val rfWen  = io.in.bits.ctrl.rfWen

  // 寄存器堆
  val rf = new RegFile
  // write rf
  when (io.wb.rfWen) { rf.write(io.wb.rfDest, io.wb.rfData) }

  // 计分板（处理数据冒险如RAW）
  // 考虑这两条连续的指令
  // auipc   sp,0x9
  // addi    sp,sp,-4 # 80009000 <_end>
  val sb = new ScoreBoard
  val src1Ready = !sb.isBusy(rfSrc1)
  val src2Ready = !sb.isBusy(rfSrc2)
  // 当IDU发现要写入某个寄存器时，把 busy(x) = 1
  // 为了处理上述连续两条指令的情景，在给 busy(x) 置位为1之前还要等待 src1Ready 和 src2Ready 为1，放置目标寄存器和源寄存器是同一个
  val idSetMask   = Mux(io.in.valid & rfWen & src1Ready & src2Ready, sb.mask(rfDest), 0.U)
  // 当WBU完成写入某个寄存器时，把 busy(x) = 0
  val wbClearMask = Mux(io.wb.rfWen, sb.mask(io.wb.rfDest), 0.U(NRReg.W))
  // 每周期更新一遍busy数组(关于enable/disable，已经暗含在 idSetMask 和 wbClearMask里了)
  sb.update(idSetMask, wbClearMask)
  // 当 !src1Ready || !src2Ready 时，说明需要阻塞(除了WBU，都阻塞1周期)
  val RAWhazard = !src1Ready || !src2Ready
  dontTouch(RAWhazard)
  BoringUtils.addSource(RAWhazard, "RAWhazard")

  // Debug之用 TODO: 后边可以去掉
  val HazardPC = WireInit(0.U(PC_LEN.W))
  HazardPC := io.out.bits.cf.pc
  BoringUtils.addSource(HazardPC, "HazardPC")

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
  
  io.in.ready  := DontCare
  io.out.valid := io.in.valid

// for difftest ---------------------------------------

  BoringUtils.addSource(VecInit((0 to NRReg-1).map(i => rf.read(i.U))), "difftestRegs")

  Debug(p"In ISU data, ${io.out.bits.data}")
  Debug(p"In ISU wb, ${io.wb}")
  Debug(p"In ISU ctrl, ${io.out.bits.ctrl}")

}

