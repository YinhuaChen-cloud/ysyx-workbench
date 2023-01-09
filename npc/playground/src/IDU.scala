//xiangshan's IDU is here: XiangShan/src/main/scala/xiangshan/backend/decode/DecodeUnit.scala
//Strongly recommend to refer to it
//I can refer to it after I can run mario

import chisel3._
import chisel3.util._
import chisel3.stage.ChiselStage
import chisel3.experimental.ChiselEnum

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
  def ADDI = BitPat("b?????????????????000?????0010011")
  // `ysyx_22050039_INSTPAT(32'b00000000000100000000000001110011, 20'b0, Special, Ebreak, `ysyx_22050039_NO_WPC, `ysyx_22050039_NO_WREG)
  def EBREAK = BitPat("b00000000000100000000000001110011")
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
  val reg_each_wen = Wire(Vec(nr_reg, Bool())) // TODO: not drive yet
  val reg_total_wen = Wire(Bool()) // TODO: not drive yet

  reg_stack(0) := 0.U // $zero/x0 is always 0 TODO: what will happen to pending wire?
  for(i <- 1 to nr_reg-1) {
    reg_stack(i) := Mux(reg_total_wen & reg_each_wen(i), io.exec_result, reg_stack(i)) 
  }

//   // submodule2 - instruction decoder: decode inst
//   val rd = Wire(UInt(reg_sel.W))
//   val rs1 = Wire(UInt(reg_sel.W))
//   val rs2 = Wire(UInt(reg_sel.W))
//   rd := inst(11:7) // TODO: not used yet
//   rs1 := inst(19:15) // TODO: not used yet
//   rs2 := inst(24:20) // TODO: not used yet

//   class Inst_Segs extends Bundle {
//     val imm = Wire(UInt(20.W))
//     val InstType = Wire(RV64InstrType())
//     val exuop = Wire(UInt(macros.func_len.W)) // TODO: need to connect with io
//     val pc_wen = Wire(Bool()) // TODO: need to connect with io
//     val reg_total_wen = Wire(Bool()) // TODO: need to connect with io
//   }

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
//   val decoder = MuxCase(,
//     Array(
//       ADDI -> a,
//       EBREAK -> b
//   // `ysyx_22050039_INSTPAT(32'b?????????????????000?????0010011, {{8{inst[31]}}, inst[31:20]}, Itype, Addi, `ysyx_22050039_NO_WPC, `ysyx_22050039_WREG)
//   // `ysyx_22050039_INSTPAT(32'b00000000000100000000000001110011, 20'b0, Special, Ebreak, `ysyx_22050039_NO_WPC, `ysyx_22050039_NO_WREG)
//     )
//   )

  io.src1 := 0.U
  io.src2 := 0.U
  io.destI := 0.U
  io.exuop := 0.U
  io.pc_wen := 0.U

}







