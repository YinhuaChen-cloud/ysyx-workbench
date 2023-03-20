package device

import chisel3._
import chisel3.util._

import cyhcore._
import bus.axi4._
import utils._

// 指令读取过程：
// 1. 我们的取指级（IF）应该发出取指信号，包括读请求（valid）和读地址（pc），
// 2. 这时AXI模块应该收到取指级的信号，如果AXI模块处于空闲状态, 则对本次读请求做出响应，AXI内部状态由空闲
// 跳转到读请求状态，产生并发送读请求（ar-valid）、读地址（ar-addr）、
// 读字节数（ar-size）、读个数（ar-len）， -- 这两个不属于 AXILite，暂时不管

abstract class AXI4MasterModule[T <: AXI4Lite, B <: Data](_type :T = new AXI4, _extra: B = null)
  extends CyhCoreModule {
  val io = IO(new Bundle{
    val out = _type // AXI4 和 AXI4Lite 默认是用在主模块上的 
    val extra = if (_extra != null) Some(Flipped(_extra)) else None // extra 用作除总线外的其它信号接口 TODO: 不懂这里的 Flipped 是干嘛的
    // 在Chisel中，Some类型常常用于描述需要在运行时确定的类型。 常用的方法为 getOrElse(xxx)，当Some类型中没有所需的内容时，返回xxx
  })

  val out = io.out // 给 io.out 一个简易命名 



  val raddr = Wire(UInt()) // 读地址
  val ren = Wire(Bool()) // 读使能


  // 暂时不支持 rLast, AXI4Lite 没有 -- start
  // val (readBeatCnt, rLast) = in match {
  //   case axi4: AXI4 =>

  //   case axi4lite: AXI4Lite => // 当 io.in 为 AXI4Lite 类型时
  //     raddr := axi4lite.ar.bits.addr // 读地址就是 in 的 addr
  //     (0.U, true.B) // 此时，readBeatCnt 为 0.U， rLast 信号永远为 true.B （因为AxiLite每次只传输一个数据）
  // }
  // 暂时不支持 rLast, AXI4Lite 没有 -- end

  // val r_busy = BoolStopWatch(in.ar.fire(), in.r.fire() && rLast, startHighPriority = true)
  // in.ar.ready := in.r.ready || !r_busy
  // // in.r.bits.resp := AXI4Parameters.RESP_OKAY // -- 不支持
  // ren := RegNext(in.ar.fire(), init=false.B) || (in.r.fire() && !rLast)
  // in.r.valid := BoolStopWatch(ren && (in.ar.fire() || r_busy), in.r.fire(), startHighPriority = true)

}







