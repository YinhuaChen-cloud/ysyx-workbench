package cyhcore

import chisel3._
import chisel3.util._
import utils.OneHotTree

import RV32I_BRUInstr._

// 这个单元现在并不做分支预测，只是对当前的instr做一点小译码，判断是否是 branch 或 jmp 指令
class BPU extends CyhCoreModule with HasInstrType {
  val io = IO(new Bundle {
    val instr = Input(UInt(64.W))
    val isBranchJmp = Output(Bool())
  })

  // val table = Array(
  //   JAL            -> true.B,
  //   JALR           -> true.B,

  //   BEQ            -> true.B,
  //   BNE            -> true.B,
  //   BLT            -> true.B,
  //   BGE            -> true.B,
  //   BLTU           -> true.B,
  //   BGEU           -> true.B
  // )

  // val res = MuxLookup(io.instr, false.B, table)

}

  // val table = Array(
  //   JAL            -> List(InstrJ, FuType.bru, ALUOpType.jal),
  //   JALR           -> List(InstrI, FuType.bru, ALUOpType.jalr),

  //   BEQ            -> List(InstrB, FuType.bru, ALUOpType.beq),
  //   BNE            -> List(InstrB, FuType.bru, ALUOpType.bne),
  //   BLT            -> List(InstrB, FuType.bru, ALUOpType.blt),
  //   BGE            -> List(InstrB, FuType.bru, ALUOpType.bge),
  //   BLTU           -> List(InstrB, FuType.bru, ALUOpType.bltu),
  //   BGEU           -> List(InstrB, FuType.bru, ALUOpType.bgeu)
  // )
