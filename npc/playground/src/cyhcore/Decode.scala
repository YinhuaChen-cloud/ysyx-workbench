package cyhcore

import chisel3._
import chisel3.util._

import Macros._
import Macros.Constants._

object FuType {
  def alu = 0.U(log2Up(num).W)
  def lsu = 1.U(log2Up(num).W)
  def mdu = 2.U(log2Up(num).W)
  // def csr = 3.U(3.W)
  // def mou = 4.U(3.W)
  // def bru = if(IndependentBru) "b101".U
  //           else               alu
  def bru = alu
  def num = 3
  def apply() = UInt(log2Up(num).W)
}

object Instructions {
  def NOP = 0x00000013.U
  val DecodeDefault = List(N, BR_N , OP1_X  , OP2_X  , ALU_X   , WB_X  , WREG_0, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_X)
  def DecodeTable = RVIInstr.table ++ RVMInstr.table ++
    Priviledged.table
    // RVZicsrInstr.table
}

object FuOpType {
  def apply() = UInt(7.W)
}

