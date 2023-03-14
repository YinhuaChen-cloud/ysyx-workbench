package cyhcore

import chisel3._
import chisel3.util._

class Backend extends CyhCoreModule {
  val io = IO(new Bundle {
    val in = Flipped(new DecodeIO)
  })

  val exu = Module(new EXU)
  val wbu  = Module(new WBU)
  val isu  = Module(new ISU) // 发射队列，目前只是用于存放 regfile，以及负责regfile的读写

  io.in <> exu.io.in
  exu.io.out <> wbu.io.in
  wbu.io.wb <> isu.io.wb
  

  // PipelineConnect(isu.io.out, exu.io.in, exu.io.out.fire(), io.flush(0))
  // PipelineConnect(exu.io.out, wbu.io.in, true.B, io.flush(1))

}

