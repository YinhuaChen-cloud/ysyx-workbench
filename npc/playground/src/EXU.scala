import chisel3._
import chisel3.util._
import chisel3.stage.ChiselStage
import scala.collection.immutable.ArraySeq

import RV64ExuOp._

class EXU (xlen: Int = 64, 
  inst_len: Int = 32) extends Module {
  val io = IO(new Bundle {
    val exuop = Input(RV64ExuOp())
    val src1 = Input(UInt(xlen.W))
    val src2 = Input(UInt(xlen.W))
    val destI = Input(UInt(xlen.W))
    val pc = Input(UInt(xlen.W))
    val exec_result = Output(UInt(xlen.W))
    val dnpc = Output(UInt(xlen.W))
  })

  class ADDER (width: Int = 64) extends Module {
    val io = IO(new Bundle{
      val input1 = Input(UInt(width.W))
      val input2 = Input(UInt(width.W))
      val sum = Output(UInt(width.W))
    }) 
    
    io.sum := io.input1 + io.input2

  }

  // The core of ExecuteUnit
  val tmpsrc1 = Wire(UInt(xlen.W)) 
//  val tmpsrc2 = Wire(UInt(xlen.W)) 

  tmpsrc1 := MuxLookup(
    io.exuop.asUInt, 0.U,
    ArraySeq.unsafeWrapArray(Array(
      Addi.asUInt -> io.src1 + io.src2,
      Auipc.asUInt -> io.src1,
      Jal.asUInt -> io.pc,
      Jalr.asUInt -> io.pc,
    ))
  )
  
//  io.exec_result := MuxLookup(
//    io.exuop, 0.U,
//    ArraySeq.unsafeWrapArray(Array(
//      Addi -> io.src1 + io.src2,
//      Auipc -> io.src1 + io.pc,
//      Jal -> io.pc + 4.U,
//      Jalr -> io.pc + 4.U,
//    ))
//  )
//      SD -> Cat(Fill(xlen-32, unpacked.imm(19)), unpacked.imm, Fill(xlen-32-20, 0.U)),
//      EBREAK -> Cat(Fill(xlen-20-1, unpacked.imm(19)), unpacked.imm, 0.U),
//

//  io.dnpc := MuxLookup(
//    io.exuop, 0.U,
//    ArraySeq.unsafeWrapArray(Array(
//      Jal -> io.pc + io.src1,
//      Jalr -> io.src1 + io.src2,
//    ))
//  )
//      SD -> Cat(Fill(xlen-32, unpacked.imm(19)), unpacked.imm, Fill(xlen-32-20, 0.U)),
//      EBREAK -> Cat(Fill(xlen-20-1, unpacked.imm(19)), unpacked.imm, 0.U),
  
// ===================================

//	insts do not write mem
//  always@(*) begin // combinational circuit
//    exec_result = 0;
//    dnpc        = 0;
//    inval       = 0;
//    case(func)
//      // Rtype
//      Addw	: exec_result = `ysyx_22050039_SEXT(XLEN, src1[31:0] + src2[31:0], 32);
//      Subw	: exec_result = `ysyx_22050039_SEXT(XLEN, src1[31:0] - src2[31:0], 32);
//      Mulw	: exec_result = `ysyx_22050039_SEXT(XLEN, src1[31:0] * src2[31:0], 32);
//      Divw	: exec_result = `ysyx_22050039_SEXT(XLEN, $signed(src1[31:0]) / $signed(src2[31:0]), 32);
//      Divuw	: exec_result = `ysyx_22050039_SEXT(XLEN, src1[31:0] / src2[31:0], 32);
//      Sllw	: exec_result = `ysyx_22050039_SEXT(XLEN, src1[31:0] << (src2 & w_shift_mask), 32); 
//      Srlw	: exec_result = `ysyx_22050039_SEXT(XLEN, src1[31:0] >> (src2 & w_shift_mask), 32); 
//      Sraw	: begin exec_result = `ysyx_22050039_SEXT(XLEN, $signed(src1[31:0]) >>> (src2 & w_shift_mask), 32); end
//      Remw	: exec_result = `ysyx_22050039_SEXT(XLEN, $signed(src1[31:0]) % $signed(src2[31:0]), 32);
//      Remuw	: exec_result = `ysyx_22050039_SEXT(XLEN, src1[31:0] % src2[31:0], 32);
//      Sub	: exec_result = src1 - src2;
//      Or	: exec_result = src1 | src2;
//      Add	: exec_result = src1 + src2;
//      Mul	: exec_result = src1 * src2;
//      Xor	: exec_result = src1 ^ src2;
//      Sll	: exec_result = src1 << (src2 & shift_mask);
//      Slt	: exec_result = ($signed(src1) < $signed(src2));
//      Sltu	: exec_result = (src1 < src2);
//      And	: exec_result = src1 & src2;
//      Div	: exec_result = $signed(src1) / $signed(src2);
//      Divu: exec_result = src1 / src2;
//      Rem	: exec_result = $signed(src1) % $signed(src2);
//      Remu: exec_result = src1 % src2;
//      // Itype
//      Xori	: exec_result = src1 ^ src2;
//      Sltiu	: exec_result = (src1 < src2);
//      Slli	: exec_result = src1 << (src2 & shift_mask);
//      Srli	: exec_result = src1 >> (src2 & shift_mask);
//      Srai	: exec_result = $signed(src1) >>> (src2 & shift_mask);
//      Andi	: exec_result = src1 & src2;
//      Ori		: exec_result = src1 | src2;
//      Addiw	: exec_result = `ysyx_22050039_SEXT(XLEN, src1[31:0] + src2[31:0], 32);
//			Slliw	: begin tmp = src1[31:0] << (src2 & w_shift_mask); exec_result = `ysyx_22050039_SEXT(XLEN, tmp, 32); end
//      Srliw	: begin exec_result = `ysyx_22050039_SEXT(XLEN, src1[31:0] >> (src2 & w_shift_mask), 32); end
//			Sraiw	: begin exec_result = `ysyx_22050039_SEXT(XLEN, $signed(src1[31:0]) >>> (src2 & w_shift_mask), 32); end
//      Ld	: exec_result = rdata; 
//      Lw	: exec_result = {{32{rdata[31]}}, rdata[31:0]};
//      Lwu	: exec_result = {32'b0, rdata[31:0]};
//      Lh	: exec_result = {{48{rdata[15]}}, rdata[15:0]};
//      Lhu	: exec_result = {48'b0, rdata[15:0]};
//      Lb	: exec_result = {{56{rdata[7]}}, rdata[7:0]};
//      Lbu	: exec_result = {56'b0, rdata[7:0]};
//			Addi	: exec_result = src1 + src2; 
//			// Stype
//			Sd	: ;
//			Sw	: ;
//			Sh	: ;
//			Sb	: ;
//			// Btype
//			Beq		: begin dnpc = (src1 == src2) ? pc + destI : pc + 4; end 
//			Bne		: begin dnpc = (src1 != src2) ? pc + destI : pc + 4; end 
//			Bltu	: begin dnpc = (src1 < src2) ? pc + destI : pc + 4; end 
//			Bge		: begin dnpc = ($signed(src1) >= $signed(src2)) ? pc + destI : pc + 4; end 
//			Bgeu	: begin dnpc = (src1 >= src2) ? pc + destI : pc + 4; end 
//			Blt	: begin dnpc = ($signed(src1) < $signed(src2)) ? pc + destI : pc + 4; end 
//			// Utype
//			Auipc	: begin exec_result = src1 + pc; end
//			Lui	:	exec_result   = src1;
//			// Jtype
//			Jal	: begin exec_result = pc + 4; dnpc = pc + src1; end
//			Ebreak	: ebreak();
//			default: inval = 1; // invalid
//    endcase
//  end

}







