package utils

import chisel3._
import chisel3.util._

object Debug {

  val debug = true.B

  def apply(pable: Printable) {
    if(debug)
      printf(pable)
  }
}