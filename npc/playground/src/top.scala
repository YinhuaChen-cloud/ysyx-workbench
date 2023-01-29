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

  ifu.io.pc_next := exu.io.pc_next
  exu.io.pc      := ifu.io.pc

  idu.io.inst    := io.inst // TODO: wait for being removed
  exu.io.inst    := io.inst

  exu.io.pc_sel := idu.io.pc_sel
  exu.io.pc_sel := idu.io.pc_sel
  exu.io.op1_sel := idu.io.op1_sel
  exu.io.op2_sel := idu.io.op2_sel
  exu.io.alu_op := idu.io.alu_op
  exu.io.reg_wen := idu.io.reg_wen

  dpic.io.pc := ifu.io.pc
  dpic.io.clk := clock
  dpic.io.rst := reset
  dpic.io.isEbreak := idu.io.isEbreak

}

