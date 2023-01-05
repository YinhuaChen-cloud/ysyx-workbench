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
  val CNT_MAX = 50000000
  val cnt = RegInit(0.U(32.W))

  when(cnt < CNT_MAX) {
    cnt := cnt + 1
  }.otherwise {
    cnt := 0
    x := ~x
  }

  io.led := x
}
