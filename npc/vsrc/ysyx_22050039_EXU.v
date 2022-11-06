`include "ysyx_22050039_all_inst.v"
`include "ysyx_22050039_colordebug.v"
`include "ysyx_22050039_config.v"

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

	// for pmem inst read
  always@(*) begin
		if(~rst)
			pmem_read(pc, inst_aux); 
		else
			inst_aux = '0; 
  end

	// for pmem data read 1
	reg [XLEN-1:0] raddr;
  reg [XLEN-1:0] rdata;
  reg [XLEN-1:0] rdata_aux;
	// TODO: the assignment of rdata here might be a problem, since rdata is
	// also the input of exec_result of Ld, Lw, ..., Lbu. (order effect?)
  always@(*)
		if(rst) begin
			raddr = '0;
			rdata_aux = '0;
		end
		else begin
			case(func)
				Ld	, 
				Lw	,
				Lwu	,
				Lh	,
				Lhu	,
				Lb	,
				Lbu	: begin raddr = src1 + src2; pmem_read(raddr, rdata_aux); end // TODO: The plus here might be problem
				default: begin raddr = '0; rdata_aux = '0; end
			endcase
		end
	// for pmem data read 2
	always@(*) begin
		rdata = '0;
		case(raddr[2:0])
			3'h0: rdata = rdata_aux;	
			3'h1: rdata[XLEN-1-8:0] = rdata_aux[XLEN-1:8];	
			3'h2: rdata[XLEN-1-16:0] = rdata_aux[XLEN-1:16];	
			3'h3: rdata[XLEN-1-24:0] = rdata_aux[XLEN-1:24];	
			3'h4: rdata[XLEN-1-32:0] = rdata_aux[XLEN-1:32];	
			3'h5: rdata[XLEN-1-40:0] = rdata_aux[XLEN-1:40];	
			3'h6: rdata[XLEN-1-48:0] = rdata_aux[XLEN-1:48];	
			3'h7: rdata[XLEN-1-56:0] = rdata_aux[XLEN-1:56];	
			default: assert(0);
		endcase
//		integer i;
//		for(i = 3'h0; i < raddr[2:0]; i = i+1)
//			rdata[XLEN-1-i*8:XLEN-1-i*8-7] = 8'b0;
//		rdata[XLEN-1-i*8:0] = rdata_aux[XLEN-1:i*8];
	end

	always@(posedge clk)
		$display("In EXU, pmem_read_inst_aux = 0x%x", inst_aux);
	always@(posedge clk)
		$display("In EXU, pmem_read_pc = 0x%x", pc);
	always@(posedge clk)
		$display("In EXU, pmem_read_rdata = 0x%x", rdata);
	always@(posedge clk)
		$display("In EXU, pmem_read_raddr 0x%x", raddr);

	// insts do write mem
	always@(posedge clk)
		case(func)
			// Stype
			Sd	: pmem_write(destI + src1, src2, 8'hff);
			Sw	: pmem_write(destI + src1, src2, 8'hf);
			Sh	: pmem_write(destI + src1, src2, 8'h3);
			Sb	: pmem_write(destI + src1, src2, 8'h1);
			default:; 
		endcase

	localparam shift_mask = 6'h3f;
	localparam w_shift_mask = 5'h1f;
	reg [31:0] tmp;
	wire z_flag;
	reg [XLEN-1:0] z_cal;
	assign z_flag = (z_cal == 0);
//	insts do not write mem
  always@(*) begin // combinational circuit
    exec_result = 0;
    dnpc        = 0;
    inval       = 0;
    case(func)
      // Rtype
      Addw	: exec_result = `ysyx_22050039_SEXT(XLEN, src1[31:0] + src2[31:0], 32);
      Subw	: exec_result = `ysyx_22050039_SEXT(XLEN, src1[31:0] - src2[31:0], 32);
      Mulw	:;
      Divw	: exec_result = `ysyx_22050039_SEXT(XLEN, $signed(src1[31:0]) / $signed(src2[31:0]), 32);
      Divuw	:;
      Sllw	: exec_result = `ysyx_22050039_SEXT(XLEN, src1[31:0] << (src2 & w_shift_mask), 32); 
      Srlw	:;
      Sraw	:;
      Remw	: exec_result = `ysyx_22050039_SEXT(XLEN, $signed(src1[31:0]) % $signed(src2[31:0]), 32);
      Remuw	:;
      Sub	: exec_result = src1 - src2;
      Or	: exec_result = src1 | src2;
      Add	: exec_result = src1 + src2;
      Mul	: exec_result = src1 * src2;
      Xor	:;
      Sll	:;
      Slt	: exec_result = ($signed(src1) < $signed(src2));
      Sltu	: exec_result = (src1 < src2);
      And	: exec_result = src1 & src2;
      Div	:;
      Divu	:;
      Rem	:;
      Remu	:;
      // Itype
      Xori	: exec_result = src1 ^ src2;
      Sltiu	: exec_result = (src1 < src2);
      Slli	: exec_result = src1 << (src2 & shift_mask);
      Srli	: exec_result = src1 >> (src2 & shift_mask);
      Srai	: exec_result = $signed(src1) >>> (src2 & shift_mask);
      Andi	: exec_result = src1 & src2;
      Ori	:;
      Addiw	: exec_result = `ysyx_22050039_SEXT(XLEN, src1[31:0] + src2[31:0], 32);
			Slliw	: begin tmp = src1[31:0] << (src2 & w_shift_mask); exec_result = `ysyx_22050039_SEXT(XLEN, tmp, 32); end
      Srliw	:;
			Sraiw	: begin exec_result = `ysyx_22050039_SEXT(XLEN, $signed(src1[31:0]) >>> (src2 & w_shift_mask), 32); end
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
			Sd	: ;
			Sw	: ;
			Sh	: ;
			Sb	: ;
			// Btype
			Beq		: begin dnpc = (src1 == src2) ? pc + destI : pc + 4; end 
			Bne		: begin dnpc = (src1 != src2) ? pc + destI : pc + 4; end 
			Bltu	: begin dnpc = (src1 < src2) ? pc + destI : pc + 4; end 
			Bge	: begin dnpc = ($signed(src1) >= $signed(src2)) ? pc + destI : pc + 4; end 
			Bgeu	:;
			Blt	: begin dnpc = ($signed(src1) < $signed(src2)) ? pc + destI : pc + 4; end 
			// Utype
			Auipc	: begin exec_result = src1 + pc; $display("auipc, exec_result = 0x%x", exec_result); end
			Lui	:	exec_result   = src1;
			// Jtype
			Jal	: begin exec_result = pc + 4; dnpc = pc + src1; end
			Ebreak	: ebreak();
			default: inval = 1; // invalid
    endcase
  end
//$display("===cyh===bge===, pc = 0x%x, destI = 0x%x", pc, destI);
  
  // invalid is only valid when rst = 0
  reg inval;
  always@(posedge clk)
    if (~rst && inval)
      invalid();
      // else do nothing
  
endmodule
