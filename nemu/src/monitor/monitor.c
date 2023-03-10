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

#include <isa.h>
#include <memory/paddr.h>

void init_rand();
void init_log(const char *log_file);
void init_mem();
void init_difftest(char *ref_so_file, long img_size, int port);
void init_device();
void init_sdb();
void init_disasm(const char *triple);

static void welcome() {
  Log("Trace: %s", MUXDEF(CONFIG_TRACE, ANSI_FMT("ON", ANSI_FG_GREEN), ANSI_FMT("OFF", ANSI_FG_RED)));
  IFDEF(CONFIG_TRACE, Log("If trace is enabled, a log file will be generated "
        "to record the trace. This may lead to a large log file. "
        "If it is not necessary, you can disable it in menuconfig"));
  Log("Build time: %s, %s", __TIME__, __DATE__);
  printf("Welcome to %s-NEMU!\n", ANSI_FMT(str(__GUEST_ISA__), ANSI_FG_YELLOW ANSI_BG_RED));
  printf("For help, type \"help\"\n");
//  Log("Exercise: Please remove me in the source code and compile NEMU again.");
//  assert(0);
}

#ifndef CONFIG_TARGET_AM
#include <getopt.h>

void sdb_set_batch_mode();

static char *log_file = NULL;
static char *diff_so_file = NULL;
static char *img_file = NULL;
static int difftest_port = 1234;
static char *elf_file = NULL;
char *elf_content = NULL;
static char *mtrace_filename = NULL;
FILE *mtrace_fp = NULL;
uint32_t text_size;
static char *ftrace_file = NULL;
FILE *ftrace_log = NULL;
static char *dtrace_filename = NULL;
FILE *dtrace_fp = NULL;

#include <elf.h>

static void init_mtrace() {
#ifdef CONFIG_MTRACE
  if (mtrace_filename == NULL) {
    Log("No mtrace_filename is given.");
		return;
  }

	printf("debug by cyh, mtrace_filename = %s\n", mtrace_filename);

  mtrace_fp = fopen(mtrace_filename, "w+");
  Assert(mtrace_fp, "Can not open '%s'", mtrace_filename);

//	// read from mtrace-file.elf to get text size
//	char *tmp_elf_name = (char *)malloc(strlen(mtrace_filename));	
//	strcpy(tmp_elf_name, mtrace_filename);
//	char *tmppos = strstr(tmp_elf_name, "-mtrace.txt");
//	strcpy(tmppos, ".elf");
//	FILE *tmp_elf_fp = fopen(tmp_elf_name, "r");
//	printf("tmp_elf_name = %s\n", tmp_elf_name);
//	printf("debug by cyh, text_size = %u\n", text_size);
//	uint8_t *tmp_elf_content = (uint8_t *)malloc(sizeof(Elf64_Ehdr));
//
//
//	free(tmp_elf_name);
//	free(tmp_elf_content);
//	fclose(tmp_elf_fp);
//	tmp_elf_name = NULL;
//	tmp_elf_fp = NULL;
#endif
} 

static long load_img() {
  if (img_file == NULL) {
    Log("No image is given. Use the default build-in image.");
    return 4096; // built-in image size
  }

  FILE *fp = fopen(img_file, "rb");
  Assert(fp, "Can not open '%s'", img_file);

  fseek(fp, 0, SEEK_END);
  long size = ftell(fp);

  Log("The image is %s, size = %ld", img_file, size);

  fseek(fp, 0, SEEK_SET);
  int ret = fread(guest_to_host(RESET_VECTOR), size, 1, fp);
  Assert(ret == 1, "The mem may be not large enough to read the bin file");

  fclose(fp);
  return size;
}

static void init_dtrace(const char *dtrace_filename) {
#ifdef CONFIG_DTRACE
  if (dtrace_filename == NULL) {
    Log("No dtrace_filename is given.");
		return;
  }

	printf("debug by cyh, dtrace_filename = %s\n", dtrace_filename);

  dtrace_fp = fopen(dtrace_filename, "w+");
  Assert(dtrace_fp, "Can not open '%s'", dtrace_filename);

#endif
}

#ifdef CONFIG_FTRACE
static long load_elf() {
  if (elf_file == NULL) {
    Log("No elf file is given.");
    return 0; // built-in image size
  }

  FILE *fp = fopen(elf_file, "rb");
  Assert(fp, "Can not open '%s'", elf_file);

  fseek(fp, 0, SEEK_END);
  long size = ftell(fp);

  Log("The elf_file is %s, size = %ld", elf_file, size);

  fseek(fp, 0, SEEK_SET);
	// TODO: we need to free elf_content after used it  
	elf_content = (char *)malloc(size);
  int ret = fread(elf_content, size, 1, fp);
  assert(ret == 1);

  fclose(fp);
  return size;
}
#endif

//int getopt_long(int argc, char * const argv[],
//                  const char *optstring,
//                  const struct option *longopts, int *longindex);
static int parse_args(int argc, char *argv[]) {
  const struct option table[] = {
    {"batch"    , no_argument      , NULL, 'b'},
    {"log"      , required_argument, NULL, 'l'},
    {"diff"     , required_argument, NULL, 'd'},
    {"port"     , required_argument, NULL, 'p'},
    {"elf"      , required_argument, NULL, 'e'},
    {"mtrace"   , required_argument, NULL, 'm'},
    {"dtrace"   , required_argument, NULL, 'D'},
    {"ftrace"   , required_argument, NULL, 'f'},
    {"help"     , no_argument      , NULL, 'h'},
    {0          , 0                , NULL,  0 },
  };
  int o;
  while ( (o = getopt_long(argc, argv, "-bhl:d:p:e:m:f:D:", table, NULL)) != -1) {
    switch (o) {
      case 'b': sdb_set_batch_mode(); break;
      case 'p': sscanf(optarg, "%d", &difftest_port); break;
      case 'l': log_file = optarg; break;
      case 'e': elf_file = optarg; break;
      case 'D': dtrace_filename = optarg; break;
      case 'm': mtrace_filename = optarg; break;
      case 'f': ftrace_file = optarg; break;
      case 'd': diff_so_file = optarg; break;
      case 1: img_file = optarg; return 0;
      default:
        printf("Usage: %s [OPTION...] IMAGE [args]\n\n", argv[0]);
        printf("\t-b,--batch              run with batch mode\n");
        printf("\t-l,--log=FILE           output log to FILE\n");
        printf("\t-d,--diff=REF_SO        run DiffTest with reference REF_SO\n");
        printf("\t-p,--port=PORT          run DiffTest with port PORT\n");
        printf("\t-e,--elf=ELF_FILE       Enable ftrace with ELF_FILE\n");
        printf("\t-m,--mtrace=MTRACE_FILE  Store mtrace records in MTRACE_FILE\n");
        printf("\t-f,--ftrace=FTRACE_FILE  Store ftrace records in FTRACE_FILE\n");
        printf("\t-D,--dtrace=DTRACE_FILE  Store dtrace records in DTRACE_FILE\n");
        printf("\n");
        exit(0);
    }
  }
  return 0;
}

void init_monitor(int argc, char *argv[]) {
  /* Perform some global initialization. */

  /* Parse arguments. */
  parse_args(argc, argv);

  /* Set random seed. */
  init_rand();

  /* Open the log file. */
  init_log(log_file);

  /* Initialize memory. */
  init_mem();

  /* Initialize devices. */
  IFDEF(CONFIG_DEVICE, init_device());

  /* Perform ISA dependent initialization. */
  init_isa();

  /* Load the image to memory. This will overwrite the built-in image. */
  long img_size = load_img();

	// open mtrace_file if exists
	init_mtrace();

	// open dtrace_file if exists
	init_dtrace(dtrace_filename);


#ifdef CONFIG_FTRACE
	long elf_size = load_elf();
	printf("elf size = %ld\n", elf_size);

	if(ftrace_file) {
		ftrace_log = fopen(ftrace_file, "w+");
		Assert(ftrace_log, "Can not open '%s'", ftrace_file);
	}
	else {
		printf("No FTRACE_FILE is given\n");
	}
#endif
  /* Initialize differential testing. */
	printf("diff_so_file = %s\n", diff_so_file);
  init_difftest(diff_so_file, img_size, difftest_port);

  /* Initialize the simple debugger. */
  init_sdb();

  IFDEF(CONFIG_ITRACE, init_disasm(
    MUXDEF(CONFIG_ISA_x86,     "i686",
    MUXDEF(CONFIG_ISA_mips32,  "mipsel",
    MUXDEF(CONFIG_ISA_riscv32, "riscv32",
    MUXDEF(CONFIG_ISA_riscv64, "riscv64", "bad")))) "-pc-linux-gnu"
  ));

  /* Display welcome message. */
  welcome();
}
#else // CONFIG_TARGET_AM
static long load_img() {
  extern char bin_start, bin_end;
  size_t size = &bin_end - &bin_start;
  Log("img size = %ld", size);
  memcpy(guest_to_host(RESET_VECTOR), &bin_start, size);
  return size;
}

void am_init_monitor() {
  init_rand();
  init_mem();
  init_isa();
  load_img();
  IFDEF(CONFIG_DEVICE, init_device());
  welcome();
}
#endif
