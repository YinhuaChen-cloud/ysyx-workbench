package device

import chisel3._
import chisel3.util._
import chisel3.experimental._
import cyhcore.HasCyhCoreParameter

class AXI4SRAM extends BlackBox with HasBlackBoxInline with HasCyhCoreParameter {
  val io = IO(new Bundle {
    val clk = Input(Clock())
    val rst = Input(Bool())
    val pc = Input(UInt(XLEN.W))
    val mem_addr = Input(UInt(XLEN.W))
    val isRead = Input(Bool())
    val isWriteMem = Input(Bool())
    val mem_write_data = Input(UInt(XLEN.W))
    val mem_write_msk = Input(UInt(8.W))
    val inst = Output(UInt(INST_LEN.W))
    val mem_in = Output(UInt(XLEN.W))
  })

  setInline("AXI4SRAM.v",
            s"""
              |module AXI4SRAM (
              |           input clk,
              |           input rst,
              |           input [${XLEN}-1:0] pc,
              |           input [${XLEN}-1:0] mem_addr,
              |           input isRead,
              |           input isWriteMem,
              |           input [${XLEN}-1:0] mem_write_data,
              |           input [7:0] mem_write_msk,
              |           output reg [${INST_LEN} - 1:0] inst,
              |           output [${XLEN}-1:0] mem_in);
              |
              |  // expose pc to cpp simulation environment
              |  import "DPI-C" function void set_pc(input logic [${XLEN}-1:0] a []);
              |  initial set_pc(pc);  
              |
              |  // for mem_rw
              |  import "DPI-C" function void pmem_read(input longint raddr, output longint rdata);
              |  import "DPI-C" function void pmem_write(input longint waddr, input longint wdata, input byte wmask);
              |  // for inst read from pmem // TODO: the pmem_read implementation will be changed greatly after implement BUS
              |  reg [${XLEN}-1:0]	inst_aux;
              |  always@(*) begin
              |    if(~rst)
              |      pmem_read(pc, inst_aux); 
              |    else
              |      inst_aux = '0; 
              |  end
              |  // inst selection	
              |  always@(*) 
              |    case(pc[2:0])
              |      3'h0: inst = inst_aux[${INST_LEN}-1:0];
              |      3'h4: inst = inst_aux[${XLEN}-1:${INST_LEN}];
              |      default: begin inst = '0; assert(0); end
              |    endcase
              |  // for data reading from mem
              |  always@(*) begin
              |    if(isRead)
			        |      pmem_read(mem_addr, mem_in); 
              |    else
              |      mem_in = '0;
              |  end
              |  // for writing mem
              |  always@(posedge clk) 
              |    if(isWriteMem) 
              |      pmem_write(mem_addr, mem_write_data, mem_write_msk);
              |
              |endmodule
            """.stripMargin)

}










