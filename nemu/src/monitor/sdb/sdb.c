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
#include <cpu/cpu.h>
#include <readline/readline.h>
#include <readline/history.h>
#include "sdb.h"
#include <memory/vaddr.h> // added by chenyinhua
#include "watchpoint.h"
#include <memory/paddr.h>

static int is_batch_mode = false;

void init_regex();
void init_wp_pool();

/* We use the `readline' library to provide more flexibility to read from stdin. */
static char* rl_gets() {
  static char *line_read = NULL;

  if (line_read) {
    free(line_read);
    line_read = NULL;
  }

  line_read = readline("(nemu) ");

  if (line_read && *line_read) {
    add_history(line_read);
  }

  return line_read;
}

static int cmd_c(char *args) {
  cpu_exec(-1);
  return 0;
}


static int cmd_q(char *args) {
  nemu_state.state = NEMU_QUIT;
  return -1;
}

static int cmd_help(char *args);

// assume args be only 1 int, we did not check args
static int cmd_si(char *args) {
  if(!args)
    cpu_exec(1);
  else
    cpu_exec(atoi(args));
  return 0;
}

// assume args is either r or w, we did not check args
static int cmd_info(char *args) {
  if(!args) {
    printf("Please give your arguments\n");
    return 0;
  }

  if(!strcmp(args, "r"))
    isa_reg_display();
  else {
    print_watchpoints();
  }
  return 0;
}

// the argument is EXPR
static int cmd_p(char *args) {
  bool success = true;
  uint64_t result = expr(args, &success);
  if(success) {
    printf("= %lu\n", result);
  }
  else {
    printf("The EXPR cannot be recognized correctly, you can check detailed information in ./build/nemu-log.txt\n");
  }
  return 0;
}

// the argument is EXPR
static int cmd_p_x (char *args) {
  bool success = true;
  uint64_t result = expr(args, &success);
  if(success) {
    printf("= 0x%016lx\n", result);
  }
  else {
    printf("The EXPR cannot be recognized correctly, you can check detailed information in ./build/nemu-log.txt\n");
  }
  return 0;
}

// the argument is a pointer 
static int cmd_p_s (char *args) {
  uint64_t addr = strtol(args, NULL, 16);
  char ch;

  if (likely(!in_pmem(addr))) {
    printf("the address is not in pmem\n");
    return 0;
  }

  while((ch = vaddr_read(addr, 1))) {
    printf("%c", ch);
    addr += 1;
  }
  printf("\n");
  return 0;
}

// the argument is EXPR
static int cmd_w(char *args) {
  bool success = true;
  WP *wp = new_wp();
  strncpy(wp->expr, args, EXPR_LEN-1);
  wp->expr[strlen(wp->expr)] = '\0';
  assert(strlen(wp->expr) < EXPR_LEN);
  wp->old_val = expr(wp->expr, &success);
  if(success) {
    nr_wp++;
  }
  else {
    printf("The EXPR cannot be recognized correctly, you can check detailed information in ./build/nemu-log.txt\n");
    free_wp(wp);
  }
  return 0;
}

// assume args is in correct format, we did not check args
static int cmd_x(char *args) {
  char *nstr = strtok(args, " ");
  char *addrstr = nstr + strlen(nstr) + 1;
  uint32_t n = atoi(nstr);
  uint32_t val;
  uint32_t cnt = 0;
  bool success = true;
  uint64_t addr = expr(addrstr, &success);

  if(!success) {
    printf("The EXPR cannot be recognized correctly, you can check detailed information in ./build/nemu-log.txt\n");
		return 0;
  }

  for(; n > 0; n--) {
    if(cnt % 4 == 0) {
      printf("\n0x%lx: ", addr);
    }
    val = vaddr_read(addr, 4);
    printf("0x%08x ", val);
    addr += 4;
    cnt++;
  }
  printf("\n");
  return 0;
}

// assume args is only a non-negative number
static int cmd_b(char *args) {
  int ret;
  int args_len = strlen(args);
  char *expr = (char *)malloc(args_len + 30);
  strcpy(expr, "$pc == ");
  strcat(expr, args);
  ret = cmd_w(expr);
  free(expr);
  expr = NULL;
  return ret;
}

// assume args is only a non-negative number
static int cmd_d(char *args) {
  int NO = atoi(args);
  free_NO_wp(NO);
  return 0;
}

static struct {
  const char *name;
  const char *description;
  int (*handler) (char *);
} cmd_table [] = {
  { "help", "Display informations about all supported commands", cmd_help },
  { "c", "Continue the execution of the program", cmd_c },
  { "q", "Exit NEMU", cmd_q },
  { "si", "Execute [N] instructions and then stop. N = 1 if omitted", cmd_si },
  { "info", "info r to print registers, info w to print watchpoints", cmd_info },
  { "x", "x [n] [addr] prints n 32-bit val begining at addr in hex format", cmd_x },
  { "p", "p EXPR to get the result of an expression in decimal format", cmd_p },
  { "p/x", "p/x EXPR to get the result of an expression in hex format", cmd_p_x },
  { "p/s", "p/s EXPR to get the result of an expression in string format", cmd_p_s },
  { "w", "w EXPR stop program when EXPR is changed", cmd_w },
  { "b", "b EXPR to set breakpint(use watchpoint)", cmd_b },
  { "d", "d [n] delete watchpoint with NO [n]", cmd_d },
  /* TODO: Add more commands */

};

#define NR_CMD ARRLEN(cmd_table)

static int cmd_help(char *args) {
  /* extract the first argument */
  char *arg = strtok(NULL, " ");
  int i;

  if (arg == NULL) {
    /* no argument given */
    for (i = 0; i < NR_CMD; i ++) {
      printf("%s - %s\n", cmd_table[i].name, cmd_table[i].description);
    }
  }
  else {
    for (i = 0; i < NR_CMD; i ++) {
      if (strcmp(arg, cmd_table[i].name) == 0) {
        printf("%s - %s\n", cmd_table[i].name, cmd_table[i].description);
        return 0;
      }
    }
    printf("Unknown command '%s'\n", arg);
  }
  return 0;
}

void sdb_set_batch_mode() {
  is_batch_mode = true;
}

void sdb_mainloop() {
  if (!is_batch_mode) {
    cmd_c(NULL);
    return;
  }

  for (char *str; (str = rl_gets()) != NULL; ) {
    char *str_end = str + strlen(str);

    /* extract the first token as the command */
    char *cmd = strtok(str, " ");
    if (cmd == NULL) { continue; }

    /* treat the remaining string as the arguments,
     * which may need further parsing
     */
    char *args = cmd + strlen(cmd) + 1;
    if (args >= str_end) {
      args = NULL;
    }

#ifdef CONFIG_DEVICE
    extern void sdl_clear_event_queue();
    sdl_clear_event_queue();
#endif

    int i;
    for (i = 0; i < NR_CMD; i ++) {
      if (strcmp(cmd, cmd_table[i].name) == 0) {
        if (cmd_table[i].handler(args) < 0) { return; }
        break;
      }
    }

    if (i == NR_CMD) { printf("Unknown command '%s'\n", cmd); }
  }
}

void init_sdb() {
  /* Compile the regular expressions. */
  init_regex();

  /* Initialize the watchpoint pool. */
  init_wp_pool();
}
