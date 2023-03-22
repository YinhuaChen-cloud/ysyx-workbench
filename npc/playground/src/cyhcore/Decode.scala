package cyhcore

import chisel3._
import chisel3.util._

trait HasInstrType {
  def InstrN  = "b0000".U
  def InstrI  = "b0100".U
  def InstrR  = "b0101".U
  def InstrS  = "b0010".U
  def InstrB  = "b0001".U
  def InstrU  = "b0110".U
  def InstrJ  = "b0111".U
  // def InstrA  = "b1110".U
  // def InstrSA = "b1111".U // Atom Inst: SC

  def isrfWen(instrType : UInt): Bool = instrType(2)
}

object SrcType {
  def reg = false.B
  def imm = true.B
  def pc  = imm // TODO: 为什么 pc 操作数类型会和 imm 属同一类型？
  def apply() = Bool()
}

object FuType {
  def alu = 0.U(log2Up(num).W)
  def lsu = 1.U(log2Up(num).W)
  def mdu = 2.U(log2Up(num).W)
  def csr = 3.U(log2Up(num).W)
  // def mou = 4.U(3.W)
  // def bru = if(IndependentBru) "b101".U
  //           else               alu
  def bru = alu
  def num = 4
  def apply() = UInt(log2Up(num).W)
}

object FuOpType {
  def apply() = UInt(7.W)
}

object Instructions extends HasInstrType {
  def NOP = 0x00000013.U // 什么也不做
  // val DecodeDefault = List(N, BR_N , OP1_X  , OP2_X  , ALU_X   , WB_X  , WREG_0, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_X)
  val DecodeDefault = List(InstrN, FuType.csr, CSROpType.jmp) 
  def DecodeTable = RVIInstr.table ++
    RVMInstr.table ++
    Priviledged.table
    // RVZicsrInstr.table
}

