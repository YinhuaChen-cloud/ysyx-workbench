package cyhcore

import chisel3._
import chisel3.util._

import utils._

class Decoder extends CyhCoreModule with HasInstrType {
  val io = IO(new Bundle {
    val in  = Flipped(new CtrlFlowIO)
    val out = new DecodeIO
    // val isWFI = Output(Bool()) // require NutCoreSim to advance mtime when wfi to reduce the idle time in Linux
  })

// out(DecodeIO) ------------------------------------------ cf(CtrlFlowIO)
  // val instr = Output(UInt(64.W))
  // val pc = Output(UInt(VAddrBits.W))
  io.out.cf <> io.in

// out(DecodeIO) ------------------------------------------ ctrl(CtrlSignalIO)
  // val src1Type = Output(SrcType())
  // val src2Type = Output(SrcType())
  // val fuType = Output(FuType())
  // val fuOpType = Output(FuOpType())
  // val rfSrc1 = Output(UInt(5.W))
  // val rfSrc2 = Output(UInt(5.W))
  // val rfWen = Output(Bool())
  // val rfDest = Output(UInt(5.W))
  val instr = io.in.instr
  // 果壳这里的默认译码似乎不是 invalid，而是中断，可能在中断中再判断是否是invalid
  // NOTE: 对于现在的我来说，不需要支持较为复杂的异常处理，凡是 InstrN 都直接判断 invalid 就好了
  val decodeList = ListLookup(instr, Instructions.DecodeDefault, Instructions.DecodeTable)

  val instrType :: fuType :: fuOpType :: Nil = decodeList 

  val SrcTypeTable = List(
    InstrI -> (SrcType.reg, SrcType.imm),
    InstrR -> (SrcType.reg, SrcType.reg),
    InstrS -> (SrcType.reg, SrcType.reg),
    // InstrSA-> (SrcType.reg, SrcType.reg),
    InstrB -> (SrcType.reg, SrcType.reg),
    InstrU -> (SrcType.pc , SrcType.imm), // Auipc 和 Lui，Auipc的src1是pc，Lui的src1是reg
    InstrJ -> (SrcType.pc , SrcType.imm),
    InstrN -> (SrcType.pc , SrcType.imm)
  )
  val src1Type = OneHotTree(instrType, SrcTypeTable.map(p => (p._1, p._2._1))) // 根据 SrcTypeTable 和 instrType 查 src1 的类型
  val src2Type = OneHotTree(instrType, SrcTypeTable.map(p => (p._1, p._2._2))) // 根据 SrcTypeTable 和 instrType 查 src2 的类型
  // fix LUI
  io.out.ctrl.src1Type := Mux(instr(6,0) === "b0110111".U, SrcType.reg, src1Type) // 如果是lui指令，那么src1类型就是reg
  io.out.ctrl.src2Type := src2Type

  io.out.ctrl.fuType   := fuType
  io.out.ctrl.fuOpType := fuOpType

  val (rs, rt, rd) = (instr(19, 15), instr(24, 20), instr(11, 7))
  val rfSrc1 = rs
  val rfSrc2 = rt
  val rfDest = rd

  io.out.ctrl.rfSrc1 := Mux(src1Type === SrcType.pc, 0.U, rfSrc1) // TODO: 有没有可能和 src1 统合成一个信号？还是为了支持乱序、多发射、流水等才分开？
  io.out.ctrl.rfSrc2 := Mux(src2Type === SrcType.reg, rfSrc2, 0.U)
  io.out.ctrl.rfWen  := isrfWen(instrType)
  io.out.ctrl.rfDest := Mux(isrfWen(instrType), rfDest, 0.U) 

// out(DecodeIO) ------------------------------------------ data(DataSrcIO)
  // val src1 = Output(UInt(XLEN.W))
  // val src2 = Output(UInt(XLEN.W))
  // val imm  = Output(UInt(XLEN.W))

  io.out.data := DontCare

  Debug(p"In IDU-Decoder, ${io.out.ctrl}")
  
}

class IDU extends CyhCoreModule with HasInstrType {
  val io = IO(new Bundle {
    // val in = Vec(2, Flipped(Decoupled(new CtrlFlowIO)))
    val in = Flipped(new CtrlFlowIO)
    // val out = Vec(2, Decoupled(new DecodeIO))
    val out = new DecodeIO
  })
  val decoder1  = Module(new Decoder)
  // val decoder2  = Module(new Decoder) // TODO: 为啥果壳默认有两个译码器？是为了双发射吗？
  // decoder1.io.in <> io.in(0)
  // io.in(1) := DontCare
  // io.in(1) <> decoder2.io.in
  io.in <> decoder1.io.in
  // io.out(0) <> decoder1.io.out
  // io.out(0) <> decoder1.io.out
  // io.out(1) := DontCare
  // io.out(1) <> decoder2.io.out

  decoder1.io.out <> io.out 

}



  // // val (valid_inst: Bool) :: br_type :: op1_sel :: op2_sel :: ds0 = decoded_signals
  // // val alu_op :: wb_sel :: (wreg: Bool) :: (wmem: Bool) :: ds1 = ds0
  // // val mem_msk_type :: alu_msk_type :: (sign_op: Bool) :: Nil = ds1

  // println(s"In IDU, io.inst = ${io.inst}, and valid_inst = ${valid_inst}")

  // io.idu_to_exu.pc_sel  := MuxLookup(
  //   br_type, PC_EXC,
  //   Array(
  //     BR_N   -> PC_4 , 
  //     BR_J   -> PC_J , 
  //     BR_JR  -> PC_JR, 
  //     BR_EQ  -> Mux(io.idu_to_exu.br_eq , PC_BR, PC_4),
  //     BR_NE  -> Mux(!io.idu_to_exu.br_eq, PC_BR, PC_4),
  //     BR_GE  -> Mux(!io.idu_to_exu.br_lt, PC_BR, PC_4),
  //     BR_GEU -> Mux(!io.idu_to_exu.br_ltu, PC_BR, PC_4),
  //     BR_LT  -> Mux(io.idu_to_exu.br_lt, PC_BR, PC_4),
  //     BR_LTU -> Mux(io.idu_to_exu.br_ltu, PC_BR, PC_4),
  //   )
  // )

  // io.idu_to_exu.op1_sel := op1_sel
  // io.idu_to_exu.op2_sel := op2_sel
  // io.idu_to_exu.alu_op  := alu_op
  // io.idu_to_exu.wb_sel  := wb_sel
  // io.idu_to_exu.reg_wen := wreg
  // io.isEbreak := (io.inst === Priviledged.EBREAK)
  // io.inv_inst := ~valid_inst
  // io.isWriteMem := wmem
  // io.idu_to_exu.sign_op := sign_op
  // io.idu_to_exu.mem_msk_type := mem_msk_type
  // io.idu_to_exu.alu_msk_type := alu_msk_type




