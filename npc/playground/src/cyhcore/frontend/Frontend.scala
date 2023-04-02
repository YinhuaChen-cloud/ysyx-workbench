package cyhcore

import chisel3._
import chisel3.util._

import bus.simplebus._
import utils._

// frontend = IFU + IDU
class Frontend extends CyhCoreModule {
  val io = IO(new Bundle {
    val imem  = new SimpleBusUC // 用来从 SRAM 读取指令的
    val out   = Decoupled(new DecodeIO) // 用来连接后端(EXU)的

    val redirect = Flipped(new RedirectIO) // 用来支持 branch, jmp 等指令的
  })

  val ifu  = Module(new IFU)
  val idu  = Module(new IDU)

  // 普通指令数据流 frontend -> backend
  io.imem <> ifu.io.imem
  // ifu.io.out <> idu.io.in
  PipelineConnect(ifu.io.out, idu.io.in) 

  idu.io.out <> io.out // 注意, io.out不用处理握手信号，idu内部已经处理了

  // 跳转指令支持 backend -> frontend
  io.redirect <> ifu.io.redirect

  // def PipelineConnect2[T <: Data](left: DecoupledIO[T], right: DecoupledIO[T],
  //   isFlush: Bool, entries: Int = 4, pipe: Boolean = false) = {
  //   right <> FlushableQueue(left, isFlush,  entries = entries, pipe = pipe)
  // }

  // PipelineConnect2(ifu.io.out, ibf.io.in, ifu.io.flushVec(0))
  // PipelineConnect(ibf.io.out, idu.io.in(0), idu.io.out(0).fire(), ifu.io.flushVec(1))
  // idu.io.in(1) := DontCare // 在没有多发射时，in1不连接有效的东西


}



