import chisel3._
import chisel3.util._
import Conf._

class MDU_bundle (implicit val conf: Configuration) extends Bundle() {
  val inst = Input(UInt(conf.inst_len.W))
  val idu_to_exu = Flipped(new IDU_to_EXU())
  val ifu_to_exu = Flipped(new IFU_to_EXU())
  val mem_in = Input(UInt(conf.xlen.W))
  val regfile_output = Output(UInt((conf.nr_reg * conf.xlen).W))
  val mem_addr = Output(UInt(conf.xlen.W))
  val mem_write_data = Output(UInt(conf.xlen.W))
  val isRead = Output(Bool())
  val mem_write_msk = Output(UInt(8.W))
}

class MDU (implicit val conf: Configuration) extends Module {
  val io = IO(new MDU_bundle())

}







