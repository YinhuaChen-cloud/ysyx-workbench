import chisel3._
import chisel3.util._

object Instructions {
  def NOP = 0x00000013.U
  def DecodeTable = RVIInstr.table ++ NutCoreTrap.table ++
    (if (HasMExtension) RVMInstr.table else Nil) ++
    // Priviledged.table ++
    // RVZicsrInstr.table
}


