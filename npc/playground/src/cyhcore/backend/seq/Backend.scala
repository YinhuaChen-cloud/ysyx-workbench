package cyhcore

import chisel3._
import chisel3.util._

import bus.simplebus._
import utils._

class Backend extends CyhCoreModule {
  val io = IO(new Bundle {
    val in = Flipped(Decoupled(new DecodeIO))
    val redirect = new RedirectIO // 用来支持 branch, jmp 等指令的
    val dmem = new SimpleBusUC
  })

  // 根据果壳的代码，后端单元顺序应该如下
  val isu = Module(new ISU) // 发射队列，目前只是用于存放 regfile，以及负责regfile的读写
  val exu = Module(new EXU)
  val wbu = Module(new WBU)

  // 一个环 io -> isu -> exu -> wbu
  //               ^             |
  //               |             |
  //               |-------------|
  isu.io.in <> io.in

  PipelineConnect(isu.io.out, exu.io.in)
  // exu.io.in <> isu.io.out 

  // PipelineConnect(exu.io.out, wbu.io.in, io.in.valid)
  wbu.io.in <> exu.io.out 

  isu.io.wb <> wbu.io.wb  

  // PipelineConnect(isu.io.out, exu.io.in, exu.io.out.fire(), io.flush(0))
  // PipelineConnect(exu.io.out, wbu.io.in, true.B, io.flush(1))

  // 跳转指令支持(EXU决定跳转指令的target，随后连线到 WBU, WBU再决定跳转指令的写入时机(valid))
  dontTouch(exu.io.out.decode.cf.redirect)
  dontTouch(wbu.io.redirect)
  io.redirect <> wbu.io.redirect

  // 内存读写支持（使用总线）
  io.dmem <> exu.io.dmem

  // 临时valid
  wbu.io.valid := isu.io.out.valid
  
  Debug(p"In Backend data, ${io.in.bits.data}")
  Debug(p"In Backend ctrl, ${io.in.bits.ctrl}")

}

