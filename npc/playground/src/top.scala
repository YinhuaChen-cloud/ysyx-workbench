import chisel3._
import chisel3.util._

class top extends Module {
  val ifu = Module(new IFU)
  val exu = Module(new EXU)
  ifu.io <> exu.io
}
