import chisel3._
import Conf._

class top extends Module {

  implicit val conf = Configuration()

  val io = IO(new Bundle {
//    val inst = Input(UInt(conf.inst_len.W))
  })

  // submodule1 IFU
  val ifu = Module(new IFU)
	// submodule2: IDU
  val idu = Module(new IDU)
	// submodule3: EXU
  val exu = Module(new EXU)
	// submodule4: DPIC
  val dpic = Module(new DPIC)

  ifu.io <> exu.io.ifu_to_exu

//  idu.io.inst    := io.inst // TODO: wait for being removed
//  exu.io.inst    := io.inst
  idu.io.inst    := dpic.io.inst // TODO: wait for being removed
  exu.io.inst    := dpic.io.inst

  idu.io.idu_to_exu <> exu.io.idu_to_exu

  dpic.io.clk := clock
  dpic.io.rst := reset
  dpic.io.pc  := ifu.io.pc
  dpic.io.isEbreak := idu.io.isEbreak
  dpic.io.inv_inst := idu.io.inv_inst
  dpic.io.regfile  := exu.io.regfile_output
  dpic.io.mem_addr := exu.io.mem_addr
  dpic.io.isRead   := exu.io.isRead
  dpic.io.isWriteMem := idu.io.isWriteMem
  dpic.io.mem_write_data := exu.io.mem_write_data
  dpic.io.mem_write_msk  := idu.io.mem_write_msk

  exu.io.mem_in   := dpic.io.mem_in
}

