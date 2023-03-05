package cyhcore

import chisel3._
import chisel3.util._

trait HasCyhCoreParameter {
  // General Parameter for NutShell
  val XLEN = 64
  val PC_LEN = 64
  val NR_GPRS = 32 // 通用寄存器的数量 x0 - x31
  val INST_LEN = 32 // 指令的位宽一般是32, 暂不支持压缩指令
  val VAddrBits = 39 // riscv32 的虚拟地址位数是32， 64位的位数则是39 
  val PAddrBits = 32 // PAddrBits is Phyical Memory addr bits
  val DataBits = XLEN
}

abstract class CyhCoreModule extends Module with HasCyhCoreParameter
abstract class CyhCoreBundle extends Bundle with HasCyhCoreParameter

