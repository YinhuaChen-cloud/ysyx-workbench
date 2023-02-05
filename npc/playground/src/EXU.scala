import chisel3._
import chisel3.util._
import chisel3.stage.ChiselStage
import Conf._
import Macros._
import Macros.Constants._

class EXU_bundle (implicit val conf: Configuration) extends Bundle() {
  val inst = Input(UInt(conf.inst_len.W))
  val idu_to_exu = Flipped(new IDU_to_EXU())
  val ifu_to_exu = Flipped(new IFU_to_EXU())
  val mem_in = Input(UInt(conf.xlen.W))
  val regfile_output = Output(UInt((conf.nr_reg * conf.xlen).W))
  val mem_addr = Output(UInt(conf.xlen.W))
  val mem_write_data = Output(UInt(conf.xlen.W))
  val isRead = Output(Bool())
}

class EXU (implicit val conf: Configuration) extends Module {
  val io = IO(new EXU_bundle())

  // submodule1 - register file
  // 1-1. reg addr
  val rs1_addr = io.inst(RS1_MSB, RS1_LSB)
  val rs2_addr = io.inst(RS2_MSB, RS2_LSB)
  val rd_addr  = io.inst(RD_MSB,  RD_LSB) 
  // 1-2. write back data
  val wb_data = Wire(UInt(conf.xlen.W)) // NOTE: data write back to reg or mem
  // 1-3. register file
  val regfile = RegInit(VecInit(Seq.fill(conf.nr_reg)(0.U(conf.xlen.W))))
  regfile(rd_addr) := Mux((rd_addr =/= 0.U && io.idu_to_exu.reg_wen), wb_data, regfile(rd_addr))

  val regfile_output_aux = Wire(Vec(conf.nr_reg * conf.xlen, Bool()))
  for(i <- 0 until conf.nr_reg) {
    regfile_output_aux.slice(i * conf.xlen, (i+1) * conf.xlen).zip(regfile(i).asBools).foreach{case (a, b) => a := b}
  }
  io.regfile_output := regfile_output_aux.asUInt

  // submodule2 - ALU
  val rs1_data = Mux((rs1_addr =/= 0.U), regfile(rs1_addr), 0.asUInt(conf.xlen.W))
  val rs2_data = Mux((rs2_addr =/= 0.U), regfile(rs2_addr), 0.asUInt(conf.xlen.W))
  // 2-2. calculate imm
  // r
  // i
  val imm_i = io.inst(31, 20)
  // s
  val imm_s = Cat(io.inst(31, 25), io.inst(11,7))
  // b
  val imm_b = Cat(io.inst(31), io.inst(7), io.inst(30,25), io.inst(11,8))
  // u
  val imm_u = io.inst(31, 12)
  // j
  val imm_j = Cat(io.inst(31), io.inst(19,12), io.inst(20), io.inst(30,21))
  // r
  // i
  val imm_i_sext = Cat(Fill(conf.xlen - 12, imm_i(11)), imm_i)
  // s
  val imm_s_sext = Cat(Fill(conf.xlen - 12, imm_s(11)), imm_s)
  // b
  val imm_b_sext = Cat(Fill(conf.xlen - 13, imm_b(11)), imm_b, 0.U)
  // u
  val imm_u_sext = Cat(imm_u, Fill(12, 0.U))
  // j
  val imm_j_sext = Cat(Fill(conf.xlen - 21, imm_j(19)), imm_j, 0.U)
  
  val alu_op1 = Wire(UInt(conf.xlen.W))   
  alu_op1 := MuxCase(0.U, Array(
              (io.idu_to_exu.op1_sel === OP1_RS1) -> rs1_data,
              (io.idu_to_exu.op1_sel === OP1_IMU) -> imm_u_sext,
//              (io.idu_to_exu.op1_sel === OP1_IMZ) -> imm_z
              )).asUInt()
 
  val alu_op2 = Wire(UInt(conf.xlen.W))   
  alu_op2 := MuxCase(0.U, Array(
              (io.idu_to_exu.op2_sel === OP2_RS2) -> rs2_data,
              (io.idu_to_exu.op2_sel === OP2_IMI) -> imm_i_sext,
              (io.idu_to_exu.op2_sel === OP2_IMS) -> imm_s_sext,
              (io.idu_to_exu.op2_sel === OP2_PC)  -> io.ifu_to_exu.pc,
              )).asUInt()
  
  val alu_out = Wire(UInt(conf.xlen.W))   
  alu_out := MuxCase(
    0.U, Array(
      (io.idu_to_exu.alu_op === ALU_ADD)    -> (alu_op1 + alu_op2).asUInt(),
      (io.idu_to_exu.alu_op === ALU_SUB)    -> (alu_op1 - alu_op2).asUInt(),
      (io.idu_to_exu.alu_op === ALU_SLTU)   -> (alu_op1 < alu_op2).asUInt(),
    )
  )
  printf("alu_op1 = 0x%x, alu_op2 = 0x%x\n", alu_op1, alu_op2)

  // submodule3 - next pc
  io.idu_to_exu.br_eq := (rs1_data === rs2_data) 
  io.idu_to_exu.br_eq
  val pc_plus4         = Wire(UInt(32.W))
  val br_target        = Wire(UInt(32.W))
  val jmp_target       = Wire(UInt(32.W))
  val jr_target        = Wire(UInt(32.W))
//  val exception_target = Wire(UInt(32.W))

  pc_plus4   := (io.ifu_to_exu.pc + 4.asUInt(conf.xlen.W))
  br_target  := io.ifu_to_exu.pc + imm_b_sext 
  jmp_target := io.ifu_to_exu.pc + imm_j_sext
  jr_target  := rs1_data + imm_i_sext 

  io.ifu_to_exu.pc_next := MuxCase(pc_plus4, Array(
               (io.idu_to_exu.pc_sel === PC_4)   -> pc_plus4,
               (io.idu_to_exu.pc_sel === PC_BR)  -> br_target,
               (io.idu_to_exu.pc_sel === PC_J )  -> jmp_target,
               (io.idu_to_exu.pc_sel === PC_JR)  -> jr_target,
//               (io.ctl.pc_sel === PC_EXC) -> exception_target
               ))

  // submodule4 - mem reading and writing
  io.isRead := (io.idu_to_exu.wb_sel === WB_MEM)
  io.mem_addr := alu_out
  io.mem_write_data := rs2_data
  // select data part from io.mem_in according to mem_addr(2, 0) 
  val mem_in_sel = Wire(UInt(conf.xlen.W)) 
  mem_in_sel := MuxLookup(
    io.mem_addr(2, 0), 0.U,
    Array(
      0.U -> io.mem_in,
      1.U -> io.mem_in(conf.xlen-1, 8),
      2.U -> io.mem_in(conf.xlen-1, 16),
      3.U -> io.mem_in(conf.xlen-1, 24),
      4.U -> io.mem_in(conf.xlen-1, 32),
      5.U -> io.mem_in(conf.xlen-1, 40),
      6.U -> io.mem_in(conf.xlen-1, 48),
      7.U -> io.mem_in(conf.xlen-1, 56),
    )
  )
  // if the inst is lw, lh, lb. Need to do signed extension
  val mem_in_sel_sext = Wire(UInt(conf.xlen.W)) 
  val mem_in_result = Wire(UInt(conf.xlen.W)) 
  mem_in_sel_sext := MuxCase(0.U, Array(
    (io.idu_to_exu.mem_msk === "hffff_ffff".U) -> Fill(32, mem_in_sel(31)),
    ))
  mem_in_result := Mux(io.idu_to_exu.sign_op, mem_in_sel_sext, mem_in_sel)

  // submodule5 - wb_data
  wb_data := MuxCase(alu_out, Array(
               (io.idu_to_exu.wb_sel === WB_ALU) -> alu_out,
               (io.idu_to_exu.wb_sel === WB_MEM) -> mem_in_result,
               (io.idu_to_exu.wb_sel === WB_PC4) -> pc_plus4,
//               (io.ctl.wb_sel === WB_CSR) -> csr.io.rw.rdata
               )) & io.idu_to_exu.mem_msk

//  printf("io.mem_in = 0x%x, io.idu_to_exu.mem_msk = 0x%x\n", io.mem_in, io.idu_to_exu.mem_msk)

}







