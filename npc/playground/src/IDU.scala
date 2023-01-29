import chisel3._
import chisel3.util._
//import scala.collection.immutable.ArraySeq
import Macros._
import Macros.RV64Inst._
import Macros.Constants._

class IDU (xlen: Int = 64, 
  inst_len: Int = 32,
  nr_reg: Int = 32,
  reg_sel: Int = 5) extends Module {
  val io = IO(new Bundle {
    val inst = Input(UInt(inst_len.W))
    val pc_sel    = Output(UInt(BR_N.getWidth.W))
    val op1_sel   = Output(UInt(OP1_X.getWidth.W))
    val op2_sel   = Output(UInt(OP2_X.getWidth.W))
    val alu_op    = Output(UInt(ALU_X.getWidth.W))
    val reg_wen   = Output(Bool())
    val isEbreak  = Output(Bool())
    val inv_inst  = Output(Bool()) // TODO: need to connect to DPIC
  })

//
//  // submodule2 - instruction decoder: decode inst
  // The core of DecodeUnit
  val decoded_signals = ListLookup(
    io.inst,
    // invalid
                   List(N, BR_N , OP1_X  , OP2_X  , ALU_X  , WREG_0),
    Array(
      // R-type
      // I-type
      ADDI      -> List(Y, BR_N , OP1_RS1, OP2_IMI, ALU_ADD, WREG_1),
      JALR      -> List(Y, BR_JR, OP1_RS1, OP2_IMI, ALU_X  , WREG_1),
      // S-type
      SD        -> List(Y, BR_N , OP1_RS1, OP2_IMS, ALU_ADD, WREG_0),
      // B-type
      // U-type
      AUIPC     -> List(Y, BR_N , OP1_IMU, OP2_PC , ALU_ADD, WREG_1),
      // J-type
      JAL       -> List(Y, BR_J , OP1_X  , OP2_X  , ALU_X  , WREG_1),
      // ebreak
      EBREAK    -> List(Y, BR_N , OP1_X  , OP2_X  , ALU_X  , WREG_0),
    )
  )

  val (valid_inst: Bool) :: br_type :: op1_sel :: op2_sel :: alu_op :: (wreg: Bool) :: Nil = decoded_signals


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

