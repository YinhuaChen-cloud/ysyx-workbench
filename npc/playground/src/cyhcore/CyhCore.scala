package cyhcore

import chisel3._
import chisel3.util._

trait HasCyhCoreParameter {
  // General Parameter for NutShell
  val XLEN = 64
}

abstract class CyhCoreModule extends Module with HasCyhCoreParameter
abstract class CyhCoreBundle extends Bundle with HasCyhCoreParameter

