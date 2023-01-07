//在Chisel中, when和switch的语义和Verilog的行为建模非常相似, 因此也不建议初学者使用. 相反, 你可以使用MuxOH等库函数来实现选择器的功能, 具体可以查阅Chisel的相关资料.
//
//存储器中可以放置若干条addi指令的二进制编码(可以利用0号寄存器的特性来编写行为确定的指令)
//由于目前未实现跳转指令, 因此NPC只能顺序执行, 你可以在NPC执行若干指令之后停止仿真
//可以通过查看波形, 或者在RTL代码中打印通用寄存器的状态, 来检查addi指令是否被正确执行
//关于通用寄存器, 你需要思考如何实现0号寄存器的特性; 此外, 为了避免选择Verilog的同学编写出不太合理的行为建模代码, 我们给出如下不完整的代码供大家补充(大家无需改动always代码块中的内容):

import chisel3._

class top (xlen: Int = 64,
  inst_len: Int = 32) extends Module {
  val io = IO(new Bundle {
    val pc = Output(UInt(xlen.W))
  })

  val ifu = Module(new IFU(xlen))
  ifu.io.pc_wen := 0.U
  ifu.io.pc_wdata := 1.U
  io.pc := ifu.io.pc

}

