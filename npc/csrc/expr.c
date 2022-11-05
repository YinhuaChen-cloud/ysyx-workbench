#include <common.h>
#include <debug.h>
/* We use the POSIX regex functions to process regular expressions.
 * Type 'man regex' for more information about POSIX regex functions.
 */
#include <regex.h>

#define ARRLEN(arr) (int)(sizeof(arr) / sizeof(arr[0]))

enum {
  TK_NOTYPE = 256, TK_EQ, TK_NUM,
  TK_NEQ, TK_AND, TK_REG, DEREF,
  /* TODO: Add more token types */

};

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

