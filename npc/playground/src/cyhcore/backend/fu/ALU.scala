// package cyhcore
// 
// import chisel3._
// import chisel3.util._
// 
// object ALUOpType {
//   def add  = "b1000000".U
//   def sll  = "b0000001".U
//   def slt  = "b0000010".U
//   def sltu = "b0000011".U
//   def xor  = "b0000100".U
//   def srl  = "b0000101".U
//   def or   = "b0000110".U
//   def and  = "b0000111".U
//   def sub  = "b0001000".U
//   def sra  = "b0001101".U
// 
//   def addw = "b1100000".U
//   def subw = "b0101000".U
//   def sllw = "b0100001".U
//   def srlw = "b0100101".U
//   def sraw = "b0101101".U
// 
//   def isWordOp(func: UInt) = func(5) // 这里的数据通路似乎是豪神自己设计的
// 
//   def jal  = "b1011000".U
//   def jalr = "b1011010".U
//   def beq  = "b0010000".U
//   def bne  = "b0010001".U
//   def blt  = "b0010100".U
//   def bge  = "b0010101".U
//   def bltu = "b0010110".U
//   def bgeu = "b0010111".U
// 
//   // for RAS
//   def call = "b1011100".U
//   def ret  = "b1011110".U
// 
//   def isAdd(func: UInt) = func(6)
//   def pcPlus2(func: UInt) = func(5)
//   def isBru(func: UInt) = func(4)
//   def isBranch(func: UInt) = !func(3)
//   def isJump(func: UInt) = isBru(func) && !isBranch(func)
//   def getBranchType(func: UInt) = func(2, 1)
//   def isBranchInvert(func: UInt) = func(0)
// }
// 
// 
// 
// 
