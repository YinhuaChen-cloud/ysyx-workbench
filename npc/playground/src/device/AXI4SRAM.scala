package device

import chisel3._
import chisel3.util._
import cyhcore.HasCyhCoreParameter

class AXI4SRAM extends BlackBox with HasBlackBoxInline with HasCyhCoreParameter {
  val io = IO(new Bundle {
    val clk = Input(Clock())
    val rst = Input(Bool())
    val pc = Input(UInt(XLEN.W))
    val inst = Output(UInt(INST_LEN.W))
  })

  setInline("AXI4SRAM.v",
            s"""
              |module AXI4SRAM (
              |           input clk,
              |           input rst,
              |           input [${XLEN}-1:0] pc,
              |           output reg [${INST_LEN} - 1:0] inst);
              |
              |  // expose pc to cpp simulation environment
              |  import "DPI-C" function void set_pc(input logic [${XLEN}-1:0] a []);
              |  initial set_pc(pc);  
              |
              |  // for mem_r
              |  import "DPI-C" function void pmem_read(input longint raddr, output longint rdata);
              |  //  ------------------------------------ inst reading ---- start
              |  // Define the state enumeration
              |  typedef enum logic [1:0] {
              |    IDLE,
              |    BUSY
              |  } state_t;
              |  // Define the state variable
              |  reg state;
              |
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
              |  //  ------------------------------------ inst reading ---- end
              |
              |endmodule
            """.stripMargin)

}










