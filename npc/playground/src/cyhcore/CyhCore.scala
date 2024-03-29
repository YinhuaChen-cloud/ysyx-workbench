package cyhcore

import chisel3._
import chisel3.util._
import chisel3.util.experimental.BoringUtils

import bus.simplebus._
import utils._

trait HasCyhCoreParameter {
  // General Parameter for NutShell
  val XLEN = 64
  val PC_LEN = 64
  val NR_GPRS = 32 // TODO: 实现流水线后可能被 removed
  val INST_LEN = 32 // 指令的位宽一般是32, 暂不支持压缩指令
  val VAddrBits = 39 // riscv32 的虚拟地址位数是32， 64位的位数则是39 
  val PAddrBits = 32 // PAddrBits is Phyical Memory addr bits
  val DataBits = XLEN
}

abstract class CyhCoreModule extends Module with HasCyhCoreParameter
abstract class CyhCoreBundle extends Bundle with HasCyhCoreParameter

// CyhCore = frontend + backend
class CyhCore extends CyhCoreModule {
  // frontend 需要和 SRAM 通信读取指令
  // backend 需要和 DRAM 通信读写内存
  val io = IO(new Bundle {
    val imem = new SimpleBusUC // 用来从SRAM读指令的
    val dmem = new SimpleBusUC
  })

  // frontend = IFU + IDU
  val frontend = Module(new Frontend)
  // backend = ISU(RegFile) + EXU + WBU
  val backend  = Module(new Backend)

  // 普通指令数据流
  frontend.io.imem <> io.imem 
  // backend.io.in <> frontend.io.out
  val ISUregControl = WireInit(false.B)
  BoringUtils.addSink(ISUregControl, "ISUregControl")
  val ISUregValid = PipelineConnect(frontend.io.out, backend.io.in, ISUregControl) 
  BoringUtils.addSource(ISUregValid, "ISUregValid")

  // 跳转指令支持
  frontend.io.redirect <> backend.io.redirect

  // 读写内存支持
  io.dmem <> backend.io.dmem

  // 流水线冒险处理 
  val hazard = Module(new Hazard) 

}

