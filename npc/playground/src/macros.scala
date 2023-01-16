object macros {
  val func_len = 8
}

object RV64ExuOp extends ChiselEnum {
  val Addi, Auipc, Jal, Jalr, Sd, Ebreak, InvalidExuOp = Value
}

