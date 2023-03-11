package system

import chisel3._
import chisel3.util._

import cyhcore._
import bus.simplebus._

// SOC = Core + Cache + 总线 + 外设通信电路
// DRAM 一般独立出来，不算在 SOC 里面
class CyhSoc extends Module  {
  val io = IO(new Bundle{
    val imem = new SimpleBusUC 
  })

  val cyhcore = Module(new CyhCore)

}

