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

    // val pc = Input(UInt(XLEN.W))
    // val inst = Output(UInt(INST_LEN.W))

	// device: AXI4SRAM -- for inst reading
  val axi4sram = Module(new AXI4SRAM)
	// device: AXI4DRAM -- for sd, ld instructions
  val axi4dram = Module(new AXI4DRAM)
  // axi4dram.io.clk := clock
  // axi4dram.io.rst := reset
  // CyhSoC   SOC = Core + Cache + 总线 + 外设通信电路
  val cyhsoc   = Module(new CyhSoc)

  // SRAM -> SOC <-> DRAM
  cyhsoc.io.imem <> axi4sram.io.imem
  cyhsoc.io.dmem <> axi4dram.io.dmem

  // // submodule1 IFU
  // val ifu = Module(new IFU)
	// // submodule2: IDU
  // val idu = Module(new IDU)
	// // submodule3: EXU
  // val exu = Module(new EXU)
	// // // submodule4: regfile
  // // val regfile = Module(new RegFile)
	// // submodule5: DPIC
  // val dpic = Module(new DPIC)
	// // device: AXI4SRAM -- for inst reading
  // val axi4sram = Module(new AXI4SRAM)
	// // device: AXI4DRAM -- for sd, ld instructions
  // val axi4dram = Module(new AXI4DRAM)

  // // for AXI4Lite bus between IFU and AXI4SRAM
  // ifu.io.ifu_to_axi4sram.inst_in := axi4sram.io.inst
  // axi4sram.io.pc := ifu.io.ifu_to_axi4sram.pc

  // // for ifu
  // ifu.io.ifu_to_exu <> exu.io.ifu_to_exu
  // idu.io.inst    := ifu.io.ifu_to_exu.inst

  // // for sram
  // axi4sram.io.clk := clock
  // axi4sram.io.rst := reset

  // // idu and exu
  // idu.io.idu_to_exu <> exu.io.idu_to_exu

  // // for dpic
  // dpic.io.clk := clock
  // dpic.io.rst := reset
  // dpic.io.isEbreak := idu.io.isEbreak
  // dpic.io.inv_inst := idu.io.inv_inst
  // dpic.io.regfile  := exu.io.regfile_output
  // // for dram
  // axi4dram.io.clk := clock
  // axi4dram.io.rst := reset
  // axi4dram.io.mem_addr := exu.io.mem_addr
  // axi4dram.io.isRead   := exu.io.isRead
  // axi4dram.io.isWriteMem := idu.io.isWriteMem
  // axi4dram.io.mem_write_data := exu.io.mem_write_data
  // axi4dram.io.mem_write_msk  := exu.io.mem_write_msk
  // exu.io.mem_in   := axi4dram.io.mem_in

}

