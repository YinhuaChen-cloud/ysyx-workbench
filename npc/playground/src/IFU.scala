import chisel3._
import chisel3.util._
import Conf._

class IFU_to_EXU (implicit val conf: Configuration) extends Bundle() {
  val pc_next = Input(UInt(conf.pc_len.W))
  val pc      = Output(UInt(conf.pc_len.W))
}

class IFU (implicit val conf: Configuration) extends Module {
  val io = IO(new IFU_to_EXU())

  val pc_reg = RegInit(conf.START_ADDR)
  pc_reg := io.pc_next
  io.pc  := pc_reg

  println(s"pc_reg = ${pc_reg}")
  println(s"io.pc_next = ${io.pc_next}")
//  printf("pc_reg = 0x%x\n", pc_reg)
//  printf("pc_next = 0x%x\n", pc_next)

}
