import chisel3._
import chisel3.util._

class EXU extends Module {
  val io = IO(new Bundle{
    val pc      = Iutput(UInt(32.W))
    val pc_next = Output(UInt(32.W))
  })
  pc_next := pc + 4.U
}
