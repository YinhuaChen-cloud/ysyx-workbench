import chisel3._
import chisel3.util._
import Conf._

class MDU_bundle (implicit val conf: Configuration) extends Bundle() {
  val alu_op1 = Input(UInt(conf.xlen.W))
  val alu_op2 = Input(UInt(conf.xlen.W))
  val alu_op  = Input(UInt(ALU_X.getWidth.W))
  val result  = Output(UInt(conf.xlen.W))
}

// DIV, MUL, REM
class MDU (implicit val conf: Configuration) extends Module {
  val io = IO(new MDU_bundle())

  io.result := MuxCase(
    0.U, Array(
//      (io.alu_op === ALU_MUX)    -> (alu_op1 * alu_op2).asUInt(),
      (io.alu_op === ALU_DIV)    -> (alu_op1 / alu_op2).asUInt(),
//      (io.alu_op === ALU_DIV && io.idu_to_exu.alu_msk_type =/= ALU_MSK_W)    -> (alu_op1.asSInt / alu_op2.asSInt).asUInt(),
//      (io.alu_op === ALU_DIV && io.idu_to_exu.alu_msk_type === ALU_MSK_W)    -> (alu_op1(31, 0).asSInt / alu_op2(31, 0).asSInt).asUInt(),
//      (io.alu_op === ALU_REM)    -> (alu_op1 % alu_op2).asUInt(),
    )
  )

}







