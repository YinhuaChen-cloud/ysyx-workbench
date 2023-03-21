package cyhcore

import chisel3._
import chisel3.util._
import utils.OneHotTree

import RV32I_BRUInstr._

// 这个单元现在并不做分支预测，只是对当前的instr做一点小译码，判断是否是 branch 或 jmp 指令
class BPU extends CyhCoreModule with HasInstrType {
  val io = IO(new Bundle {
    val instr = Input(UInt(INST_LEN.W))
    val isBranchJmp = Output(Bool())
  })

  val table = Array(
    JAL            -> List(true.B),
    JALR           -> List(true.B),

    BEQ            -> List(true.B),
    BNE            -> List(true.B),
    BLT            -> List(true.B),
    BGE            -> List(true.B),
    BLTU           -> List(true.B),
    BGEU           -> List(true.B)
  )

  val res = ListLookup(io.instr, List(false.B), table)

  val isBranchJmp :: Nil = res

  io.isBranchJmp := isBranchJmp

}
