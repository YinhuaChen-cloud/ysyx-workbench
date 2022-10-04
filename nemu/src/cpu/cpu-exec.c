/***************************************************************************************
* Copyright (c) 2014-2022 Zihao Yu, Nanjing University
*
* NEMU is licensed under Mulan PSL v2.
* You can use this software according to the terms and conditions of the Mulan PSL v2.
* You may obtain a copy of Mulan PSL v2 at:
*          http://license.coscl.org.cn/MulanPSL2
*
* THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
* EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
* MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
*
* See the Mulan PSL v2 for more details.
***************************************************************************************/

#include <cpu/cpu.h>
#include <cpu/decode.h>
#include <cpu/difftest.h>
#include <locale.h>
#include "watchpoint.h"
#include <memory/paddr.h>

uint64_t expr(char *e, bool *success);
extern void print_mtrace();

/* The assembly code of instructions executed is only output to the screen
 * when the number of instructions executed is less than this value.
 * This is useful when you use the `si' command.
 * You can modify this value as you want.
 */
#define MAX_INST_TO_PRINT 10

CPU_state cpu = {};
uint64_t g_nr_guest_inst = 0;
static uint64_t g_timer = 0; // unit: us
static bool g_print_step = false;

void device_update();

#ifdef CONFIG_IRINGBUF
#define RING_LEN 32
char iringbuf[RING_LEN][128];
int iringbuf_p;
#endif

void print_iringbuf() {
#ifdef CONFIG_IRINGBUF
  iringbuf[iringbuf_p][0] = '-';
  iringbuf[iringbuf_p][1] = '-';
  iringbuf[iringbuf_p][2] = '>';
  printf("Something bad happened, the instructions executed recently is the following:\n");
  for(int i = 0; i < RING_LEN; i++) {
    printf("%s\n", iringbuf[i]);
  }
#endif
  return;
}

void check_all_watchpoints() {
  WP *p = get_wp_head();
  bool success = true;
  while(p) {
    uint64_t val = expr(p->expr, &success);
    assert(success);
    if(val != p->old_val) {
      printf("Trigger watchpoint %s\n", p->expr);
      printf("The old val is %lu(decimal)\t0x%016lx(hex)\n", p->old_val, p->old_val);
      printf("Now the val is %lu(decimal)\t0x%016lx(hex)\n", val, val);
      nemu_state.state = NEMU_STOP;
    }
    p = p->next;
  }
}

static void trace_and_difftest(Decode *_this, vaddr_t dnpc) {
#ifdef CONFIG_ITRACE_COND
  if (ITRACE_COND) log_write("%s\n", _this->logbuf);
#endif
  if (g_print_step) { IFDEF(CONFIG_ITRACE, puts(_this->logbuf)); }
  IFDEF(CONFIG_DIFFTEST, difftest_step(_this->pc, dnpc));
  IFDEF(CONFIG_CC_WATCHPOINT, check_all_watchpoints());
}

static void exec_once(Decode *s, vaddr_t pc) {
#ifdef CONFIG_MTRACE
	extern bool isldst;
	isldst = false;
#endif

#ifdef CONFIG_DTRACE
	extern bool isdevice;
	isdevice = false;
#endif

	s->pc = pc;
  s->snpc = pc;
  isa_exec_once(s);
  cpu.pc = s->dnpc;

#ifdef CONFIG_ITRACE
  char *p = s->logbuf; // the logbuf is in Decode structure
  p += snprintf(p, sizeof(s->logbuf), FMT_WORD ":", s->pc); // record pc
  int ilen = s->snpc - s->pc; // instruction length, it might be 2 bytes
  int i;
  uint8_t *inst = (uint8_t *)&s->isa.inst.val;
  for (i = ilen - 1; i >= 0; i --) {
    p += snprintf(p, 4, " %02x", inst[i]);
  }
  int ilen_max = MUXDEF(CONFIG_ISA_x86, 8, 4);
  int space_len = ilen_max - ilen;
  if (space_len < 0) space_len = 0;
  space_len = space_len * 3 + 1;
  memset(p, ' ', space_len); // fill logbuf with space
  p += space_len;

  void disassemble(char *str, int size, uint64_t pc, uint8_t *code, int nbyte);
  disassemble(p, s->logbuf + sizeof(s->logbuf) - p,
      MUXDEF(CONFIG_ISA_x86, s->snpc, s->pc), (uint8_t *)&s->isa.inst.val, ilen);

#ifdef CONFIG_IRINGBUF
  iringbuf_p = (iringbuf_p + 1) % RING_LEN;
  
  p = iringbuf[iringbuf_p];
  p += snprintf(p, sizeof(iringbuf[iringbuf_p]), "    "); // 4 spaces

  strncpy(p, s->logbuf, iringbuf[iringbuf_p] + sizeof(iringbuf[iringbuf_p]) - p);

#endif

#endif

#ifdef CONFIG_MTRACE
	if(isldst){
		extern char *mtrace_buf_p;
		extern int pmtrace;
		extern char mtrace_buf[MTBUF_NUM][MTBUF_LEN];
		strncpy(mtrace_buf_p, s->logbuf, mtrace_buf[pmtrace] + sizeof(mtrace_buf[pmtrace]) - mtrace_buf_p);
	}
#endif

#ifdef CONFIG_DTRACE
#define DTRACE_OUTPUT_LEN 160
	if(isdevice) {
		extern char device_output_buf[DTRACE_OUTPUT_LEN];
		extern char device_trace_buf[DTBUF_LEN];
		extern FILE *dtrace_fp; 
		strncpy(device_output_buf, s->logbuf, DTRACE_OUTPUT_LEN);
		int tmplen = strlen(device_output_buf);
		strncat(device_output_buf, "\t", DTRACE_OUTPUT_LEN - tmplen);
		strncat(device_output_buf, device_trace_buf, DTRACE_OUTPUT_LEN - tmplen - 1);
		assert(dtrace_fp);
		fwrite(device_output_buf, strlen(device_output_buf), 1, dtrace_fp);
	}
#endif

}

static void execute(uint64_t n) {
  Decode s;
  for (;n > 0; n --) {
    exec_once(&s, cpu.pc);
    g_nr_guest_inst ++;
    trace_and_difftest(&s, cpu.pc);
    if (nemu_state.state != NEMU_RUNNING) break;
    IFDEF(CONFIG_DEVICE, device_update());
  }
}

static void statistic() {
  IFNDEF(CONFIG_TARGET_AM, setlocale(LC_NUMERIC, ""));
#define NUMBERIC_FMT MUXDEF(CONFIG_TARGET_AM, "%ld", "%'ld")
  Log("host time spent = " NUMBERIC_FMT " us", g_timer);
  Log("total guest instructions = " NUMBERIC_FMT, g_nr_guest_inst);
  if (g_timer > 0) Log("simulation frequency = " NUMBERIC_FMT " inst/s", g_nr_guest_inst * 1000000 / g_timer);
  else Log("Finish running in less than 1 us and can not calculate the simulation frequency");
}

void assert_fail_msg() {
  isa_reg_display();
  statistic();
  print_iringbuf();
	print_mtrace();
#ifdef CONFIG_FTRACE
	extern FILE *ftrace_log;
	fclose(ftrace_log);
#endif
#ifdef CONFIG_DTRACE
	extern FILE *dtrace_fp;
	fclose(dtrace_fp);
#endif
}

/* Simulate how the CPU works. */
void cpu_exec(uint64_t n) {
  g_print_step = (n < MAX_INST_TO_PRINT);
  switch (nemu_state.state) {
    case NEMU_END: case NEMU_ABORT:
      printf("Program execution has ended. To restart the program, exit NEMU and run again.\n");
//      return;
    default: nemu_state.state = NEMU_RUNNING;
  }

  uint64_t timer_start = get_time();

  execute(n);

  uint64_t timer_end = get_time();
  g_timer += timer_end - timer_start;

  switch (nemu_state.state) {
    case NEMU_RUNNING: nemu_state.state = NEMU_STOP; break;

    case NEMU_END: case NEMU_ABORT:
      Log("nemu: %s at pc = " FMT_WORD,
          (nemu_state.state == NEMU_ABORT ? ANSI_FMT("ABORT", ANSI_FG_RED) :
           (nemu_state.halt_ret == 0 ? ANSI_FMT("HIT GOOD TRAP", ANSI_FG_GREEN) :
            ANSI_FMT("HIT BAD TRAP", ANSI_FG_RED))),
          nemu_state.halt_pc);
      // fall through
    case NEMU_QUIT: statistic();
  }
}
