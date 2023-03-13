package cyhcore

import chisel3._
import chisel3.util._

// import Macros._
// import Macros.Constants._

object RVMInstr extends HasInstrType {
  def MUL     = BitPat("b0000001_?????_?????_000_?????_0110011")
  def MULW    = BitPat("b0000001_?????_?????_000_?????_0111011")
  def DIVW    = BitPat("b0000001_?????_?????_100_?????_0111011")
  def DIVU    = BitPat("b0000001_?????_?????_101_?????_0110011")
  def DIVUW   = BitPat("b0000001_?????_?????_101_?????_0111011")
  def REMW    = BitPat("b0000001_?????_?????_110_?????_0111011")

  val mulTable = Array(
    // MUL       -> List(Y, BR_N  , OP1_RS1, OP2_RS2, ALU_MUX , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_N),
    // MULW      -> List(Y, BR_N  , OP1_RS1, OP2_RS2, ALU_MUX , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_W, SIGN_N),

    MUL            -> List(InstrR, FuType.mdu, MDUOpType.mul),
    MULW           -> List(InstrR, FuType.mdu, MDUOpType.mulw)
  )

  val divTable = Array(
    // DIVW      -> List(Y, BR_N  , OP1_RS1, OP2_RS2, ALU_DIV , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_W, SIGN_N),
    // DIVU      -> List(Y, BR_N  , OP1_RS1, OP2_RS2, ALU_DIV , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_N),
    // DIVUW     -> List(Y, BR_N  , OP1_RS1, OP2_RS2, ALU_DIV , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_W, SIGN_N),
    // REMW      -> List(Y, BR_N  , OP1_RS1, OP2_RS2, ALU_REM , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_W, SIGN_N),

    DIVW           -> List(InstrR, FuType.mdu, MDUOpType.divw),
    DIVU           -> List(InstrR, FuType.mdu, MDUOpType.divu),
    DIVUW          -> List(InstrR, FuType.mdu, MDUOpType.divuw),
    REMW           -> List(InstrR, FuType.mdu, MDUOpType.remw),
  )

  val table = mulTable ++ divTable
}
