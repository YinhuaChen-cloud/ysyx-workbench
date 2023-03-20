package system

import chisel3._

import cyhcore._
import device._
import utils._

// 目前的设备有：
// 1. SRAM
// 2. DRAM
class top extends Module {

  val io = IO(new Bundle {
  })

	// device: AXI4SRAM -- for inst reading
  val axi4sram = Module(new AXI4SRAM)
	// device: AXI4DRAM -- for sd, ld instructions
  val axi4dram = Module(new AXI4DRAM)
  // CyhSoC   SOC = Core + Cache + 总线 + 外设通信电路
  val cyhsoc   = Module(new CyhSoc)

  // SRAM -> SOC <-> DRAM
  cyhsoc.io.imem <> axi4sram.io.imem
  cyhsoc.io.dmem <> axi4dram.io.dmem

}

