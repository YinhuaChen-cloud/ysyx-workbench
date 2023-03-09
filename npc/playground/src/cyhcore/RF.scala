package cyhcore

import chisel3._
import chisel3.util._

trait HasRegFileParameter {
  val NRReg = 32
}

class RegFile extends HasRegFileParameter with HasNutCoreParameter {
  val rf = Mem(NRReg, UInt(XLEN.W))
  def read(addr: UInt) : UInt = Mux(addr === 0.U, 0.U, rf(addr))
  def write(addr: UInt, data: UInt) = { rf(addr) := data(XLEN-1,0) }
} 



