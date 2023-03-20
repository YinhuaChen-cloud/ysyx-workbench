package utils

import chisel3._
import chisel3.util._

object BoolStopWatch {
  def apply(start: Bool, stop: Bool, startHighPriority: Boolean = false) = { // start 用来表示什么时候开始; stop 用来表示什么时候结束; startHighPriority 当前两个信号都为高，start更优先, 否则，stop更优先。
    val r = RegInit(false.B) // 一个寄存器，默认为 false, 表示是否在工作
    if (startHighPriority) {
      when (stop) { r := false.B } // 当 stop 为高，停止工作
      when (start) { r := true.B } // 当 start 为高， 开始工作
    }
    else {
      when (start) { r := true.B }
      when (stop) { r := false.B }
    }
    r
  }
}


