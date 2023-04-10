package device

import chisel3._
import chisel3.util._

import cyhcore._
import bus.axi4._
import utils._

// 这里的中括号用于指定泛型类型参数。泛型类型参数是一种在类或方法定义中使用的占位符类型，它们可以让你在使用类或方法时指定具体的类型。
// [T <: AXI4Lite] 表示 T是AXI4Lite类型、或其子类型
// AXI4SlaveModule 抽象类，所有作为总线Slave端的模块都要继承这个模块
// 目前只支持 AXI4Lite 从机
abstract class AXI4SlaveModule[T <: AXI4Lite, B <: Data](_type :T = new AXI4, _extra: B = null) // 默认第一个参数是一个AXI4 Bundle, 第二个参数是 null
  extends Module with HasCyhCoreParameter {
  val io = IO(new Bundle{
    val axislave = Flipped(_type) // AXI4 和 AXI4Lite 默认是用在主模块上的，这里我们要设计 Slave 端，所以要 Flipped
    val extra = if (_extra != null) Some(Flipped(Flipped(_extra))) else None // extra 似乎是用来作为 AXI4 总线的补充，由于要跟外面对接，所以也要 Flipped
    // 在Chisel中，Some类型常常用于描述需要在运行时确定的类型。 常用的方法为 getOrElse(xxx)，当Some类型中没有所需的内容时，返回xxx
  })
  val axislave = io.axislave // 简化命名

  // AXI4-Lite 需要处理的信号包括:
  // 1. ar_addr ar_valid ar_ready ar_prot
  // 2. r_data r_valid r_ready r_resp

  // 1. ar_addr ar_valid ar_ready ar_prot ----------------------------------------- 除了 ar_ready 都是输入

  val ren = Wire(Bool()) // 读使能

  // 读忙碌内部信号。当ar.fire，r_busy 在下一周期为真； 表示正在读取
  // 当 r.fire 且 rLast(表示传输最后一个数据) 都为真，r_busy 在下一周期为假，表示不在读取 (AXI4Lite 不支持 rLast 信号, 我们一次只能读一个地址)
  // start信号优先级更高，当 ar.fire 和 r.fire 同时为真，下一周期 r_busy 为真，表示正在读取
  val r_busy = BoolStopWatch(axislave.ar.fire, axislave.r.fire, startHighPriority = true) 

  // 当不忙碌的时候，ar处于ready状态
  axislave.ar.ready := !r_busy 
  ren := axislave.ar.fire // 读使能信号，由继承 AXI4Slave 的模块使用

  // 2. r_data r_valid r_ready r_resp --------------------------------------------- 出入 r_ready 都是输出

  axislave.r.valid := BoolStopWatch(ren && (axislave.ar.fire || r_busy), axislave.r.fire(), startHighPriority = true) // 读数据 valid 信号
  // r_data 由 继承 AXI4Slave 的模块自己处理
  axislave.r.bits.resp := AXI4Parameters.RESP_OKAY  // 读的 resp 总是为 OKAY，暂时不支持复杂的功能 

}





