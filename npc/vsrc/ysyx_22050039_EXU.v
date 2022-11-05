`include "ysyx_22050039_all_inst.v"
`include "ysyx_22050039_colordebug.v"

module ysyx_22050039_EXU #(XLEN = 64, INST_LEN = 32)
                          (input clk,
                           input rst,
                           input [`ysyx_22050039_FUNC_LEN-1:0] func,
                           input [XLEN-1:0] src1,
                           input [XLEN-1:0] src2,
													 input [XLEN-1:0] destI,
                           input [XLEN-1:0] pc,
                           output reg [INST_LEN-1:0] inst,
                           output reg [XLEN-1:0] exec_result,
                           output [XLEN-1:0] dnpc);
  
  import "DPI-C" function void ebreak();
  import "DPI-C" function void invalid();
	 
	// for mem_rw
  import "DPI-C" function void pmem_read(input longint raddr, output longint rdata);
  import "DPI-C" function void pmem_write(input longint waddr, input longint wdata, input byte wmask);


	// ifetch
	reg [XLEN-1:0]	inst_aux;
// instruction width	
	always@(*) 
		case(pc[2:0])
			3'h0: inst = inst_aux[INST_LEN-1:0];
			3'h4: inst = inst_aux[XLEN-1:INST_LEN];
			default: begin inst = 0; assert(0); end
		endcase

  always@(*) begin
		if(~rst)
			pmem_read(pc, inst_aux); 
		else
			inst_aux = '0; 
  end

  reg [XLEN-1:0] rdata;
	reg [XLEN-1:0] raddr;
  always@(*) begin
		if(~rst)
			pmem_read(raddr, rdata); 
		else
			rdata = '0;
//    pmem_write(waddr, wdata, wmask);
  end

	always@(posedge clk)
		$display("In EXU, pmem_read_inst_aux = 0x%x", inst_aux);
	always@(posedge clk)
		$display("In EXU, pmem_read_pc = 0x%x", pc);
	always@(posedge clk)
		$display("In EXU, pmem_read_rdata = 0x%x", rdata);
	always@(posedge clk)
		$display("In EXU, pmem_read_raddr 0x%x", raddr);

	// for raddr
	always@(*)
		case(func)
      Ld	, 
      Lw	,
      Lwu	,
      Lh	,
      Lhu	,
      Lb	,
      Lbu	: raddr = src1 + src2; // TODO: The plus here might be problem
			default: raddr = 64'h8000_0000; 
		endcase

  always@(*) begin // combinational circuit
    exec_result = 0;
    dnpc        = 0;
    inval       = 0;
    case(func)
      // Rtype
      Addw	: exec_result = src1 + src2;
      Subw	:;
      Mulw	:;
      Divw	:;
      Divuw	:;
      Sllw	:;
      Srlw	:;
      Sraw	:;
      Remw	:;
      Remuw	:;
      Sub	:;
      Or	:;
      Add	:;
      Mul	:;
      Xor	:;
      Sll	:;
      Slt	:;
      Sltu	:;
      And	:;
      Div	:;
      Divu	:;
      Rem	:;
      Remu	:;
      // Itype
      Xori	:;
      Sltiu	:;
      Slli	:;
      Srli	:;
      Srai	:;
      Andi	:;
      Ori	:;
      Addiw	:;
      Slliw	:;
      Srliw	:;
      Sraiw	:;
      Ld	: exec_result = rdata; 
      Lw	: exec_result = {{32{rdata[31]}}, rdata[31:0]};
      Lwu	: exec_result = {32'b0, rdata[31:0]};
      Lh	: exec_result = {{48{rdata[15]}}, rdata[15:0]};
      Lhu	: exec_result = {48'b0, rdata[15:0]};
      Lb	: exec_result = {{56{rdata[7]}}, rdata[7:0]};
      Lbu	: exec_result = {56'b0, rdata[7:0]};
			Addi	: begin $display("addi"); exec_result = src1 + src2; end
			Jalr	: begin exec_result = pc + 4; dnpc = src1 + src2; end
			// Stype
			Sd	: pmem_write(destI + src1, src2, 8'hff);
			Sw	: ;
			Sh	:;
			Sb	:;
			// Btype
			Beq	:;
			Bne		:;
			Bltu	:;
			Bge	:;
			Bgeu	:;
			Blt	:;
			// Utype
			Auipc	: begin exec_result = src1 + pc; $display("auipc, exec_result = 0x%x", exec_result); end
			Lui	:	exec_result   = src1;
			// Jtype
			Jal	: begin exec_result = pc + 4; dnpc = pc + src1; end
			Ebreak	: ebreak();
			default: inval = 1; // invalid
    endcase
  end
  
  // invalid is only valid when rst = 0
  reg inval;
  always@(posedge clk)
    if (~rst && inval)
      invalid();
      // else do nothing
  
endmodule
