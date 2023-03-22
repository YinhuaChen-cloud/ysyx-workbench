package cyhcore

import chisel3._
import chisel3.util._

import RV32I_BRUInstr._

// 这个单元现在并不做分支预测，只是对当前的instr做一点小译码，判断是否是 branch 或 jmp 指令
class BPU extends CyhCoreModule with HasInstrType {
  val io = IO(new Bundle {
    val instr = Input(UInt(INST_LEN.W))
    val fuOpType = Output(FuOpType()) // 告诉ALU计算redirect的部分选择哪个操作
    val isBranchJmp = Output(Bool())
  })

// fuOpType(FuOpType) -----------------------------------------------------

  val fuOpres = ListLookup(io.instr, Instructions.DecodeDefault, table)

  val instrType :: fuType :: fuOpType :: Nil = fuOpres

  io.fuOpType := fuOpType

// isBranchJmp(Bool) ------------------------------------------------------

  val TFtable = Array(
    JAL            -> List(true.B),
    JALR           -> List(true.B),

    BEQ            -> List(true.B),
    BNE            -> List(true.B),
    BLT            -> List(true.B),
    BGE            -> List(true.B),
    BLTU           -> List(true.B),
    BGEU           -> List(true.B)
  )

  // NOTE: 经过试验，只有ListLookup能够以index的形式判断io.instr和BitPat之间的关系
  // 使用MuxLookup的时候会报错
  // 使用 MuxCase 则需要自己手动打 === 
  val tfres = ListLookup(io.instr, List(false.B), TFtable)

  val isBranchJmp :: Nil = tfres

  io.isBranchJmp := isBranchJmp

}
