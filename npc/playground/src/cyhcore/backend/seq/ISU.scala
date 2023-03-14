package cyhcore

import chisel3._
import chisel3.util._

import utils._
import sim.DiffTest

class ISU extends CyhCoreModule with HasRegFileParameter {
  val io = IO(new Bundle {
    val in = Flipped(new DecodeIO) // make in-order backend compatible with high performance frontend  TODO: how? (make in-order backend compatible with high performance frontend)  
    val wb = Flipped(new WriteBackIO)
    val out = new DecodeIO
  })

  val rf = new RegFile
  // difftest ------------------- start TODO: 这个东西后面应该会被 remove 掉
  val difftest = new DiffTest
  difftest.io.clk := clock
  difftest.io.rst := reset
  val rf_aux = Wire(Vec(NRReg * XLEN, Bool()))
  for(i <- 0 until NRReg) {
    rf_aux.slice(i * XLEN, (i+1) * XLEN).zip(rf.rf(i).asBools).foreach{case (a, b) => a := b}
  }
  difftest.io.regfile := rf_aux.asUInt
  // difftest ------------------- end

  // write rf
  when (io.wb.rfWen) { rf.write(io.wb.rfDest, io.wb.rfData) }

// out(DecodeIO) -------------------------------------- cf(CtrlFlowIO)
//   val instr = Output(UInt(64.W))
//   val pc = Output(UInt(VAddrBits.W))
//   val redirect = new RedirectIO  // TODO: 我猜测这个应该是用来处理跳转指令的

  io.in.cf <> io.out.cf

// out(DecodeIO) -------------------------------------- ctrl(CtrlSignalIO)
//   val src1Type = Output(SrcType())
//   val src2Type = Output(SrcType())
//   val fuType = Output(FuType())
//   val fuOpType = Output(FuOpType())
//   val rfSrc1 = Output(UInt(5.W))     // 来自 Decoder 的 rf1 addr
//   val rfSrc2 = Output(UInt(5.W))     // 来自 Decoder 的 rf2 addr
//   val rfWen = Output(Bool())         // 是否写入寄存器
//   val rfDest = Output(UInt(5.W))     // 写入的目标寄存器的 addr

  io.out.ctrl <> io.in.ctrl

// out(DecodeIO) -------------------------------------- data(DataSrcIO)
//   val src1 = Output(UInt(XLEN.W))
//   val src2 = Output(UInt(XLEN.W))
//   val imm  = Output(UInt(XLEN.W))

  val rfSrc1 = io.in.ctrl.rfSrc1
  val rfSrc2 = io.in.ctrl.rfSrc2
  val rfDest = io.in.ctrl.rfDest

  io.out.data.src1 := Mux1H(List(
    (io.in.ctrl.src1Type === SrcType.pc)                                            -> SignExt(io.in.cf.pc, PC_LEN), // TODO: 为什么用 pc 作为src1要进行有符号扩展？ 为什么不是无符号扩展？
    // src1ForwardNextCycle                                                            -> io.forward.wb.rfData, //io.forward.wb.rfData,
    // (src1Forward && !src1ForwardNextCycle)                                          -> io.wb.rfData, //io.wb.rfData,
    // ((io.in.ctrl.src1Type =/= SrcType.pc) && !src1ForwardNextCycle && !src1Forward) -> rf.read(rfSrc1)
    (io.in.ctrl.src1Type =/= SrcType.pc)                                            -> rf.read(rfSrc1)
  ))

  io.out.data.src2 := Mux1H(List(
    (io.in.ctrl.src2Type =/= SrcType.reg)                                           -> io.in.data.imm, // TODO: 为什么我们仍然需要 io.out.data.imm 端口？
    // src2ForwardNextCycle                                                             -> io.forward.wb.rfData, //io.forward.wb.rfData,
    // (src2Forward && !src2ForwardNextCycle)                                           -> io.wb.rfData, //io.wb.rfData,
    // ((io.in.ctrl.src2Type === SrcType.reg) && !src2ForwardNextCycle && !src2Forward) -> rf.read(rfSrc2)
    (io.in.ctrl.src2Type === SrcType.reg)                                           -> rf.read(rfSrc2)
  ))

  io.out.data.imm  := io.in.data.imm

}

