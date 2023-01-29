import chisel3._
import chisel3.util._
import chisel3.stage.ChiselStage

import Macros._
import Macros.Constants._

class EXU (xlen: Int = 64, 
  inst_len: Int = 32,
  nr_reg: Int = 32) extends Module {
  val io = IO(new Bundle {
    val inst = Input(UInt(inst_len.W))

    val pc_sel    = Input(UInt(BR_N.getWidth.W))
    val op1_sel   = Input(UInt(OP1_X.getWidth.W))
    val op2_sel   = Input(UInt(OP2_X.getWidth.W))
    val alu_op    = Input(UInt(ALU_X.getWidth.W))
    val wb_sel    = Input(UInt(WB_X.getWidth.W))
    val reg_wen   = Input(Bool())

    val pc        = Input(UInt(32.W))
    val pc_next   = Output(UInt(32.W))
  })

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
  
  // submodule3 - next pc
  val pc_plus4         = Wire(UInt(32.W))
//  val br_target        = Wire(UInt(32.W))
  val jmp_target       = Wire(UInt(32.W))
  val jr_target  = Wire(UInt(32.W))
//  val exception_target = Wire(UInt(32.W))

  pc_plus4   := (io.pc + 4.asUInt(xlen.W))
  jmp_target := io.pc + imm_j_sext
  jr_target  := rs1_data + imm_i_sext 

  io.pc_next := MuxCase(pc_plus4, Array(
               (io.pc_sel === PC_4)   -> pc_plus4,
//               (io.ctl.pc_sel === PC_BR)  -> br_target,
               (io.pc_sel === PC_J )  -> jmp_target,
               (io.pc_sel === PC_JR)  -> jr_target,
//               (io.ctl.pc_sel === PC_EXC) -> exception_target
               ))

//

  // submodule4 - wb_data
  wb_data := MuxCase(alu_out, Array(
               (io.wb_sel === WB_ALU) -> alu_out,
//               (io.ctl.wb_sel === WB_MEM) -> io.dmem.resp.bits.data,
               (io.wb_sel === WB_PC4) -> pc_plus4,
//               (io.ctl.wb_sel === WB_CSR) -> csr.io.rw.rdata
               ))


//  printf("====== rs1_data = 0x%x, imm_i_sext = 0x%x\n", rs1_data, imm_i_sext)
//  printf("====== ra, regfile(1) = 0x%x\n", regfile(1))
//  printf("====== rd_addr = 0x%x\n", rd_addr)
//  printf("====== wb_data = 0x%x\n", wb_data)

  // submodule4 - comparison --- for BR mostly
  

}







