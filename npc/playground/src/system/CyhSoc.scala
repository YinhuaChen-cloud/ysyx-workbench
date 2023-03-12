package system

import chisel3._
import chisel3.util._

import cyhcore._
import bus.simplebus._
import device._

// SOC = Core + Cache + 总线 + 外设通信模块(包括内存)
// DRAM 一般独立出来，不算在 SOC 里面
// 这里我们先把 SRAM 也独立出去，后边把 SRAM 当 cache 再弄回来
// 目前的设备有：
// 1. SRAM
// 2. DRAM
class CyhSoc extends Module  {
  val io = IO(new Bundle{
    val imem = new SimpleBusUC 
    val mem  = new SimpleBusUC
  })

  val cyhcore  = Module(new CyhCore)  // Core

  io.imem <> cyhcore.io.imem // TODO: 这里可能会有 bug? 
  // io.imem.req := cyhcore.imem.req
  // cyhcore.imem.resp := io.imem.resp

}


