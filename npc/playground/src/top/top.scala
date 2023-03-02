package system

import chisel3._
import Conf._

import cyhcore._
import device._
import utils._

class top extends Module {

  implicit val conf = Configuration()

  val io = IO(new Bundle {
//    val inst = Input(UInt(conf.inst_len.W))
  })

  // submodule1 IFU
  val ifu = Module(new IFU)
	// submodule2: IDU
  val idu = Module(new IDU)
	// submodule3: EXU
  val exu = Module(new EXU)
	// submodule4: DPIC
  val dpic = Module(new DPIC)
	// device: AXI4SRAM
  val axi4sram = Module(new AXI4SRAM)

  ifu.io <> exu.io.ifu_to_exu

//  idu.io.inst    := io.inst // TODO: wait for being removed
//  exu.io.inst    := io.inst
  idu.io.inst    := axi4sram.io.inst // TODO: wait for being removed
  exu.io.inst    := axi4sram.io.inst

  idu.io.idu_to_exu <> exu.io.idu_to_exu

  dpic.io.clk := clock
  dpic.io.rst := reset
  dpic.io.isEbreak := idu.io.isEbreak
  dpic.io.inv_inst := idu.io.inv_inst
  dpic.io.regfile  := exu.io.regfile_output
  axi4sram.io.clk := clock
  axi4sram.io.rst := reset
  axi4sram.io.pc := ifu.io.pc
  axi4sram.io.mem_addr := exu.io.mem_addr
  axi4sram.io.isRead   := exu.io.isRead
  axi4sram.io.isWriteMem := idu.io.isWriteMem
  axi4sram.io.mem_write_data := exu.io.mem_write_data
  axi4sram.io.mem_write_msk  := exu.io.mem_write_msk

  exu.io.mem_in   := axi4sram.io.mem_in
}

