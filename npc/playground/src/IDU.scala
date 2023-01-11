//xiangshan's IDU is here: XiangShan/src/main/scala/xiangshan/backend/decode/DecodeUnit.scala
//Strongly recommend to refer to it
//I can refer to it after I can run mario

import chisel3._
import chisel3.util._
import chisel3.stage.ChiselStage
import chisel3.experimental.ChiselEnum
import scala.collection.immutable.ArraySeq

object RV64InstrType extends ChiselEnum {
  val Rtype, Itype, Stype, Btype, Utype, Jtype, Special = Value
  // Special: Ebreak, Invalid
  // val R = Wire(Bool())
  // val I = Wire(Bool())
  // val S = Wire(Bool())
  // val B = Wire(Bool())
  // val U = Wire(Bool())
  // val J = Wire(Bool())
}

// addi
// auipc
// jal
// jalr
// sd
// ebreak
object RV64Instr {
  // `ysyx_22050039_INSTPAT(32'b?????????????????000?????0010011, {{8{inst[31]}}, inst[31:20]}, Itype, Addi, `ysyx_22050039_NO_WPC, `ysyx_22050039_WREG)
  def ADDI(inst: UInt) = (BitPat("b?????????????????000?????0010011") === inst)
  // `ysyx_22050039_INSTPAT(32'b00000000000100000000000001110011, 20'b0, Special, Ebreak, `ysyx_22050039_NO_WPC, `ysyx_22050039_NO_WREG)
  def EBREAK(inst: UInt) = (BitPat("b00000000000100000000000001110011") === inst)
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
    val imm = Wire(UInt(20.W))
    val InstType = Wire(RV64InstrType())
    val exuop = Wire(UInt(macros.func_len.W)) // TODO: need to connect with io
    val pc_wen = Wire(Bool()) // TODO: need to connect with io
    val reg_total_wen = Wire(Bool()) // TODO: need to connect with io
  }

//   // val z = Wire(UInt(9.W))
//   // z := ...
//   // val unpacked = z.asTypeOf(new MyBundle)
//   }

//   // val z = Wire(UInt(9.W))
//   // z := ...
//   // val unpacked = z.asTypeOf(new MyBundle)
//   // unpacked.a
//   // unpacked.b
//   // unpacked.c

// `define ysyx_22050039_INSTINVALID() \
// 	default : bundle = {
// 		{inst[31], \
// 		inst[19:12], inst[20], inst[30:21]}, Special, Invalid, 1'b0, 1'b0}; 

   // The core of DecodeUnit
  val decoded_output = Wire(UInt())
    decoded_output := MuxCase(0.U,
      ArraySeq.unsafeWrapArray(Array(
        RV64Instr.ADDI(io.inst) -> Cat(Fill(16, 1.U(1.W)), "h5678".U(16.W)),
        RV64Instr.EBREAK(io.inst) -> "hdeadbeef".U 
    // `ysyx_22050039_INSTPAT(32'b?????????????????000?????0010011, {{8{inst[31]}}, inst[31:20]}, Itype, Addi, `ysyx_22050039_NO_WPC, `ysyx_22050039_WREG)
    // `ysyx_22050039_INSTPAT(32'b00000000000100000000000001110011, 20'b0, Special, Ebreak, `ysyx_22050039_NO_WPC, `ysyx_22050039_NO_WREG)
    //`define ysyx_22050039_INSTPAT(pattern, imm, type, func, pc_wen, reg_wen) \
    //	pattern: bundle = {inst[6:0], inst[14:12], \
    //		inst[11:7], inst[19:15], inst[24:20], inst[31:25], imm, \
    //		type, func, pc_wen, reg_wen}; 
    ))
  )
  printf("decoded_output = 0x%x\n", decoded_output)

  // submodule4 - reg addressing: 5-32 decoder
  // Only 1 bit of output can be high, and that is the reg to write
  assert(reg_each_wen =/= "hdeadbeef".U)
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

  reg_total_wen := 1.U 
  io.src1 := 0.U
  io.src2 := 0.U
  io.destI := 0.U
  io.exuop := 0.U
  io.pc_wen := 0.U

}







