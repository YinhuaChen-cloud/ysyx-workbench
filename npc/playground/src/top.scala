//在Chisel中, when和switch的语义和Verilog的行为建模非常相似, 因此也不建议初学者使用. 相反, 你可以使用MuxOH等库函数来实现选择器的功能, 具体可以查阅Chisel的相关资料.

import chisel3._

class top (xlen: Int = 64,
  inst_len: Int = 32) extends Module {
  val io = IO(new Bundle {
    val pc = Output(UInt(xlen.W))
  })

  io.pc := ifu.io.pc

  // submodule1 IFU
//	wire pc_wen; // IDU -> IFU
//	wire [XLEN-1:0] dnpc; // EXU -> IFU
//	wire [XLEN-1:0] pc; // IFU -> EXU
  val ifu = Module(new IFU(xlen))
  ifu.io.pc_wen := 0.U
  ifu.io.pc_wdata := 1.U
   

//  ifu.io.pc_wen := idu.io.pc_wen
//  ifu.io.pc_wdata := exu.io.dnpc
//  exu.io.pc := ifu.io.pc

	// submodule2: IDU
//	wire [XLEN-1:0] src1; // IDU -> EXU
//	wire [XLEN-1:0] src2; // IDU -> EXU
//	wire [XLEN-1:0] destI; // IDU -> EXU
//	wire [`ysyx_22050039_FUNC_LEN-1:0] func; // IDU -> EXU
//	wire [XLEN-1:0] exec_result; // EXU -> IDU
//	wire [INST_LEN-1:0] exec_result; // EXU -> IDU
//	wire [INST_LEN-1:0] inst; // EXU -> IDU
//  val idu = Module(new IDU(xlen, inst_len))
//  exu.io.src1 := idu.io.src1
//  exu.io.src2 := idu.io.src2
//  exu.io.destI := idu.io.destI
//  exu.io.func := idu.io.func
//  idu.io.exec_result := exu.io.exec_result
//  idu.io.inst := exu.io.result
//
//	// submodule3: EXU
//  val exu = Module(new EXU(xlen, inst_len))

}

