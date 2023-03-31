package cyhcore

import chisel3._
import chisel3.util._

trait HasRegFileParameter {
  val NRReg = 32 // 通用寄存器的数量 x0 - x31
}

class RegFile extends HasRegFileParameter with HasCyhCoreParameter {
  val rf = RegInit(VecInit(Seq.fill(NRReg)(0.U(XLEN.W))))
  def read(addr: UInt) : UInt = Mux(addr === 0.U, 0.U, rf(addr))
  def write(addr: UInt, data: UInt) = { rf(addr) := Mux(addr === 0.U, rf(addr), data(XLEN-1,0)) }
} 

// 计分板
// 用来处理RAW(写后读)数据冒险
// 当IDU发现要写入某个寄存器时，把 busy(x) = 1
// 当WBU完成写入某个寄存器时，把 busy(x) = 0
// 在IDU阶段，若需要读出寄存器x，而此时 busy(x) = 1，说明发生了RAW
class ScoreBoard extends HasRegFileParameter {

  val busy = RegInit(0.U(NRReg.W))

  def isBusy(idx: UInt): Bool = busy(idx) 

  def update = {
    // busy := ... ?
  }
}



