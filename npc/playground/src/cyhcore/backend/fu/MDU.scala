package cyhcore

import chisel3._
import chisel3.util._
// import Conf._
// import Macros._
// import Macros.Constants._

object MDUOpType {
  def mul    = "b0000".U
  def mulh   = "b0001".U
  def mulhsu = "b0010".U
  def mulhu  = "b0011".U
  def div    = "b0100".U
  def divu   = "b0101".U
  def rem    = "b0110".U
  def remu   = "b0111".U

  def mulw   = "b1000".U
  def divw   = "b1100".U
  def divuw  = "b1101".U
  def remw   = "b1110".U
  def remuw  = "b1111".U

  def isDiv(op: UInt) = op(2)
  def isDivSign(op: UInt) = isDiv(op) && !op(0)
  def isW(op: UInt) = op(3)
}

// class MDU_bundle (implicit val conf: Configuration) extends Bundle() {
//   val alu_op1 = Input(UInt(conf.xlen.W))
//   val alu_op2 = Input(UInt(conf.xlen.W))
//   val alu_op  = Input(UInt(ALU_X.getWidth.W))
//   val alu_msk_type = Input(UInt(ALU_MSK_X.getWidth.W))
//   val result  = Output(UInt(conf.xlen.W))
// }

// // DIV, MUL, REM
// class MDU (implicit val conf: Configuration) extends Module {
//   val io = IO(new MDU_bundle())

//   io.result := MuxCase(
//     0.U, Array(
//       (io.alu_op === ALU_DIV && io.alu_msk_type =/= ALU_MSK_W)    -> (io.alu_op1.asSInt / io.alu_op2.asSInt).asUInt,
//       (io.alu_op === ALU_DIV && io.alu_msk_type === ALU_MSK_W)    -> (io.alu_op1(31, 0).asSInt / io.alu_op2(31, 0).asSInt).asUInt,
//       (io.alu_op === ALU_REM && io.alu_msk_type =/= ALU_MSK_W)    -> (io.alu_op1.asSInt % io.alu_op2.asSInt).asUInt(),
//       (io.alu_op === ALU_REM && io.alu_msk_type === ALU_MSK_W)    -> (io.alu_op1(31, 0).asSInt % io.alu_op2(31, 0).asSInt).asUInt,
//     )
//   )

// }







