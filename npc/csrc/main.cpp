#include "Vtop.h"
#include "verilated.h"
#include "svdpi.h"
#include "Vtop__Dpi.h"
#include <getopt.h>
#include "diff.h"
#include "common.h"
#include "paddr.h"
#include "errormessage.h"
#include "reg.h"
#include <sdb.h>
#include <cpu-exec.h>

#define _BSD_SOURCE
#include <sys/time.h>

#ifdef CONFIG_WAVEFORM
#include "verilated_vcd_c.h"
VerilatedVcdC* tfp = NULL;
#endif

void dealWithExit();

struct timeval boot_time = {};

static const uint32_t default_img [] = {
  0x00000297,  // auipc t0,0
  0x0002b823,  // sd  zero,16(t0)
  0x0102b503,  // ld  a0,16(t0)
  0x00100073,  // ebreak (used as npc_trap)
  0xdeadbeef,  // some data
};

static char *log_file = NULL;
static char *diff_so_file = NULL;
static char *img_file = NULL;
static int difftest_port = 1234;
bool is_sdb_mode = false;
char *itrace_file;
extern char *mtrace_file;

static int parse_args(int argc, char *argv[]) {
  const struct option table[] = {
    {"sdb"			, no_argument      , NULL, 's'},
    {"log"      , required_argument, NULL, 'l'},
    {"itrace"   , required_argument, NULL, 'i'},
    {"mtrace"   , required_argument, NULL, 'm'},
    {"diff"     , required_argument, NULL, 'd'},
    {"help"     , no_argument      , NULL, 'h'},
    {0          , 0                , NULL,  0 },
  };
  int o;
  while ( (o = getopt_long(argc, argv, "-shl:i:m:d:", table, NULL)) != -1) {
    switch (o) {
      case 's': is_sdb_mode = true; break;
//      case 'p': sscanf(optarg, "%d", &difftest_port); break;
      case 'l': log_file = optarg; break;
      case 'i': itrace_file = optarg; break;
      case 'm': mtrace_file = optarg; break;
      case 'd': diff_so_file = optarg; break;
      case 1: img_file = optarg; break;
      default:
        printf("Usage: %s [OPTION...] IMAGE [args]\n\n", argv[0]);
        printf("\t-s,--sdb								run with sdb mode\n");
        printf("\t-l,--log=FILE           output log to FILE\n");
        printf("\t-i,--itrace=FILE        output itrace to FILE\n");
        printf("\t-m,--mtrace=FILE				output mtrace log to FILE\n");
        printf("\t-d,--diff=REF_SO        run DiffTest with reference REF_SO\n");
//        printf("\t-p,--port=PORT          run DiffTest with port PORT\n");
        printf("\n");
        exit(0);
    }
  }
#ifdef CONFIG_SDB
	is_sdb_mode = true;
#else
	is_sdb_mode = false;
#endif
  return 0;
}

void ebreak() {
	npc_state.halt_pc = *pc;
	dealWithExit();
}

void invalid() { 
	invalid_inst(*pc); 
	dealWithExit();
}

typedef struct {
	uint32_t opcode1_0 : 2;
	uint32_t opcode6_2 : 5;
	uint32_t rd        : 5;
	uint32_t funct3    : 3;
	uint32_t rs1       : 5;
	int32_t  simm11_0  :12;
} inst_I_type;

static long load_img() {
  if (img_file == NULL) {
    printf("No image is given. Use the default build-in image.\n");
		memcpy(pmem, default_img, sizeof(default_img));
    return sizeof(default_img); // built-in image size
  }

  FILE *fp = fopen(img_file, "rb");
	assert(fp);

  fseek(fp, 0, SEEK_END);
  long size = ftell(fp);

  printf("The image is %s, size = %ld, MSIZE = %d\n", img_file, size, CONFIG_MSIZE);
	assert(size <= CONFIG_MSIZE);

  fseek(fp, 0, SEEK_SET);
  int ret = fread(pmem, size, 1, fp);
  assert(ret == 1);

  fclose(fp);
  return size;
}

static void reset(int n) {
  top->reset = 1;
  while (n -- > 0) single_cycle();
  top->reset = 0;
//	printf("In reset, pc = 0x%p\n", pc);
//	printf("In reset, *pc = 0x%lx\n", *pc);
//	printf("In reset, *(uint32_t *)(*pc) = 0x%lx\n", *(uint32_t *)(*pc));
}

int main(int argc, char** argv, char** env) {

#ifdef CONFIG_WAVEFORM
	Verilated::mkdir("logs");
#endif

	contextp = new VerilatedContext;

#ifdef CONFIG_WAVEFORM
	Verilated::traceEverOn(true);
	tfp = new VerilatedVcdC;
#endif

	contextp->commandArgs(argc, argv);
	top = new Vtop{contextp};

#ifdef CONFIG_WAVEFORM
	top->trace(tfp, 99); // Trace 99 levels of hierarchy (or see below)
	// tfp->dumpvars(1, "t"); // trace 1 level under "t"
	tfp->open("./logs/simx.vcd");	
#endif

	parse_args(argc, argv);
	init_pmem();
	long img_size = load_img();

	printf("============ before reset(10) =============\n");

  gettimeofday(&boot_time, NULL);

	reset(10);

	// ------------- tell the user the status of debugging tools ----- start
	printf("------------ sdb is ");
#ifdef CONFIG_SDB
	printf("on");
#else
	printf("off");
#endif
  printf(" -------------\n");

	printf("------------ watchpoints is ");
#ifdef CONFIG_WATCHPOINTS
	printf("on");
#else
	printf("off");
#endif
  printf(" -------------\n");

//	printf("------------ instruction trace is ");
//#ifdef CONFIG_ITRACE
//	printf("on");
//#else
//	printf("off");
//#endif
//  printf(" -------------\n");

	printf("------------ mtrace is ");
#ifdef CONFIG_MTRACE
	printf("on");
#else
	printf("off");
#endif
  printf(" -------------\n");
	 
	printf("------------ difftest is ");
#ifdef CONFIG_DIFFTEST
	printf("on");
#else
	printf("off");
#endif
  printf(" -------------\n");

	// ------------- tell the user the status of debugging tools ----- end

	printf("============ after reset(10) =============\n");

	printf("diff_so_file = %s\n", diff_so_file);

#ifdef CONFIG_DIFFTEST
 	sv_regs_to_c();
 	init_difftest(diff_so_file, img_size, difftest_port);
#endif

	npc_state.state = NPC_RUNNING;

	init_mtrace();

	if(is_sdb_mode) {
		init_sdb();
		sdb_mainloop();
	}
	else {
		while (1) {

			cpu_exec(-1);

			if (npc_state.state != NPC_RUNNING) break;
		}
	}


	npc_state.halt_pc = pc_just_exec;
	npc_state.halt_ret = -1; 

	dealWithExit();

}

void dealWithExit() {
#ifdef CONFIG_WAVEFORM
	tfp->close();
#endif

	printTrap();

	delete top;
	delete contextp;
	free(pmem);

	close_mtrace();
	exit(is_exit_status_bad());
}

