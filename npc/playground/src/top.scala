//在Chisel中, when和switch的语义和Verilog的行为建模非常相似, 因此也不建议初学者使用. 相反, 你可以使用MuxOH等库函数来实现选择器的功能, 具体可以查阅Chisel的相关资料.

import chisel3._

class top (xlen: Int = 64,
  inst_len: Int = 32) extends Module {
  val io = IO(new Bundle {
    val inst = Input(UInt(inst_len.W))
  })

  // submodule1 IFU
  val ifu = Module(new IFU(xlen))
	// submodule2: IDU
  val idu = Module(new IDU(xlen, inst_len))
	// submodule3: EXU
  val exu = Module(new EXU(xlen, inst_len))
	// submodule4: DPIC
  val dpic = Module(new DPIC(xlen))
  // wire relationships between modules:
  //	wire pc_wen; // IDU -> IFU
  //	wire [XLEN-1:0] dnpc; // EXU -> IFU
  //	wire [XLEN-1:0] pc; // IFU -> EXU
  //
  //	wire [XLEN-1:0] src1; // IDU -> EXU
  //	wire [XLEN-1:0] src2; // IDU -> EXU
  //	wire [XLEN-1:0] destI; // IDU -> EXU
  //	wire [`ysyx_22050039_FUNC_LEN-1:0] func; // IDU -> EXU
  //	wire [XLEN-1:0] exec_result; // EXU -> IDU
  //	wire [INST_LEN-1:0] inst; // EXU -> IDU
  //
  // wire [XLEN-1:0] pc // IFU -> DPIC

  ifu.io <> idu.io
  idu <> ifu
  idu <> exu
  exu <> idu
  ifu <> exu
  exu <> ifu
  // ifu.io.pc_wen := idu.io.pc_wen
  // ifu.io.pc_wdata := exu.io.dnpc
  // exu.io.pc := ifu.io.pc

  // exu.io.src1 := idu.io.src1
  // exu.io.src2 := idu.io.src2
  // exu.io.destI := idu.io.destI
  // exu.io.exuop := idu.io.exuop
  // idu.io.exec_result := exu.io.exec_result
  // // idu.io.inst := exu.io.inst
  // idu.io.inst := io.inst

  dpic.io.pc := ifu.io.pc
  dpic.io.clk := clock
  dpic.io.rst := reset

  printf("out is 0x%x\n", io.inst)

}

