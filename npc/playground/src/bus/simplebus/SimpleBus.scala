package bus.simplebus

import chisel3._
import chisel3.util._
import cyhcore.HasCyhCoreParameter

// 以下来自ChatGPT:
// Scala 中的 sealed 关键字用于限制一个 trait 或者 class 的子类的定义范围。如果一个 trait 或者 class 被 sealed 修饰，
// 那么它的所有子类必须定义在同一个源文件中，不能在其他文件中定义新的子类。
sealed abstract class SimpleBusBundle extends Bundle with HasCyhCoreParameter

object SimpleBusCmd {
  // def isRead() = !cmd(0) && !cmd(3) 只有 READ， 0 和 3 才都是 0
  // def isWrite() = cmd(0) 只有 Write, cmd(0) 才是 1
  // def isBurst() = cmd(1) 只有 Burst, cmd(1) 才是 1

  // req
                                 //   hit    |    miss
  def read           = "b0000".U //  read    |   refill
  def write          = "b0001".U //  write   |   refill
  // def readBurst      = "b0010".U //  read    |   refill
  // def writeBurst     = "b0011".U //  write   |   refill
  // def writeLast      = "b0111".U //  write   |   refill   TODO: 这也是 Burst 吗？
  // def probe          = "b1000".U //  read    | do nothing   TODO： 这不是 READ 吗?
  // def prefetch       = "b0100".U //  read    |   refill    TODO： 这也是 READ 吗？

  // // resp
  // def readLast       = "b0110".U
  // def writeResp      = "b0101".U
  // def probeHit       = "b1100".U
  // def probeMiss      = "b1000".U

  // 在不实现握手信号的时候，作为 disable 内存读写的 cmd
  def disable        = "b0010".U 

  def apply() = UInt(4.W)
}

class SimpleBusReqBundle extends SimpleBusBundle {
  val cmd = Output(SimpleBusCmd())  // 总线接收到的来自主模块的命令  比如：读 和 写

  val addr = Output(UInt(PAddrBits.W)) // 访存地址（位宽与体系结构实现相关）, 默认 32 位

  val wmask = Output(UInt((DataBits / 8).W))  // 内存写掩码  64/8 = 8 即8个bit, 表示8个字节
  val wdata = Output(UInt(DataBits.W)) // 内存写数据（位宽与体系结构实现相关）  , 默认 XLEN
  // val size = Output(UInt(3.W)) // 访存大小（访存Byte = 2^(req.size)） 默认为 8, 分为 8, 4, 2, 1 TODO: 这个我们暂时不用

  // // 下面这行东西用来打印 SimpleBusReqBundle 对象
  // override def toPrintable: Printable = {
  //   p"addr = 0x${Hexadecimal(addr)}, cmd = ${cmd}, size = ${size}, " +
  //   p"wmask = 0x${Hexadecimal(wmask)}, wdata = 0x${Hexadecimal(wdata)}"
  // }

  def apply(addr: UInt, cmd: UInt) {
    this.addr := addr
    // this.cmd := cmd
  }

  def isDisable() = cmd(1)
  def isRead()    = !isDisable() && !cmd(0) && !cmd(3)
  def isWrite()   = !isDisable() && cmd(0)
}

class SimpleBusRespBundle extends SimpleBusBundle {
  // val cmd = Output(SimpleBusCmd()) // 总线将要发给从模块的信号
  val rdata = Output(UInt(XLEN.W)) 

  // override def toPrintable: Printable = p"rdata = ${Hexadecimal(rdata)}, cmd = ${cmd}"
}

// Uncache
// SimpleBusUC 是 SimpleBus 的最基本实现, 用于非 Cache 的访存通路中, 它包含了 req 和 resp 两个通路, 使用 Decoupled 方式握手
class SimpleBusUC extends SimpleBusBundle { // 默认是主模块端
  val req  = new SimpleBusReqBundle
  val resp = Flipped(new SimpleBusRespBundle)

  // def isWrite() = req.valid && req.bits.isWrite()
  // def isRead()  = req.valid && req.bits.isRead()
  // def isWrite() = req.isWrite()
  // def isRead()  = req.isRead()
  // def toMemPort() = SimpleBus2MemPortConverter(this, new MemPortIo(32)) // TODO: 连接内存需要用到这个吗？

  // 这个 dump 函数看起来是用来 DEBUG 的
  // def dump(name: String) = { 
  //   when (req.fire()) { printf(p"${GTimer()},[${name}] ${req.bits}\n") }
  //   when (resp.fire()) { printf(p"${GTimer()},[${name}] ${resp.bits}\n") }
  // }
}

