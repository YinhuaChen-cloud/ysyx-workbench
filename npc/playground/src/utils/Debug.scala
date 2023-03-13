package utils

import chisel3._
import chisel3.util._

object Debug {

  val debug = true // Scala Boolean

  def apply(fmt: String, data: Bits*): Any = // 这行抄的（理直气壮）
    apply(Printable.pack(fmt, data:_*))

  def apply(pable: Printable) {
    if(debug)
      printf("[Cycle: %ld]", CTimer())
      printf(pable)
      printf("\n")
  }
}