//在Chisel中, when和switch的语义和Verilog的行为建模非常相似, 因此也不建议初学者使用. 相反, 你可以使用MuxOH等库函数来实现选择器的功能, 具体可以查阅Chisel的相关资料.

import chisel3._

class top extends Module {
  val xlen = 32
  val io = IO(new Bundle {
    val led = Output(Bool())
  })

  val ifu = Module(new IFU(xlen))
  ifu.io.pc_wen := 0.U
  ifu.io.pc_wdata := 1.U
  io.led := ifu.io.pc(31)

}

