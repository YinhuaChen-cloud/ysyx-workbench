package cyhcore

import chisel3._
import chisel3.util._

import utils._

class ISU extends CyhCoreModule with HasRegFileParameter {
  val io = IO(new Bundle {
    val in = Flipped(new DecodeIO) // make in-order backend compatible with high performance frontend  TODO: how? (make in-order backend compatible with high performance frontend)  
    val wb = Flipped(new WriteBackIO)
    val out = new DecodeIO
  })

  val rf = new RegFile

  // write rf
  when (io.wb.rfWen) { rf.write(io.wb.rfDest, io.wb.rfData) }
  
}

