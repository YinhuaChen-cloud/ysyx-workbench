package utils

import chisel3._
import chisel3.util._

// 因此，在选择编码方式时，应该根据具体应用情况综合考虑各种因素。一般来说，在选择信号的位数较少的情况下，一热编码选择器是更好的选择。但是，在选择信号的位数较多时，一般选择器可能更加适合。
object OneHotTree {
  // [T<:Data] 有点类似于C++中的模板，定义一个模板类型T,这个T只能是Data的派生类
  def apply[T <: Data](key: UInt, mapping: Iterable[(UInt, T)]): T =
    Mux1H(mapping.map(p => (p._1 === key, p._2)))
}

// object LookupTreeDefault {
//   def apply[T <: Data](key: UInt, default: T, mapping: Iterable[(UInt, T)]): T =
//     MuxLookup(key, default, mapping.toSeq)
// }
