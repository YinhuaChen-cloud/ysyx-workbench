package cyhcore

import chisel3._
import chisel3.util._

import top.Settings
import bus.simplebus._

trait HasResetVector {
  val resetVector = Settings.getLong("ResetVector")
}

// class IFU_to_EXU extends CyhCoreBundle() { // TODO: 下一个步骤，让 IFU 获得指令，再交给 IDU/EXU
//   val pc_next  = Input(UInt(PC_LEN.W))
//   val pc       = Output(UInt(PC_LEN.W))
//   val inst = Output(UInt(INST_LEN.W))
// }

// class IFU_to_AXI4SRAM extends CyhCoreBundle() { // TODO: 下一个步骤，让 IFU 获得指令，再交给 IDU/EXU
//   val pc      = Output(UInt(PC_LEN.W))
//   val inst_in = Input(UInt(INST_LEN.W))
// }

// class IFU_bundle extends CyhCoreBundle() {
//   // val ifu_to_exu = new IFU_to_EXU()
//   val ifu_to_axi4sram = new IFU_to_AXI4SRAM()
// }

class IFU extends CyhCoreModule with HasResetVector {
  // val io = IO(new IFU_bundle())
  val io = IO(new Bundle {
    val imem = new SimpleBusUC
    // val out  = new CtrlFlowIO
  })

  val pc_reg = RegInit(resetVector.U(PC_LEN.W)) // TODO：果壳里，PC寄存器的长度是39
  // pc_reg := io.ifu_to_exu.pc_next
  // io.ifu_to_exu.pc  := pc_reg
  // io.ifu_to_axi4sram.pc  := pc_reg
  // io.ifu_to_exu.inst := io.ifu_to_axi4sram.inst_in

  io.imem.req.addr  := pc_reg
  pc_reg := pc_reg + 4.U
  printf("The inst read is 0x%x\n", io.imem.resp.rdata)

}
