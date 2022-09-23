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

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <assert.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#define BUFLEN 65536
#define checkBufferOverflow(len_added, total_added, gen, ...) \
  len_added = gen(__VA_ARGS__);  \
  if(!len_added) {  \
    buf_cursor -= total_added;  \
    buf[buf_cursor] = '\0'; \
    return 0; \
  } \
  total_added += len_added;

// this should be enough
static char buf[BUFLEN] = {};
static char auxbuf[32];
static int buf_cursor; // its max val is BUFLEN-1, since the last pos should be '\0'
static char code_buf[BUFLEN + 160] = {}; // a little larger than `buf`, to contain de C code
static char *code_format =
"#include <stdio.h>\n"
"int main() { "
"  int loop = %d; "
"  unsigned long result = %s; "
"  printf(\"%%lu\", result); "
"  return 0; "
"}";
 
// checked
uint32_t choose(uint32_t n) {
  return rand() % n;
}

uint64_t rand_64bit() {
  uint64_t num = rand();
  num <<= 31;
  num |= rand();
  num <<= 2;
  num |= (rand() & 3);
  return num;
}

// return the num of added char
static int gen_num() {
  uint64_t num = rand_64bit();
  int numlen = -1;
  switch(choose(2)) {
    case 0:
      numlen = sprintf(auxbuf, "%luULL", num);
      break;
    default:
      numlen = sprintf(auxbuf, "0x%lxULL", num);
      break;
  }
  if(numlen + buf_cursor > BUFLEN-1)
    return 0;
  strcpy(buf + buf_cursor, auxbuf);
  buf_cursor += numlen;
  buf[buf_cursor] = '\0';
  return numlen;
}

// will return 0 if cursor is at end, return 1 if success
static int gen(char c) {
  assert(buf_cursor <= BUFLEN-1);
  if(buf_cursor == BUFLEN-1)
    return 0;
  buf[buf_cursor] = c;
  buf_cursor++;
  buf[buf_cursor] = '\0';
  return 1;
}

static int gen_twoChar_op(char c1, char c2) {
  int total = 0;
  int len = -1;

  len = gen(c1);
  if(!len)
    return total;
  total += len;

  len = gen(c2);
  if(!len) {
    buf_cursor -= total;
    buf[buf_cursor] = '\0';
    return 0;
  }
  total += len;
  
  return total;
}

// will avoid bufferoverflow automatically since gen(char c) will do it
static int gen_rand_op() {
  switch (choose(7)) {
    case 0: return gen('+'); 
    case 1: return gen('-'); 
    case 2: return gen('*'); 
    case 3: return gen('/'); 
    case 4: return gen_twoChar_op('=', '='); 
    case 5: return gen_twoChar_op('!', '=');
    case 6: return gen_twoChar_op('&', '&');
    default: assert(0);
  }
}

// will avoid bufferoverflow automatically since gen(char c) will do it
static int gen_space_rand() {
  int total_added = 0;
  switch (choose(6)) {
    case 0:
      for(int i = choose(3)+1; i > 0; i--)
        total_added += gen(' '); 
      break;
    default: return 0;
  }
  return total_added;
}

// will return the char added to buffer(do not include space)
static int my_gen_rand_expr() {
  int len_added = 0;
  int total_added = 0;
  int len_after_op = 0;
  switch (choose(3)) {
    case 0: // number
      total_added += gen_space_rand(); 
      checkBufferOverflow(len_added, total_added, gen_num)
      total_added += gen_space_rand(); 
      break;
    case 1: // (expr)
      total_added += gen_space_rand(); 
      checkBufferOverflow(len_added, total_added, gen, '(')
      total_added += gen_space_rand(); 
      checkBufferOverflow(len_added, total_added, my_gen_rand_expr)
      total_added += gen_space_rand(); 
      checkBufferOverflow(len_added, total_added, gen, ')')
      total_added += gen_space_rand(); 
      break;
    default: // expr op expr
      total_added += gen_space_rand(); 
      checkBufferOverflow(len_added, total_added, my_gen_rand_expr)
      total_added += gen_space_rand(); 

      len_added = gen_rand_op();
      if(!len_added) {
        return total_added;
      }
      total_added += len_added;
      len_after_op += len_added;

      len_added = gen_space_rand(); 
      total_added += len_added;
      len_after_op += len_added;

      len_added = my_gen_rand_expr();
      if(!len_added) {
        buf_cursor -= len_after_op;
        buf[buf_cursor] = '\0';
        return total_added - len_after_op;
      }
      total_added += len_added;
      len_after_op += len_added;

      len_added = gen_space_rand(); 
      total_added += len_added;
      len_after_op += len_added;
      break;
  }
  return total_added;
}

static void gen_rand_expr() {
  buf[0] = '\0';
  buf_cursor = 0;
  my_gen_rand_expr();
}

int main(int argc, char *argv[]) {
  // added by cyh
  // printf("In dir gen-expr\n");     So we know this code is not executed by nemu main part
  // assert(0);
  // added by cyh ends
  // int seed = time(0);
  int seed = 0;
  int exitno = 0;
  srand(seed);
  int loop = 1;
  if (argc > 1) {
    sscanf(argv[1], "%d", &loop);
  }
  int i;
  for (i = 0; i < loop; i ++) {
    gen_rand_expr();

    sprintf(code_buf, code_format, i, buf);

    FILE *fp = fopen("/tmp/.code.c", "w");
    assert(fp != NULL);
    fputs(code_buf, fp);
    fclose(fp);

    int ret = system("gcc /tmp/.code.c -Werror=div-by-zero -o /tmp/.expr");
    if (ret != 0) continue;

    fp = popen("/tmp/.expr", "r");
    assert(fp != NULL);

    uint64_t result;
    fscanf(fp, "%lu", &result);
    exitno = pclose(fp);
    if(exitno != 0) // filter out the division-zero exprs
      continue;

    printf("%lu %s\n", result, buf);
  }
  return 0;
}
