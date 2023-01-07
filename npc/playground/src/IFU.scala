import chisel3._

class IFU (xlen: Int = 64) extends Module {
  val io = IO(new Bundle {
    val pc_wen = Input(Bool())
    val pc_wdata = Input(UInt(xlen.W))
    val pc = Output(UInt(xlen.W))
  })

  val pc_reg = RegInit("h80000000".U(xlen.W))
  pc_reg := Mux(io.pc_wen, io.pc_wdata, pc_reg + 4.U)
  io.pc := pc_reg

}

