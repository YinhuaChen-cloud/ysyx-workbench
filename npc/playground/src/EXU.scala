import chisel3._
import chisel3.util._

class EXU extends Module {
  val io = IO(new Bundle{
    val pc      = Input(UInt(32.W))
    val pc_next = Output(UInt(32.W))
  })
  io.pc_next := io.pc + 4.U
}
