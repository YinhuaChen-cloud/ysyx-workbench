import chisel3._
import chisel3.util._
import Conf._
import Macros._
import Macros.RV64Inst._
import Macros.Constants._

class IDU_to_EXU (implicit val conf: Configuration) extends Bundle() {
  val br_eq     = Input(Bool())
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
    io.inst,
                   // invalid
                   List(N, BR_N , OP1_X  , OP2_X  , ALU_X   , WB_X  , WREG_0, WMEM_0, MEM_MSK_X, ALU_MSK_X, SIGN_X),
    Array(
      // R-type
      ADD       -> List(Y, BR_N , OP1_RS1, OP2_RS2, ALU_ADD , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X, ALU_MSK_X, SIGN_Y),
      ADDW      -> List(Y, BR_N , OP1_RS1, OP2_RS2, ALU_ADD , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X, ALU_MSK_W, SIGN_Y),
      SUB       -> List(Y, BR_N , OP1_RS1, OP2_RS2, ALU_SUB , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X, ALU_MSK_X, SIGN_N),
      // I-type
      LD        -> List(Y, BR_N , OP1_RS1, OP2_IMI, ALU_ADD , WB_MEM, WREG_1, WMEM_0, MEM_MSK_X, ALU_MSK_X, SIGN_Y),
      LW        -> List(Y, BR_N , OP1_RS1, OP2_IMI, ALU_ADD , WB_MEM, WREG_1, WMEM_0, MEM_MSK_W, ALU_MSK_X, SIGN_Y),
      ADDI      -> List(Y, BR_N , OP1_RS1, OP2_IMI, ALU_ADD , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X, ALU_MSK_X, SIGN_Y),
      ADDIW     -> List(Y, BR_N , OP1_RS1, OP2_IMI, ALU_ADD , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X, ALU_MSK_W, SIGN_Y),
      JALR      -> List(Y, BR_JR, OP1_RS1, OP2_IMI, ALU_X   , WB_PC4, WREG_1, WMEM_0, MEM_MSK_X, ALU_MSK_X, SIGN_N),
      SLTIU     -> List(Y, BR_N , OP1_RS1, OP2_IMI, ALU_SLTU, WB_ALU, WREG_1, WMEM_0, MEM_MSK_X, ALU_MSK_X, SIGN_N),
      SLLI      -> List(Y, BR_N , OP1_RS1, OP2_IMI, ALU_SLL , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X, ALU_MSK_X, SIGN_N),
      // S-type
      SD        -> List(Y, BR_N , OP1_RS1, OP2_IMS, ALU_ADD , WB_X  , WREG_0, WMEM_1, MEM_MSK_X, ALU_MSK_X, SIGN_X),
      // B-type
      BEQ       -> List(Y, BR_EQ, OP1_X  , OP2_X  , ALU_X   , WB_X  , WREG_0, WMEM_0, MEM_MSK_X, ALU_MSK_X, SIGN_Y),
      BNE       -> List(Y, BR_NE, OP1_X  , OP2_X  , ALU_X   , WB_X  , WREG_0, WMEM_0, MEM_MSK_X, ALU_MSK_X, SIGN_Y),
      // U-type
      AUIPC     -> List(Y, BR_N , OP1_IMU, OP2_PC , ALU_ADD , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X, ALU_MSK_X, SIGN_N),
      // J-type
      JAL       -> List(Y, BR_J , OP1_X  , OP2_X  , ALU_X   , WB_PC4, WREG_1, WMEM_0, MEM_MSK_X, ALU_MSK_X, SIGN_N),
      // ebreak
      EBREAK    -> List(Y, BR_N , OP1_X  , OP2_X  , ALU_X   , WB_X  , WREG_0, WMEM_0, MEM_MSK_X, ALU_MSK_X, SIGN_X),
    )
  )

  val (valid_inst: Bool) :: br_type :: op1_sel :: op2_sel :: ds0 = decoded_signals
  val alu_op :: wb_sel :: (wreg: Bool) :: (wmem: Bool) :: ds1 = ds0
  val mem_msk_type :: alu_msk_type :: (sign_op: Bool) :: Nil = ds1

  println(s"In IDU, io.inst = ${io.inst}, and valid_inst = ${valid_inst}")

  io.idu_to_exu.pc_sel  := MuxLookup(
    br_type, PC_EXC,
    Array(
      BR_N  -> PC_4 , 
      BR_J  -> PC_J , 
      BR_JR -> PC_JR, 
      BR_EQ -> Mux(io.idu_to_exu.br_eq , PC_BR, PC_4),
      BR_NE -> Mux(!io.idu_to_exu.br_eq, PC_BR, PC_4),
    )
  )

  io.idu_to_exu.op1_sel := op1_sel
  io.idu_to_exu.op2_sel := op2_sel
  io.idu_to_exu.alu_op  := alu_op
  io.idu_to_exu.wb_sel  := wb_sel
  io.idu_to_exu.reg_wen := wreg
  io.isEbreak := (io.inst === EBREAK)
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

