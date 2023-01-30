package Conf {
import chisel3._
import chisel3.util._

case class Configuration() {
   val xlen = 64
   val inst_len = 32
   val pc_len = 32
   val START_ADDR = "h8000_0000".U(32.W)
//   val nxprbits = log2Ceil(nxpr)
//   val rvc = false
//   val vm = false
//   val usingUser = false
}


}

