// package cyhcore
// 
// import chisel3._
// import chisel3.util._
// 
// class CtrlSignalIO extends CyhCoreBundle {
//   val src1Type = Output(SrcType())
//   val src2Type = Output(SrcType())
//   val fuType = Output(FuType())
//   val fuOpType = Output(FuOpType())
//   val rfSrc1 = Output(UInt(5.W))
//   val rfSrc2 = Output(UInt(5.W))
//   val rfWen = Output(Bool())
//   val rfDest = Output(UInt(5.W))
//   // val isNutCoreTrap = Output(Bool())
//   // val isSrc1Forward = Output(Bool())
//   // val isSrc2Forward = Output(Bool())
//   // val noSpecExec = Output(Bool())  // This inst can not be speculated
//   // val isBlocked = Output(Bool())   // This inst requires pipeline to be blocked
// }
// 
// class DataSrcIO extends CyhCoreBundle {
//   val src1 = Output(UInt(XLEN.W))
//   val src2 = Output(UInt(XLEN.W))
//   val imm  = Output(UInt(XLEN.W))
// }
// 
// // 用来写回 PC，实现跳转指令
// class RedirectIO extends CyhCoreBundle {
//   val target = Output(UInt(PC_LEN.W))
//   // val rtype = Output(UInt(1.W)) // 1: branch mispredict: only need to flush frontend  0: others: flush the whole pipeline
//   // val valid = Output(Bool())
// }
// 
// class FunctionUnitIO extends CyhCoreBundle {
//   val in = Flipped(new Bundle {
//     val src1 = Output(UInt(XLEN.W))
//     val src2 = Output(UInt(XLEN.W))
//     val func = Output(FuOpType())
//   })
//   val out = Output(UInt(XLEN.W))
// }
// 
// // NOTE: 豪神在定义 Bundle 接口的时候似乎会把所有端口都定义成 Output
// // 关于 Input 接口，就接一个 Flipped
// class CtrlFlowIO extends CyhCoreBundle {
//   val instr = Output(UInt(64.W))
//   val pc = Output(UInt(VAddrBits.W))
//   // val pnpc = Output(UInt(VAddrBits.W)) // predicted next pc
//   val redirect = new RedirectIO  // TODO: 我猜测这个应该是用来处理跳转指令的
//   // val exceptionVec = Output(Vec(16, Bool()))
//   // val intrVec = Output(Vec(12, Bool()))
//   // val brIdx = Output(UInt(4.W))
//   // val isRVC = Output(Bool())
//   // val crossPageIPFFix = Output(Bool())
// }
// 
// class DecodeIO extends CyhCoreBundle {
//   val cf = new CtrlFlowIO
//   val ctrl = new CtrlSignalIO
//   val data = new DataSrcIO
// }
// 
// // 用来写回寄存器堆
// class WriteBackIO extends CyhCoreBundle { 
//   val rfWen = Output(Bool())
//   val rfDest = Output(UInt(5.W))
//   val rfData = Output(UInt(XLEN.W))
// }
// 
// // EXU -> WBU 的模块
// class CommitIO extends CyhCoreBundle {
//   val decode = new DecodeIO
//   val commits = Output(Vec(FuType.num, UInt(XLEN.W))) // EXU 四个功能单元的输出都在这里，让 WBU 挑选
// }
// 
// 
// 
