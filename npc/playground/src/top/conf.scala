package Conf {
import chisel3._
import chisel3.util._

case class Configuration() {
  val xlen = 64
  val inst_len = 32
  val nr_reg = 32
  val pc_len = xlen
  val START_ADDR = "h8000_0000".U(pc_len.W)
//   val nxprbits = log2Ceil(nxpr)
//   val rvc = false
}

}

