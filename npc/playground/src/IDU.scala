import chisel3._
import chisel3.util._
import Conf._
import Macros._
import Macros.RV64Inst._
import Macros.Constants._

class IDU (implicit val conf: Configuration) extends Module {
  val io = IO(new Bundle {
    val inst = Input(UInt(conf.inst_len.W))

    val pc_sel    = Output(UInt(BR_N.getWidth.W))
    val op1_sel   = Output(UInt(OP1_X.getWidth.W))
    val op2_sel   = Output(UInt(OP2_X.getWidth.W))
    val alu_op    = Output(UInt(ALU_X.getWidth.W))
    val wb_sel    = Output(UInt(WB_X.getWidth.W))
    val reg_wen   = Output(Bool())

    val isEbreak  = Output(Bool())
    val inv_inst  = Output(Bool()) // TODO: need to connect to DPIC
  })

  // The core of DecodeUnit
  val decoded_signals = ListLookup(
    io.inst,
                   // invalid
                   List(N, BR_N , OP1_X  , OP2_X  , ALU_X  , WB_X  , WREG_0),
    Array(
      // R-type
      // I-type
      ADDI      -> List(Y, BR_N , OP1_RS1, OP2_IMI, ALU_ADD, WB_ALU, WREG_1),
      JALR      -> List(Y, BR_JR, OP1_RS1, OP2_IMI, ALU_X  , WB_PC4, WREG_1),
      // S-type
      SD        -> List(Y, BR_N , OP1_RS1, OP2_IMS, ALU_ADD, WB_MEM, WREG_0),
      // B-type
      // U-type
      AUIPC     -> List(Y, BR_N , OP1_IMU, OP2_PC , ALU_ADD, WB_ALU, WREG_1),
      // J-type
      JAL       -> List(Y, BR_J , OP1_X  , OP2_X  , ALU_X  , WB_PC4, WREG_1),
      // ebreak
      EBREAK    -> List(Y, BR_N , OP1_X  , OP2_X  , ALU_X  , WB_X  , WREG_0),
    )
  )

  val (valid_inst: Bool) :: br_type :: op1_sel :: op2_sel :: ds0 = decoded_signals
  val alu_op :: wb_sel :: (wreg: Bool) :: Nil = ds0

  io.pc_sel  := MuxLookup(
    br_type, PC_EXC,
    Array(
      BR_N  -> PC_4 , 
      BR_J  -> PC_J , 
      BR_JR -> PC_JR, 
    )
  )

  io.op1_sel := op1_sel
  io.op2_sel := op2_sel
  io.alu_op  := alu_op
  io.wb_sel  := wb_sel
  io.reg_wen := wreg
  io.isEbreak := (io.inst === EBREAK)
  io.inv_inst := ~valid_inst
  
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

