package utils

import chisel3._
import chisel3.util._

// Cycle timer to debug
object CTimer {

  val MAX_CYCLE_BITS = 64

  def apply() = {
    val c = RegInit(0.U(MAX_CYCLE_BITS.W))
    c := c + 1.U
    c
  }
}

