package cyhcore

import chisel3._
import chisel3.util._

import utils._

class Decoder extends CyhCoreModule with HasInstrType {
  val io = IO(new Bundle {
    val in  = Flipped(Decoupled(new CtrlFlowIO))
    val out = Decoupled(new DecodeIO)
    // val isWFI = Output(Bool()) // require NutCoreSim to advance mtime when wfi to reduce the idle time in Linux
  })

// out(DecodeIO) ------------------------------------------ cf(CtrlFlowIO)
  // val instr = Output(UInt(64.W))
  // val pc = Output(UInt(VAddrBits.W))

  io.in.bits <> io.out.bits.cf

// out(DecodeIO) ------------------------------------------ ctrl(CtrlSignalIO)
  // val src1Type = Output(SrcType())
  // val src2Type = Output(SrcType())
  // val fuType = Output(FuType())
  // val fuOpType = Output(FuOpType())
  // val rfSrc1 = Output(UInt(5.W))
  // val rfSrc2 = Output(UInt(5.W))
  // val rfWen = Output(Bool())
  // val rfDest = Output(UInt(5.W))

  val instr = io.in.bits.instr
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
  // 如果指令是 Lui，那么之前对 src1Type 的赋值是错的，下面这行需要纠正之前的错误
  io.out.bits.ctrl.src1Type := Mux(instr(6,0) === "b0110111".U, SrcType.reg, src1Type) // 如果是lui指令，那么src1类型就是reg
  io.out.bits.ctrl.src2Type := src2Type

  io.out.bits.ctrl.fuType   := fuType
  io.out.bits.ctrl.fuOpType := fuOpType

  val (rs, rt, rd) = (instr(19, 15), instr(24, 20), instr(11, 7))
  val rfSrc1 = rs
  val rfSrc2 = rt
  val rfDest = rd

  io.out.bits.ctrl.rfSrc1 := Mux(src1Type === SrcType.pc, 0.U, rfSrc1) // TODO: 有没有可能和 src1 统合成一个信号？还是为了支持乱序、多发射、流水等才分开？
  io.out.bits.ctrl.rfSrc2 := Mux(src2Type === SrcType.reg, rfSrc2, 0.U)
  io.out.bits.ctrl.rfWen  := isrfWen(instrType)
  io.out.bits.ctrl.rfDest := Mux(isrfWen(instrType), rfDest, 0.U) 

// out(DecodeIO) ------------------------------------------ data(DataSrcIO)
  // val src1 = Output(UInt(XLEN.W))
  // val src2 = Output(UInt(XLEN.W))
  // val imm  = Output(UInt(XLEN.W))

  // TODO: 目前来看，src1 和 src2 由于位于 ISU 内的 寄存器堆 赋值, imm 则在译码阶段给出
  io.out.bits.data := DontCare
  val imm = OneHotTree(instrType, List(
    InstrI  -> SignExt(instr(31, 20), XLEN),
    InstrS  -> SignExt(Cat(instr(31, 25), instr(11, 7)), XLEN),
    InstrB  -> SignExt(Cat(instr(31), instr(7), instr(30, 25), instr(11, 8), 0.U(1.W)), XLEN),
    InstrU  -> SignExt(Cat(instr(31, 12), 0.U(12.W)), XLEN), //fixed
    InstrJ  -> SignExt(Cat(instr(31), instr(19, 12), instr(20), instr(30, 21), 0.U(1.W)), XLEN)
  ))
  io.out.bits.data.imm := imm

// handshake ------------------------------------------ 
  
  io.in.ready  := DontCare
  // 由于假设IDU的运算能在一拍内完成，当 in 为 valid 时，就可以让 out 为 valid
  // io.out.valid := io.in.valid
  io.out.valid := DontCare

  Debug(p"In IDU-Decoder, ${io.out.bits.ctrl}")

// ---------------- judge whether instr is EBREAK --------------- start
  val isEbreak = (io.in.bits.instr === Priviledged.EBREAK) & io.in.valid
  val inv_inst = (instrType === InstrN) & io.in.valid
  val dpic = Module(new DPIC)
  dpic.io.clk := clock
  dpic.io.rst := reset
  dpic.io.isEbreak := isEbreak 
  dpic.io.inv_inst := inv_inst
// ---------------- judge whether instr is EBREAK --------------- end
  
}

class IDU extends CyhCoreModule with HasInstrType {
  val io = IO(new Bundle {
    // val in = Vec(2, Flipped(Decoupled(new CtrlFlowIO)))
    val in = Flipped(Decoupled(new CtrlFlowIO))
    // val out = Vec(2, Decoupled(new DecodeIO))
    val out = Decoupled(new DecodeIO)
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

