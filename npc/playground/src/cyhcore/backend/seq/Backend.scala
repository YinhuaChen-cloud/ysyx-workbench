package cyhcore

import chisel3._
import chisel3.util._

import utils._

class Backend extends CyhCoreModule {
  val io = IO(new Bundle {
    val in = Flipped(new DecodeIO)
  })

  // 根据果壳的代码，后端单元顺序应该如下
  val isu  = Module(new ISU) // 发射队列，目前只是用于存放 regfile，以及负责regfile的读写
  val exu = Module(new EXU)
  val wbu  = Module(new WBU)

  // 一个环 io -> isu -> exu -> wbu
  //               ^             |
  //               |             |
  //               |-------------|
  io.in <> isu.io.in
  isu.io.out <> exu.io.in
  exu.io.out <> wbu.io.in
  wbu.io.wb  <> isu.io.wb
  
  // PipelineConnect(isu.io.out, exu.io.in, exu.io.out.fire(), io.flush(0))
  // PipelineConnect(exu.io.out, wbu.io.in, true.B, io.flush(1))

  Debug(p"In Backend data, ${io.in.data}")
  Debug(p"In Backend ctrl, ${io.in.ctrl}")

}

