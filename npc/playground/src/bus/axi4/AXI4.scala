package bus.axi4

import chisel3._
import chisel3.util._

import cyhcore.HasCyhCoreParameter

object AXI4Parameters extends HasCyhCoreParameter {
  val addrBits  = PAddrBits
  val dataBits  = XLEN
  val protBits  = 3
  val respBits  = 2

  def PROT_PRIVILEDGED = 1.U(protBits.W)
  def PROT_INSECURE    = 2.U(protBits.W)
  def PROT_INSTRUCTION = 4.U(protBits.W)

  // def BURST_FIXED = 0.U(burstBits.W)
  // def BURST_INCR  = 1.U(burstBits.W)
  // def BURST_WRAP  = 2.U(burstBits.W)

  // rresp读响应 和 bresp写响应 的位宽和取值是一样的
  def RESP_OKAY   = 0.U(respBits.W)
  def RESP_EXOKAY = 1.U(respBits.W) // The EXOKAY response is not supported on the read data and write response channels. - AXI4-Lite
  def RESP_SLVERR = 2.U(respBits.W)
  def RESP_DECERR = 3.U(respBits.W)
}

trait AXI4HasData {
  def dataBits = AXI4Parameters.dataBits
  val data  = Output(UInt(dataBits.W))
}

// AXI4-Lite
// The key functionality of AXI4-Lite operation is:
// • All transactions are of burst length 1. 突发长度为1
// • All data accesses use the full width of the data bus: AXI4-Lite supports a data bus width of 32-bit or 64-bit.  数据访问使用数据总线的所有位宽，AXI4-lite 支持 32位 和 64位
// • All accesses are Non-modifiable, Non-bufferable. 所有的访问都是不可修改的、不可缓存的
// • Exclusive accesses are not supported. 不支持独占访问

// Address channel:
//   1. AVALID
//   2. AREADY
//   3. AADDR
//   4. APROT
class AXI4LiteBundleA extends Bundle {  // valid 和 ready 由 Decoupled 接口实现了
  val addr  = Output(UInt(AXI4Parameters.addrBits.W))
  val prot  = Output(UInt(AXI4Parameters.protBits.W)) // -- 加上这个端口，但我们暂时不支持它
}

class AXI4LiteBundleB extends Bundle {
  val resp = Output(UInt(AXI4Parameters.respBits.W))
}

// 包含两个输出 1. rdata 2. rresp
class AXI4LiteBundleR(override val dataBits: Int = AXI4Parameters.dataBits) extends AXI4LiteBundleB with AXI4HasData // -- 果壳版本
// resp 和 data 都是 Output
// resp 用来传输总线错误，比如当读的内存地址非法，那么就要报错，简单核的实现可以不实现这个 -- 我们只加resp接口，不使用它

class AXI4Lite extends Bundle { // 默认作为 Master 段的接口
  // val aw = Decoupled(new AXI4LiteBundleA)           // write address
  // val w  = Decoupled(new AXI4LiteBundleW)           // write data
  // val b  = Flipped(Decoupled(new AXI4LiteBundleB))  // wrtie response
  val ar = Decoupled(new AXI4LiteBundleA)           // read address
  val r  = Flipped(Decoupled(new AXI4LiteBundleR))  // read data
}

class AXI4 extends AXI4Lite { // 默认作为 Master 段的接口
}

// R通道：
//   Slave->Master信号：
//     RDATA ：读取数据结果 -1
//     RLAST ：标记最后一次读数据传输 -- AXI4Lite 没有
//     可用于检验COUNT是否一致
//     RRESP ：读数据的反馈，用于传输总线错误。 -2 -- (这个我们暂时不支持)
//     简单核的实现可以在总线错误时不产生异常，只需要确保软件访问物理内存地址一定正确即
//     可。
//     RVALID ：读数据有效 -3
//     RID 用于与 ARID 对应，用于标识对应的请求。 -- AXI4Lite 没有
//   Master->Slave信号：
//     RREADY ：本次读数据传输完成  -4  ----- 1,2,3,4 Rdata 通道 AXI4Lite 齐全了, 我们暂不支持2

// AR/AW通道：
//   Master->Slave信号:
//     A[RW]ADDR ：读写的字节地址   -1

//     A[RW]LEN ：读写的传输次数，次数定义为 A[RW]LEN+1 。 -- AXI4Lite 没有: AXI4Lite 固定single burst

//     A[RW]SIZE ：单次传输的数据大小，字节数定义为 2 ** A[RW]SIZE ，且不可超过数据总线 -- AXI4Lite 没有 :  AXI4Lite 固定使用完全总线宽度，完全总线宽度支持32位和64位
//     宽度。

//     A[RW]BURST ：突发传输类型（INCR与WARP模式可以一次地址握手完成多次不同地址的数 -- AXI4Lite 没有
//     据传输，提高Cache替换效率，若只需要实现AXI4Lite可直接使用FIXED模式）

//     A[RW]VALID ：读写的有效性 -2

//     此外，这里依据Slave支持的特性不同可能还有 A[RW]CACHE(没有) 、 A[RW]PROT -3(我们暂时不支持) 、
//     A[RW]QOS(没有) 信号，这些信号我们可暂时忽略，直接assign为0即可

//     如果总线支持 A[RW]ID(没有) ，则需要对于不同的设备传输正确的ID信息。例如你的CPU的I-Cache与D-Cache独立，且都使用AXI访问总线，你就可以在CPU核里面写一个AXI Crossbar，并使用不同的
//     ID区分设备，在握手时仲裁，并在数据返回时发送给对应的设备。
//   Slave->Master:
//     A[RW]READY ：地址握手完成 -4
//    1,2,3,4 AXI4Lite 齐全了，我们暂时不支持 3
//   地址握手流程：
//     0. 初始状态，Master端 A[RW]VALID 必须为0，Slave端 A[RW]READY 只要不是复位状态可以为1，以
//     便Slave单周期握手。
//     1. Master填写正确填写 A[RW]ADDR 、 A[RW]SIZE 等信号，并将 A[RW]VALID 设置为1。
//     2. 当某一时刻的时钟上升沿之前出现 A[RW]VALID 与 A[RW]READY 都为1时，地址握手结束。此时
//     Master端必须在时钟上升沿之后将 A[RW]VALID 信号置0或发送新的请求。否则Slave端将认为同
//     一个地址请求发送了2次，并做出2次响应。

