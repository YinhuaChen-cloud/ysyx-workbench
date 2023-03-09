package cyhcore

import chisel3._
import chisel3.util._

// trait HasRegFileParameter {
//   val NRReg = 32 // 通用寄存器的数量 x0 - x31
// }

// class RegFile extends HasRegFileParameter with HasCyhCoreParameter {
//   val rf = RegInit(VecInit(Seq.fill(NRReg)(0.U(XLEN.W))))
//   def read(addr: UInt) : UInt = Mux(addr === 0.U, 0.U, rf(addr))
//   def write(addr: UInt, data: UInt) = { rf(addr) := data(XLEN-1,0) }
// } 




