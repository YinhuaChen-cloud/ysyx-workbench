`include "ysyx_22050039_all_inst.v"

module ysyx_22050039_EXU #(XLEN = 64)
                          (input clk,
                           input rst,
                           input [`ysyx_22050039_FUNC_LEN-1:0] func,
                           input [XLEN-1:0] src1,
                           input [XLEN-1:0] src2,
                           input [XLEN-1:0] pc,
                           output reg [XLEN-1:0] exec_result,
                           output [XLEN-1:0] dnpc);
  
  import "DPI-C" function void ebreak();
  import "DPI-C" function void invalid();
	 
	// for mem_rw
  import "DPI-C" function void pmem_read(input longint raddr, output longint rdata);
//  import "DPI-C" function void pmem_write(input longint waddr, input longint wdata, input byte wmask);

  wire [XLEN-1:0] rdata;
	reg [XLEN-1:0] raddr;
  always@(*) begin
    pmem_read(raddr, rdata); 
//    pmem_write(waddr, wdata, wmask);
  end

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

	always@(posedge clk)
		$display("pmem_read = 0x%x", rdata);
  
  always@(*) begin
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
      Addi	: exec_result = src1 + src2;
			Jalr	: begin exec_result = pc + 4; dnpc = src1 + src2; end
			// Stype
			Sd	:; // sd empty now
			Sw	:;
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
			Auipc	: exec_result = src1 + pc;
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
