package cyhcore

import chisel3._
import chisel3.util._

import Macros._
import Macros.Constants._

object Instructions {
  def NOP = 0x00000013.U
  val DecodeDefault = List(N, BR_N , OP1_X  , OP2_X  , ALU_X   , WB_X  , WREG_0, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_X)
  def DecodeTable = RVIInstr.table ++ RVMInstr.table ++
    Priviledged.table
    // RVZicsrInstr.table ++ RVZifenceiInstr.table
}

