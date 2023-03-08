package device

import chisel3._
import chisel3.util._
import cyhcore.HasCyhCoreParameter

class AXI4DRAM extends BlackBox with HasBlackBoxInline with HasCyhCoreParameter {
  val io = IO(new Bundle {
    val clk = Input(Clock())
    val rst = Input(Bool())
    val mem_addr = Input(UInt(XLEN.W))
    val isRead = Input(Bool())
    val isWriteMem = Input(Bool())
    val mem_write_data = Input(UInt(XLEN.W))
    val mem_write_msk = Input(UInt(8.W))
    val mem_in = Output(UInt(XLEN.W))

    // 在加入流水线之前，用来适配 IFU-AXI4SRAM 总线
    val enable = Input(Bool()) // 用来使能寄存器的写入
  })

  setInline("AXI4DRAM.v",
            s"""
              |module AXI4DRAM (
              |           input clk,
              |           input rst,
              |           input [${XLEN}-1:0] mem_addr,
              |           input isRead,
              |           input isWriteMem,
              |           input [${XLEN}-1:0] mem_write_data,
              |           input [7:0] mem_write_msk,
              |           output reg [${XLEN}-1:0] mem_in,
              |           // 在加入流水线之前，用来适配 IFU-AXI4SRAM 总线
              |           input enable); // 用来使能寄存器的写入
              |
              |  // for mem_rw
              |  import "DPI-C" function void pmem_read(input longint raddr, output longint rdata);
              |  import "DPI-C" function void pmem_write(input longint waddr, input longint wdata, input byte wmask);
              |  // for data reading from mem
              |  always@(*) begin
              |    if(isRead)
			        |      pmem_read(mem_addr, mem_in); 
              |    else
              |      mem_in = '0;
              |  end
              |  // for writing mem
              |  always@(posedge clk) 
              |    if(isWriteMem & enable) 
              |      pmem_write(mem_addr, mem_write_data, mem_write_msk);
              |
              |endmodule
            """.stripMargin)

}











