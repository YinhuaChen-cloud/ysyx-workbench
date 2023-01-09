import chisel3._

class EXU (xlen: Int = 64, 
  inst_len: Int = 32) extends Module {
  val io = IO(new Bundle {
    val exuop = Input(UInt(macros.func_len.W))
    val src1 = Input(UInt(xlen.W))
    val src2 = Input(UInt(xlen.W))
    val destI = Input(UInt(xlen.W))
    val pc = Input(UInt(xlen.W))
    // val inst = Output(UInt(inst_len.W))
    val exec_result = Output(UInt(xlen.W))
    val dnpc = Output(UInt(xlen.W))
  })

  // io.inst := 0.U
  io.exec_result := 0.U
  io.dnpc := 0.U

}







