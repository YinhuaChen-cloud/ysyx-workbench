#include "sdb.h"
#include "watchpoint.h"

#define NR_WP 32

int nr_wp;
static WP wp_pool[NR_WP] = {};
static WP *head = NULL, *free_ = NULL, *tail = NULL;

void init_wp_pool() {
  int i;
  for (i = 0; i < NR_WP; i ++) {
    wp_pool[i].NO = i;
    wp_pool[i].next = (i == NR_WP - 1 ? NULL : &wp_pool[i + 1]);
  }

  head = NULL;
  free_ = wp_pool;
  nr_wp = 0;
}

/* TODO: Implement the functionality of watchpoint */

WP* new_wp() {
  assert(free_); // assume there are always free watchpoints
  if(tail) {
    tail->next = free_;
    free_ = free_->next;
    tail = tail->next;
    tail->next = NULL;
  }
  else {
    head = free_;
    free_ = free_->next;
    head->next = NULL;
    tail = head;
  }
  return tail;
}

void free_NO_wp(int NO) {
  WP *p = head;
  bool exist = false;
  while(p) {
    if(p->NO == NO) {
      exist = true;
      free_wp(p);
      break;
    }
    p = p->next;
  }
  
  if(!exist)
    printf("Watchpoints with NO %d does not exist\n", NO);
}

void free_wp(WP *wp) {
  // wp might be any element in head list
  if(head == wp) {
    head = head->next;
    wp->next = free_;
    free_ = wp;
    if(!head)
      tail = NULL;
    return;
  }

  bool inhead = false;
  WP *p = head;
  while(p) {
    if(p->next == wp){
      inhead = true;
      p->next = wp->next;
      if(tail == wp)
        tail = p;
      break;
    }
    p = p->next;
  }
  assert(inhead);
  wp->next = free_;
  free_ = wp;
  return;
}

WP* get_wp_head() { return head; }

void print_watchpoints() {
  WP *p = head;
  while(p) {
    printf("NO: %d\t%s\n", p->NO, p->expr);
    p = p->next;
  }
}

