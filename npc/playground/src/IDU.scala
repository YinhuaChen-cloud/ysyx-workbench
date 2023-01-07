//xiangshan's IDU is here: XiangShan/src/main/scala/xiangshan/backend/decode/DecodeUnit.scala
//Strongly recommend to refer to it
//I can refer to it after I can run mario

//import chisel3._
//
//class IDU (xlen: Int, 
//  inst_len: Int,
//  nr_reg: Int,
//  reg_sel: Int) extends Module {
//  val io = IO(new Bundle {
//    val pc_wen = Input(Bool())
//    val pc_wdata = Input(UInt(xlen.W))
//    val pc = Output(UInt(xlen.W))
//  })
//
//  val pc_reg = RegInit("h80000000".U(xlen.W))
//  pc_reg := Mux(io.pc_wen, io.pc_wdata, pc_reg + 4.U)
//  io.pc := pc_reg
//
//}







