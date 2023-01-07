import chisel3._
import chisel3.util.HasBlackBoxInline

//class IFU (xlen: Int = 64) extends Module {
class IFU (xlen: Int = 64) extends BlackBox with HasBlackBoxInline {
  val io = IO(new Bundle {
    val pc_wen = Input(Bool())
    val pc_wdata = Input(UInt(xlen.W))
    val pc = Output(UInt(xlen.W))
  })

  setInline("IFU.v",
    """import "DPI-C" function void set_pc(input logic [XLEN-1:0] a []);
      |initial set_pc(pc);  
    """.stripMargin)

  val pc_reg = RegInit("h80000000".U(xlen.W))
  pc_reg := Mux(io.pc_wen, io.pc_wdata, pc_reg + 4.U)
  io.pc := pc_reg

}

