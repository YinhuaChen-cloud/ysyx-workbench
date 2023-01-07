//xiangshan's IDU is here: XiangShan/src/main/scala/xiangshan/backend/decode/DecodeUnit.scala
//Strongly recommend to refer to it
//I can refer to it after I can run mario

import chisel3._

class IDU (xlen: Int = 64, 
  inst_len: Int = 32,
  nr_reg: Int = 32,
  reg_sel: Int = 5) extends Module {
  val io = IO(new Bundle {
                           output Allinst func,
    val inst = Input(UInt(inst_len.W))
    val exec_result = Input(UInt(xlen.W))
    val src1 = Output(UInt(xlen.W))
    val src2 = Output(UInt(xlen.W))
    val destI = Output(UInt(xlen.W))
    val func = Output()
    val pc_wen = Output(Bool())
  })

  val pc_reg = RegInit("h80000000".U(xlen.W))
  pc_reg := Mux(io.pc_wen, io.pc_wdata, pc_reg + 4.U)
  io.pc := pc_reg

}







