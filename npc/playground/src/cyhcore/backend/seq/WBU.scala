package cyhcore

import chisel3._
import chisel3.util._

import utils._

// 用来把结果写回 寄存器堆 和 PC   TODO: 从端口来看，似乎不写回内存
class WBU extends CyhCoreModule { // ------------- halfchecked
  val io = IO(new Bundle {
    val in = Flipped(new CommitIO)
    val wb = new WriteBackIO // 写回寄存器用的端口
    val redirect = new RedirectIO
  })

// wb(WriteBackIO) ------------------------------------------
  // val rfWen = Output(Bool())
  // val rfDest = Output(UInt(5.W))
  // val rfData = Output(UInt(XLEN.W))

  io.wb.rfWen  := io.in.decode.ctrl.rfWen
  io.wb.rfDest := io.in.decode.ctrl.rfDest
  io.wb.rfData := io.in.commits(io.in.decode.ctrl.fuType) // EXU 四个功能单元的输出都在commit，让 WBU 挑选

// redirect(RedirectIO) ------------------------------------------
  // val target = Output(UInt(PC_LEN.W))

  dontTouch(io.redirect)
  dontTouch(io.in.decode.cf.redirect)
  io.in.decode.cf.redirect <> io.redirect
  // io.redirect.valid := io.in.bits.decode.cf.redirect.valid && io.in.valid
  
}

