package utils

import chisel3._
import chisel3.util._

object Debug {
  def apply(pable: Printable) {
    printf(pable)
  }
}