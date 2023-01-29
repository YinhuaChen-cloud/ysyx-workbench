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

  ifu.io.pc_wen := idu.io.pc_wen
  ifu.io.pc_wdata := exu.io.dnpc
  exu.io.pc := ifu.io.pc

  exu.io.src1 := idu.io.src1
  exu.io.src2 := idu.io.src2
  exu.io.destI := idu.io.destI
  exu.io.exuop := idu.io.exuop
  idu.io.exec_result := exu.io.exec_result
  // idu.io.inst := exu.io.inst
  idu.io.inst := io.inst

  dpic.io.pc := ifu.io.pc
  dpic.io.clk := clock
  dpic.io.rst := reset
  dpic.io.isEbreak := exu.io.isEbreak

}

