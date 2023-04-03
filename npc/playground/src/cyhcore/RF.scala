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

// 用来处理RAW(写后读)数据冒险
// 当IDU发现要写入某个寄存器时，把 busy(x) = 1
// 当WBU完成写入某个寄存器时，把 busy(x) = 0
// 在IDU阶段，若需要读出寄存器x，而此时 busy(x) = 1，说明发生了RAW (在我们的设计中，读寄存器和写寄存器都发生在ISU单元里)
class ScoreBoard extends HasRegFileParameter {
  val busy = RegInit(0.U(NRReg.W))
  def isBusy(idx: UInt): Bool = busy(idx) 
  def mask(idx: UInt) = (1.U(NRReg.W) << idx)(NRReg-1, 0) // 根据寄存器idx生成用于update的mask
  def update(setMask: UInt, clearMask: UInt) = { // 用来更新busy
    busy := Cat(((busy & ~clearMask) | setMask)(NRReg-1, 1), 0.U(1.W)) // 0位永远是0，因为 $0 寄存器永远都是0
    // clearMask 上为1的bits，在busy中要置为0
    // 在 setMask 上为1的bits，在busy中要置为1
    // setMask优先级更高，因为当IDU发现要写入某个寄存器 且同时 WBU完成写入某个寄存器时，busy相应的位仍然应该是1
  }
}




