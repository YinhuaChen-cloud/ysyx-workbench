import chisel3._
import Conf._

class top extends Module {

  implicit val conf = Configuration()

  val io = IO(new Bundle {
    val inst = Input(UInt(conf.inst_len.W))
  })

  val xlen = 64
  val inst_len = 32

  // submodule1 IFU
  val ifu = Module(new IFU)
	// submodule2: IDU
  val idu = Module(new IDU)
	// submodule3: EXU
  val exu = Module(new EXU)
	// submodule4: DPIC
  val dpic = Module(new DPIC)

  ifu.io <> exu.io.ifu_to_exu

  idu.io.inst    := io.inst // TODO: wait for being removed
  exu.io.inst    := io.inst

  idu.io.idu_to_exu <> exu.io.idu_to_exu
//  exu.io.pc_sel := idu.io.pc_sel
//  exu.io.op1_sel := idu.io.op1_sel
//  exu.io.op2_sel := idu.io.op2_sel
//  exu.io.alu_op := idu.io.alu_op
//  exu.io.wb_sel := idu.io.wb_sel
//  exu.io.reg_wen := idu.io.reg_wen

  dpic.io.pc := ifu.io.pc
  dpic.io.clk := clock
  dpic.io.rst := reset
  dpic.io.isEbreak := idu.io.isEbreak

}

