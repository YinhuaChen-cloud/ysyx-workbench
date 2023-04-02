package cyhcore

import chisel3._
import chisel3.util._
import chisel3.stage.ChiselStage

import bus.simplebus._
import utils._

class EXU extends CyhCoreModule {
  val io = IO(new Bundle {
    val in   = Flipped(Decoupled(new DecodeIO))
    val out  = Decoupled(new CommitIO)  // EXU把执行结果交给WBU的过程叫做 Commit
    val dmem = new SimpleBusUC
  })

  // 给从前端传来的 DataSrcIO 简短的别名，还有 CtrlSignalIO 简短的别名
  val src1 = io.in.bits.data.src1(XLEN-1,0)
  val src2 = io.in.bits.data.src2(XLEN-1,0)
  val imm  = io.in.bits.data.imm
  val (fuType, fuOpType) = (io.in.bits.ctrl.fuType, io.in.bits.ctrl.fuOpType)

  // fuValids 用来使能不同的功能单元
  val fuValids = Wire(Vec(FuType.num, Bool()))
  // 范围是 0 到 FuType.num-1
  (0 until FuType.num).map (i => fuValids(i) := (fuType === i.U))

  val alu = Module(new ALU)
  val aluOut = alu.access(valid = fuValids(FuType.alu), src1 = src1, src2 = src2, func = fuOpType)
  alu.io.cfIn := io.in.bits.cf
  alu.io.offset := io.in.bits.data.imm

  val lsu = Module(new LSU) 
  val lsuOut = lsu.access(valid = fuValids(FuType.lsu), src1 = src1, src2 = imm,  func = fuOpType)
  lsu.io.wdata := src2
  io.dmem <> lsu.io.dmem

  val mdu = Module(new MDU)
  val mduOut = mdu.access(src1 = src1, src2 = src2, func = fuOpType)

// out(CommitIO) ------------------------------------------ decode(DecodeIO)
  // val cf = new CtrlFlowIO
  // val ctrl = new CtrlSignalIO
  // val data = new DataSrcIO

  // io.in.bits.cf <> io.out.decode.cf  // TODO: 等下换成这种写法试试

  // Debug(p"---------------- In EXU, alu.io.redirect ${alu.io.redirect}")
  // Debug(p"---------------- In EXU, alu.io.redirect ${alu.io.redirect}")

  io.out.bits.decode := DontCare

  io.out.bits.decode.cf.pc := io.in.bits.cf.pc
  io.out.bits.decode.cf.instr := io.in.bits.cf.instr
  io.out.bits.decode.cf.redirect := alu.io.redirect

  io.out.bits.decode.ctrl <> io.in.bits.ctrl

// out(CommitIO) ------------------------------------------ commits( Output(Vec(FuType.num, UInt(XLEN.W))) )
  // val commits = Output(Vec(FuType.num, UInt(XLEN.W))) // EXU 四个功能单元的输出都在这里，让 WBU 挑选

  io.out.bits.commits := DontCare
  io.out.bits.commits(FuType.alu) := aluOut
  io.out.bits.commits(FuType.lsu) := lsuOut
  io.out.bits.commits(FuType.mdu) := mduOut
  // io.out.commits(FuType.csr) := csrOut

// handshake ------------------------------------------ 
  // 一个前提：所有时序电路，最早也是在下个时钟上升沿才会读取我们的输出
  // 因此，输出只要能在下个时钟上升沿之前准备好，就可以在下个时钟上升沿之前拉高valid（哪怕早于“数据真的准备好了”）

  // 执行单元与内存无关的操作可以在当拍弄完
  // (目前)读内存可以在valid为true的当时周期内把信号处理好，准备好输出
  // 写内存也可以在下一个时钟上升沿的时候写完，不妨碍下一次读内存（读内存也是在执行单元）
  // 所以，执行单元的 ready 永远为 true，valid则和输入的valid同步
  
  dontTouch(io.in.ready)
  io.in.ready  := true.B // DontCare
  io.out.valid := io.in.valid

  Debug(p"In EXU ctrl, ${io.in.bits.ctrl}")
  Debug(p"In EXU data, ${io.in.bits.data}")
  
}


