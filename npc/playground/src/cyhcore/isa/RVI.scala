package cyhcore

import chisel3._
import chisel3.util._

// do not support 32-bit CPU
object RV32I_ALUInstr extends HasInstrType {
  def ADDI    = BitPat("b????????????_?????_000_?????_0010011")
  def SLLI    = BitPat("b000000??????_?????_001_?????_0010011")
  def SLTIU   = BitPat("b????????????_?????_011_?????_0010011")
  def XORI    = BitPat("b????????????_?????_100_?????_0010011")
  def SRLI    = BitPat("b000000??????_?????_101_?????_0010011")
  def ORI     = BitPat("b????????????_?????_110_?????_0010011")
  def ANDI    = BitPat("b????????????_?????_111_?????_0010011")
  def SRAI    = BitPat("b010000??????_?????_101_?????_0010011")
  def ADD     = BitPat("b0000000_?????_?????_000_?????_0110011")
  def SLL     = BitPat("b0000000_?????_?????_001_?????_0110011")
  def SLT     = BitPat("b0000000_?????_?????_010_?????_0110011")
  def SLTU    = BitPat("b0000000_?????_?????_011_?????_0110011")
  def XOR     = BitPat("b0000000_?????_?????_100_?????_0110011")
  def OR      = BitPat("b0000000_?????_?????_110_?????_0110011")
  def AND     = BitPat("b0000000_?????_?????_111_?????_0110011")
  def SUB     = BitPat("b0100000_?????_?????_000_?????_0110011")
  def AUIPC   = BitPat("b????????????????????_?????_0010111")
  def LUI     = BitPat("b????????????????????_?????_0110111")

  val table = Array(
    // ADDI      -> List(Y, BR_N  , OP1_RS1, OP2_IMI, ALU_ADD , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_Y),
    // SLLI      -> List(Y, BR_N  , OP1_RS1, OP2_IMI, ALU_SLL , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_N),
    // SLTIU     -> List(Y, BR_N  , OP1_RS1, OP2_IMI, ALU_SLTU, WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_N),
    // XORI      -> List(Y, BR_N  , OP1_RS1, OP2_IMI, ALU_XOR , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_Y),
    // SRLI      -> List(Y, BR_N  , OP1_RS1, OP2_IMI, ALU_SRL , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_N),
    // ORI       -> List(Y, BR_N  , OP1_RS1, OP2_IMI, ALU_OR  , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_Y),
    // ANDI      -> List(Y, BR_N  , OP1_RS1, OP2_IMI, ALU_AND , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_Y),
    // SRAI      -> List(Y, BR_N  , OP1_RS1, OP2_IMI, ALU_SRA , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_N),

    // ADD       -> List(Y, BR_N  , OP1_RS1, OP2_RS2, ALU_ADD , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_Y),
    // SLL       -> List(Y, BR_N  , OP1_RS1, OP2_RS2, ALU_SLL , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_N),
    // SLT       -> List(Y, BR_N  , OP1_RS1, OP2_RS2, ALU_SLT , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_N),
    // SLTU      -> List(Y, BR_N  , OP1_RS1, OP2_RS2, ALU_SLTU, WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_N),
    // XOR       -> List(Y, BR_N  , OP1_RS1, OP2_RS2, ALU_XOR , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_N),
    // OR        -> List(Y, BR_N  , OP1_RS1, OP2_RS2, ALU_OR  , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_N),
    // AND       -> List(Y, BR_N  , OP1_RS1, OP2_RS2, ALU_AND , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_N),
    // SUB       -> List(Y, BR_N  , OP1_RS1, OP2_RS2, ALU_SUB , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_N),

    // AUIPC     -> List(Y, BR_N  , OP1_IMU, OP2_PC , ALU_ADD , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_N),
    // LUI       -> List(Y, BR_N  , OP1_IMU, OP2_X ,  ALU_ADD , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_W, SIGN_N),

    // ADDI           -> List(InstrI, FuType.alu, ALUOpType.add),
    // SLLI           -> List(InstrI, FuType.alu, ALUOpType.sll),
    // // SLTI           -> List(InstrI, FuType.alu, ALUOpType.slt),
    // SLTIU          -> List(InstrI, FuType.alu, ALUOpType.sltu),
    // XORI           -> List(InstrI, FuType.alu, ALUOpType.xor),
    // SRLI           -> List(InstrI, FuType.alu, ALUOpType.srl),
    // ORI            -> List(InstrI, FuType.alu, ALUOpType.or ),
    // ANDI           -> List(InstrI, FuType.alu, ALUOpType.and),
    // SRAI           -> List(InstrI, FuType.alu, ALUOpType.sra),

    // ADD            -> List(InstrR, FuType.alu, ALUOpType.add),
    // SLL            -> List(InstrR, FuType.alu, ALUOpType.sll),
    // SLT            -> List(InstrR, FuType.alu, ALUOpType.slt),
    // SLTU           -> List(InstrR, FuType.alu, ALUOpType.sltu),
    // XOR            -> List(InstrR, FuType.alu, ALUOpType.xor),
    // // SRL            -> List(InstrR, FuType.alu, ALUOpType.srl),
    // OR             -> List(InstrR, FuType.alu, ALUOpType.or ),
    // AND            -> List(InstrR, FuType.alu, ALUOpType.and),
    // SUB            -> List(InstrR, FuType.alu, ALUOpType.sub),
    // // SRA            -> List(InstrR, FuType.alu, ALUOpType.sra),

    // AUIPC          -> List(InstrU, FuType.alu, ALUOpType.add),
    // LUI            -> List(InstrU, FuType.alu, ALUOpType.add)
  )
}

object RV32I_BRUInstr extends HasInstrType {
  def JAL     = BitPat("b????????????????????_?????_1101111")
  def JALR    = BitPat("b????????????_?????_000_?????_1100111")

  def BNE     = BitPat("b???????_?????_?????_001_?????_1100011")
  def BEQ     = BitPat("b???????_?????_?????_000_?????_1100011")
  def BLT     = BitPat("b???????_?????_?????_100_?????_1100011")
  def BGE     = BitPat("b???????_?????_?????_101_?????_1100011")
  def BLTU    = BitPat("b???????_?????_?????_110_?????_1100011")
  def BGEU    = BitPat("b???????_?????_?????_111_?????_1100011")

  val table = Array(
    // JAL       -> List(Y, BR_J  , OP1_X  , OP2_X  , ALU_X   , WB_PC4, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_N),
    // JALR      -> List(Y, BR_JR , OP1_RS1, OP2_IMI, ALU_X   , WB_PC4, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_N),

    // BEQ       -> List(Y, BR_EQ , OP1_X  , OP2_X  , ALU_X   , WB_X  , WREG_0, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_Y),
    // BNE       -> List(Y, BR_NE , OP1_X  , OP2_X  , ALU_X   , WB_X  , WREG_0, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_Y),
    // BLT       -> List(Y, BR_LT , OP1_X  , OP2_X  , ALU_X   , WB_X  , WREG_0, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_Y),
    // BGE       -> List(Y, BR_GE , OP1_X  , OP2_X  , ALU_X   , WB_X  , WREG_0, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_Y),
    // BLTU      -> List(Y, BR_LTU, OP1_X  , OP2_X  , ALU_X   , WB_X  , WREG_0, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_Y),
    // BGEU      -> List(Y, BR_GEU, OP1_X  , OP2_X  , ALU_X   , WB_X  , WREG_0, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_Y),

    // TODO: 在没有独立 BRU 的情况下，使用 ALUOPType，那么在有独立的 BRU 时呢？
    // 独立的 BRU 似乎只出现在有 BPU (分支预测单元) 的情况下
    // JAL            -> List(InstrJ, FuType.bru, ALUOpType.jal),
    // JALR           -> List(InstrI, FuType.bru, ALUOpType.jalr),

    // BEQ            -> List(InstrB, FuType.bru, ALUOpType.beq),
    // BNE            -> List(InstrB, FuType.bru, ALUOpType.bne),
    // BLT            -> List(InstrB, FuType.bru, ALUOpType.blt),
    // BGE            -> List(InstrB, FuType.bru, ALUOpType.bge),
    // BLTU           -> List(InstrB, FuType.bru, ALUOpType.bltu),
    // BGEU           -> List(InstrB, FuType.bru, ALUOpType.bgeu)
  )
}

object RV32I_LSUInstr extends HasInstrType {
  def LB      = BitPat("b????????????_?????_000_?????_0000011")
  def LH      = BitPat("b????????????_?????_001_?????_0000011")
  def LW      = BitPat("b????????????_?????_010_?????_0000011")
  def LBU     = BitPat("b????????????_?????_100_?????_0000011")
  def LHU     = BitPat("b????????????_?????_101_?????_0000011")
  def SB      = BitPat("b???????_?????_?????_000_?????_0100011")
  def SH      = BitPat("b???????_?????_?????_001_?????_0100011")
  def SW      = BitPat("b???????_?????_?????_010_?????_0100011")

  val table = Array(
    // LB        -> List(Y, BR_N  , OP1_RS1, OP2_IMI, ALU_ADD , WB_MEM, WREG_1, WMEM_0, MEM_MSK_B , ALU_MSK_X, SIGN_N),
    // LH        -> List(Y, BR_N  , OP1_RS1, OP2_IMI, ALU_ADD , WB_MEM, WREG_1, WMEM_0, MEM_MSK_H , ALU_MSK_X, SIGN_Y),
    // LW        -> List(Y, BR_N  , OP1_RS1, OP2_IMI, ALU_ADD , WB_MEM, WREG_1, WMEM_0, MEM_MSK_W , ALU_MSK_X, SIGN_Y),
    // LBU       -> List(Y, BR_N  , OP1_RS1, OP2_IMI, ALU_ADD , WB_MEM, WREG_1, WMEM_0, MEM_MSK_BU, ALU_MSK_X, SIGN_N),
    // LHU       -> List(Y, BR_N  , OP1_RS1, OP2_IMI, ALU_ADD , WB_MEM, WREG_1, WMEM_0, MEM_MSK_HU, ALU_MSK_X, SIGN_Y),
    // SB        -> List(Y, BR_N  , OP1_RS1, OP2_IMS, ALU_ADD , WB_X  , WREG_0, WMEM_1, MEM_MSK_B , ALU_MSK_X, SIGN_X),
    // SH        -> List(Y, BR_N  , OP1_RS1, OP2_IMS, ALU_ADD , WB_X  , WREG_0, WMEM_1, MEM_MSK_H , ALU_MSK_X, SIGN_X),
    // SW        -> List(Y, BR_N  , OP1_RS1, OP2_IMS, ALU_ADD , WB_X  , WREG_0, WMEM_1, MEM_MSK_W , ALU_MSK_X, SIGN_X),

    // LB             -> List(InstrI, FuType.lsu, LSUOpType.lb ),
    // LH             -> List(InstrI, FuType.lsu, LSUOpType.lh ),
    // LW             -> List(InstrI, FuType.lsu, LSUOpType.lw ),
    // LBU            -> List(InstrI, FuType.lsu, LSUOpType.lbu),
    // LHU            -> List(InstrI, FuType.lsu, LSUOpType.lhu),
    // SB             -> List(InstrS, FuType.lsu, LSUOpType.sb ),
    // SH             -> List(InstrS, FuType.lsu, LSUOpType.sh ),
    // SW             -> List(InstrS, FuType.lsu, LSUOpType.sw)
  )
}

object RV64IInstr extends HasInstrType {
  def ADDIW   = BitPat("b???????_?????_?????_000_?????_0011011")
  def SLLIW   = BitPat("b0000000_?????_?????_001_?????_0011011")
  def SRLIW   = BitPat("b0000000_?????_?????_101_?????_0011011")
  def SRAIW   = BitPat("b0100000_?????_?????_101_?????_0011011")
  def SLLW    = BitPat("b0000000_?????_?????_001_?????_0111011")
  def SRLW    = BitPat("b0000000_?????_?????_101_?????_0111011")
  def SRAW    = BitPat("b0100000_?????_?????_101_?????_0111011")
  def ADDW    = BitPat("b0000000_?????_?????_000_?????_0111011")
  def SUBW    = BitPat("b0100000_?????_?????_000_?????_0111011")

  def LWU     = BitPat("b???????_?????_?????_110_?????_0000011")
  def LD      = BitPat("b???????_?????_?????_011_?????_0000011")
  def SD      = BitPat("b???????_?????_?????_011_?????_0100011")

  val table = Array(
    // ADDIW     -> List(Y, BR_N  , OP1_RS1, OP2_IMI, ALU_ADD , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_W, SIGN_Y),
    // SLLIW     -> List(Y, BR_N  , OP1_RS1, OP2_IMI, ALU_SLL , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_W, SIGN_N),
    // SRLIW     -> List(Y, BR_N  , OP1_RS1, OP2_IMI, ALU_SRL , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_W, SIGN_N),
    // SRAIW     -> List(Y, BR_N  , OP1_RS1, OP2_IMI, ALU_SRA , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_W, SIGN_N),
    // SLLW      -> List(Y, BR_N  , OP1_RS1, OP2_RS2, ALU_SLL , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_W, SIGN_N),
    // SRLW      -> List(Y, BR_N  , OP1_RS1, OP2_RS2, ALU_SRL , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_W, SIGN_N),
    // SRAW      -> List(Y, BR_N  , OP1_RS1, OP2_RS2, ALU_SRA , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_W, SIGN_N),
    // ADDW      -> List(Y, BR_N  , OP1_RS1, OP2_RS2, ALU_ADD , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_W, SIGN_Y),
    // SUBW      -> List(Y, BR_N  , OP1_RS1, OP2_RS2, ALU_SUB , WB_ALU, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_W, SIGN_Y),

    // LWU       -> List(Y, BR_N  , OP1_RS1, OP2_IMI, ALU_ADD , WB_MEM, WREG_1, WMEM_0, MEM_MSK_WU, ALU_MSK_X, SIGN_Y),
    // LD        -> List(Y, BR_N  , OP1_RS1, OP2_IMI, ALU_ADD , WB_MEM, WREG_1, WMEM_0, MEM_MSK_X , ALU_MSK_X, SIGN_Y),
    // SD        -> List(Y, BR_N  , OP1_RS1, OP2_IMS, ALU_ADD , WB_X  , WREG_0, WMEM_1, MEM_MSK_X , ALU_MSK_X, SIGN_X),

    // ADDIW          -> List(InstrI, FuType.alu, ALUOpType.addw),
    // SLLIW          -> List(InstrI, FuType.alu, ALUOpType.sllw),
    // SRLIW          -> List(InstrI, FuType.alu, ALUOpType.srlw),
    // SRAIW          -> List(InstrI, FuType.alu, ALUOpType.sraw),
    // SLLW           -> List(InstrR, FuType.alu, ALUOpType.sllw),
    // SRLW           -> List(InstrR, FuType.alu, ALUOpType.srlw),
    // SRAW           -> List(InstrR, FuType.alu, ALUOpType.sraw),
    // ADDW           -> List(InstrR, FuType.alu, ALUOpType.addw),
    // SUBW           -> List(InstrR, FuType.alu, ALUOpType.subw),

    // LWU            -> List(InstrI, FuType.lsu, LSUOpType.lwu),
    // LD             -> List(InstrI, FuType.lsu, LSUOpType.ld ),
    // SD             -> List(InstrS, FuType.lsu, LSUOpType.sd)
  )
}

object RVIInstr {
  val table = RV32I_ALUInstr.table
    // RV32I_BRUInstr.table ++ RV32I_LSUInstr.table ++
    // RV64IInstr.table
}

