package system

import chisel3._
import Conf._

import cyhcore._
import device._
import utils._

class top extends Module {

  implicit val conf = Configuration()

  val io = IO(new Bundle {
  })

  // submodule1 IFU
  val ifu = Module(new IFUnew)
	// submodule2: IDU
  val idu = Module(new IDU)
	// submodule3: EXU
  val exu = Module(new EXU)
	// submodule4: DPIC
  val dpic = Module(new DPIC)
	// device: AXI4SRAM -- for inst reading
  val axi4sram = Module(new AXI4SRAM)
	// device: AXI4DRAM -- for sd, ld instructions
  val axi4dram = Module(new AXI4DRAM)

  // ifu.io <> exu.io.ifu_to_exu --- flag: 注意，这里是备份，准备改 AXI4Lite IFU
  ifu.io <> exu.io.ifu_to_exu

  // for sram
  axi4sram.io.clk := clock
  axi4sram.io.rst := reset
  // axi4sram.io.pc := ifu.io.pc --- flag: 注意，这里需要改变，准备改 AXI4Lite IFU
  axi4sram.io.pc := ifu.io.pc
  idu.io.inst    := axi4sram.io.inst // TODO: wait for being removed
  exu.io.inst    := axi4sram.io.inst

  idu.io.idu_to_exu <> exu.io.idu_to_exu

  // for dpic
  dpic.io.clk := clock
  dpic.io.rst := reset
  dpic.io.isEbreak := idu.io.isEbreak
  dpic.io.inv_inst := idu.io.inv_inst
  dpic.io.regfile  := exu.io.regfile_output
  // for dram
  axi4dram.io.clk := clock
  axi4dram.io.rst := reset
  axi4dram.io.mem_addr := exu.io.mem_addr
  axi4dram.io.isRead   := exu.io.isRead
  axi4dram.io.isWriteMem := idu.io.isWriteMem
  axi4dram.io.mem_write_data := exu.io.mem_write_data
  axi4dram.io.mem_write_msk  := exu.io.mem_write_msk
  exu.io.mem_in   := axi4dram.io.mem_in

}

