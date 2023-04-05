package cyhcore

import chisel3._
import chisel3.util._

import top.Settings
import bus.simplebus._
import utils._
import chisel3.util.experimental.BoringUtils

trait HasResetVector {
  val resetVector = Settings.getLong("ResetVector")
}

class IFU extends CyhCoreModule with HasResetVector {
  val io = IO(new Bundle {
    val imem = new SimpleBusUC
    val out  = Decoupled(new CtrlFlowIO)

    val redirect = Flipped(new RedirectIO) // 用来支持 branch, jmp 等指令的
  })

  // pc
  val pc_reg = RegInit(resetVector.U(PC_LEN.W)) // TODO：果壳里，PC寄存器的长度是39
  val bpu = Module(new BPU)
  bpu.io.instr := io.imem.resp.rdata(INST_LEN-1, 0) // imem.resp.rdata 是从 imem 中读取的真正的指令
  // 当isNOP为 1，表示当前周期要产生气泡指令
  // val isNOP = RegInit(false.B)
  // 如果预译码发现当前指令是 branch/jmp，说明下一周期开始要产生气泡指令，因此置 isNOP reg 为 1
  // 例外：当 io.redirect.valid 为 true 时，说明下一周期 pc_reg 会跳转到正确的指令地址上，因此下一周期不需要再产生气泡指令
  // isNOP := bpu.io.isBranchJmp && !io.redirect.valid

  val CtrlHazard = Wire(Bool())
  CtrlHazard := bpu.io.isBranchJmp && !io.redirect.valid
  // BoringUtils.addSource(CtrlHazard, "CtrlHazard") // 延迟一个周期进行阻塞，以便把跳转指令传给下一级，同时延迟一个周期使IDUregValid==true.B，腾时间让pc_reg跳转
  val CtrlHazard_next_cycle = RegNext(CtrlHazard) // 延迟一个周期发送气泡指令，因此使用这个延时信号
  //TODO: 当控制冒险和数据冒险一同出现时，之前放置流水级寄存器整体为 invalid 的行为会导致等不来 redirect_valid = true.B
  // val sent = RegInit(true.B) // 在遇到控制冒险时，得等到当前指令发射出去后，才能对IFU进行阻塞，这个信号表示指令是否已经发射出去
  // sent := Mux(sent, !CtrlHazard, )  // 平常 sent == true.B，当遇到控制冒险后，在下一周期

  // io.redirect.valid, io.redirect.target 需要在第二拍才能计算出来
  // 思路：实现一个小译码，判断当前读到的指令（发送给下一级的指令）是否是branch指令（jmp属于无条件跳转指令）
  // 如果是branch，则阻塞流水线(pc不变，下一周期发送NOP)，直到io.redirect.valid为true，并且取用io.redirect.target
  // 如果是jmp，也是阻塞流水线(pc不变，下一周期发送NOP)，...... TODO：无条件跳转指令应该能进一步优化
  // 如果不是，就 PC + 4
  // 如果这一周期 bpu.io.isBranchJmp 为真，说明下一周期不需要取指令（发出NOP）, 等待ALU计算redirect结果，再更新
  // 由 ISU-ScoreBoard 检测是否有 RAW 冒险
  val RAWhazard = WireInit(false.B)
  BoringUtils.addSink(RAWhazard, "RAWhazard")

  // 不能用 io.out.ready，因为 io.out.ready可以是控制冒险造成的
  pc_reg := Mux(RAWhazard, pc_reg,  // 发生RAWhazard时，pc_reg停住不动，直到RAWhazard结束
    Mux(!bpu.io.isBranchJmp, pc_reg + 4.U, 
    Mux(!io.redirect.valid, pc_reg, 
    io.redirect.target)))

// imem(SimpleBusUC) ------------------------------------ req(SimpleBusReqBundle)
  // val addr = Output(UInt(PAddrBits.W)) // 访存地址（位宽与体系结构实现相关）, 默认 32 位

  io.imem.req       := DontCare
  io.imem.req.addr  := pc_reg
  io.imem.req.cmd   := SimpleBusCmd.read

// out(CtrlFlowIO) ------------------------------------------ 
  // val instr = Output(UInt(64.W))
  // val pc = Output(UInt(VAddrBits.W))
  // val redirect = new RedirectIO  

  io.out       := DontCare
  // 如果发现 isNOP = true.B，说明这一回合应该发送气泡指令，而非真正的指令，真正的指令需要保留一回合
  // io.out.bits.instr := Mux(isNOP, Instructions.NOP, io.imem.resp.rdata)(INST_LEN-1, 0)
  // 发射NOP的时刻：RAWHazard, CtrlHazard && !io.redirect.valid
  io.out.bits.pc    := pc_reg

  val next_pipeline_valid = WireInit(false.B)
  BoringUtils.addSink(next_pipeline_valid, "IDUregControl")
  val isBranchSent = RegInit(false.B) // 表示在CtrlHazard时，跳转指令是否成功发射(监控下级流水的valid即可)

  // 当读取到了跳转指令，且跳转指令没有成功发射时; inst发射 真正指令, isBranchSent等于下一级流水valid_in
  when(bpu.io.isBranchJmp && !isBranchSent) {
    io.out.bits.instr := (io.imem.resp.rdata)(INST_LEN-1, 0)
    isBranchSent := next_pipeline_valid
  } 
  // 当读取到了跳转指令，且跳转指令发射成功时，但还没等到 redirect_valid时; inst发射NOP
  .elsewhen(bpu.io.isBranchJmp && isBranchSent && !io.redirect.valid) {
    io.out.bits.instr := Instructions.NOP
  }
  // 当redirect_valid = true.B 时，说明下一个时钟上升沿pc_reg会跳转到正确的地方; 此时 inst发射最后一次NOP, isBranchSent 置 false.B
  .elsewhen(bpu.io.isBranchJmp && isBranchSent && io.redirect.valid) {
    io.out.bits.instr := Instructions.NOP
    isBranchSent := false.B
  }
  // 其它时候; inst正常, isBranchSent保持不变(false.B)
  .otherwise {
    io.out.bits.instr := (io.imem.resp.rdata)(INST_LEN-1, 0)
  }


  // when(CtrlHazard & !RAWhazard) { // 当只有控制冒险的时候
  //   io.out.bits.instr := Mux(CtrlHazard_next_cycle, Instructions.NOP, (io.imem.resp.rdata)(INST_LEN-1, 0))
  // } .elsewhen(CtrlHazard & RAWhazard) { // 当控制冒险和RAW同时出现的时候
  //   io.out.bits.instr := Instructions.NOP
  // } .otherwise {
  //   io.out.bits.instr := (io.imem.resp.rdata)(INST_LEN-1, 0)
  // }

// handshake ------------------------------------------------

  // val rst = Wire(Bool())
  // rst := reset
  // rst 时，IFU输出不有效
  // bpu.io.isBranchJmp && !io.redirect.valid 时，IFU只有一个周期是有效的
  // 有效信号就是无效信号取反
  // rst || (bpu.io.isBranchJmp && !io.redirect.valid)
  // 取反就是 !rst && (!bpu.io.isBranchJmp || io.redirect.valid)
  // io.out.valid := !rst && (!bpu.io.isBranchJmp || io.redirect.valid)
  io.out.valid := DontCare

// difftest --------------------------------------------------
  BoringUtils.addSource(pc_reg, "difftestJumpPC")
  // 这玩意儿有效，说明下一回合pc会跳转，所以要延迟一个周期生效
  BoringUtils.addSource(RegNext(io.redirect.valid), "difftestIsRedirect") 

  Debug("In IFU, The inst read is 0x%x", io.imem.resp.rdata)

}
