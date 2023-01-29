import chisel3._
import chisel3.util._

class top extends Module {
  val io = IO(new Bundle{
    val pc      = Output(UInt(32.W))
  })

  val ifu = Module(new IFU)
  val exu = Module(new EXU)
  ifu.io <> exu.io
  io.pc := ifu.io.pc
}
