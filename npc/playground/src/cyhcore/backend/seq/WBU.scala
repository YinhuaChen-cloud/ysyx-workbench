package cyhcore

import chisel3._
import chisel3.util._

import utils._
import chisel3.util.experimental.BoringUtils

// 用来把结果写回 寄存器堆 和 PC   TODO: 从端口来看，似乎不写回内存
class WBU extends CyhCoreModule { // ------------- halfchecked
  val io = IO(new Bundle {
    val in = Flipped(Decoupled(new CommitIO))
    val wb = new WriteBackIO // 写回寄存器用的端口     这里不接入流水是为了缓解数据冒险造成的延时
    val redirect = new RedirectIO   // 这里不接入流水是为了缓解控制冒险造成的延时
    
    // val valid = Input(Bool())
  })

  dontTouch(io.in.bits.decode.cf.instr)

// wb(WriteBackIO) ------------------------------------------
  // val rfWen = Output(Bool())
  // val rfDest = Output(UInt(5.W))
  // val rfData = Output(UInt(XLEN.W))

  // io.wb.rfWen  := io.in.bits.decode.ctrl.rfWen
  io.wb.rfWen  := io.in.bits.decode.ctrl.rfWen & io.in.valid
  io.wb.rfDest := io.in.bits.decode.ctrl.rfDest
  io.wb.rfData := io.in.bits.commits(io.in.bits.decode.ctrl.fuType) // EXU 四个功能单元的输出都在commit，让 WBU 挑选

// redirect(RedirectIO) ------------------------------------------
  // val target = Output(UInt(PC_LEN.W))

  dontTouch(io.redirect)
  dontTouch(io.in.bits.decode.cf.redirect)
  io.redirect := io.in.bits.decode.cf.redirect 
  io.redirect.valid := io.in.bits.decode.cf.redirect.valid && io.in.valid // 输入有效，redirect才有效

// handshake ------------------------------------------ 
  
  // io.in.bits.ready  := DontCare
  io.in.ready  := DontCare

// for difftest ---------------------------------------
  // TODO: 上板的时候这个应该得去掉(果壳去掉了)
  // 当 io.in.valid 为 true 时，说明下一周期寄存器堆就会被写入（WBU和ISU之间没有流水线）
 // 所以，可以在下一个时钟上升沿启用 difftest
  BoringUtils.addSource(RegNext(io.in.valid && io.in.bits.decode.cf.instr =/= Instructions.NOP), "difftestCommit")
  // 用于difftest的"平时pc"，指的是没有执行跳转指令时，用来做difftest的PC
  // 在执行跳转指令时做difftest的pc是IFU的pc_reg
  BoringUtils.addSource(io.in.bits.decode.cf.pc, "difftestCommonPC")

}

