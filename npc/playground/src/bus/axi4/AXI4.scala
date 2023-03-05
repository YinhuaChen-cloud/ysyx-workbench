package bus.axi4

import chisel3._
import chisel3.util._

import cyhcore.HasCyhCoreParameter

object AXI4Parameters extends HasCyhCoreParameter {
  val addrBits  = PAddrBits

  // def PROT_PRIVILEDGED = 1.U(protBits.W)
  // def PROT_INSECURE    = 2.U(protBits.W)
  // def PROT_INSTRUCTION = 4.U(protBits.W)

  // def BURST_FIXED = 0.U(burstBits.W)
  // def BURST_INCR  = 1.U(burstBits.W)
  // def BURST_WRAP  = 2.U(burstBits.W)

  // def RESP_OKAY   = 0.U(respBits.W)
  // def RESP_EXOKAY = 1.U(respBits.W) // The EXOKAY response is not supported on the read data and write response channels. - AXI4-Lite
  // def RESP_SLVERR = 2.U(respBits.W)
  // def RESP_DECERR = 3.U(respBits.W)
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
  // val prot  = Output(UInt(AXI4Parameters.protBits.W))
}

class AXI4Lite extends Bundle {
  // val aw = Decoupled(new AXI4LiteBundleA)           // write address
  // val w  = Decoupled(new AXI4LiteBundleW)           // write data
  // val b  = Flipped(Decoupled(new AXI4LiteBundleB))  // wrtie response
  val ar = Decoupled(new AXI4LiteBundleA)           // read address
  // val r  = Flipped(Decoupled(new AXI4LiteBundleR))  // read data
}







