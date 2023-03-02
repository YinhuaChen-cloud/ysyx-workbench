package cyhcore

import chisel3._
import chisel3.util._
import chisel3.experimental.ExtModule
import chisel3.experimental.Param

trait HasCyhCoreParameter {
  // General Parameter for NutShell
  val XLEN = 64
  val VAddrBits = 39 // riscv32 的虚拟地址位数是32， 64位的位数则是39 
  val PAddrBits = 32 // PAddrBits is Phyical Memory addr bits
  val DataBits = XLEN
}

abstract class CyhCoreModule extends Module with HasCyhCoreParameter
abstract class CyhCoreBundle extends Bundle with HasCyhCoreParameter
abstract class CyhCoreExtModule (val params: Map[String, Param] = Map.empty[String, Param]) extends ExtModule(params) with HasCyhCoreParameter

