import chisel3._
import chisel3.util._

class IFU extends Module {
  val io = IO(new Bundle{
    val pc_next = Input(UInt(32.W))
    val pc      = Output(UInt(32.W))
  })
  val pc_reg = RegInit("h8000_0000".U(32.W))
  pc_reg := io.pc_next
  io.pc  := pc_reg
}
