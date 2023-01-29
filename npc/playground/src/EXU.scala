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
//    val pc = Input(UInt(xlen.W))
    val inst = Input(UInt(inst_len.W))

    val pc_sel    = Input(UInt(BR_N.getWidth.W))
    val op1_sel   = Input(UInt(OP1_X.getWidth.W))
    val op2_sel   = Input(UInt(OP2_X.getWidth.W))
    val alu_op    = Input(UInt(ALU_X.getWidth.W))
    val reg_wen   = Input(Bool())

//    val pc_next   = Output(UInt(xlen.W))
    val pc = Output(UInt(xlen.W))
  })

  // submodule0 - IFU
  val pc_next          = Wire(UInt(32.W))
  val pc_reg = RegInit("h8000_0000".U(32.W))
  pc_reg := pc_next
  io.pc := pc_reg
//  pc_reg := Mux(io.pc_wen, io.pc_wdata, pc_reg + 4.U)
//  io.pc := pc_reg


  // submodule1 - register file
  // 1-1. reg addr
  val rs1_addr = io.inst(RS1_MSB, RS1_LSB)
  val rs2_addr = io.inst(RS2_MSB, RS2_LSB)
  val rd_addr  = io.inst(RD_MSB,  RD_LSB) 
  // 1-2. write back data
  val wb_data = Wire(UInt(xlen.W)) // NOTE: data write back to reg or mem
  // 1-3. register file
  val regfile = RegInit(VecInit(Seq.fill(nr_reg)(0.U(xlen.W))))
  regfile(rd_addr) := Mux((rd_addr =/= 0.U && io.reg_wen), wb_data, regfile(rd_addr))
//  val reg_each_wen = Wire(UInt(nr_reg.W)) // TODO: not drive yet
//  val reg_total_wen = Wire(Bool()) // TODO: not drive yet
//  regfile(0) := 0.U // $zero/x0 is always 0 TODO: what will happen to pending wire?
//  for(i <- 1 to nr_reg-1) {
//    regfile(i) := Mux(reg_total_wen & reg_each_wen(i), io.exec_result, regfile(i)) 
//  }

  // submodule2 - ALU
  val rs1_data = Mux((rs1_addr =/= 0.U), regfile(rs1_addr), 0.asUInt(xlen.W))
  val rs2_data = Mux((rs2_addr =/= 0.U), regfile(rs2_addr), 0.asUInt(xlen.W))
  // 2-2. calculate imm
  // r
  // i
  val imm_i = io.inst(31, 20)
  // s
  val imm_s = Cat(io.inst(31, 25), io.inst(11,7))
  // b
  // u
  val imm_u = io.inst(31, 12)
  // j
  val imm_j = Cat(io.inst(31), io.inst(19,12), io.inst(20), io.inst(30,21))
  // r
  // i
  val imm_i_sext = Cat(Fill(20,imm_i(11)), imm_i)
  // s
  val imm_s_sext = Cat(Fill(20,imm_s(11)), imm_s)
  // b
  // u
  val imm_u_sext = Cat(imm_u, Fill(12,0.U))
  // j
  val imm_j_sext = Cat(Fill(11,imm_j(19)), imm_j, 0.U)
  
  val alu_op1 = MuxCase(0.U, Array(
              (io.op1_sel === OP1_RS1) -> rs1_data,
              (io.op1_sel === OP1_IMU) -> imm_u_sext,
//              (io.op1_sel === OP1_IMZ) -> imm_z
              )).asUInt()
 
  val alu_op2 = MuxCase(0.U, Array(
//              (io.op2_sel === OP2_RS2) -> rs2_data,
              (io.op2_sel === OP2_IMI) -> imm_i_sext,
              (io.op2_sel === OP2_IMS) -> imm_s_sext,
              (io.op2_sel === OP2_PC)  -> io.pc,
              )).asUInt()
  
  val alu_out = Wire(UInt(xlen.W))   
  alu_out := MuxCase(
    0.U, Array(
      (io.alu_op === ALU_ADD)    -> (alu_op1 + alu_op2).asUInt(),
    )
  )
  
  wb_data := alu_out

  // submodule3 - next pc
  val pc_plus4         = Wire(UInt(32.W))
//  val br_target        = Wire(UInt(32.W))
  val jmp_target       = Wire(UInt(32.W))
  val jr_target  = Wire(UInt(32.W))
//  val exception_target = Wire(UInt(32.W))

  pc_next := MuxCase(pc_plus4, Array(
               (io.pc_sel === PC_4)   -> pc_plus4,
//               (io.ctl.pc_sel === PC_BR)  -> br_target,
               (io.pc_sel === PC_J )  -> jmp_target,
               (io.pc_sel === PC_JR)  -> jr_target,
//               (io.ctl.pc_sel === PC_EXC) -> exception_target
               ))

  pc_plus4   := (pc_reg + 4.asUInt(xlen.W))
  jmp_target := pc_reg + imm_j_sext
  jr_target  := rs1_data + imm_i_sext 

  // submodule4 - comparison --- for BR mostly
  
  
  
  
  
  

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







