package cyhcore

import chisel3._
import chisel3.util._
import Conf._
import Macros._
import Macros.Constants._

class IDU_to_EXU (implicit val conf: Configuration) extends Bundle() {
  val br_eq     = Input(Bool())
  val br_lt     = Input(Bool())
  val br_ltu    = Input(Bool())
  val pc_sel    = Output(UInt(BR_N.getWidth.W))
  val op1_sel   = Output(UInt(OP1_X.getWidth.W))
  val op2_sel   = Output(UInt(OP2_X.getWidth.W))
  val alu_op    = Output(UInt(ALU_X.getWidth.W))
  val wb_sel    = Output(UInt(WB_X.getWidth.W))
  val reg_wen   = Output(Bool())
  val mem_msk_type  = Output(UInt(MEM_MSK_X.getWidth.W))
  val alu_msk_type  = Output(UInt(ALU_MSK_X.getWidth.W))
  val sign_op   = Output(Bool())
}

class IDU_bundle (implicit val conf: Configuration) extends Bundle() {
  val inst = Input(UInt(conf.inst_len.W))
  val idu_to_exu = new IDU_to_EXU()
  val isEbreak  = Output(Bool())
  val inv_inst  = Output(Bool())
  val isWriteMem = Output(Bool())
} 

class IDU (implicit val conf: Configuration) extends Module {
  val io = IO(new IDU_bundle())

  // The core of DecodeUnit
  val decoded_signals = ListLookup(
    io.inst, Instructions.DecodeDefault,
    Instructions.DecodeTable
  )

  val (valid_inst: Bool) :: br_type :: op1_sel :: op2_sel :: ds0 = decoded_signals
  val alu_op :: wb_sel :: (wreg: Bool) :: (wmem: Bool) :: ds1 = ds0
  val mem_msk_type :: alu_msk_type :: (sign_op: Bool) :: Nil = ds1

  println(s"In IDU, io.inst = ${io.inst}, and valid_inst = ${valid_inst}")

  io.idu_to_exu.pc_sel  := MuxLookup(
    br_type, PC_EXC,
    Array(
      BR_N   -> PC_4 , 
      BR_J   -> PC_J , 
      BR_JR  -> PC_JR, 
      BR_EQ  -> Mux(io.idu_to_exu.br_eq , PC_BR, PC_4),
      BR_NE  -> Mux(!io.idu_to_exu.br_eq, PC_BR, PC_4),
      BR_GE  -> Mux(!io.idu_to_exu.br_lt, PC_BR, PC_4),
      BR_GEU -> Mux(!io.idu_to_exu.br_ltu, PC_BR, PC_4),
      BR_LT  -> Mux(io.idu_to_exu.br_lt, PC_BR, PC_4),
      BR_LTU -> Mux(io.idu_to_exu.br_ltu, PC_BR, PC_4),
    )
  )

  io.idu_to_exu.op1_sel := op1_sel
  io.idu_to_exu.op2_sel := op2_sel
  io.idu_to_exu.alu_op  := alu_op
  io.idu_to_exu.wb_sel  := wb_sel
  io.idu_to_exu.reg_wen := wreg
  io.isEbreak := (io.inst === Priviledged.EBREAK)
  io.inv_inst := ~valid_inst
  io.isWriteMem := wmem
  io.idu_to_exu.sign_op := sign_op
  io.idu_to_exu.mem_msk_type := mem_msk_type
  io.idu_to_exu.alu_msk_type := alu_msk_type
  
}


//  io.src2 := MuxLookup(
//    instType.asUInt, 0.U,
//    ArraySeq.unsafeWrapArray(Array(
//      Rtype.asUInt -> reg_stack(rs2),
//      Itype.asUInt -> SEXT(xlen, unpacked.imm),
//      Stype.asUInt -> reg_stack(rs2),
//      Btype.asUInt -> reg_stack(rs2),
//      Utype.asUInt -> 0.U, 
//      Jtype.asUInt -> 0.U,
//      Special.asUInt -> 0.U,
//    ))
//  )

