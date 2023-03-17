package cyhcore

import chisel3._
import chisel3.util._

import utils._

object MDUOpType {
  // MUL performs an XLEN-bit×XLEN-bit multiplication of rs1 by rs2 and places the 
  // lower XLEN bits in the destination register
  def mul    = "b0000".U
  // def mulh   = "b0001".U
  // def mulhsu = "b0010".U
  // def mulhu  = "b0011".U
  // def div    = "b0100".U
  def divu   = "b0101".U
  // def rem    = "b0110".U
  // def remu   = "b0111".U

  // MULW is an RV64 instruction that multiplies the lower 32 bits of the source registers, 
  // placing the sign-extension of the lower 32 bits of the result into the destination register.
  def mulw   = "b1000".U
  def divw   = "b1100".U
  def divuw  = "b1101".U
  def remw   = "b1110".U
  // def remuw  = "b1111".U

  // 求余可以用除法器来计算，所以这两个做同一个判断
  def isDivRem(op: UInt) = op(2)
  def isDivRemSign(op: UInt) = isDivRem(op) && !op(0)
  def isRem(op: UInt) = op(1)
  def isW(op: UInt) = op(3)
}

class MulDivIO(val len: Int) extends Bundle {
  val in = Flipped(Vec(2, Output(UInt(len.W)))) // 两个输入
  val sign = Input(Bool()) // 是否有符号
  val out = Output(UInt((len * 2).W)) // 乘法结果的位宽有可能是输入位宽的2倍
}

class Multiplier(len: Int) extends CyhCoreModule {
  val io = IO(new MulDivIO(len))

  val mulRes = io.in(0).asSInt * io.in(1).asSInt
  io.out := mulRes.asUInt
}

class Divider(len: Int) extends CyhCoreModule {
  val io = IO(new MulDivIO(len))

  val (sign, src1, src2) = (io.sign, io.in(0), io.in(1))

  val resQ = Wire(UInt(len.W))
  resQ := Mux(sign, (src1.asSInt / src2.asSInt).asUInt, src1.asUInt / src2.asUInt)
  val resR = Wire(UInt(len.W))
  resR := Mux(sign, (src1.asSInt % src2.asSInt).asUInt, src1.asUInt % src2.asUInt)
  io.out := Cat(resR, resQ)
}

class MDUIO extends FunctionUnitIO {
}

// DIV, MUL, REM
class MDU extends CyhCoreModule {
  // val io = IO(new MDU_bundle())
  val io = IO(new MDUIO)

  val (src1, src2, func) = (io.in.src1, io.in.src2, io.in.func)
  def access(src1: UInt, src2: UInt, func: UInt): UInt = {
    this.src1  := src1
    this.src2  := src2
    this.func  := func
    io.out
  }

  // 判断使用除法器还是乘法器
  val isDivRem = MDUOpType.isDivRem(func)
  // 判断是否是求余
  val isRem = MDUOpType.isRem(func)
  // 如果是除法，是有符号还是无符号    NOTE: 乘法不需要判断符号
  val isDivRemSign = MDUOpType.isDivRemSign(func)
  // 判断是否是 half 计算
  val isW = MDUOpType.isW(func)

  // TODO: 为什么果壳这里乘法器的长度是 XLEN + 1，不是XLEN?
  val mul = Module(new Multiplier(XLEN)) 
  mul.io.in(0) := src1
  mul.io.in(1) := src2
  mul.io.sign  := isDivRemSign // NOTE: 其实乘法不需要判断符号
  val mulRes = mul.io.out(XLEN-1,0)   // mul 把XLEN*XLEN后，只取XLEN位宽的结果

  val div = Module(new Divider(XLEN)) // 除法器的结果位宽是2*XLEN，低XLEN位放商，高XLEN位放余
  div.io.in(0) := src1
  div.io.in(1) := src2
  div.io.sign  := isDivRemSign // NOTE: 其实乘法不需要判断符号
  val divRes = Mux(isRem, div.io.out(2*XLEN-1,XLEN), div.io.out(XLEN-1,0)) // 除法的商放在低XLEN位，余数放在高XLEN位

  val res = Mux(isDivRem, divRes, mulRes)

  io.out := Mux(isW, SignExt(res(31,0),XLEN), res)  // 根据数学公式证明，mulw 直接取 mul 结果的低32位即可
}


