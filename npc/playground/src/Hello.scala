/*
 * This code is a minimal hardware described in Chisel.
 * 
 * Blinking LED: the FPGA version of Hello World
 */

import chisel3._

/**
 * The blinking LED component.
 */

class Hello extends Module {
  val io = IO(new Bundle {
    val led = Output(UInt(1.W))
  })
  val CNT_MAX = (50000000 / 2 - 1).U // a defined constant

  val cntReg = RegInit(0.U(32.W)) // define a reg
  val blkReg = RegInit(0.U(1.W)) // define another reg

  cntReg := cntReg + 1.U // cntReg + 1 for every cycle
  when(cntReg === CNT_MAX) {
    cntReg := 0.U
    blkReg := ~blkReg
  }
  io.led := blkReg
}

/**
 * An object extending App to generate the Verilog code.
 */
object Hello extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new Hello())
}
