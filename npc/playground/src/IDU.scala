//xiangshan's IDU is here: XiangShan/src/main/scala/xiangshan/backend/decode/DecodeUnit.scala
//Strongly recommend to refer to it
//I can refer to it after I can run mario

import chisel3._
import chisel3.util._
import chisel3.stage.ChiselStage
import chisel3.experimental.ChiselEnum
import scala.collection.immutable.ArraySeq

object RV64InstType extends ChiselEnum {
  val Rtype, Itype, Stype, Btype, Utype, Jtype, Special, InvalidType = Value
}

object RV64ExuOp extends ChiselEnum {
  val Addi, Auipc, Jal, Jalr, Sd, Ebreak, Invalid = Value
}

object RV64Inst {
  def ADDI(inst: UInt) = (BitPat("b?????????????????000?????0010011") === inst)
  def AUIPC(inst: UInt) = (BitPat("b?????????????????????????0010111") === inst)
  def JAL(inst: UInt) = (BitPat("b?????????????????????????1101111") === inst)
  def JALR(inst: UInt) = (BitPat("b?????????????????000?????1100111") === inst)
  def SD(inst: UInt) = (BitPat("b?????????????????011?????0100011") === inst)
  def EBREAK(inst: UInt) = (BitPat("b00000000000100000000000001110011") === inst)
}

object RV64GeneralMacros {
  val WPC = 1.U
  val NO_WPC = 0.U
  val WREG = 1.U
  val NO_WREG = 0.U

  def SEXT(xlen: Int, bits: UInt, bitlen: Int) = {
    assert(xlen >= bitlen)
    assert(bits.getWidth == bitlen)
    Cat(Fill(xlen-bitlen, bits(bitlen-1)), bits)
  }

  def UEXT(xlen: Int, bits: UInt, bitlen: Int) = {
    assert(xlen >= bitlen)
    assert(bits.getWidth == bitlen)
    Cat(Fill(xlen-bitlen, 0.U(1.W)), bits)
  }
}

class IDU (xlen: Int = 64, 
  inst_len: Int = 32,
  nr_reg: Int = 32,
  reg_sel: Int = 5) extends Module {
  val io = IO(new Bundle {
    val inst = Input(UInt(inst_len.W))
    val exec_result = Input(UInt(xlen.W))
    val src1 = Output(UInt(xlen.W))
    val src2 = Output(UInt(xlen.W))
    val destI = Output(UInt(xlen.W))
    val exuop = Output(UInt(macros.func_len.W))
    val pc_wen = Output(Bool())
  })

  // submodule1 - registers_heap: generate GPRS x0-x31
  val reg_stack = RegInit(VecInit(Seq.fill(nr_reg)(0.U(xlen.W))))
  val reg_each_wen = Wire(UInt(nr_reg.W)) // TODO: not drive yet
  val reg_total_wen = Wire(Bool()) // TODO: not drive yet

  reg_stack(0) := 0.U // $zero/x0 is always 0 TODO: what will happen to pending wire?
  for(i <- 1 to nr_reg-1) {
    reg_stack(i) := Mux(reg_total_wen & reg_each_wen(i), io.exec_result, reg_stack(i)) 
  }

  // submodule2 - instruction decoder: decode inst
  val rd = Wire(UInt(reg_sel.W))
  val rs1 = Wire(UInt(reg_sel.W))
  val rs2 = Wire(UInt(reg_sel.W))
  rd := io.inst(11, 7) // TODO: not used yet
  rs1 := io.inst(19, 15) // TODO: not used yet
  rs2 := io.inst(24, 20) // TODO: not used yet

  class Decoded_output extends Bundle {
    val imm = UInt(20.W)
    val instType = RV64InstType()
    val exuop = UInt(macros.func_len.W) // TODO: need to connect with io
    val pc_wen = Bool() // TODO: need to connect with io
    val reg_total_wen = Bool() // TODO: need to connect with io
  }

//   // val z = Wire(UInt(9.W))
//   // z := ...
//   // val unpacked = z.asTypeOf(new MyBundle)
//   // unpacked.a
//   // unpacked.b
//   // unpacked.c

  // The core of DecodeUnit
  import RV64Inst._
  import RV64InstType._
  import RV64ExuOp._
  import RV64GeneralMacros._

  val decoded_output = Wire(UInt())
  decoded_output := MuxCase( Cat(Fill(20, 0.U(1.W)), Special.asUInt, Invalid.asUInt, NO_WPC, NO_WREG),
    ArraySeq.unsafeWrapArray(Array(
      ADDI(io.inst) -> Cat(Fill(8, io.inst(31)), io.inst(31, 20), Itype.asUInt, Addi.asUInt, NO_WPC, WREG),
      AUIPC(io.inst) -> Cat(io.inst(31, 12), Utype.asUInt, Auipc.asUInt, NO_WPC, WREG),
      JAL(io.inst) -> Cat(io.inst(31), io.inst(19, 12), io.inst(20), io.inst(30, 21), Jtype.asUInt, Jal.asUInt, WPC, WREG),
      JALR(io.inst) -> Cat(Fill(8, io.inst(31)), io.inst(31, 20), Itype.asUInt, Jalr.asUInt, WPC, WREG),
      SD(io.inst) -> Cat(Fill(8, io.inst(31)), io.inst(31, 25), io.inst(11, 7), Stype.asUInt, Sd.asUInt, NO_WPC, NO_WREG),
      EBREAK(io.inst) -> Cat(Fill(20, 0.U(1.W)), Special.asUInt, Ebreak.asUInt, NO_WPC, NO_WREG)
    ))
  )

  val unpacked = decoded_output.asTypeOf(new Decoded_output)
  reg_total_wen := unpacked.reg_total_wen 
  io.exuop := unpacked.exuop
  io.pc_wen := unpacked.pc_wen

  // submodule3 - define src1 src2 destI
  assert(unpacked.instType.asUInt >= 0.U && unpacked.instType < InvalidType) 
  io.src1 := MuxLookup(
    unpacked.instType.asUInt, 0.U,
    ArraySeq.unsafeWrapArray(Array(
      Rtype.asUInt -> reg_stack(rs1),
      Itype.asUInt -> reg_stack(rs1),
      Stype.asUInt -> reg_stack(rs1),
      Btype.asUInt -> reg_stack(rs1),
      Utype.asUInt -> Cat(Fill(xlen-32, unpacked.imm(19)), unpacked.imm, Fill(xlen-32-20, 0.U)), // TODO: assume only 32-bit and 64-bit CPU are supported
      Jtype.asUInt -> Cat(Fill(xlen-20-1, unpacked.imm(19)), unpacked.imm, 0.U), // TODO: assume only 32-bit and 64-bit CPU are supported
      Special.asUInt -> 0.U,
    ))
  )

  io.src2 := MuxLookup(
    unpacked.instType.asUInt, 0.U,
    ArraySeq.unsafeWrapArray(Array(
      Rtype.asUInt -> reg_stack(rs2),
      Itype.asUInt -> SEXT(xlen, unpacked.imm, 20),
      Stype.asUInt -> reg_stack(rs2),
      Btype.asUInt -> reg_stack(rs2),
      Utype.asUInt -> 0.U, 
      Jtype.asUInt -> 0.U,
      Special.asUInt -> 0.U,
    ))
  )

  io.destI := 0.U
    
//  io.destI := MuxLookup(
//    unpacked.instType.asUInt, 0.U,
//    ArraySeq.unsafeWrapArray(Array(
//      Rtype.asUInt -> 0.U
//      Itype.asUInt -> 0.U
//      Stype.asUInt -> reg_stack(rs2),
//      Btype.asUInt -> reg_stack(rs2),
//      Utype.asUInt -> 0.U, 
//      Jtype.asUInt -> 0.U,
//      Special.asUInt -> 0.U,
//    ))
//  )

//	All_inst_types inst_type;
//  assign inst_type = {R, I, S, B, U, J};
//  
//  always@(*) begin
//    src1 = 0;
//    src2 = 0;
//		destI = 0;
//    case(inst_type)
//			Rtype		: begin src1 = regs[rs1]; src2 = regs[rs2]; end // checked
//			Itype		: begin src1 = regs[rs1]; src2 = {{44{imm[19]}}, imm}; end // checked
//			Stype		: begin destI = `ysyx_22050039_SEXT(XLEN, imm, 20); src1 = regs[rs1]; src2 = regs[rs2]; end // checked
//			Btype		: begin destI = `ysyx_22050039_SEXT(XLEN, {imm, 1'b0}, 21); src1 = regs[rs1]; src2 = regs[rs2]; end // checked
//			Utype		: begin src1 = {{32{imm[19]}}, imm, 12'b0}; end // checked
//			Jtype		: begin src1 = {{43{imm[19]}}, imm, 1'b0}; end // checked
//			// ebreak and invalid
//			Special	: ;
//			default : assert(0);
//		endcase
//  end
  
  // submodule4 - reg addressing: 5-32 decoder
  // Only 1 bit of output can be high, and that is the reg to write
  assert(rd >= 0.U && rd <= 31.U)
  reg_each_wen := MuxLookup(
    rd, "hdeadbeef".U,
    ArraySeq.unsafeWrapArray(Array(
      0.U -> "h0000_0000".U, // $zero is always 0
      1.U -> "h0000_0002".U,
      2.U -> "h0000_0004".U,
      3.U -> "h0000_0008".U,
      4.U -> "h0000_0010".U,
      5.U -> "h0000_0020".U,
      6.U -> "h0000_0040".U,
      7.U -> "h0000_0080".U,
      8.U -> "h0000_0100".U,
      9.U -> "h0000_0200".U,
      10.U -> "h0000_0400".U,
      11.U -> "h0000_0800".U,
      12.U -> "h0000_1000".U,
      13.U -> "h0000_2000".U,
      14.U -> "h0000_4000".U,
      15.U -> "h0000_8000".U,
      16.U -> "h0001_0000".U,
      17.U -> "h0002_0000".U,
      18.U -> "h0004_0000".U,
      19.U -> "h0008_0000".U,
      20.U -> "h0010_0000".U,
      21.U -> "h0020_0000".U,
      22.U -> "h0040_0000".U,
      23.U -> "h0080_0000".U,
      24.U -> "h0100_0000".U,
      25.U -> "h0200_0000".U,
      26.U -> "h0400_0000".U,
      27.U -> "h0800_0000".U,
      28.U -> "h1000_0000".U,
      29.U -> "h2000_0000".U,
      30.U -> "h4000_0000".U,
      31.U -> "h8000_000".U
    ))
  )

}







