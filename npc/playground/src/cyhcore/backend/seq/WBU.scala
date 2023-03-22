package cyhcore

import chisel3._
import chisel3.util._

import utils._
import chisel3.util.experimental.BoringUtils

// 用来把结果写回 寄存器堆 和 PC   TODO: 从端口来看，似乎不写回内存
class WBU extends CyhCoreModule { // ------------- halfchecked
  val io = IO(new Bundle {
    val in = Flipped(Decoupled(new CommitIO))
    val wb = new WriteBackIO // 写回寄存器用的端口
    val redirect = new RedirectIO
  })

// wb(WriteBackIO) ------------------------------------------
  // val rfWen = Output(Bool())
  // val rfDest = Output(UInt(5.W))
  // val rfData = Output(UInt(XLEN.W))

  io.wb.rfWen  := io.in.bits.decode.ctrl.rfWen & io.in.valid
  io.wb.rfDest := io.in.bits.decode.ctrl.rfDest
  io.wb.rfData := io.in.bits.commits(io.in.bits.decode.ctrl.fuType) // EXU 四个功能单元的输出都在commit，让 WBU 挑选

// redirect(RedirectIO) ------------------------------------------
  // val target = Output(UInt(PC_LEN.W))

  dontTouch(io.redirect)
  dontTouch(io.in.bits.decode.cf.redirect)
  io.in.bits.decode.cf.redirect <> io.redirect
  // io.redirect.valid := io.in.bits.decode.cf.redirect.valid && io.in.valid

// handshake ------------------------------------------ 
  
  io.in.ready  := DontCare

// for difftest ---------------------------------------
  // 当 io.in.valid 为 true 时，说明下一周期寄存器堆就会被写入（WBU和ISU之间没有流水线）
  // 所以，可以在下一个时钟上升沿启用 difftest
  // TODO: 上板的时候这个应该得去掉(果壳去掉了)
  BoringUtils.addSource(RegNext(io.in.valid), "difftestCommit")

}

