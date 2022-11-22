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
#include <stdbool.h>
#include "intStackforC.h"
#include <assert.h>
#include <string.h>
#include <memory/paddr.h>

/* We use the POSIX regex functions to process regular expressions.
 * Type 'man regex' for more information about POSIX regex functions.
 */
#include <regex.h>

#define TK_STR_MAX_LEN 32
#define TK_MAX_NUM 16384


enum {
  TK_NOTYPE = 256, TK_EQ, TK_NUM,
  TK_NEQ, TK_AND, TK_REG, DEREF,
  /* TODO: Add more token types */

};

char *getTKName(int token_type) {
  switch(token_type) {
    case TK_NOTYPE:
      return "TK_NOTYPE";
    case TK_EQ:
      return "TK_EQ";
    case TK_NUM:
      return "TK_NUM";
    case TK_NEQ:
      return "TK_NEQ";
    case TK_AND:
      return "TK_AND";
    case TK_REG:
      return "TK_REG";
    case DEREF:
      return "DEREF";
    case '+':
      return "+";
    case '-':
      return "-";
    case '*':
      return "*";
    case '/':
      return "/";
    case '(':
      return "(";
    case ')':
      return ")";
    default:
      assert(0);
  }
}

static struct rule {
  const char *regex;
  int token_type;
} rules[] = {

  /* TODO: Add more rules.
   * Pay attention to the precedence level of different rules.
   */

  {" +", TK_NOTYPE},    // spaces
  {"([1-9][0-9]*(U|UL|ULL)?)|(0[xX][0-9a-fA-F]+(U|UL|ULL)?)", TK_NUM},    // decimal
  {"\\+", '+'},         // plus
  {"-", '-'},         // minus
  {"\\*", '*'},         // multiply
  {"/", '/'},         // division
  {"\\(", '('},         // leftParenthesis
  {"\\)", ')'},         // rightParenthesis
  {"==", TK_EQ},        // equal
  {"!=", TK_NEQ},        // not equal
  {"&&", TK_AND},        // and
  {"\\$[$0-9a-zA-Z]+", TK_REG},        // and
};

#define NR_REGEX ARRLEN(rules)

static regex_t re[NR_REGEX] = {};

/* Rules are used for many times.
 * Therefore we compile them only once before any usage.
 */
void init_regex() {
  int i;
  char error_msg[128];
  int ret;

  for (i = 0; i < NR_REGEX; i ++) {
    ret = regcomp(&re[i], rules[i].regex, REG_EXTENDED);
    if (ret != 0) {
      regerror(ret, &re[i], error_msg, 128);
      panic("regex compilation failed: %s\n%s", error_msg, rules[i].regex);
    }
  }
}

typedef struct token {
  int type;
  int priority;
  char str[TK_STR_MAX_LEN];
} Token;

static Token tokens[TK_MAX_NUM] __attribute__((used)) = {};
static int nr_token __attribute__((used))  = 0;

static bool make_token(char *e) {
  int position = 0;
  int i;
  regmatch_t pmatch;
  bool reg_success = true;
  word_t reg_val = 0; 

  nr_token = 0;

  while (e[position] != '\0') {
    /* Try all rules one by one. */
    for (i = 0; i < NR_REGEX; i ++) {
      if (regexec(&re[i], e + position, 1, &pmatch, 0) == 0 && pmatch.rm_so == 0) {
        char *substr_start = e + position;
        int substr_len = pmatch.rm_eo;

//        Log("match rules[%d] = \"%s\" at position %d with len %d: %.*s",
//            i, rules[i].regex, position, substr_len, substr_len, substr_start);

        position += substr_len;

        /* TODO: Now a new token is recognized with rules[i]. Add codes
         * to record the token in the array `tokens'. For certain types
         * of tokens, some extra actions should be performed.
         */

        // TODO: do not consider bufferoverflow yet
        if(rules[i].token_type == TK_NOTYPE)
          break;

        tokens[nr_token].type = rules[i].token_type;
        if(substr_len > TK_STR_MAX_LEN-1) // avoid str bufferoverflow
          assert(0);
        strncpy(tokens[nr_token].str, substr_start, substr_len);
        tokens[nr_token].str[substr_len] = '\0';

        switch (rules[i].token_type) {
          case TK_NUM:
            if(tokens[nr_token].str[substr_len-1] == 'U')
              tokens[nr_token].str[substr_len-1] = '\0';
            if(tokens[nr_token].str[substr_len-2] == 'U')
              tokens[nr_token].str[substr_len-2] = '\0';
            if(tokens[nr_token].str[substr_len-3] == 'U')
              tokens[nr_token].str[substr_len-3] = '\0';
            break;
          // operator priority: http://c.biancheng.net/view/285.html
          case '*': 
          case '/':
            tokens[nr_token].priority = 3; break;
          case '+':
          case '-':
            tokens[nr_token].priority = 4; break;
          case TK_EQ:
          case TK_NEQ:
            tokens[nr_token].priority = 7; break;
          case TK_AND:
            tokens[nr_token].priority = 11; break;
          case TK_REG:
            reg_val = isa_reg_str2val(tokens[nr_token].str+1, &reg_success); // meaning of +1: skip the $ character
            if(reg_success) {
              tokens[nr_token].type = TK_NUM;
              snprintf(tokens[nr_token].str, TK_STR_MAX_LEN, "%lu", reg_val);
            }
            else {
              printf("No any register named %s\n", tokens[nr_token].str);
              Log("No any register named %s\n", tokens[nr_token].str);
              return false;
            }
            break;
          default: // ( , )
            assert(rules[i].token_type == '(' || rules[i].token_type == ')');
        }
        nr_token++;
        break;
      }
    }

    if (i == NR_REGEX) {
      printf("no match at position %d\n%s\n%*.s^\n", position, e, position, "");
      return false;
    }
  }

  return true;
}

// PA1: added by chenyinhua
// assume tokens is in correct format
bool check_parentheses(int p, int q) {
  assert(p < q);
  if(tokens[p].type != '(' || tokens[q].type != ')')
    return false;
  void *astack = createIntStack();
  pushIntStack(astack, p);
  for(int i = p+1; i <= q; i++) {
    if(tokens[i].type != '(' && tokens[i].type != ')')
      continue;
    else if(tokens[i].type == '(')
      pushIntStack(astack, i);
    else {
      if(isIntStackEmpty(astack))
        return false;
      else {
        popIntStack(astack);
        if(isIntStackEmpty(astack) && i != q)
          return false;
      }
    }
  }
  bool result = isIntStackEmpty(astack);
  deleteIntStack(astack);
  return result;
}

// assume input format is correct
// how to find main op?
//  * / L-R
//  + - L-R
//  == != L-R
//  && L-R
// 1. 非运算符的token不是主运算符.
// 2. 出现在一对括号中的token不是主运算符. 注意到这里不会出现有括号包围整个表达式的情况, 因为这种情况已经在check_parentheses()相应的if块中被处理了.
// 3. 主运算符的优先级在表达式中是最低的. 这是因为主运算符是最后一步才进行的运算符.
// 4. 当有多个运算符的优先级都是最低时, 根据结合性, 最后被结合的运算符才是主运算符. 一个例子是1 + 2 + 3, 它的主运算符应该是右边的+.
int posOfMainOp(int p, int q) {
  assert(p < q); // assume input format is correct
  // thought: use stack to scan tokens[p:q]
  // 1. skip all number token
  // 2. push all other token into stack
  //  2.1. when meet (, push it into stack, and skip all following tokens( except '(' and ')' ) until meet the matched )
  //  2.2. when meet ), pop the ( on stack top
  //  2.3. when stack is empty, push any op into stack
  //  2.4. if stack top has lower priority than op, skip it, else push into stack
  // 3. the Op on stack top is the main op token
  bool inparen = false;
  void *astack = createIntStack();
  for(int i = p; i <= q; i++) {
    if(tokens[i].type == TK_NUM)
      continue;
    if(tokens[i].type != '(' && tokens[i].type != ')' && inparen)
      continue;
    if(tokens[i].type == '(') {
      inparen = true;
      pushIntStack(astack, i);
      continue;
    }
    if(tokens[i].type == ')') {
      assert(tokens[intStackTop(astack)].type == '(');
      popIntStack(astack);
      if(isIntStackEmpty(astack) || tokens[intStackTop(astack)].type != '(') {
        inparen = false;
      }
      continue;
    }
    // must be ==, !=, &&, +, -, *, /
    // printf("The token type is %s\n", getTKName(tokens[i].type));
    assert(tokens[i].type == TK_EQ || tokens[i].type == TK_NEQ || tokens[i].type == TK_AND || tokens[i].type == '+' || \
    tokens[i].type == '-' || tokens[i].type == '*' || tokens[i].type == '/' || tokens[i].type == DEREF);

    if(isIntStackEmpty(astack)) {
      pushIntStack(astack, i);
      continue;
    }
    if(tokens[intStackTop(astack)].priority > tokens[i].priority)
      continue;
    else
      pushIntStack(astack, i);
  }
  int result = intStackTop(astack);
  deleteIntStack(astack);
  return result;
}

// PA1: added by chenyinhua
uint64_t eval(int p, int q) {
  // use tokens array
  if (p > q) {
    /* Bad expression */
    return 0;
  }
  else if (p == q) {
    /* Single token.
      * For now this token should be a number.
      * Return the value of the number.
      */
    assert(tokens[p].type == TK_NUM);
    return strtoul(tokens[p].str, NULL, 0); // TODO: we assume the format is correct
  }
  else if (check_parentheses(p, q) == true) {
    /* The expression is surrounded by a matched pair of parentheses.
      * If that is the case, just throw away the parentheses.
      */
    return eval(p + 1, q - 1);
  }
  else {
    int op = posOfMainOp(p, q);

    switch (tokens[op].type) {
      case '+': return eval(p, op - 1) + eval(op + 1, q);
      case '-': return eval(p, op - 1) - eval(op + 1, q);
      case '*': return eval(p, op - 1) * eval(op + 1, q);
      case '/': return eval(p, op - 1) / eval(op + 1, q);
      case TK_AND : return eval(p, op - 1) && eval(op + 1, q);
      case TK_EQ : return eval(p, op - 1) == eval(op + 1, q);
      case TK_NEQ : return eval(p, op - 1) != eval(op + 1, q);
      case DEREF : 
        assert(op == p); 
        uint64_t addr = eval(op+1, q);
        return paddr_read(addr, sizeof(word_t));
      default: assert(0);
    }
  }
}

// TODO: I guess this function returns the val of the whole expr
uint64_t expr(char *e, bool *success) {
  if (!make_token(e)) {
    *success = false;
    return 0;
  }

  /* TODO: Implement code to evaluate the expression. */
  for (int i = 0; i < nr_token; i++) {
    if (tokens[i].type == '*' && (i == 0 || (tokens[i - 1].type != TK_NUM &&  tokens[i - 1].type != ')'))) { 
      // printf("tokens[i - 1].type == %s\n", getTKName(tokens[i - 1].type));
      tokens[i].type = DEREF;
      tokens[i].priority = 2;
    }
  }

  // TODO: In the future we may need to support format like *(expr) where the first '*' is DEREF

  return eval(0, nr_token-1);
}


