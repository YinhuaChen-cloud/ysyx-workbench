// package Macros
// 
// import chisel3._
// import chisel3.util._
// 
// trait DecoderConstants {
//   // Whether inst is invalid
//   val Y = true.B
//   val N = false.B
// 
//   // PC Select Signal
//   val PC_4   = 0.asUInt(3.W)  // PC + 4
//   val PC_BR  = 1.asUInt(3.W)  // branch_target
//   val PC_J   = 2.asUInt(3.W)  // jump_target
//   val PC_JR  = 3.asUInt(3.W)  // jump_reg_target
//   val PC_EXC = 4.asUInt(3.W)  // exception
// 
//   // Branch Type
//   val BR_N   = 0.asUInt(4.W)  // Next
//   val BR_NE  = 1.asUInt(4.W)  // Branch on NotEqual
//   val BR_EQ  = 2.asUInt(4.W)  // Branch on Equal
//   val BR_GE  = 3.asUInt(4.W)  // Branch on Greater/Equal
//   val BR_GEU = 4.asUInt(4.W)  // Branch on Greater/Equal Unsigned
//   val BR_LT  = 5.asUInt(4.W)  // Branch on Less Than
//   val BR_LTU = 6.asUInt(4.W)  // Branch on Less Than Unsigned
//   val BR_J   = 7.asUInt(4.W)  // Jump
//   val BR_JR  = 8.asUInt(4.W)  // Jump Register
// 
//   // Operand 1 Select Signal
//   val OP1_RS1 = 1.asUInt(2.W) // Register Source #1
//   val OP1_IMU = 2.asUInt(2.W) // immediate, U-type
//   val OP1_IMZ = 3.asUInt(2.W) // Zero-extended rs1 field of inst, for CSRI instructions
//   val OP1_X   = 0.asUInt(2.W)
//  
//   // Operand 2 Select Signal
//   val OP2_RS2 = 1.asUInt(3.W) // Register Source #2
//   val OP2_IMI = 2.asUInt(3.W) // immediate, I-type
//   val OP2_IMS = 3.asUInt(3.W) // immediate, S-type
//   val OP2_PC  = 4.asUInt(3.W) // PC
//   val OP2_X   = 0.asUInt(3.W)
// 
//   // ALU Operation Signal
//   val ALU_ADD = 1.asUInt(4.W)
//   val ALU_SUB = 2.asUInt(4.W)
//   val ALU_MUX = 3.asUInt(4.W)
//   val ALU_DIV = 4.asUInt(4.W)
//   val ALU_REM = 5.asUInt(4.W)
//   val ALU_SLL = 6.asUInt(4.W)
//   val ALU_SRL = 7.asUInt(4.W)
//   val ALU_SRA = 8.asUInt(4.W)
//   val ALU_AND = 9.asUInt(4.W)
//   val ALU_OR  = 10.asUInt(4.W)
//   val ALU_XOR = 11.asUInt(4.W)
//   val ALU_SLT = 12.asUInt(4.W)
//   val ALU_SLTU= 13.asUInt(4.W)
//   val ALU_COPY1= 14.asUInt(4.W)
//   val ALU_X   = 0.asUInt(4.W)
// 
//   // ALU Unsigned or Signed
//   val SIGN_N  = false.B
//   val SIGN_Y  = true.B
//   val SIGN_X  = false.B 
// 
//   // Writeback Select Signal
//   val WB_ALU  = 0.asUInt(2.W)
//   val WB_MEM  = 1.asUInt(2.W)
//   val WB_PC4  = 2.asUInt(2.W)
// //  val WB_CSR  = 3.asUInt(2.W)
//   val WB_X    = 0.asUInt(2.W)
// 
//   // Whether write register
//   val WREG_0 = false.B 
//   val WREG_1 = true.B 
// 
//   // Whether write mem
//   val WMEM_0 = false.B 
//   val WMEM_1 = true.B 
// 
//   // mem mask
//   val MEM_MSK_B   = 0.asUInt(3.W)
//   val MEM_MSK_BU  = 1.asUInt(3.W)
//   val MEM_MSK_H   = 2.asUInt(3.W)
//   val MEM_MSK_HU  = 3.asUInt(3.W)
//   val MEM_MSK_W   = 4.asUInt(3.W)
//   val MEM_MSK_WU  = 5.asUInt(3.W)
//   val MEM_MSK_X   = 6.asUInt(3.W)
// 
//   // alu mask
//   val ALU_MSK_X = 0.asUInt(1.W)
//   val ALU_MSK_W = 1.asUInt(1.W) 
// }
// 
// trait RISCVConstants
// {
//    val RD_MSB  = 11
//    val RD_LSB  = 7
//    val RS1_MSB = 19
//    val RS1_LSB = 15
//    val RS2_MSB = 24
//    val RS2_LSB = 20
// }
// 
// object Constants extends
//   DecoderConstants with
//   RISCVConstants
// {}
// 
// 
// 
// 
// 
