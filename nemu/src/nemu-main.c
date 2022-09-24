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

#include <common.h>
#include <sdb.h>
#define BUFLEN 65600

static char buf[BUFLEN] = {};
void init_monitor(int, char *[]);
void am_init_monitor();
void engine_start();
int is_exit_status_bad();

void arithmetic_test() {
  // test the expr() function
  printf("-----------arithmetic expr test starts----------\n");
  FILE * fp = fopen("./tools/gen-expr/input", "r");
  char *e;
  char *r;
  uint64_t result = 0;
  uint64_t calculated_result = 1;
  bool success = true;
  if(result);
  assert(fp);
  while(fgets(buf, BUFLEN, fp)) {
    r = strtok(buf, " ");
    e = r + strlen(r) + 1;
    e[strlen(e)-1] = '\0';
    result = strtoul(r, NULL, 10);
    // printf("result = %lu\n", result); 
    calculated_result = expr(e, &success);
    assert(success);
    // printf("result = %lu, calculated = %lu\n", result, calculated_result);
    assert(result == calculated_result);
  }
  // word_t expr(char *e, bool *success)
  fclose(fp);
  printf("-----------arithmetic expr test ends----------\n");
}

void test_expr() {
  arithmetic_test();
  printf("-----------all tests pass-----------\n");
}

int main(int argc, char *argv[]) {
  /* Initialize the monitor. */
#ifdef CONFIG_TARGET_AM
  am_init_monitor();
#else
  init_monitor(argc, argv);
#endif

//  test_expr();

  /* Start engine. */
  engine_start();

  return is_exit_status_bad();
}
