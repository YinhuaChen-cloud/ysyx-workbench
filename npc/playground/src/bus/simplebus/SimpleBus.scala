// package bus.simplebus

// import chisel3._
// import chisel3.util._
// import cyhcore.HasCyhCoreParameter

// // 以下来自ChatGPT:
// // Chisel 的 sealed 关键字可以用于定义密封类(sealed class)，密封类是一种特殊的抽象类，它的子类数量是有限的，而且必须在密封类的内部定义。
// // 密封类在模式匹配中非常有用。由于密封类的子类数量是有限的，所以我们可以用模式匹配来完整地覆盖所有可能的情况，从而避免了一些潜在的错误。
// sealed abstract class SimpleBusBundle extends Bundle with HasCyhCoreParameter

// object SimpleBusCmd {
//   // def isRead() = !cmd(0) && !cmd(3) 只有 READ， 0 和 3 才都是 0
//   // def isWrite() = cmd(0) 只有 Write, cmd(0) 才是 1
//   // def isBurst() = cmd(1) 只有 Burst, cmd(1) 才是 1
//   // req
//                                  //   hit    |    miss
//   def read           = "b0000".U //  read    |   refill
//   def write          = "b0001".U //  write   |   refill
//   def readBurst      = "b0010".U //  read    |   refill
//   def writeBurst     = "b0011".U //  write   |   refill
//   def writeLast      = "b0111".U //  write   |   refill   TODO: 这也是 Burst 吗？
//   def probe          = "b1000".U //  read    | do nothing   TODO： 这不是 READ 吗?
//   def prefetch       = "b0100".U //  read    |   refill    TODO： 这也是 READ 吗？

//   // resp
//   def readLast       = "b0110".U
//   def writeResp      = "b0101".U
//   def probeHit       = "b1100".U
//   def probeMiss      = "b1000".U

//   def apply() = UInt(4.W)
// }

// class SimpleBusReqBundle(val userBits: Int = 0, val addrBits: Int = 32, val idBits: Int = 0) extends SimpleBusBundle {
//   val addr = Output(UInt(addrBits.W)) // 访存地址（位宽与体系结构实现相关）, 默认 32 位
//   val size = Output(UInt(3.W)) // 访存大小（访存Byte = 2^(req.size)） 默认为 8
//   val cmd = Output(SimpleBusCmd()) // 访存指令, 详见 SimpleBus.scala 中 SimpleBusCmd 的实现
//   val wmask = Output(UInt((DataBits / 8).W))  // 内存写掩码  64/8 = 8 即8个bit, 表示8个字节
//   val wdata = Output(UInt(DataBits.W)) // 内存写数据（位宽与体系结构实现相关）  , 默认 XLEN
//   val user = if (userBits > 0) Some(Output(UInt(userBits.W))) else None // 用户自定义数据, 在访存过程中不被修改
//   val id = if (idBits > 0) Some(Output(UInt(idBits.W))) else None // 标识访存请求的来源, 在访存过程中不被修改

//   // 下面这行东西用来打印 SimpleBusReqBundle 对象
//   override def toPrintable: Printable = {
//     p"addr = 0x${Hexadecimal(addr)}, cmd = ${cmd}, size = ${size}, " +
//     p"wmask = 0x${Hexadecimal(wmask)}, wdata = 0x${Hexadecimal(wdata)}"
//   }

//   def apply(addr: UInt, cmd: UInt, size: UInt, wdata: UInt, wmask: UInt, user: UInt = 0.U, id: UInt = 0.U) {
//     this.addr := addr
//     this.cmd := cmd
//     this.size := size
//     this.wdata := wdata
//     this.wmask := wmask
//     this.user.map(_ := user)
//     this.id.map(_ := id)
//   }

//   def isRead() = !cmd(0) && !cmd(3)
//   def isWrite() = cmd(0)
//   def isBurst() = cmd(1)
//   def isReadBurst() = cmd === SimpleBusCmd.readBurst
//   def isWriteSingle() = cmd === SimpleBusCmd.write
//   def isWriteLast() = cmd === SimpleBusCmd.writeLast
//   def isProbe() = cmd === SimpleBusCmd.probe
//   def isPrefetch() = cmd === SimpleBusCmd.prefetch
// }

// // Uncache
// // SimpleBusUC 是 SimpleBus 的最基本实现, 用于非 Cache 的访存通路中, 它包含了 req 和 resp 两个通路, 使用 Decoupled 方式握手
// class SimpleBusUC(val userBits: Int = 0, val addrBits: Int = 32, val idBits: Int = 0) extends SimpleBusBundle {
//   val req = Decoupled(new SimpleBusReqBundle(userBits, addrBits, idBits))
//   val resp = Flipped(Decoupled(new SimpleBusRespBundle(userBits, idBits)))

//   def isWrite() = req.valid && req.bits.isWrite()
//   def isRead()  = req.valid && req.bits.isRead()
//   def toAXI4Lite() = SimpleBus2AXI4Converter(this, new AXI4Lite, false)
//   def toAXI4(isFromCache: Boolean = false) = SimpleBus2AXI4Converter(this, new AXI4, isFromCache)
//   def toMemPort() = SimpleBus2MemPortConverter(this, new MemPortIo(32))

//   def dump(name: String) = {
//     when (req.fire()) { printf(p"${GTimer()},[${name}] ${req.bits}\n") }
//     when (resp.fire()) { printf(p"${GTimer()},[${name}] ${resp.bits}\n") }
//   }
// }

