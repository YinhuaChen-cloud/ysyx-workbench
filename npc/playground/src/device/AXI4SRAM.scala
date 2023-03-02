package device

import chisel3._
import chisel3.util._
import chisel3.experimental._
import Conf._

class AXI4SRAM (implicit val conf: Configuration) 
extends ExtModule(Map("XLEN" -> conf.xlen, "NR_REG" -> conf.nr_reg, "PC_LEN" -> conf.pc_len, "INST_LEN" -> conf.inst_len)) 
with HasExtModuleInline {
  val io = IO(new Bundle {
    val clk = Input(Clock())
    val rst = Input(Bool())
    val pc = Input(UInt(conf.pc_len.W))
    val mem_addr = Input(UInt(conf.xlen.W))
    val isRead = Input(Bool())
    val isWriteMem = Input(Bool())
    val mem_write_data = Input(UInt(conf.xlen.W))
    val mem_write_msk = Input(UInt(8.W))
    val inst = Output(UInt(conf.inst_len.W))
    val mem_in = Output(UInt(conf.xlen.W))
  })

  setInline("DPIC.v",
            s"""
              |module DPIC #(XLEN=${conf.xlen}, NR_REG=${conf.nr_reg}, PC_LEN=${conf.pc_len}, INST_LEN=${conf.inst_len}) (
              |           input io_clk,
              |           input io_rst,
              |           input [PC_LEN-1:0] io_pc,
              |           input [XLEN-1:0] io_mem_addr,
              |           input io_isRead,
              |           input io_isWriteMem,
              |           input [XLEN-1:0] io_mem_write_data,
              |           input [7:0] io_mem_write_msk,
              |           output reg [INST_LEN - 1:0] io_inst,
              |           output [XLEN-1:0] io_mem_in);
              |
              |  // expose pc to cpp simulation environment
              |  import "DPI-C" function void set_pc(input logic [PC_LEN-1:0] a []);
              |  initial set_pc(io_pc);  
              |
              |  // for mem_rw
              |  import "DPI-C" function void pmem_read(input longint raddr, output longint rdata);
              |  import "DPI-C" function void pmem_write(input longint waddr, input longint wdata, input byte wmask);
              |  // for inst read from pmem // TODO: the pmem_read implementation will be changed greatly after implement BUS
              |  reg [XLEN-1:0]	inst_aux;
              |  always@(*) begin
              |    if(~io_rst)
              |      pmem_read(io_pc, inst_aux); 
              |    else
              |      inst_aux = '0; 
              |  end
              |  // inst selection	
              |  always@(*) 
              |    case(io_pc[2:0])
              |      3'h0: io_inst = inst_aux[INST_LEN-1:0];
              |      3'h4: io_inst = inst_aux[XLEN-1:INST_LEN];
              |      default: begin io_inst = '0; assert(0); end
              |    endcase
              |  // for data reading from mem
              |  always@(*) begin
              |    if(io_isRead)
			        |      pmem_read(io_mem_addr, io_mem_in); 
              |    else
              |      io_mem_in = '0;
              |  end
              |  // for writing mem
              |  always@(posedge io_clk) 
              |    if(io_isWriteMem) 
              |      pmem_write(io_mem_addr, io_mem_write_data, io_mem_write_msk);
              |
              |endmodule
            """.stripMargin)

}






