package sim

import chisel3._

import cyhcore._
import device._
import utils._
import system._
import chisel3.util.experimental.BoringUtils

// TODO: 这个暂时用不上，除了工作量啥都没
// class DiffTestIO extends CyhCoreBundle {
//   val regfile = Input(UInt((NR_GPRS * XLEN).W))
//   val thisPC = Output(UInt(PC_LEN.W))
//   val commit = Output(Bool())
// }

// 目前的设备有：
// 1. SRAM
// 2. DRAM
class CyhSocSimTop extends CyhCoreModule with HasRegFileParameter {

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

  // difftest ------------------- start 
  // 当 io.in.valid 为 true 时，说明目前的信号会在下一个时钟上升沿起效果（写入寄存器、写入内存）
  // 因此 difftest 也要在下一个时钟上升沿去做
  // 一个例外：当接收到的指令为NOP时，下一个时钟上升沿不能做difftest
  val difftest = Module(new DiffTest)
  difftest.io.clk   := clock
  difftest.io.rst   := reset
  BoringUtils.addSink(difftest.io.commit, "difftestCommit")
  difftest.io.pc    := DontCare // 现在先不对比 pc

  // val difftest_valid = RegNext(io.in.valid & (io.in.bits.cf.instr =/= Instructions.NOP)) // 告诉仿真环境可以做difftest了
  val rf = WireInit(VecInit(Seq.fill(NRReg)(0.U(XLEN.W))))
  BoringUtils.addSink(rf, "difftestRegs")
  val rf_aux = Wire(Vec(NRReg * XLEN, Bool()))
  for(i <- 0 until NRReg) {
    rf_aux.slice(i * XLEN, (i+1) * XLEN).zip(rf(i).asBools).foreach{case (a, b) => a := b}
  }
  difftest.io.regfile := rf_aux.asUInt
  // difftest ------------------- end

}

