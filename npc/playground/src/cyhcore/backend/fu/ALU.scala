package cyhcore

import chisel3._
import chisel3.util._

import utils._

object ALUOpType {
  // 可以依靠 func(3, 0) 进行区分 -- start
  def add  = "b1000000".U
  def sll  = "b0000001".U
  def slt  = "b0000010".U
  def sltu = "b0000011".U
  def xor  = "b0000100".U
  def srl  = "b0000101".U
  def or   = "b0000110".U
  def and  = "b0000111".U
  def sub  = "b0001000".U
  def sra  = "b0001101".U
  // 可以依靠 func(3, 0) 进行区分 -- end

  // 所有的 w 指令的 func(5) 都为1，其它的指令为0
  def addw = "b1100000".U 
  def subw = "b0101000".U
  def sllw = "b0100001".U
  def srlw = "b0100101".U
  def sraw = "b0101101".U

  def isWordOp(func: UInt) = func(5) // 这里的数据通路似乎是豪神自己设计的

  // 所有的 branch/jmp 指令的 func(4) 都为1，其它的指令为0
  // 所有的 branchp 指令的 func(4) 为 1， func(3) 为 0
  // 所有的 jmp 指令的 func(4) 为 1， func(3) 为 1
  def jal  = "b1011000".U
  def jalr = "b1011010".U
  def beq  = "b0010000".U
  def bne  = "b0010001".U
  def blt  = "b0010100".U
  def bge  = "b0010101".U
  def bltu = "b0010110".U
  def bgeu = "b0010111".U

  // // for RAS
  // def call = "b1011100".U  TODO: 根据我的理解，call和ret都只是伪指令，不应该出现
  // def ret  = "b1011110".U

  def isAdd(func: UInt) = func(6)
  def pcPlus2(func: UInt) = func(5)
  def isBru(func: UInt) = func(4)
  def isBranch(func: UInt) = !func(3) // TODO: 我觉得这里应该是 isBru(func) && !func(3)
  def isJump(func: UInt) = isBru(func) && !isBranch(func)
  def getBranchType(func: UInt) = func(2, 1)
  def isBranchInvert(func: UInt) = func(0)
}

class ALUIO extends FunctionUnitIO {
  // val cfIn = Flipped(new CtrlFlowIO)
  // val redirect = new RedirectIO
  // val offset = Input(UInt(XLEN.W))
}

class ALU extends CyhCoreModule {

  val io = IO(new ALUIO)

  val (src1, src2, func) = (io.in.src1, io.in.src2, io.in.func)
  def access(src1: UInt, src2: UInt, func: UInt): UInt = {
    this.src1 := src1
    this.src2 := src2
    this.func := func
    io.out
  }

  // isAdderSub 表示加法器是否使用减法模式，只要当前指令不需要使用加法, 则使用减法（TODO: 感觉有点不对劲，如果 branch 指令需要使用加法结果怎么办？）
  val isAdderSub = !ALUOpType.isAdd(func)
  // +&: 带了位宽扩展的加法 TODO: 必须要记得做XLEN的截断
  // 如果是加法，则 adderRes = src1 +& (src2 ^ 0) + 0 = src1 + src2
  // 如果是减法，则 adderRes = src1 +& (src2 ^ '1) + 1 = src1 - src2
  val adderRes = (src1 +& (src2 ^ Fill(XLEN, isAdderSub))) + isAdderSub  // 这个结果有两个地方（两处代码）要用，为了避免综合出两个加法器，单独在这里写出来
  val xorRes = src1 ^ src2  // 同上
  // sltu: 如果 src1 < src2, 则 sltu 的结果应为 1，否则为0
  // 由于指令是 sltu，因此 src1 和 src2 都被当成正数，且位宽为 XLEN
  // 若本来 src1 和 src2 都是正数，比如 1 - 2 = 1 + 0xfffe = 0xffff，此时XLEN-bit = 0，sltu = 1 正确; 2 - 1 = 2 + 0xffff = 0x10001, XLEN-bit 为 1，sltu = 0，正确。
  // 若本来 src1 和 src2 都是负数, 在 sltu 指令中，被当成正数的负数之间的大小关系，和被当成负数的负数之间的大小关系是一样的
  // 比如 -1 - (-2) = 0xffff + 2 = 0x10001, 此时 XLEN-bit = 1, sltu = 0, 表示 -1 >= -2, 正确；-2 - (-1) = 0xfffe + 1 = 0xffff，此时XLEN-bit = 0, sltu = 1，表示 -2 < -1，正确
  // 若本来 src1 和 src2 一正一负, 那么此时在 sltu 指令中，明显负数更大
  // 比如 1 - (-1)  = 1 + 1 = 2 此时，XLEN-bit = 0, sltu = 1，表示 1 < -1，正确；比如 -1 - 1 = 0xffff + 0xffff = 0x1fffe, 此时 XLEN-bit = 1, sltu = 0,表示 -1 >= 1，正确
  val sltu = !adderRes(XLEN)  // 三处要用  // TODO：以后我们能看综合电路了，可以看看这种写法和直接写 “<” 有什么区别
  // 此时是有符号数的 src1 和 src2

  // 当 (src1 ^ src2)(XLEN-1, 0) = 1 时，说明 src1 和 src2 符号不同
  // 此时负数一定小于正数
  // 若 sltu = 0, 说明无符号比较中，src1 >= src2，那么src1 就是负数，则 src1 < src2 此时 slt = 1
  // 若 sltu = 1, 说明无符号比较中，src1 < src2，那么src2 就是负数，则 src1 > src2 此时 slt = 0

  // 当 (src1 ^ src2)(XLEN-1, 0) = 0 时，说明 src1 和 src2 符号相同
  // 此时可以直接套用 sltu 无符号比较的结果
  // 若此时 src1和src2都是正数，当 sltu = 0时, 说明无符号比较中，src1 >= src2, slt 应为 0, 若 sltu = 1,说明无符号比较中 src1 < src2, slt 应为 1
  // 若此时 src1和src2都是负数, 当 sltu = 0时，说明无符号比较中，src1 >= src2, 说明在有符号对比中 src1 >= src2(注意：负数的无符号对比中，更大的负数，它的无符号对比也就越大), slt 应为0
  // 若此时 src1和src2都是负数, 当 sltu = 1时，说明无符号比较中，src1 < src2, 说明在有符号对比中 src1 < src2(注意：负数的无符号对比中，更大的负数，它的无符号对比也就越大), slt 应为1
  val slt = xorRes(XLEN-1) ^ sltu  // 两处要用

  val shsrc1 = MuxLookup(func, src1(XLEN-1,0), List(
    // ALUOpType.sllw -> SignExt(src1(31,0), XLEN) // sllw 和 sll 的操作没有区别，所以不需要在这里开头做处理，只需要在结果做阶段
    ALUOpType.srlw -> ZeroExt(src1(31,0), XLEN),   // 逻辑右移，做0位扩展
    ALUOpType.sraw -> SignExt(src1(31,0), XLEN)    // 必须做有符号扩展，否则无法共享64位指令的算术右移
  ))
  val shamt = Mux(ALUOpType.isWordOp(func), src2(4, 0), src2(5, 0))
  // ALU最好只有一个加法器
  // def add  = "b1000000".U
  // def sub  = "b0001000".U
  // 在这里可以看到 ，res的值仅仅由 func(3,0) 决定，哪怕 BRANCH 指令中的 func(3,0) 和计算指令的 func(3,0) 有重叠
  // TODO: 原因是 BRANCH 指令的结果放到 redirectIO，只需要 IDU 告诉 WBU 译码结果，WBU就能知道选择哪个信号，要写回哪里
  val res = MuxLookup(func(3, 0), adderRes, List(
  // def sll  = "b0000001".U
    ALUOpType.sll  -> ((shsrc1  << shamt)(XLEN-1, 0)), // 左移
  // def slt  = "b0000010".U
    ALUOpType.slt  -> ZeroExt(slt, XLEN),      // 置位
  // def sltu = "b0000011".U
    ALUOpType.sltu -> ZeroExt(sltu, XLEN),       // 置位
  // def xor  = "b0000100".U
    ALUOpType.xor  -> xorRes,                  // 异或
  // def srl  = "b0000101".U
    ALUOpType.srl  -> (shsrc1  >> shamt),     // 右移
  // def or   = "b0000110".U
    ALUOpType.or   -> (src1  |  src2),        // 或
  // def and  = "b0000111".U
    ALUOpType.and  -> (src1  &  src2),   // 且
  // def sra  = "b0001101".U
    ALUOpType.sra  -> ((shsrc1.asSInt >> shamt).asUInt)  // 算数右移
  ))
  // 根据是否是 w 指令，来决定是否对结果做有符号扩展
  // TODO: 为什么 addw, subw 不需要对 src1 和 src2 进行截断？
  // 回答：也许在 64 位加法中，直接截取其32位的结果，这个结果和32位加法是一样的。
  val aluRes = Mux(ALUOpType.isWordOp(func), SignExt(res(31,0), 64), res) // 如果是 w 算数指令，最后的结果都要做有符号扩展

// FunctionUnitIO ------------------------------------------ out(Output(UInt(XLEN.W)))
  io.out := aluRes

}


