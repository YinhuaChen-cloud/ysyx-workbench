import chisel3._
import chisel3.util._
//import chisel3.stage.ChiselStage
//import chisel3.experimental.ChiselEnum
//import scala.collection.immutable.ArraySeq
import Macros._
//import Macros.RV64ExuOp._
import Macros.RV64Inst._
import Macros.Constants._

//object RV64InstType extends ChiselEnum {
//  val Rtype, Itype, Stype, Btype, Utype, Jtype, Special, InvalidInstType = Value
//}
//
//object RV64GeneralMacros {
//  val WPC = true.B
//  val NO_WPC = false.B
//  val WREG = true.B
//  val NO_WREG = false.B
//
//  def SEXT(xlen: Int, bits: UInt) = {
//    assert(xlen >= bits.getWidth)
//    Cat(Fill(xlen-bits.getWidth, bits(bits.getWidth-1)), bits)
//  }
//
//  def UEXT(xlen: Int, bits: UInt) = {
//    assert(xlen >= bits.getWidth)
//    Cat(Fill(xlen-bits.getWidth, bits(bits.getWidth-1)), bits)
//  }
//}
//
//import RV64InstType._
//import RV64GeneralMacros._

class IDU (xlen: Int = 64, 
  inst_len: Int = 32,
  nr_reg: Int = 32,
  reg_sel: Int = 5) extends Module {
  val io = IO(new Bundle {
    val inst = Input(UInt(inst_len.W))
//    val exec_result = Input(UInt(xlen.W))
//    val src1 = Output(UInt(xlen.W))
//    val src2 = Output(UInt(xlen.W))
//    val destI = Output(UInt(xlen.W))
//    val exuop = Output(RV64ExuOp())
//    val pc_wen = Output(Bool())
    val pc_sel    = Output(UInt(BR_N.getWidth.W))
    val op1_sel   = Output(UInt(OP1_X.getWidth.W))
    val op2_sel   = Output(UInt(OP2_X.getWidth.W))
    val alu_op    = Output(UInt(ALU_X.getWidth.W))
    val reg_wen   = Output(Bool())
    val isEbreak  = Output(Bool())
    val inv_inst  = Output(Bool())
  })

//  // submodule1 - registers_heap: generate GPRS x0-x31
//  val reg_stack = RegInit(VecInit(Seq.fill(nr_reg)(0.U(xlen.W))))
//  val reg_each_wen = Wire(UInt(nr_reg.W)) // TODO: not drive yet
//  val reg_total_wen = Wire(Bool()) // TODO: not drive yet
//
//  reg_stack(0) := 0.U // $zero/x0 is always 0 TODO: what will happen to pending wire?
//  for(i <- 1 to nr_reg-1) {
//    reg_stack(i) := Mux(reg_total_wen & reg_each_wen(i), io.exec_result, reg_stack(i)) 
//  }
//
//  // submodule2 - instruction decoder: decode inst
//  val rd = Wire(UInt(reg_sel.W))
//  val rs1 = Wire(UInt(reg_sel.W))
//  val rs2 = Wire(UInt(reg_sel.W))
//  rd := io.inst(11, 7) // TODO: not used yet
//  rs1 := io.inst(19, 15) // TODO: not used yet
//  rs2 := io.inst(24, 20) // TODO: not used yet


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
  
//  class Decoded_output extends Bundle {
//    val imm = UInt(20.W)
//    val pc_wen = Bool() // TODO: need to connect with io
//    val reg_total_wen = Bool() // TODO: need to connect with io
//  }
//  
//  val decoded_output = Wire(UInt((new Decoded_output).getWidth.W))
//  decoded_output := MuxCase( Cat(Fill(20, 0.U(1.W)), NO_WPC, NO_WREG),
//    ArraySeq.unsafeWrapArray(Array(
//      ADDI(io.inst) -> Cat(Fill(8, io.inst(31)), io.inst(31, 20), NO_WPC, WREG),
//      AUIPC(io.inst) -> Cat(io.inst(31, 12), NO_WPC, WREG),
//      JAL(io.inst) -> Cat(io.inst(31), io.inst(19, 12), io.inst(20), io.inst(30, 21), WPC, WREG),
//      JALR(io.inst) -> Cat(Fill(8, io.inst(31)), io.inst(31, 20), WPC, WREG),
//      SD(io.inst) -> Cat(Fill(8, io.inst(31)), io.inst(31, 25), io.inst(11, 7), NO_WPC, NO_WREG),
//      EBREAK(io.inst) -> Cat(Fill(20, 0.U(1.W)), NO_WPC, NO_WREG)
//    ))
//  )
//  val unpacked = decoded_output.asTypeOf(new Decoded_output)
//  reg_total_wen := unpacked.reg_total_wen 
//  io.pc_wen := unpacked.pc_wen
//
//  io.exuop := MuxCase( InvalidExuOp,
//    ArraySeq.unsafeWrapArray(Array(
//      ADDI(io.inst) -> Addi,
//      AUIPC(io.inst) -> Auipc,
//      JAL(io.inst) -> Jal,
//      JALR(io.inst) -> Jalr,
//      SD(io.inst) -> Sd,
//      EBREAK(io.inst) -> Ebreak
//    ))
//  )
//
//  val instType = Wire(RV64InstType())
//  instType := MuxCase( Special,
//    ArraySeq.unsafeWrapArray(Array(
//      ADDI(io.inst) -> Itype,
//      AUIPC(io.inst) -> Utype,
//      JAL(io.inst) -> Jtype,
//      JALR(io.inst) -> Itype,
//      SD(io.inst) -> Stype,
//      EBREAK(io.inst) -> Special
//    ))
//  )
//
//  // submodule3 - determine src1 src2 destI
////  Predef.printf("======predef=========Utype.getWidth = %d\n", Utype.getWidth)
////  printf("======predef=========Utype.asUInt = %d\n", Utype.asUInt)
////  printf("invalid = %d\n", InvalidInstType.asUInt)
//  assert(instType.asUInt >= 0.U && instType < InvalidInstType) 
//  io.src1 := MuxLookup(
//    instType.asUInt, 0.U,
//    ArraySeq.unsafeWrapArray(Array(
//      Rtype.asUInt -> reg_stack(rs1),
//      Itype.asUInt -> reg_stack(rs1),
//      Stype.asUInt -> reg_stack(rs1),
//      Btype.asUInt -> reg_stack(rs1),
//      Utype.asUInt -> Cat(Fill(xlen-32, unpacked.imm(19)), unpacked.imm, Fill(xlen-32-20, 0.U)), // TODO: assume only 32-bit and 64-bit CPU are supported
//      Jtype.asUInt -> Cat(Fill(xlen-20-1, unpacked.imm(19)), unpacked.imm, 0.U), // TODO: assume only 32-bit and 64-bit CPU are supported
//      Special.asUInt -> 0.U,
//    ))
//  )
//
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
//
//  io.destI := MuxLookup(
//    instType.asUInt, 0.U,
//    ArraySeq.unsafeWrapArray(Array(
//      Rtype.asUInt -> 0.U,
//      Itype.asUInt -> 0.U,
//      Stype.asUInt -> SEXT(xlen, unpacked.imm),
//      Btype.asUInt -> SEXT(xlen, Cat(unpacked.imm, 0.U(1.W))),
//      Utype.asUInt -> 0.U, 
//      Jtype.asUInt -> 0.U,
//      Special.asUInt -> 0.U,
//    ))
//  )
  
//  // submodule4 - reg addressing: 5-32 decoder
//  // Only 1 bit of output can be high, and that is the reg to write
//  assert(rd >= 0.U && rd <= 31.U)
//  reg_each_wen := MuxLookup(
//    rd, "hdeadbeef".U,
//    ArraySeq.unsafeWrapArray(Array(
//      0.U -> "h0000_0000".U, // $zero is always 0
//      1.U -> "h0000_0002".U,
//      2.U -> "h0000_0004".U,
//      3.U -> "h0000_0008".U,
//      4.U -> "h0000_0010".U,
//      5.U -> "h0000_0020".U,
//      6.U -> "h0000_0040".U,
//      7.U -> "h0000_0080".U,
//      8.U -> "h0000_0100".U,
//      9.U -> "h0000_0200".U,
//      10.U -> "h0000_0400".U,
//      11.U -> "h0000_0800".U,
//      12.U -> "h0000_1000".U,
//      13.U -> "h0000_2000".U,
//      14.U -> "h0000_4000".U,
//      15.U -> "h0000_8000".U,
//      16.U -> "h0001_0000".U,
//      17.U -> "h0002_0000".U,
//      18.U -> "h0004_0000".U,
//      19.U -> "h0008_0000".U,
//      20.U -> "h0010_0000".U,
//      21.U -> "h0020_0000".U,
//      22.U -> "h0040_0000".U,
//      23.U -> "h0080_0000".U,
//      24.U -> "h0100_0000".U,
//      25.U -> "h0200_0000".U,
//      26.U -> "h0400_0000".U,
//      27.U -> "h0800_0000".U,
//      28.U -> "h1000_0000".U,
//      29.U -> "h2000_0000".U,
//      30.U -> "h4000_0000".U,
//      31.U -> "h8000_000".U
//    ))
//  )

}







