package bus.simplebus

import chisel3._
import chisel3.util._

import bus.axi4._

// 这个转换桥应该只包含组合逻辑
// val bridge = Module(new SimpleBus2AXI4Converter(outType, isFromCache))
// 参数1： 要转换成的目标类型： AXI4 or AXI4Lite
// 参数2： 是否来自 cache
class SimpleBus2AXI4Converter[OT <: AXI4Lite](outType: OT, isFromCache: Boolean) extends Module {
  val io = IO(new Bundle {
    val in = Flipped(new SimpleBusUC)
    val out = outType // AXI4Lite or AXI4 （主端）
  })

  // 简化命名，增加可读性
  val (simplebus, axi) = (io.in, io.out)
  val (ar, r) = (axi.ar.bits, axi.r.bits)

  // AXI4-Lite 需要处理的信号包括:
  // 1. ar_addr ar_valid ar_ready ar_prot
  // 2. r_data r_valid r_ready r_resp

  // 1. ar_addr ar_valid ar_ready ar_prot -----------------------------------------

  ar.addr              := simplebus.req.bits.addr
  axi.ar.valid         := simplebus.isRead()
  simplebus.req.ready  := axi.ar.ready
  ar.prot              := AXI4Parameters.PROT_PRIVILEDGED // arprot 设置为特权访问

  // 2. r_data r_valid r_ready r_resp ---------------------------------------------

  simplebus.resp.bits.rdata  := r.data
  simplebus.resp.valid       := axi.r.valid
  axi.r.ready                := simplebus.resp.ready
  // simplebus.resp.bits.cmd    := Mux(rlast, SimpleBusCmd.readLast, 0.U) // TODO: 目前我们暂时只用 r_valid 来表示读数据有效，resp暂时不管

  // ---------------------------------- 分割线 -------------------------------------

  // 判断是 AXI4 or AXI4Lite 的代码，暂时和我们无关
  // val toAXI4Lite = !(io.in.req.valid && io.in.req.bits.isBurst()) && (outType.getClass == classOf[AXI4Lite]).B
  // val toAXI4 = (outType.getClass == classOf[AXI4]).B
  // assert(toAXI4Lite || toAXI4)

  // val (mem, axi) = (io.in, io.out)
  // val (ar, aw, w, r, b) = (axi.ar.bits, axi.aw.bits, axi.w.bits, axi.r.bits, axi.b.bits)

  // w.data := mem.req.bits.wdata
  // w.strb := mem.req.bits.wmask

  // 下面这部分只跟 AXI4 有关，跟 AXI4Lite 无关
  // def LineBeats = 8
  // val wlast = WireInit(true.B)
  // val rlast = WireInit(true.B)
  // if (outType.getClass == classOf[AXI4]) {
  //   val axi4 = io.out.asInstanceOf[AXI4]
  //   axi4.ar.bits.id    := 0.U
  //   axi4.ar.bits.len   := Mux(mem.req.bits.isBurst(), (LineBeats - 1).U, 0.U)
  //   axi4.ar.bits.size  := mem.req.bits.size
  //   axi4.ar.bits.burst := (if (isFromCache) AXI4Parameters.BURST_WRAP
  //                          else AXI4Parameters.BURST_INCR)
  //   axi4.ar.bits.lock  := false.B
  //   axi4.ar.bits.cache := 0.U
  //   axi4.ar.bits.qos   := 0.U
  //   axi4.ar.bits.user  := 0.U
  //   axi4.w.bits.last   := mem.req.bits.isWriteLast() || mem.req.bits.isWriteSingle()
  //   wlast := axi4.w.bits.last
  //   rlast := axi4.r.bits.last
  // }

  // aw := ar
  // simplebus.resp.bits.rdata := r.data
  // simplebus.resp.bits.cmd  := Mux(rlast, SimpleBusCmd.readLast, 0.U) // TODO: 暂时不知道这有啥用

  // val wSend = Wire(Bool())
  // val awAck = BoolStopWatch(axi.aw.fire(), wSend)
  // val wAck = BoolStopWatch(axi.w.fire() && wlast, wSend)
  // wSend := (axi.aw.fire() && axi.w.fire() && wlast) || (awAck && wAck)
  // val wen = RegEnable(mem.req.bits.isWrite(), mem.req.fire())

  // axi.ar.valid := mem.isRead()
  // axi.aw.valid := mem.isWrite() && !awAck
  // axi.w .valid := mem.isWrite() && !wAck
  // mem.req.ready  := Mux(mem.req.bits.isWrite(), !wAck && axi.w.ready, axi.ar.ready)

  // axi.r.ready  := mem.resp.ready
  // axi.b.ready  := mem.resp.ready
  // mem.resp.valid  := Mux(wen, axi.b.valid, axi.r.valid)
}

// def toAXI4Lite() = SimpleBus2AXI4Converter(this, new AXI4Lite, false)
// 参数1： 使用这个转换器的 simplebus 对象
// 参数2： 要转换成的目标类型： AXI4 or AXI4Lite
// 参数3： 是否来自 cache
object SimpleBus2AXI4Converter {
  def apply[OT <: AXI4Lite](in: SimpleBusUC, outType: OT, isFromCache: Boolean = false): OT = {
    // bridge 的硬件意义是： 把 simpleBus 转成 AXI4 (也可以是 AXI4Lite)
    val bridge = Module(new SimpleBus2AXI4Converter(outType, isFromCache))
    bridge.io.in <> in // 输入连 Simplebus
    bridge.io.out // 返回输出
  }
}

