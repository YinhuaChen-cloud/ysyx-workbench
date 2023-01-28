import chisel3._
import chisel3.util._
import chisel3.stage.ChiselStage
//import scala.collection.immutable.ArraySeq

import Macros._
import Macros.Constants._
//import Macros.RV64ExuOp._

class EXU (xlen: Int = 64, 
  inst_len: Int = 32,
  nr_reg: Int = 32) extends Module {
  val io = IO(new Bundle {
//    val exuop = Input(RV64ExuOp())
//    val src1 = Input(UInt(xlen.W))
//    val src2 = Input(UInt(xlen.W))
//    val destI = Input(UInt(xlen.W))
//    val exec_result = Output(UInt(xlen.W))
//    val isEbreak = Output(Bool())
    val pc = Input(UInt(xlen.W))
    val inst = Input(UInt(inst_len.W))

    val op1_sel   = Input(UInt(OP1_X.getWidth.W))
    val op2_sel   = Input(UInt(OP2_X.getWidth.W))
    val alu_op   = Input(UInt(ALU_X.getWidth.W))
    val invalid_inst = Input(Bool())

    val dnpc = Output(UInt(xlen.W))
  })

  // submodule1 - register file
  val regfile = RegInit(VecInit(Seq.fill(nr_reg)(0.U(xlen.W))))
  val reg_each_wen = Wire(UInt(nr_reg.W)) // TODO: not drive yet
  val reg_total_wen = Wire(Bool()) // TODO: not drive yet

  regfile(0) := 0.U // $zero/x0 is always 0 TODO: what will happen to pending wire?
  for(i <- 1 to nr_reg-1) {
    regfile(i) := Mux(reg_total_wen & reg_each_wen(i), io.exec_result, regfile(i)) 
  }

  // submodule2 - ALU
  // 2-1. get data from regs
  val rs1_addr = io.inst(RS1_MSB, RS1_LSB)
  val rs2_addr = io.inst(RS2_MSB, RS2_LSB)
  val rd_addr  = io.inst(RD_MSB,  RD_LSB) 

  val rs1_data = Mux((rs1_addr =/= 0.U), regfile(rs1_addr), 0.asUInt(xlen.W))
  val rs2_data = Mux((rs2_addr =/= 0.U), regfile(rs2_addr), 0.asUInt(xlen.W))
  // 2-2. calculate imm
  // r
  // i
  val imm_i = inst(31, 20)
  // s
  val imm_s = Cat(inst(31, 25), inst(11,7))
  // b
  // u
  val imm_u = inst(31, 12)
  // j
  // r
  // i
  val imm_i_sext = Cat(Fill(20,imm_i(11)), imm_i)
  // s
  val imm_s_sext = Cat(Fill(20,imm_s(11)), imm_s)
  // b
  // u
  val imm_u_sext = Cat(imm_u, Fill(12,0.U))
  // j
  
  val alu_op1 = MuxCase(0.U, Array(
              (io.op1_sel === OP1_RS1) -> rs1_data,
              (io.op1_sel === OP1_IMU) -> imm_u_sext,
//              (io.op1_sel === OP1_IMZ) -> imm_z
              )).asUInt()
 
  val alu_op2 = MuxCase(0.U, Array(
//              (io.op2_sel === OP2_RS2) -> rs2_data,
              (io.op2_sel === OP2_IMI) -> imm_i_sext,
              (io.op2_sel === OP2_IMS) -> imm_s_sext
              (io.op2_sel === OP2_PC)  -> pc_reg,
              )).asUInt()
  
  val alu_out = Wire(UInt(xlen.W))   
  alu_out := MuxCase(
    0.U, Array(
      (io.alu_op === ALU_ADD)    -> (alu_op1 + alu_op2).asUInt(),
    )
  )
  

////  class ADDER (width: Int = 64) extends Module {
////    val io = IO(new Bundle{
////      val input1 = Input(UInt(width.W))
////      val input2 = Input(UInt(width.W))
////      val sum = Output(UInt(width.W))
////    }) 
////    
////    io.sum := io.input1 + io.input2
////
////  }
//
//  // The core of ExecuteUnit
//  val tmpsrc1 = Wire(UInt(xlen.W)) 
//  val tmpsrc2 = Wire(UInt(xlen.W)) 
//
//  tmpsrc1 := MuxLookup(
//    io.exuop.asUInt, 0.U,
//    ArraySeq.unsafeWrapArray(Array(
//      Addi.asUInt -> io.src1,
//      Auipc.asUInt -> io.src1,
//      Jal.asUInt -> io.pc,
//      Jalr.asUInt -> io.pc,
//    ))
//  )
//
//  tmpsrc2 := MuxLookup(
//    io.exuop.asUInt, 0.U,
//    ArraySeq.unsafeWrapArray(Array(
//      Addi.asUInt -> io.src2,
//      Auipc.asUInt -> io.pc,
//      Jal.asUInt -> 4.U,
//      Jalr.asUInt -> 4.U,
//    ))
//  )
//  
//  val adder1 = Module(new ADDER(xlen))
//  io.exec_result := adder1.io.sum
//  adder1.io.input1 := tmpsrc1
//  adder1.io.input2 := tmpsrc2
//
////      SD -> Cat(Fill(xlen-32, unpacked.imm(19)), unpacked.imm, Fill(xlen-32-20, 0.U)),
////      EBREAK -> Cat(Fill(xlen-20-1, unpacked.imm(19)), unpacked.imm, 0.U),
////
//
//  val dnpc_src1 = Wire(UInt(xlen.W)) 
//  val dnpc_src2 = Wire(UInt(xlen.W)) 
//  
//  dnpc_src1 := MuxLookup(
//    io.exuop.asUInt, 0.U,
//    ArraySeq.unsafeWrapArray(Array(
//      Jal.asUInt -> io.pc,
//      Jalr.asUInt -> io.src1,
//    ))
//  )
//
//  dnpc_src2 := MuxLookup(
//    io.exuop.asUInt, 0.U,
//    ArraySeq.unsafeWrapArray(Array(
//      Jal.asUInt -> io.src1,
//      Jalr.asUInt -> io.src2,
//    ))
//  )
//  val adder2 = Module(new ADDER(xlen))
//  io.dnpc := adder2.io.sum
//  adder2.io.input1 := dnpc_src1
//  adder2.io.input2 := dnpc_src2
//
////      EBREAK -> Cat(Fill(xlen-20-1, unpacked.imm(19)), unpacked.imm, 0.U),
//  io.isEbreak := Mux((io.exuop === Ebreak), true.B, false.B)
//
////      SD -> Cat(Fill(xlen-32, unpacked.imm(19)), unpacked.imm, Fill(xlen-32-20, 0.U)),
  

}







