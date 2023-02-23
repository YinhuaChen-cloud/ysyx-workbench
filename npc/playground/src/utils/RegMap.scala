package utils

import chisel3._
import chisel3.util._

import system._

import cyhcore.HasCyhCoreParameter
object MaskedRegMap extends HasCyhCoreParameter {
  def WritableMask = Fill(XLEN, true.B) // TODO: change 64 to settings
  def apply(addr: Int, reg: UInt, wmask: UInt = WritableMask, wfn: UInt => UInt = (x => x), rmask: UInt = WritableMask) = (addr, (reg, wmask, wfn, rmask))
}


