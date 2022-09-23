#ifndef __WATCHPOINT_H__
#define __WATCHPOINT_H__

#define EXPR_LEN 256

typedef struct watchpoint {
  int NO;
  struct watchpoint *next;

  /* TODO: Add more members if necessary */
  char expr[EXPR_LEN];
  uint64_t old_val;
} WP;

int nr_wp;
WP* new_wp();
void free_wp(WP *wp);
WP* get_wp_head();
void print_watchpoints();
void free_NO_wp(int NO);

#endif
