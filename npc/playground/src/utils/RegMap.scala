package utils

import chisel3._
import chisel3.util._

object MaskedRegMap {
  def WritableMask = Fill(64, true.B)
  def apply(addr: Int, reg: UInt, wmask: UInt = WritableMask, wfn: UInt => UInt = (x => x), rmask: UInt = WritableMask) = (addr, (reg, wmask, wfn, rmask))
}


