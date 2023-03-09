package cyhcore

import chisel3._
import chisel3.util._

import Macros._
import Macros.Constants._

object Priviledged extends HasInstrType {
  // def ECALL   = BitPat("b000000000000_00000_000_00000_1110011")
  def EBREAK  = BitPat("b000000000001_00000_000_00000_1110011")
  // def MRET    = BitPat("b001100000010_00000_000_00000_1110011")
  // def SRET    = BitPat("b000100000010_00000_000_00000_1110011")
  // def SFANCE_VMA = BitPat("b0001001_?????_?????_000_00000_1110011")
  // def FENCE   = BitPat("b????????????_?????_000_?????_0001111")
  // def WFI     = BitPat("b0001000_00101_00000_000_00000_1110011") 

  // val table_s = Array(
  //   SRET           -> List(InstrI, FuType.csr, CSROpType.jmp),
  //   SFANCE_VMA     -> List(InstrR, FuType.mou, MOUOpType.sfence_vma)
  // )

  val table = Array(
    // ECALL          -> List(InstrI, FuType.csr, CSROpType.jmp),
    // EBREAK    -> List(Y, BR_N  , OP1_X  , OP2_X  , ALU_X   , WB_X  , WREG_0, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_X),
    EBREAK         -> List(InstrI, FuType.csr, CSROpType.jmp),
  )
  //   MRET           -> List(InstrI, FuType.csr, CSROpType.jmp),
  //   FENCE          -> List(InstrS, FuType.mou, MOUOpType.fence), // nop    InstrS -> !wen
  //   WFI            -> List(InstrI, FuType.alu, ALUOpType.add) // nop
  //   // FENCE          -> List(InstrB, FuType.mou, MOUOpType.fencei)
  // ) ++ (if (!Settings.get("MmodeOnly")) table_s else Nil)
}
