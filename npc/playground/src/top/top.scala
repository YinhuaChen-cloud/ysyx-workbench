package system

import chisel3._
import chisel3.util.Counter
import Conf._

import cyhcore._
import device._
import utils._

class top extends Module {

  implicit val conf = Configuration()

  val io = IO(new Bundle {
  })

  // submodule1 IFU
  val ifu = Module(new IFU)
	// submodule2: IDU
  val idu = Module(new IDU)
	// submodule3: EXU
  val exu = Module(new EXU)
	// submodule4: DPIC
  val dpic = Module(new DPIC)
	// device: AXI4SRAM -- for inst reading
  val axi4sram = Module(new AXI4SRAMnew)
	// device: AXI4DRAM -- for sd, ld instructions
  val axi4dram = Module(new AXI4DRAM)

  // for AXI4Lite bus between IFU and AXI4SRAM
  ifu.io.ifu_to_axi4sram.inst_in.valid := axi4sram.io.inst_valid  
  ifu.io.ifu_to_axi4sram.inst_in.bits  := axi4sram.io.inst       
  axi4sram.io.inst_ready               := ifu.io.ifu_to_axi4sram.inst_in.ready
  axi4sram.io.pc_for_diff              := ifu.io.ifu_to_axi4sram.pc_op

  axi4sram.io.pc_valid            := ifu.io.ifu_to_axi4sram.pc.valid
  axi4sram.io.pc                  := ifu.io.ifu_to_axi4sram.pc.bits 
  ifu.io.ifu_to_axi4sram.pc.ready := axi4sram.io.pc_ready 

  // for ifu
  ifu.io.ifu_to_exu <> exu.io.ifu_to_exu
  idu.io.inst    := ifu.io.ifu_to_exu.inst

  // // for sram
  // axi4sram.io.clk := clock
  // axi4sram.io.rst := reset

  // idu and exu
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

  // 以下这个Counter只是为了在加流水线之前，让我的CPU能够通过测试用例
  // 每个 4 个时钟中，tick 会有一个时钟周期为 true.B, 此时使能 寄存器写入和内存写入
  val cycles = 3
  val counter = Counter(cycles)
  val tick = Wire(Bool())
  tick := (counter.value === 1.U)
  ifu.io.enable := DontCare
  idu.io.enable := DontCare
  exu.io.enable := tick
  axi4dram.io.enable := tick

}

