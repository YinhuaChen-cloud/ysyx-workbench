import chisel3._
import chisel3.util._
import Conf._
import Macros._
import Macros.Constants._

class MDU_bundle (implicit val conf: Configuration) extends Bundle() {
  val alu_op1 = Input(UInt(conf.xlen.W))
  val alu_op2 = Input(UInt(conf.xlen.W))
  val alu_op  = Input(UInt(ALU_X.getWidth.W))
  val alu_msk_type = Input(UInt(ALU_MSK_X.getWidth.W))
  val result  = Output(UInt(conf.xlen.W))
}

// DIV, MUL, REM
class MDU (implicit val conf: Configuration) extends Module {
  val io = IO(new MDU_bundle())

  val result_aux = MuxCase(
    0.U, Array(
      (io.alu_op === ALU_DIV && io.alu_msk_type =/= ALU_MSK_W)    -> (io.alu_op1.asSInt / io.alu_op2.asSInt).asUInt(),
      (io.alu_op === ALU_DIV && io.alu_msk_type === ALU_MSK_W)    -> (io.alu_op1(31, 0).asSInt / io.alu_op2(31, 0).asSInt).asUInt(),
    )
  )

  io.result := result_aux(conf.xlen-1, 0)

}







