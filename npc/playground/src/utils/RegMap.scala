package utils

import chisel3._
import chisel3.util._
import cyhcore.HasCyhCoreParameter

object MaskedRegMap extends HasCyhCoreParameter {

  def WritableMask = Fill(XLEN, true.B)

  // def apply(addr: Int, reg: UInt, wmask: UInt = WritableMask, wfn: UInt => UInt = (x => x), rmask: UInt = WritableMask) = (addr, (reg, wmask, wfn, rmask))
  def apply(addr: Int, reg: UInt) = (addr, reg)

  // def generate(mapping: Map[Int, (UInt, UInt, UInt => UInt, UInt)], raddr: UInt, rdata: UInt,
    // waddr: UInt, wen: Bool, wdata: UInt):Unit = {
  def generate(mapping: Map[Int, UInt], raddr: UInt, rdata: UInt, waddr: UInt, wen: Bool, wdata: UInt):Unit = {
    // chiselMapping 的目的是把 mapping 转化成适合 OneHotTree 的形式，只有两个元素
    // val chiselMapping = mapping.map { case (a, (r, wm, w, rm)) => (a.U, r, wm, w, rm) } // 这是一个模式匹配语句, 仅对能匹配的行进行操作
    // rdata := OneHotTree(raddr, chiselMapping.map { case (a, r, wm, w, rm) => (a, r & rm) })
    rdata := OneHotTree(raddr, mapping.map { case (csr_addr, csr) => (csr_addr.U, csr) })
    // 这里的map还有一个作用，通过几行代码，对某一种类型的硬件节点进行批量的相同的操作
    mapping.map { case (csr_addr, csr) => { csr := Mux((wen && waddr === csr_addr.U), wdata, csr) } }
    // 个人认为，其实 map 的作用就跟 SystemVerilog 里的 generate 差不多
  }
}


