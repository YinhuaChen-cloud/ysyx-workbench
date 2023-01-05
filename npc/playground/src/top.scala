//在Chisel中, when和switch的语义和Verilog的行为建模非常相似, 因此也不建议初学者使用. 相反, 你可以使用MuxOH等库函数来实现选择器的功能, 具体可以查阅Chisel的相关资料.

import chisel3._

/**
  * Compute GCD using subtraction method.
  * Subtracts the smaller from the larger until register y is zero.
  * value in register x is then the GCD
  */
class top extends Module {
  val io = IO(new Bundle {
    val led   = Output(Bool())
  })

  val x = RegInit(0.U(1.W))
  val CNT_MAX = 25000000.U
  val cnt = RegInit(0.U(32.W))

  when(cnt < CNT_MAX) {
    cnt := cnt + 1.U
  }.otherwise {
    cnt := 0.U
    x := ~x
  }

  io.led := x
}
