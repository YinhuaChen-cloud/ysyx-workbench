package device

import chisel3._
import chisel3.util._

import cyhcore._
import bus.simplebus._

class AXI4DRAM extends CyhCoreModule {
  val io = IO(new Bundle {
    val dmem = Flipped(new SimpleBusUC)  // DRAM 属于从模块，因此要 Flipped
  })

  val rwmem = Module(new RWMEM)
  rwmem.io.clk  := clock
  rwmem.io.rst  := reset

  rwmem.io.isRead    := io.dmem.req.isRead()
  io.dmem.resp.rdata := rwmem.io.rdata

  rwmem.io.addr  := Mux(RegNext(io.dmem.req.isWrite()), RegNext(io.dmem.req.addr), io.dmem.req.addr) // TODO: 为了匹配difftest, 延迟一个周期写入内存

  rwmem.io.isWrite := RegNext(io.dmem.req.isWrite()) // TODO: 为了匹配difftest, 延迟一个周期写入内存
  rwmem.io.mem_write_data := RegNext(io.dmem.req.wdata)
  rwmem.io.mem_write_msk  := RegNext(io.dmem.req.wmask)

}

class RWMEM extends BlackBox with HasBlackBoxInline with HasCyhCoreParameter {
  val io = IO(new Bundle {
    val clk = Input(Clock())
    val rst = Input(Bool())
    // read
    val isRead = Input(Bool())
    val rdata = Output(UInt(XLEN.W))
    // addr for r/w
    val addr = Input(UInt(PAddrBits.W))
    // write
    val isWrite = Input(Bool())
    val mem_write_data = Input(UInt(XLEN.W))
    val mem_write_msk = Input(UInt(8.W))
  })

  setInline("RWMEM.v",
            s"""
              |module RWMEM (
              |           input clk,
              |           input rst,
              |
              |           input isRead,
              |           output reg [${XLEN}-1:0] rdata,
              |
              |           input [${PAddrBits}-1:0] addr,
              |
              |           input isWrite,
              |           input [${XLEN}-1:0] mem_write_data,
              |           input [7:0] mem_write_msk);
              |
              |  wire [${XLEN}-1:0] mem_addr;
              |  assign mem_addr[${PAddrBits}-1:0] = addr;
              |
              |  always@(*) begin
              |    $$display("mem_addr is %x", mem_addr);
              |  end
              |
              |  // for mem_rw
              |  import "DPI-C" function void pmem_read(input longint raddr, output longint rdata);
              |  import "DPI-C" function void pmem_write(input longint waddr, input longint wdata, input byte wmask);
              |  // for data reading from mem
              |  always@(*) begin
              |    if(~rst && isRead)
			        |      pmem_read(mem_addr, rdata); 
              |    else
              |      rdata = '0;
              |  end
              |  // for writing mem
              |  always@(posedge clk) 
              |    if(~rst && isWrite) 
              |      pmem_write(mem_addr, mem_write_data, mem_write_msk);
              |
              |endmodule
            """.stripMargin)

}











