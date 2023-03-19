package cyhcore

import chisel3._
import chisel3.util._

object RVMInstr extends HasInstrType {
  def MUL     = BitPat("b0000001_?????_?????_000_?????_0110011")
  def MULW    = BitPat("b0000001_?????_?????_000_?????_0111011")
  def DIVW    = BitPat("b0000001_?????_?????_100_?????_0111011")
  def DIVU    = BitPat("b0000001_?????_?????_101_?????_0110011")
  def DIVUW   = BitPat("b0000001_?????_?????_101_?????_0111011")
  def REMW    = BitPat("b0000001_?????_?????_110_?????_0111011")

  val mulTable = Array(
    MUL            -> List(InstrR, FuType.mdu, MDUOpType.mul),
    MULW           -> List(InstrR, FuType.mdu, MDUOpType.mulw)
  )

  val divTable = Array(
    DIVW           -> List(InstrR, FuType.mdu, MDUOpType.divw),
    DIVU           -> List(InstrR, FuType.mdu, MDUOpType.divu),
    DIVUW          -> List(InstrR, FuType.mdu, MDUOpType.divuw),
    REMW           -> List(InstrR, FuType.mdu, MDUOpType.remw),
  )

  val table = mulTable ++ divTable
}
