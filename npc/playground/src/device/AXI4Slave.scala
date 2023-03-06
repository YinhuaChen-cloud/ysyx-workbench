// package device

// // TODO: 这个暂时不能用

// import chisel3._
// import chisel3.util._

// import cyhcore._
// import bus.axi4._
// import utils._

// // 这里的中括号用于指定泛型类型参数。泛型类型参数是一种在类或方法定义中使用的占位符类型，它们可以让你在使用类或方法时指定具体的类型。
// // [T <: AXI4Lite] 表示 T是AXI4Lite类型、或其子类型
// // [B <: AXI4Lite] 表示 T是Data类型、或其子类型
// // AXI4SlaveModule 抽象类，所有作为总线Slave端的模块都要继承这个模块
// abstract class AXI4SlaveModule[T <: AXI4Lite, B <: Data](_type :T = new AXI4, _extra: B = null)
//   extends CyhCoreModule {
//   val io = IO(new Bundle{
//     val in = Flipped(_type) // AXI4 和 AXI4Lite 默认是用在主模块上的，这里我们要设计 Slave 端，所以要 Flipped
//     val extra = if (_extra != null) Some(Flipped(Flipped(_extra))) else None // extra 用作除总线外的其它信号接口
//     // 在Chisel中，Some类型常常用于描述需要在运行时确定的类型。 常用的方法为 getOrElse(xxx)，当Some类型中没有所需的内容时，返回xxx
//   })
//   val in = io.in // 给 io.in 一个简易命名 

//   val raddr = Wire(UInt()) // 读地址
//   val ren = Wire(Bool()) // 读使能
//   val (readBeatCnt, rLast) = in match {
//     case axi4: AXI4 =>

//     case axi4lite: AXI4Lite => // 当 io.in 为 AXI4Lite 类型时
//       raddr := axi4lite.ar.bits.addr // 读地址就是 in 的 addr
//       (0.U, true.B) // 此时，readBeatCnt 为 0.U， rLast 信号永远为 true.B （因为AxiLite每次只传输一个数据）
//   }

//   val r_busy = BoolStopWatch(in.ar.fire(), in.r.fire() && rLast, startHighPriority = true)
//   in.ar.ready := in.r.ready || !r_busy
//   in.r.bits.resp := AXI4Parameters.RESP_OKAY
//   ren := RegNext(in.ar.fire(), init=false.B) || (in.r.fire() && !rLast)
//   in.r.valid := BoolStopWatch(ren && (in.ar.fire() || r_busy), in.r.fire(), startHighPriority = true)

// }






