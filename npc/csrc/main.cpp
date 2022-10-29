#include "Vysyx_22050039_top.h"
#include "verilated.h"
#include "svdpi.h"
#include "Vysyx_22050039_top__Dpi.h"
#include <getopt.h>
#include "diff.h"
#include "common.h"
#include "paddr.h"
#include "errormessage.h"
#include "reg.h"

VerilatedContext* contextp;
Vysyx_22050039_top* top;

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

static int parse_args(int argc, char *argv[]) {
  const struct option table[] = {
    {"log"      , required_argument, NULL, 'l'},
    {"diff"     , required_argument, NULL, 'd'},
    {"help"     , no_argument      , NULL, 'h'},
    {0          , 0                , NULL,  0 },
  };
  int o;
  while ( (o = getopt_long(argc, argv, "-hl:d:", table, NULL)) != -1) {
    switch (o) {
//      case 'p': sscanf(optarg, "%d", &difftest_port); break;
      case 'l': log_file = optarg; break;
      case 'd': diff_so_file = optarg; break;
      case 1: img_file = optarg; return 0;
      default:
        printf("Usage: %s [OPTION...] IMAGE [args]\n\n", argv[0]);
        printf("\t-l,--log=FILE           output log to FILE\n");
        printf("\t-d,--diff=REF_SO        run DiffTest with reference REF_SO\n");
//        printf("\t-p,--port=PORT          run DiffTest with port PORT\n");
        printf("\n");
        exit(0);
    }
  }
  return 0;
}

void ebreak() {
	printf("In main.cpp ebreak\n");  
	npc_state.halt_pc = top->pc;
//  printf("omg, top->pc = 0x%x\n", top->pc);
	printTrap();
	exit(is_exit_status_bad());
}

void invalid() { 
	printf("In main.cpp invalid\n");
	invalid_inst(top->pc); 
	printTrap();
	exit(is_exit_status_bad());
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
    printf("No image is given. Use the default build-in image.");
		memcpy(pmem, default_img, sizeof(default_img));
    return sizeof(default_img); // built-in image size
  }

  FILE *fp = fopen(img_file, "rb");
	assert(fp);

  fseek(fp, 0, SEEK_END);
  long size = ftell(fp);

  printf("The image is %s, size = %ld\n", img_file, size);

  fseek(fp, 0, SEEK_SET);
  int ret = fread(pmem, size, 1, fp);
  assert(ret == 1);

  fclose(fp);
  return size;
}


static void single_cycle() {
  top->clk = 0; top->eval();
  top->clk = 1; top->eval();
}

static void reset(int n) {
  top->rst = 1;
  while (n -- > 0) single_cycle();
  top->rst = 0;
}

int main(int argc, char** argv, char** env) {

	contextp = new VerilatedContext;
	contextp->commandArgs(argc, argv);
	top = new Vysyx_22050039_top{contextp};

	parse_args(argc, argv);
	init_pmem();
	long img_size = load_img();
	reset(10);

// difftest start
	cpu.pc = top->pc;
	cpu_gpr_to_cpu();
	init_difftest(diff_so_file, img_size, difftest_port);
// difftest end

	int sim_time = 70;

	npc_state.state = NPC_RUNNING;

	while (contextp->time() < sim_time && !contextp->gotFinish()) {
		contextp->timeInc(1);
//		printf("before pmem_read\n");
//		printf("top = 0x%p\n", top);
//		printf("pc = %lu\n", top->pc);	
		top->inst = pmem_read(top->pc);
//		printf("after pmem_read\n");
		printf("In main.cpp main() top->pc = 0x%lx, top->inst = 0x%x\n", top->pc, top->inst);
		single_cycle();

		cpu.pc = top->pc;
		cpu_gpr_to_cpu();

		difftest_step();
    if (npc_state.state != NPC_RUNNING) break;
	}

	npc_state.halt_pc = top->pc;
	npc_state.halt_ret = -1; 
	printTrap();

	delete top;
	delete contextp;
	free(pmem);

	// TODO: maybe need to be changed
	return is_exit_status_bad();
}

