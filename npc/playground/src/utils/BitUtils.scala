package utils

import chisel3._
import chisel3.util._

object SignExt {
  def apply(a: UInt, len: Int) = {
    val aLen = a.getWidth // 获取长度
    val signBit = a(aLen-1) // 获取符号位
    if (aLen >= len) a(len-1,0) else Cat(Fill(len - aLen, signBit), a) // 如果过长，截断，否则，补齐
  }
}

object ZeroExt {
  def apply(a: UInt, len: Int) = {
    val aLen = a.getWidth // 获取长度
    if (aLen >= len) a(len-1,0) else Cat(0.U((len - aLen).W), a) // 如果过长，截断，否则，补齐
  }
}



