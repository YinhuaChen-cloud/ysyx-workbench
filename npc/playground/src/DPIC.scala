import chisel3._
import chisel3.util._
import chisel3.experimental._
import Conf._

class DPIC (implicit val conf: Configuration) 
extends ExtModule(Map("XLEN" -> conf.xlen, "NR_REG" -> conf.nr_reg, "PC_LEN" -> conf.pc_len, "INST_LEN" -> conf.inst_len)) 
with HasExtModuleInline {
  val io = IO(new Bundle {
    val clk = Input(Clock())
    val rst = Input(Bool())
    val pc = Input(UInt(conf.pc_len.W))
    val isEbreak = Input(Bool())
    val inv_inst  = Input(Bool())
    val regfile = Input(UInt((conf.nr_reg * conf.xlen).W))
    val mem_addr = Input(UInt(conf.xlen.W))
    val isRead = Input(Bool())
    val isWriteMem = Input(Bool())
    val mem_write_data = Input(UInt(conf.xlen.W))
    val inst = Output(UInt(conf.inst_len.W))
    val mem_in = Output(UInt(conf.xlen.W))
  })

  setInline("DPIC.v",
            s"""
              |module DPIC #(XLEN=${conf.xlen}, NR_REG=${conf.nr_reg}, PC_LEN=${conf.pc_len}, INST_LEN=${conf.inst_len}) (
              |           input io_clk,
              |           input io_rst,
              |           input [PC_LEN-1:0] io_pc,
              |           input io_isEbreak,
              |           input io_inv_inst,
              |           input [NR_REG * XLEN - 1:0] io_regfile,
              |           input [XLEN-1:0] io_mem_addr,
              |           input io_isRead,
              |           input io_isWriteMem,
              |           input [XLEN-1:0] io_mem_write_data,
              |           output reg [INST_LEN - 1:0] io_inst,
              |           output [XLEN-1:0] io_mem_in);
              |
              |  // expose pc to cpp simulation environment
              |  import "DPI-C" function void set_pc(input logic [PC_LEN-1:0] a []);
              |  initial set_pc(io_pc);  
              |
              |  // only cpp simulation environment can execute ebreak()
              |  import "DPI-C" function void ebreak();
              |  always@(*) begin
              |    if(io_isEbreak)
              |      ebreak();   
              |  end
              |
              |  // used to report invalid inst error
              |  import "DPI-C" function void invalid();
              |    always@(posedge io_clk)
              |      if (~io_rst && io_inv_inst)
              |        invalid();
              |
              |  // expose regfile for difftest
              |  import "DPI-C" function void set_gpr_ptr(input logic [XLEN-1:0] a []);
              |  wire [XLEN-1:0] regs [NR_REG-1:0];
              |  genvar i;
              |  generate
              |    for(i = 0; i < NR_REG; i = i+1) begin
              |      assign regs[i] = io_regfile[(i+1)*XLEN - 1 : i*XLEN]; 
              |    end
              |  endgenerate
              |  initial set_gpr_ptr(regs);
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
              |
              |endmodule
            """.stripMargin)

}


