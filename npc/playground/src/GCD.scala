import chisel3._

/**
  * Compute GCD using subtraction method.
  * Subtracts the smaller from the larger until register y is zero.
  * value in register x is then the GCD
  */
class GCD extends Module {
  val io = IO(new Bundle {
    val led   = Output(Bool())
  })

  val x = RegInit(0.U(1.W))

  x := ~x
  io.led := x
}
