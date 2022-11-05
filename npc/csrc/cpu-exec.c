//#include <common.h>
//
//static void execute(uint64_t n) {
//  Decode s;
//  for (;n > 0; n --) {
//    exec_once(&s, cpu.pc);
//    g_nr_guest_inst ++;
//    trace_and_difftest(&s, cpu.pc);
//    if (nemu_state.state != NEMU_RUNNING) break;
//    IFDEF(CONFIG_DEVICE, device_update());
//  }
//}
//
///* Simulate how the CPU works. */
//void cpu_exec(uint64_t n) {
//  g_print_step = (n < MAX_INST_TO_PRINT);
//  switch (nemu_state.state) {
//    case NEMU_END: case NEMU_ABORT:
//      printf("Program execution has ended. To restart the program, exit NEMU and run again.\n");
////      return;
//    default: nemu_state.state = NEMU_RUNNING;
//  }
//
//  uint64_t timer_start = get_time();
//
//  execute(n);
//
//  uint64_t timer_end = get_time();
//  g_timer += timer_end - timer_start;
//
//  switch (nemu_state.state) {
//    case NEMU_RUNNING: nemu_state.state = NEMU_STOP; break;
//
//    case NEMU_END: case NEMU_ABORT:
//      Log("nemu: %s at pc = " FMT_WORD,
//          (nemu_state.state == NEMU_ABORT ? ANSI_FMT("ABORT", ANSI_FG_RED) :
//           (nemu_state.halt_ret == 0 ? ANSI_FMT("HIT GOOD TRAP", ANSI_FG_GREEN) :
//            ANSI_FMT("HIT BAD TRAP", ANSI_FG_RED))),
//          nemu_state.halt_pc);
//      // fall through
//    case NEMU_QUIT: statistic();
//  }
//}
